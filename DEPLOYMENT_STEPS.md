# 🚀 Deploy miiwiichat to Railway - Step by Step

## Option 1: Two-Service Deployment (Recommended)

This separates frontend and backend for better scalability.

### Step 1: Push to GitHub

```bash
# Initialize git (if not already done)
cd /app
git init
git add .
git commit -m "Initial commit: miiwiichat"

# Create a new repo on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/miiwiichat.git
git branch -M main
git push -u origin main
```

### Step 2: Create Railway Project & Add MongoDB

1. Go to https://railway.app and sign in
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Select your `miiwiichat` repository
4. Railway will start deploying automatically
5. Click **"+ New"** → **"Database"** → **"Add MongoDB"**
6. Copy the `MONGO_URL` connection string from MongoDB variables

### Step 3: Configure Backend Service

1. Click on your main service (should auto-detect backend)
2. Go to **"Settings"** tab:
   - **Root Directory**: `backend`
   - **Start Command**: `uvicorn server:app --host 0.0.0.0 --port $PORT`
   - **Service Name**: `backend`

3. Go to **"Variables"** tab and add:
```
MONGO_URL=<paste-your-mongodb-url-here>
DB_NAME=miiwiichat
CORS_ORIGINS=*
JWT_SECRET=super-secret-change-this-in-production-12345
PORT=8001
```

4. Go to **"Settings"** → **"Networking"** → Click **"Generate Domain"**
5. Copy the backend domain (e.g., `backend-production-xxxx.railway.app`)

### Step 4: Add Frontend Service

1. In project dashboard, click **"+ New"** → **"GitHub Repo"**
2. Select the same `miiwiichat` repository again
3. Click on this new service
4. Go to **"Settings"** tab:
   - **Root Directory**: `frontend`
   - **Build Command**: `yarn install && yarn build`
   - **Start Command**: `npx serve -s build -p $PORT`
   - **Service Name**: `frontend`

5. Go to **"Variables"** tab and add:
```
REACT_APP_BACKEND_URL=https://backend-production-xxxx.railway.app
PORT=3000
```
   *(Replace with your actual backend domain from Step 3)*

6. Go to **"Settings"** → **"Networking"** → Click **"Generate Domain"**
7. Your app is now live at this domain! 🎉

### Step 5: Final Backend Update

Go back to backend service → Variables and update CORS:
```
CORS_ORIGINS=https://your-frontend-domain.railway.app,*
```

---

## Option 2: Single-Service Deployment (Simpler but less scalable)

### Step 1: Push to GitHub (same as above)

### Step 2: Create Railway Project

1. Go to https://railway.app → **"New Project"** → **"Deploy from GitHub repo"**
2. Select your `miiwiichat` repository
3. Click **"+ New"** → **"Database"** → **"Add MongoDB"**
4. Copy the `MONGO_URL`

### Step 3: Configure Service

1. Click on your service
2. Go to **"Settings"** tab:
   - **Start Command**: Leave empty (will use Procfile)
   - **Install Command**: `cd frontend && yarn install && cd ../backend && pip install -r requirements.txt`
   - **Build Command**: `cd frontend && yarn build`

3. Go to **"Variables"** tab:
```
MONGO_URL=<your-mongodb-url>
DB_NAME=miiwiichat
CORS_ORIGINS=*
JWT_SECRET=super-secret-key-change-this
PORT=8001
REACT_APP_BACKEND_URL=
```

4. After deployment, copy your Railway domain and update:
```
REACT_APP_BACKEND_URL=https://your-app.railway.app
```

5. **Generate Domain** in Settings → Networking

---

## Making Yourself Admin

After deployment, connect to your Railway MongoDB:

1. In Railway, go to MongoDB service → **"Data"** tab
2. Click **"MongoDB Compass"** or use the connection string
3. Run this query:

```javascript
use miiwiichat

// After you register, make yourself admin:
db.users.updateOne(
  { email: "your-email@example.com" },
  { $set: { is_admin: true } }
)
```

Now you can access `/admin` in your app!

---

## Testing Your Deployment

1. Visit your Railway frontend URL
2. **Register**: Create an account with an 8-digit user number
3. **Create Server**: Click the + button
4. **Add Channels**: Create text and voice channels
5. **Message**: Send messages in channels
6. **DM**: Search for another user and start a DM
7. **Call**: Try voice/video calls (needs HTTPS)
8. **Admin**: If admin, click the crown icon

---

## Troubleshooting

### Build Fails
- Check **Deployments** tab for error logs
- Ensure `requirements.txt` and `package.json` are complete
- Verify Python version (use 3.9+)

### App Won't Load
- Check **Deployments** → **View Logs**
- Verify environment variables are set
- Test backend URL directly: `https://backend-url/api/`

### WebSocket Not Working
- Ensure backend URL uses `https://` (not `http://`)
- Check CORS settings
- Verify WebSocket URL in frontend uses `wss://`

### Database Connection Failed
- Verify `MONGO_URL` is correctly copied
- Check MongoDB service is running
- Test connection from backend logs

### Video/Voice Calls Not Working
- Must use HTTPS (Railway provides this)
- Browser must support WebRTC
- Allow camera/microphone permissions

---

## Cost Estimate

**Railway Pricing:**
- **Hobby Plan**: $5/month (includes $5 usage credit)
- **MongoDB**: ~$5-7/month
- **Two Services**: ~$5-10/month total
- **Free Trial**: $5 credit monthly (great for testing)

**Total**: About $10-15/month for production use

---

## Production Checklist

- [ ] Changed JWT_SECRET to a strong random value
- [ ] Updated CORS_ORIGINS to only your frontend domain
- [ ] Set up MongoDB backups in Railway
- [ ] Tested registration and login
- [ ] Tested messaging and calls
- [ ] Made yourself admin
- [ ] Tested admin dashboard
- [ ] Added custom domain (optional)
- [ ] Set up monitoring/alerts

---

## Adding a Custom Domain

1. Go to your frontend service → **"Settings"** → **"Domains"**
2. Click **"Custom Domain"**
3. Enter your domain (e.g., `miiwiichat.com`)
4. Add DNS records shown by Railway to your domain provider
5. Wait for DNS propagation (5-30 minutes)
6. Update backend `CORS_ORIGINS` to include your custom domain

---

## Support Resources

- **Railway Docs**: https://docs.railway.app
- **Railway Discord**: https://discord.gg/railway
- **Railway Status**: https://status.railway.app
- **miiwiichat Docs**: See README.md in your repo

---

## Next Steps After Deployment

1. **Invite Users**: Share your Railway URL
2. **Create Communities**: Build servers and channels
3. **Monitor Usage**: Check Railway metrics
4. **Admin Dashboard**: Monitor user activity
5. **Customize**: Add features or modify design
6. **Scale**: Upgrade Railway plan if needed

---

**Congratulations! Your Discord clone is now live! 🎉**
