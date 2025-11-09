# miiwiichat - Discord Clone

A full-featured communication platform with real-time messaging, video/voice calling, and comprehensive admin monitoring.

## Features

### Core Features
- 🔐 **Dual Authentication**: JWT + Google OAuth
- 🔢 **Unique User Numbers**: 8-digit user identification system
- 💬 **Real-time Messaging**: WebSocket-powered instant messaging
- 🎥 **Video Calls**: WebRTC-based video calling
- 📞 **Voice Calls**: WebRTC-based voice calling
- 🏢 **Servers & Channels**: Discord-like organization
- 📱 **Direct Messages**: Private conversations
- 👥 **User Search**: Find users by username or user number
- 🟢 **Presence System**: Online/offline status

### Admin Dashboard
- 📊 Real-time statistics
- 👁️ Complete message surveillance
- 📝 Activity logging for all user actions
- 🗑️ User and content moderation
- 🔄 Auto-refresh every 5 seconds

## Tech Stack

**Backend:**
- FastAPI (Python)
- MongoDB (Database)
- WebSocket (Real-time communication)
- WebRTC (Video/Voice calls)
- JWT + Google OAuth (Authentication)

**Frontend:**
- React 19
- TailwindCSS + shadcn/ui
- Socket.io-client (WebSocket)
- SimplePeer (WebRTC)

## Quick Start (Development)

### Prerequisites
- Python 3.9+
- Node.js 18+
- MongoDB
- Yarn

### Backend Setup
```bash
cd backend
pip install -r requirements.txt
cp .env.example .env  # Configure your environment variables
uvicorn server:app --reload --port 8001
```

### Frontend Setup
```bash
cd frontend
yarn install
yarn start
```

### Environment Variables

**Backend (.env):**
```
MONGO_URL=mongodb://localhost:27017
DB_NAME=miiwiichat
CORS_ORIGINS=http://localhost:3000
JWT_SECRET=your-secret-key
```

**Frontend (.env):**
```
REACT_APP_BACKEND_URL=http://localhost:8001
```

## Deployment

See [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md) for detailed Railway deployment instructions.

### Quick Railway Deploy

1. Push to GitHub
2. Connect to Railway
3. Add MongoDB database
4. Configure environment variables
5. Deploy!

## Usage

### Register & Login
1. Create account with email, username, and **8-digit user number**
2. Or use Google OAuth for instant login

### Create Communities
1. Click + button to create a server
2. Add text and voice channels
3. Invite friends by username or user number

### Communication
- **Text Chat**: Send messages in channels or DMs
- **Voice Calls**: Click phone icon in DMs
- **Video Calls**: Click video icon in DMs

### Admin Access
- Admin users see a crown icon
- Access admin dashboard to monitor all activity
- View messages, users, and activity logs
- Moderate content and users

## Project Structure

```
miiwiichat/
├── backend/
│   ├── server.py          # FastAPI application
│   ├── requirements.txt   # Python dependencies
│   └── .env              # Backend config
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   │   ├── AuthPage.js
│   │   │   ├── MainApp.js
│   │   │   └── AdminDashboard.js
│   │   ├── components/ui/  # shadcn components
│   │   ├── App.js
│   │   └── App.css
│   ├── package.json
│   └── .env              # Frontend config
├── RAILWAY_DEPLOYMENT.md  # Deployment guide
└── README.md
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login with credentials
- `GET /api/auth/google` - Google OAuth
- `POST /api/auth/session` - Create session from Google
- `GET /api/auth/me` - Get current user
- `POST /api/auth/logout` - Logout

### Servers & Channels
- `GET /api/servers` - List user's servers
- `POST /api/servers` - Create server
- `GET /api/servers/{id}/channels` - List channels
- `POST /api/servers/{id}/channels` - Create channel

### Messaging
- `GET /api/channels/{id}/messages` - Get messages
- `POST /api/channels/{id}/messages` - Send message
- `GET /api/dms` - List DM conversations
- `POST /api/dms` - Create DM
- `GET /api/dms/{id}/messages` - Get DM messages
- `POST /api/dms/{id}/messages` - Send DM

### Admin (Requires Admin Role)
- `GET /api/admin/stats` - Platform statistics
- `GET /api/admin/users` - All users
- `GET /api/admin/messages` - All messages
- `GET /api/admin/activity` - Activity logs
- `DELETE /api/admin/users/{id}` - Delete user
- `DELETE /api/admin/messages/{id}` - Delete message
- `DELETE /api/admin/servers/{id}` - Delete server

### WebSocket
- `/ws/{user_id}` - WebSocket connection for real-time features

## Making a User Admin

Connect to your MongoDB and run:

```javascript
db.users.updateOne(
  { email: "admin@example.com" },
  { $set: { is_admin: true } }
)
```

## Security Features

- 🔒 Password hashing with bcrypt
- 🎫 JWT token authentication
- 🔐 Secure session management
- 🛡️ CORS protection
- 📝 Activity logging
- 👮 Admin-only endpoints

## Browser Compatibility

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+ (macOS/iOS)
- Opera 76+

**WebRTC Requirements:**
- HTTPS (required for camera/microphone access)
- Modern browser with WebRTC support

## Contributing

This is a demonstration project. Feel free to fork and customize!

## License

MIT License - Feel free to use for learning and personal projects.

## Support

For issues or questions:
1. Check [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md)
2. Review API documentation above
3. Check browser console for errors

## Roadmap

- [ ] File sharing in messages
- [ ] Screen sharing in calls
- [ ] Server roles and permissions
- [ ] Message reactions
- [ ] Typing indicators
- [ ] Message editing/deletion
- [ ] User profiles
- [ ] Server discovery

---

Built with ❤️ using FastAPI, React, and modern web technologies.