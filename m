Return-Path: <linux-fsdevel+bounces-70954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F05CAB908
	for <lists+linux-fsdevel@lfdr.de>; Sun, 07 Dec 2025 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C663018986
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Dec 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397812E22B5;
	Sun,  7 Dec 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="c7QVAE+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64B2E4266
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Dec 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765132220; cv=none; b=FC3HoIDZri6AOy2iREu6NPjLkY5s0T5TLbFgRCBLHBgF+x4kRR69ART/i634RytDIbW8BfjD6k6wfns3XR7CD7QAEXWajEyUhkT9ZrBS4A06tgIUbYbSHtWhJOTrwYPvswZz/LG8IAL46Olex95VXYl90CqQ66ZWuaeUNIKqwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765132220; c=relaxed/simple;
	bh=YwwTM0RUM+hEqvCRZFkIEJvxCdt6l+TvVb5/n/rf8yk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ppt5mF+ufwQyqENqHa0FzGfLkNHMAJM9mg+qflnqJL11IdOwgdFT1wllWHF1Ug7ys0P5vemeB/1PjN8XSt83H/R9d1OUA6+uOkHw6t0VvswKpEDXVmhI5390Sg/KawvsQFwEjVwpAZhDekGK4zf+hUgYALCNtXQoWwJNScRVj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=c7QVAE+G; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 6db13834-d39b-11f0-b0b9-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6db13834-d39b-11f0-b0b9-00505699b430;
	Sun, 07 Dec 2025 19:34:56 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c279d7fa-d39a-11f0-80d9-00505699693e;
	Sun, 07 Dec 2025 19:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=sZ6knXE2b7duLXf1Szbrvpv7t3cS3ret1ZHO1YPYS4c=;
	b=c7QVAE+GcJN0/d1xePupQxTJbqPfaO6/b4IaVWNwd8w1aE27r8DQ7eX10ApR1ISv8my2AuS1U3Y2k
	 30kJBfbDJwlBWqQPB6d8DuJV/RbdOQx2KP3rfsV8hYudHHS8mnD/RCbDf0oDXd6yXyf3FNQ+7yo/sT
	 7VM78f291vqCdbB9VRM0gamV7q3cbVsjBeDF5dWRljvCNovU03H3Cih8Aip5aUR5ZhF3kGWjwBimMV
	 /tz1fUIff2voiYwiUoRp2HUcDKE50AT+a1IcWIgT7AbQShSguTCvAEMB+fQ027QJsF+WGX1wXVddIh
	 nlZKFhh7SPq+TfawtsO/dgwPfBduXCQ==
X-KPN-MID: 33|UyOnERTg2emV0sWaJTi/t03jS2laK8r/NUAq0wejS77QwUaDy+N8GuPr011rRtj
 9G3ab9IF2DZjRUFVmQSsP9lyYWesuOjEI/XFFoRTh+DI=
X-CMASSUN: 33|G1g/xgRtJLlTQRosmK62+bw3dYwh8WNwMvTI9SLqczOpi3mlMDqpYyBWaxdhByV
 RvERufxXDSMqgWCXqRIqxIA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c26a8138-d39a-11f0-b8d7-005056995d6c;
	Sun, 07 Dec 2025 19:30:08 +0100 (CET)
Date: Sun, 7 Dec 2025 19:30:08 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
 <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Message-ID: <2000105566.816789.1765132208865@kpc.webmail.kpnmail.nl>
In-Reply-To: <d84de70a91656d57b27831043b6ab064c89db828.camel@ibm.com>
References: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
 <18cf065cbc331fd2f287c4baece3a33cd1447ef6.camel@ibm.com>
 <299926848.3375545.1764534866882@kpc.webmail.kpnmail.nl>
 <01e9ce7fb96e555f0ab07f27890b0ed3406a92ae.camel@ibm.com>
 <604178298.203251.1764693934054@kpc.webmail.kpnmail.nl>
 <d84de70a91656d57b27831043b6ab064c89db828.camel@ibm.com>
Subject: RE: [PATCH v2] hfs: replace BUG_ONs with error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hi Viacheslav,

> 
> > +	    return -EINVAL;
> 
> It's not about input values, from my point of view. We have
> folder_count/file_count out of range. I think -ERANGE more good fit here.

There is not really any good errno to indicate programmer error, or something like
that. I saw in ext2 that they will sometimes use EINVAL for this, although I agree
that this has nothing to do with user input.

But I have no objection to changing it to ERANGE.

> >  
> > +static bool hfs_mdb_verify(struct super_block *sb) {
> > +	struct hfs_sb_info *sbi = HFS_SB(sb);
> > +
> > +	/* failure of one of the following checks indicates programmer error */
> > +	if (atomic64_read(&sbi->next_id) > U32_MAX)
> > +		pr_err("mdb invalid: next CNID exceeds limit\n");
> > +	else if (atomic64_read(&sbi->file_count) > U32_MAX)
> > +		pr_err("mdb invalid: file count exceeds limit\n");
> > +	else if (atomic64_read(&sbi->folder_count) > U32_MAX)
> > +		pr_err("mdb invalid: folder count exceeds limit\n");
> > +	else
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static int hfs_sync_fs(struct super_block *sb, int wait)
> >  {
> > +	if (!hfs_mdb_verify(sb)) {
> > +		pr_err("cannot sync fs because hfs_mdb_verify() failed\n");
> > +		return -EINVAL;
> 
> OK. I think that don't execute commit is not good strategy here, anyway. First
> of all, we are protecting from exceeding next_id/folder_count/file_count above
> U32_MAX. So, it's really low probability event. Potentially, we still could have
> such corruption during file system driver operations. However, even if
> next_id/folder_count/file_count values will be inconsistent, then FSCK can
> easily recover file system.
> 
> So, I suggest of executing the check and inform about potential corruption with
> recommendation of running FSCK. But we need to execute commit anyway, because of
> low probability of such event and easy recovering by FSCK from such corruption.
> So, don't return error here but continue the logic. To break commit is more
> harmful here than to execute it, from my point of view.
>

I have incorported your suggestions for improvement and retested. Please let me know
what you think, and again thanks for your time. I am learing quite a lot from this
discussion :)


diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..9df3d5b9c87e 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, mode);
-	if (!inode)
-		return -ENOMEM;
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -254,11 +254,19 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
  */
 static int hfs_remove(struct inode *dir, struct dentry *dentry)
 {
+	struct hfs_sb_info *sbi = HFS_SB(dir->i_sb);
 	struct inode *inode = d_inode(dentry);
 	int res;
 
 	if (S_ISDIR(inode->i_mode) && inode->i_size != 2)
 		return -ENOTEMPTY;
+
+	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX
+	    || atomic64_read(&sbi->file_count) > U32_MAX)) {
+	    pr_err("cannot remove file/folder: count exceeds limit\n");
+	    return -ERANGE;
+	}
+
 	res = hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
 	if (res)
 		return res;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index fff149af89da..76b6f19c251f 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -188,6 +188,7 @@ extern void hfs_delete_inode(struct inode *);
 extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
+extern bool hfs_mdb_verify_limits(struct super_block *);
 extern int hfs_mdb_get(struct super_block *);
 extern void hfs_mdb_commit(struct super_block *);
 extern void hfs_mdb_close(struct super_block *);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 81ad93e6312f..98089ac490db 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -186,16 +186,23 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -ERANGE;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		atomic64_dec(&HFS_SB(sb)->next_id);
+		pr_err("cannot create new inode: next CNID exceeds limit\n");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -209,7 +216,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count > U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->folder_count);
+			pr_err("cannot create new inode: folder count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -219,7 +230,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->file_count);
+			pr_err("cannot create new inode: file count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -243,6 +258,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);
+	out_err:
+		return ERR_PTR(err);
 }
 
 void hfs_delete_inode(struct inode *inode)
@@ -251,7 +271,6 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
@@ -260,7 +279,6 @@ void hfs_delete_inode(struct inode *inode)
 		return;
 	}
 
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..84acb67d2551 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -64,6 +64,22 @@ static int hfs_get_last_session(struct super_block *sb,
 	return 0;
 }
 
+bool hfs_mdb_verify_limits(struct super_block *sb)
+{
+	struct hfs_sb_info *sbi = HFS_SB(sb);
+
+	if (atomic64_read(&sbi->next_id) > U32_MAX)
+		pr_warn("mdb invalid: next CNID exceeds limit\n");
+	else if (atomic64_read(&sbi->file_count) > U32_MAX)
+		pr_warn("mdb invalid: file count exceeds limit\n");
+	else if (atomic64_read(&sbi->folder_count) > U32_MAX)
+		pr_warn("mdb invalid: folder count exceeds limit\n");
+	else
+		return true;
+
+	return false;
+}
+
 /*
  * hfs_mdb_get()
  *
@@ -156,6 +172,12 @@ int hfs_mdb_get(struct super_block *sb)
 	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
 	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
 
+	if (!hfs_mdb_verify_limits(sb)) {
+		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommended.\n");
+		pr_warn("mounting read only.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
@@ -209,7 +231,7 @@ int hfs_mdb_get(struct super_block *sb)
 
 	attrib = mdb->drAtrb;
 	if (!(attrib & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
-		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  mounting read-only.\n");
+		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.	Mounting read-only.\n");
 		sb->s_flags |= SB_RDONLY;
 	}
 	if ((attrib & cpu_to_be16(HFS_SB_ATTRIB_SLOCK))) {
@@ -273,15 +295,12 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
 		mdb->drNxtCNID =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 		mdb->drFilCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..ca5f9b5a296e 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,6 +34,9 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
+	if (!hfs_mdb_verify_limits(sb))
+		pr_warn("hfs_mdb_verify_limits() failed during filesystem sync\n");
+
 	hfs_mdb_commit(sb);
 	return 0;
 }
@@ -65,6 +68,9 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
+	if (!hfs_mdb_verify_limits(sb))
+		pr_warn("hfs_mdb_verify_limits() failed during mdb flushing\n");
+
 	hfs_mdb_commit(sb);
 }

Thanks,
Jori.

