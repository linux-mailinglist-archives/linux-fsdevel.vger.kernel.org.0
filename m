Return-Path: <linux-fsdevel+bounces-68137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C78C550DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E756B3B0B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1435261B8D;
	Thu, 13 Nov 2025 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LXRDm4lg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ps+sLJGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEEC1A9FBC;
	Thu, 13 Nov 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994564; cv=none; b=r3SCuTfsMK9jM2TNIqMr54EGTLPiM1SR6r+wKUoYJbJrOaVIHJzlFmN/Et39ZdHI2vme/LhbGb1WLX66Y/gtNku/z9NFNsQqqnYUT7nHX83wI566X8f8gfmJPj/2G4lVrAMowqAViDl20//pdj1fE2pWGd5XxQccmVFUVWgo9V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994564; c=relaxed/simple;
	bh=/DBg5tiBlBX+Omsr7LhVh+lPEvFcuqRusM9ymbztkVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/uIeaOCDMROqhPA5fdLfVpqZfoJeil4yFUhjlVeTnreJt58fYdp7DGTfi+EA0nTaExkm3gi2RizejRxdPZAIgE4Kil7/ubTTkiiG9QLtG/I63pugz/yN101Y93LHDDjbymw2816kyNB5tUdrA8ZVjDRt96gtZMMCqjaTHKOQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LXRDm4lg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ps+sLJGE; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 5862813000C2;
	Wed, 12 Nov 2025 19:42:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 19:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762994560;
	 x=1763001760; bh=qC4DY1mn6AlIRvjJA8/p1mIWvwunaqj4qhqQMQGH3Ak=; b=
	LXRDm4lgycX4TIIaweB6UsONeUu/W/7H8Iz2P6Stp9ZSo1V2knAL4jeZdAtkjvrk
	YALBX2m3IgKrKr8jxPhCxdaj2VxbLfzo0aO443DPVgKEaGOu3NBs0r//P+5XWOb+
	4Z6bwm6Ypp4JGtRh4rnezK+iJxkZ4Mhk85GKo1RflMXjI8W25jQETiXojZ54Sars
	1J48ZiY1KM6YiWMbaWEUyjkCirN9jMreTLm3nR0R0ODdgM+Jr1qLnyVrl8L43n5U
	T1wh5DV50s2ei+ZJTeg5c10VWVrTRexoE+BBUe9cH+dc1PNYteEBj92aMV8hDWhI
	neX3vdMWNRu0xb5S0u2W3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762994560; x=1763001760; bh=q
	C4DY1mn6AlIRvjJA8/p1mIWvwunaqj4qhqQMQGH3Ak=; b=Ps+sLJGEtn/zTr22J
	Jvj3Dyczy+V2c4nxfMEh2AUjoJG6MG416UDAyp0x/5yb2bRCHwVD9XgrshypTuKN
	Fub+Kmvi6/kD5D7Pv00JXImLEd1rqRwZ1o6iCVAd47RVyqHtkudr7KFhIGISEAg3
	SxehBfkrt7kFF9pMiqmMQvzFm8ixdFhPZDwE5LVkniLnPqhr85rsy8mHMytnqtFw
	zvQVY/7aXlKJr11tS0rPsRw55gl842IKcIxbCiUDgbUSOq0w/IT2HAnjQy1ackEi
	H0aaM9QeFyJ06x5GNBEEeX6NS/NW84001rQUTLJvcjKgrJrRICc58d9kc6ilvKqK
	5aVqA==
X-ME-Sender: <xms:fykVaVevMvakB_UTy3DWpwGYfLqJoFN2LJCmhCGrddNrc1PPKYV_4A>
    <xme:fykVaY8Xd15Xt45FAb_DYMHwNuooEmRW29w8dDV48rmEmu_ZEhW0xhIHSpYjPEa4i
    5JJYc4ixxWvMoeQanA-h6OGqw98cYzw28e3ePGtF4eszEHI-w>
X-ME-Received: <xmr:fykVaVUj4mad2iANQ5PcVf9xlfyW10ugg-E_8B8Jtt8IH3x5N-Ln2LeuEjJ15TUylgI2bkt30_Gae-20idtnPWmvsGCYzUebXlynw2COhXPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:fykVaWIA9P0t8za9jfdQK7thOeKih_vNto-Wr4MvGsyolWlbXnSA-w>
    <xmx:fykVaSlEcQPbW3JJsGkSvILkmngDAxhkxq4Ms0x1_kzy1QAyNlYdvA>
    <xmx:fykVaSDwe3o_KYEmI8QhzkRrMYY_ezZ5wrLxJt8CPLHVH3wWapPn-g>
    <xmx:fykVaYuppoAHvkOqgCCdLRmg2QNNmxsxRmPMjSLydkirqInIY9Em7g>
    <xmx:gCkVaW5d7WWKNngI4nA80MurZ6f2ZG97gdoaozi2Nf37xPggaaARgOAg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 19:42:29 -0500 (EST)
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
Subject: [PATCH v6 13/15] ecryptfs: use new start_creating/start_removing APIs
Date: Thu, 13 Nov 2025 11:18:36 +1100
Message-ID: <20251113002050.676694-14-neilb@ownmail.net>
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

This requires the addition of start_creating_dentry() which is given the
dentry which has already been found, and asks for it to be locked and
its parent validated.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v4
- two places in ecryptfs uses dget_parent(dentry->d_parent),
  thus incorrectly. getting grandparent.  Changed to
  dget_parent(dentry).
---
 fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
 fs/namei.c            |  33 +++++++++
 include/linux/namei.h |   2 +
 3 files changed, 107 insertions(+), 81 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index fc6d37419753..37d6293600c7 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -24,18 +24,26 @@
 #include <linux/unaligned.h>
 #include "ecryptfs_kernel.h"
 
-static int lock_parent(struct dentry *dentry,
-		       struct dentry **lower_dentry,
-		       struct inode **lower_dir)
+static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dentry)
 {
-	struct dentry *lower_dir_dentry;
+	struct dentry *parent = dget_parent(dentry);
+	struct dentry *ret;
 
-	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
-	*lower_dir = d_inode(lower_dir_dentry);
-	*lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	ret = start_creating_dentry(ecryptfs_dentry_to_lower(parent),
+				    ecryptfs_dentry_to_lower(dentry));
+	dput(parent);
+	return ret;
+}
 
-	inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
-	return (*lower_dentry)->d_parent == lower_dir_dentry ? 0 : -EINVAL;
+static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dentry)
+{
+	struct dentry *parent = dget_parent(dentry);
+	struct dentry *ret;
+
+	ret = start_removing_dentry(ecryptfs_dentry_to_lower(parent),
+				    ecryptfs_dentry_to_lower(dentry));
+	dput(parent);
+	return ret;
 }
 
 static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
@@ -141,15 +149,12 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry,
-					NULL);
-	}
+	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+
+	lower_dir = lower_dentry->d_parent->d_inode;
+	rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
 	if (rc) {
 		printk(KERN_ERR "Error in vfs_unlink; rc = [%d]\n", rc);
 		goto out_unlock;
@@ -158,8 +163,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 out_unlock:
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
 	struct inode *lower_dir;
 	struct inode *inode;
 
-	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_create(&nop_mnt_idmap, lower_dir,
-				lower_dentry, mode, true);
+	lower_dentry = ecryptfs_start_creating_dentry(ecryptfs_dentry);
+	if (IS_ERR(lower_dentry))
+		return ERR_CAST(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+	rc = vfs_create(&nop_mnt_idmap, lower_dir,
+			lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
 		       "rc = [%d]\n", __func__, rc);
@@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_attr_times(directory_inode, lower_dir);
 	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	return inode;
 }
 
@@ -433,10 +439,12 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
-	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
-			      lower_new_dentry, NULL);
+	lower_new_dentry = ecryptfs_start_creating_dentry(new_dentry);
+	if (IS_ERR(lower_new_dentry))
+		return PTR_ERR(lower_new_dentry);
+	lower_dir = lower_new_dentry->d_parent->d_inode;
+	rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
+		      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
 	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
@@ -448,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_new_dentry, NULL);
 	return rc;
 }
 
@@ -468,9 +476,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	size_t encoded_symlen;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat = NULL;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (rc)
-		goto out_lock;
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
 	mount_crypt_stat = &ecryptfs_superblock_to_private(
 		dir->i_sb)->mount_crypt_stat;
 	rc = ecryptfs_encrypt_and_encode_filename(&encoded_symname,
@@ -490,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, NULL);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -501,12 +511,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int rc;
 	struct dentry *lower_dentry;
+	struct dentry *lower_dir_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (rc)
-		goto out;
-
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return lower_dentry;
+	lower_dir_dentry = dget(lower_dentry->d_parent);
+	lower_dir = lower_dir_dentry->d_inode;
 	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
 				 lower_dentry, mode);
 	rc = PTR_ERR(lower_dentry);
@@ -522,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
 out:
-	inode_unlock(lower_dir);
+	end_creating(lower_dentry, lower_dir_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
@@ -534,21 +546,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct inode *lower_dir;
 	int rc;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	dget(lower_dentry);	// don't even try to make the lower negative
-	if (!rc) {
-		if (d_unhashed(lower_dentry))
-			rc = -EINVAL;
-		else
-			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
-	}
+	lower_dentry = ecryptfs_start_removing_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
+	rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
 		fsstack_copy_attr_times(dir, lower_dir);
 		set_nlink(dir, lower_dir->i_nlink);
 	}
-	dput(lower_dentry);
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (!rc)
 		d_drop(dentry);
 	return rc;
@@ -562,10 +571,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct dentry *lower_dentry;
 	struct inode *lower_dir;
 
-	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode, dev);
+	lower_dentry = ecryptfs_start_creating_dentry(dentry);
+	if (IS_ERR(lower_dentry))
+		return PTR_ERR(lower_dentry);
+	lower_dir = lower_dentry->d_parent->d_inode;
+
+	rc = vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
@@ -574,7 +585,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out:
-	inode_unlock(lower_dir);
+	end_removing(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -590,7 +601,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct dentry *lower_new_dentry;
 	struct dentry *lower_old_dir_dentry;
 	struct dentry *lower_new_dir_dentry;
-	struct dentry *trap;
 	struct inode *target_inode;
 	struct renamedata rd = {};
 
@@ -605,31 +615,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	target_inode = d_inode(new_dentry);
 
-	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
-	dget(lower_new_dentry);
-	rc = -EINVAL;
-	if (lower_old_dentry->d_parent != lower_old_dir_dentry)
-		goto out_lock;
-	if (lower_new_dentry->d_parent != lower_new_dir_dentry)
-		goto out_lock;
-	if (d_unhashed(lower_old_dentry) || d_unhashed(lower_new_dentry))
-		goto out_lock;
-	/* source should not be ancestor of target */
-	if (trap == lower_old_dentry)
-		goto out_lock;
-	/* target should not be ancestor of source */
-	if (trap == lower_new_dentry) {
-		rc = -ENOTEMPTY;
-		goto out_lock;
-	}
+	rd.mnt_idmap  = &nop_mnt_idmap;
+	rd.old_parent = lower_old_dir_dentry;
+	rd.new_parent = lower_new_dir_dentry;
+	rc = start_renaming_two_dentries(&rd, lower_old_dentry, lower_new_dentry);
+	if (rc)
+		return rc;
 
-	rd.mnt_idmap		= &nop_mnt_idmap;
-	rd.old_parent		= lower_old_dir_dentry;
-	rd.old_dentry		= lower_old_dentry;
-	rd.new_parent		= lower_new_dir_dentry;
-	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
 	if (rc)
 		goto out_lock;
@@ -640,8 +632,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_dir != old_dir)
 		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
 out_lock:
-	dput(lower_new_dentry);
-	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	end_renaming(&rd);
 	return rc;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 7f0384ceb976..2444c7ddb926 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3397,6 +3397,39 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 }
 EXPORT_SYMBOL(start_removing_noperm);
 
+/**
+ * start_creating_dentry - prepare to create a given dentry
+ * @parent: directory from which dentry should be removed
+ * @child:  the dentry to be removed
+ *
+ * A lock is taken to protect the dentry again other dirops and
+ * the validity of the dentry is checked: correct parent and still hashed.
+ *
+ * If the dentry is valid and negative a reference is taken and
+ * returned.  If not an error is returned.
+ *
+ * end_creating() should be called when creation is complete, or aborted.
+ *
+ * Returns: the valid dentry, or an error.
+ */
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child)
+{
+	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
+	if (unlikely(IS_DEADDIR(parent->d_inode) ||
+		     child->d_parent != parent ||
+		     d_unhashed(child))) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EINVAL);
+	}
+	if (d_is_positive(child)) {
+		inode_unlock(parent->d_inode);
+		return ERR_PTR(-EEXIST);
+	}
+	return dget(child);
+}
+EXPORT_SYMBOL(start_creating_dentry);
+
 /**
  * start_removing_dentry - prepare to remove a given dentry
  * @parent: directory from which dentry should be removed
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 9104c7104191..0e6b1b9afc26 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -101,6 +101,8 @@ struct dentry *start_removing_killable(struct mnt_idmap *idmap,
 				       struct qstr *name);
 struct dentry *start_creating_noperm(struct dentry *parent, struct qstr *name);
 struct dentry *start_removing_noperm(struct dentry *parent, struct qstr *name);
+struct dentry *start_creating_dentry(struct dentry *parent,
+				     struct dentry *child);
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
-- 
2.50.0.107.gf914562f5916.dirty


