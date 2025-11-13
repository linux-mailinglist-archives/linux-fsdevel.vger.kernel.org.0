Return-Path: <linux-fsdevel+bounces-68139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF02C5512C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B12F334CC11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7D1C84D0;
	Thu, 13 Nov 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LcFeVDZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y5IZtIaQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0226E6F5;
	Thu, 13 Nov 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994591; cv=none; b=PLfsTLnnteJErhHPVi5P5e1R/lpnPl2xzi0XYkJZUfdSvYCaX9+cYdHuX81EtxkYUiGP9gSPcnjEBW3LC4iJy44cfqehnNdLawWmTR6y4o6hNhlKDJRlo+3qYX3c6uW2uev2lTM9MYYN3hciog6bPkgKBCYJAreZt6h0gekBhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994591; c=relaxed/simple;
	bh=OTB0rGLAxSxPYqaVuzKhtxaaom6SXBwXYWGgKixk4og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqrqu4o5GvS9NXQzlb4+DphUWW0uPJT9NYfXlDGp5UpZfndo0TDEdyB37mOr58mbgg4beTV3W3HpnJm2h55LtVIpu+OrrIyD9uuw07irQ5CHCcKhYQYlr18UsOKMSl6jL5CfA661X0fFQqtjzDv4uiQwS+/6BMuYo8hfUsaAJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LcFeVDZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y5IZtIaQ; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 1C94C1300C9C;
	Wed, 12 Nov 2025 19:43:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 19:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994587;
	 x=1763001787; bh=LH6B8gufGV0TjJ4vlHu8RH1VmAxd1MYT56YsH6sKK6w=; b=
	LcFeVDZgdj6isygMwW1oIYlc7mst+quWlTaNMT0fsvXfYmp1ZXN1NXM4X95hrrSv
	DvoZcFS/DH6CH+uKZJBGXii8RSKCe2jAKSdyTbzyLr5rxDVADOhFFguBaHaIZogi
	Oo84gyVH5AkICsS30Alo8gyP9KHpBLzZCGALCeL/pjklVuqcD4VNCTlpX5EFnFTy
	8dwEwqys52KZbOFCf//pXRccTxqE/H12Vm9+s30YWKbYHR5Xr5Aar++CxnTNrRq0
	MHhuhpn8Rdx8Q7lybzi2Wb7ZZFdPSAlEMNeK47V59B8GpH2W7bk59BOEmFxSFlb0
	0nePM9v/timsp+emzn9D9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994587; x=1763001787; bh=L
	H6B8gufGV0TjJ4vlHu8RH1VmAxd1MYT56YsH6sKK6w=; b=y5IZtIaQ5rUB7FZc9
	DZiFRQNoyTxQjRss2CWGi/2vujHuc8nwLRS0bIATFM/3zmLXR1D+WqEgcUa5xBgG
	NmIj2541lKoAXLaqsR+t2zkfDd8Kl87UiOQCz/YwJSIqsZHFh8c8Mezk7hoitMfJ
	+lkR8gI45oA9KzMR3Y72nNsZYENu4QGgO7onqdAlQmku+pyNP8tEJR9CF3f8dq20
	LQjyaoNmewI7tTUsacxY2huMyhJ2JCCpvq+mPm/yIp/Z7sQisLYcFT5bTmeFXEIH
	SZ3QOLjICK5YWweqXwcazxL2DuID/AwpOp2Y+XiPrSW17gr7GwaaLGVmaWHciqFp
	OHW7Q==
X-ME-Sender: <xms:mykVaSUwVqtIzfyjHocH7cPvv5XBpa0X1D_9lZn61xQbxHCxkXGasw>
    <xme:mykVaTqMEcjDOUNn2Ok2QhFo2ec8KKqTJWiECORYIv3NWqT4aZa1u3vIAgqIt3DuT
    eL62AF9da2UBumwh6hHqMlr2Apy5LlOPCd8u_VE77TRzFCxGA>
X-ME-Received: <xmr:mykVaTYWE3CdfkUP4vOCNQ4YFfvW5eEWclj8W-i2XmghbotjkL8ytkpP4S6-hBL6wB21RR8h9qeV8G8-UnifVAI_9CT3ZWU5uS00Yn9GZUFO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:mykVaXCaC6FMRT2xrI4xiuXZMdd4I6puaIt8pgf5zrtW07ZMrxjszw>
    <xmx:mykVaeH4gTlfc_orQZm7HbzBGUxV9g9PdW-yYmi3BPtyvHuOubhxEg>
    <xmx:mykVaTwsOiMEB8iYLInJyeTZKhfJ1yAms0HRzV6umBeNshUynQYHXg>
    <xmx:mykVaTfSC-8N3rruS9d_IutVbX-KqK1QErWxGADESmYPr-whfK0uGA>
    <xmx:mykVaWuUGHt76D35n5qsHYsTqLG9Zdz2WwzhMWF2V0_uy5i2t_IuohBZ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:42:57 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v6 15/15] VFS: introduce end_creating_keep()
Date: Thu, 13 Nov 2025 11:18:38 +1100
Message-ID: <20251113002050.676694-16-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251113002050.676694-1-neilb@ownmail.net>
References: <20251113002050.676694-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Occasionally the caller of end_creating() wants to keep using the dentry.
Rather then requiring them to dget() the dentry (when not an error)
before calling end_creating(), provide end_creating_keep() which does
this.

cachefiles and overlayfs make use of this.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c |  3 +--
 fs/overlayfs/dir.c    |  8 ++------
 fs/overlayfs/super.c  | 11 +++--------
 include/linux/namei.h | 22 ++++++++++++++++++++++
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 59327618ac42..ef22ac19545b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -155,8 +155,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* Tell rmdir() it's not allowed to delete the subdir */
 	inode_lock(d_inode(subdir));
-	dget(subdir);
-	end_creating(subdir);
+	end_creating_keep(subdir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 739f974dc258..d21f81a524f6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -251,10 +251,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	if (IS_ERR(ret))
 		return ret;
 	ret = ovl_create_real(ofs, workdir, ret, attr);
-	if (!IS_ERR(ret))
-		dget(ret);
-	end_creating(ret);
-	return ret;
+	return end_creating_keep(ret);
 }
 
 static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upper,
@@ -364,8 +361,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
 
-	dget(newdentry);
-	end_creating(newdentry);
+	end_creating_keep(newdentry);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3acda985c8a3..7b8fc1cab6eb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -319,8 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		};
 
 		if (work->d_inode) {
-			dget(work);
-			end_creating(work);
+			end_creating_keep(work);
 			if (persist)
 				return work;
 			err = -EEXIST;
@@ -336,9 +335,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
-		if (!IS_ERR(work))
-			dget(work);
-		end_creating(work);
+		end_creating_keep(work);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -630,9 +627,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 		if (!child->d_inode)
 			child = ovl_create_real(ofs, parent, child,
 						OVL_CATTR(mode));
-		if (!IS_ERR(child))
-			dget(child);
-		end_creating(child);
+		end_creating_keep(child);
 	}
 	dput(parent);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b4d95b79b5a8..58600cf234bc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -126,6 +126,28 @@ static inline void end_creating(struct dentry *child)
 	end_dirop(child);
 }
 
+/* end_creating_keep - finish action started with start_creating() and return result
+ * @child: dentry returned by start_creating() or vfs_mkdir()
+ *
+ * Unlock and return the child. This can be called after
+ * start_creating() whether that function succeeded or not,
+ * but it is not needed on failure.
+ *
+ * If vfs_mkdir() was called then the value returned from that function
+ * should be given for @child rather than the original dentry, as vfs_mkdir()
+ * may have provided a new dentry.
+ *
+ * Returns: @child, which may be a dentry or an error.
+ *
+ */
+static inline struct dentry *end_creating_keep(struct dentry *child)
+{
+	if (!IS_ERR(child))
+		dget(child);
+	end_dirop(child);
+	return child;
+}
+
 /**
  * end_removing - finish action started with start_removing
  * @child:  dentry returned by start_removing()
-- 
2.50.0.107.gf914562f5916.dirty


