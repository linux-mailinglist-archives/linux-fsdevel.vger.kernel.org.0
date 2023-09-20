Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216BD7A761B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjITIl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjITIl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:41:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50E93;
        Wed, 20 Sep 2023 01:41:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F97CC433C8;
        Wed, 20 Sep 2023 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695199310;
        bh=qGh90UNcKG/Be9UhcsQucQmAlzzaN0ybdDwui9BIyYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFXFNGFoQU2CKw9WyfGOIqib6ndJAqnLiG0gf5coXTntD9bzGoDVbWnIjqFY5yw7w
         /iL0Uod2MFZ8DEr6puUf1sJCredMIGJpWb79vtbE1ushIQwYZMxYIi/wrGi9Fb08X3
         lSA57r158BOH8f+EL6t2kjQEmID+gvoToIjnVUls1kcLXlPyD1YnLKMqHSQHxJwNle
         vpfc8azuJlJ8vyz4F1Ic7z+BrOBPimV2UU0lRBnSM6gAhS5GK9UYFCZFWZn+W0Rcg0
         ZifyAdzqTfctk3qOLSOZL59aCo+mxjvM+Qd6lemjUSliLN+1OQBJgtNIB7A++8sTra
         7xjjm3n+ayagw==
Date:   Wed, 20 Sep 2023 10:41:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Bruno Haible <bruno@clisp.org>, Jan Kara <jack@suse.cz>,
        Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bo b Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <l@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230920-leerung-krokodil-52ec6cb44707@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > f1 was last written to *after* f2 was last written to. If the timestamp of f1
> > is then lower than the timestamp of f2, timestamps are fundamentally broken.
> > 
> > Many things in user-space depend on timestamps, such as build system
> > centered around 'make', but also 'find ... -newer ...'.
> > 
> 
> 
> What does breakage with make look like in this situation? The "fuzz"
> here is going to be on the order of a jiffy. The typical case for make
> timestamp comparisons is comparing source files vs. a build target. If
> those are being written nearly simultaneously, then that could be an
> issue, but is that a typical behavior? It seems like it would be hard to
> rely on that anyway, esp. given filesystems like NFS that can do lazy
> writeback.
> 
> One of the operating principles with this series is that timestamps can
> be of varying granularity between different files. Note that Linux
> already violates this assumption when you're working across filesystems
> of different types.
> 
> As to potential fixes if this is a real problem:
> 
> I don't really want to put this behind a mount or mkfs option (a'la
> relatime, etc.), but that is one possibility.
> 
> I wonder if it would be feasible to just advance the coarse-grained
> current_time whenever we end up updating a ctime with a fine-grained
> timestamp? It might produce some inode write amplification. Files that

Less than ideal imho.

If this risks breaking existing workloads by enabling it unconditionally
and there isn't a clear way to detect and handle these situations
without risk of regression then we should move this behind a mount
option.

So how about the following:

From cb14add421967f6e374eb77c36cc4a0526b10d17 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 20 Sep 2023 10:00:08 +0200
Subject: [PATCH] vfs: move multi-grain timestamps behind a mount option

While we initially thought we can do this unconditionally it turns out
that this might break existing workloads that rely on timestamps in very
specific ways and we always knew this was a possibility. Move
multi-grain timestamps behind a vfs mount option.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_context.c     | 18 ++++++++++++++++++
 fs/inode.c          |  4 ++--
 fs/proc_namespace.c |  1 +
 fs/stat.c           |  2 +-
 include/linux/fs.h  |  4 +++-
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a0ad7a0c4680..dd4dade0bb9e 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -44,6 +44,7 @@ static const struct constant_table common_set_sb_flag[] = {
 	{ "mand",	SB_MANDLOCK },
 	{ "ro",		SB_RDONLY },
 	{ "sync",	SB_SYNCHRONOUS },
+	{ "mgtime",	SB_MGTIME },
 	{ },
 };
 
@@ -52,18 +53,32 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
+	{ "nomgtime",	SB_MGTIME },
 	{ },
 };
 
+static inline int check_mgtime(unsigned int token, const struct fs_context *fc)
+{
+	if (token != SB_MGTIME)
+		return 0;
+	if (!(fc->fs_type->fs_flags & FS_MGTIME))
+		return invalf(fc, "Filesystem doesn't support multi-grain timestamps");
+	return 0;
+}
+
 /*
  * Check for a common mount option that manipulates s_flags.
  */
 static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 {
 	unsigned int token;
+	int ret;
 
 	token = lookup_constant(common_set_sb_flag, key, 0);
 	if (token) {
+		ret = check_mgtime(token, fc);
+		if (ret)
+			return ret;
 		fc->sb_flags |= token;
 		fc->sb_flags_mask |= token;
 		return 0;
@@ -71,6 +86,9 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 
 	token = lookup_constant(common_clear_sb_flag, key, 0);
 	if (token) {
+		ret = check_mgtime(token, fc);
+		if (ret)
+			return ret;
 		fc->sb_flags &= ~token;
 		fc->sb_flags_mask |= token;
 		return 0;
diff --git a/fs/inode.c b/fs/inode.c
index 54237f4242ff..fd1a2390aaa3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2141,7 +2141,7 @@ EXPORT_SYMBOL(current_mgtime);
 
 static struct timespec64 current_ctime(struct inode *inode)
 {
-	if (is_mgtime(inode))
+	if (IS_MGTIME(inode))
 		return current_mgtime(inode);
 	return current_time(inode);
 }
@@ -2588,7 +2588,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		now = current_time(inode);
 
 		/* Just copy it into place if it's not multigrain */
-		if (!is_mgtime(inode)) {
+		if (!IS_MGTIME(inode)) {
 			inode_set_ctime_to_ts(inode, now);
 			return now;
 		}
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 250eb5bf7b52..08f5bf4d2c6c 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_MGTIME, ",mgtime" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_opts *fs_infop;
diff --git a/fs/stat.c b/fs/stat.c
index 6e60389d6a15..2f18dd5de18b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -90,7 +90,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
 
-	if (is_mgtime(inode)) {
+	if (IS_MGTIME(inode)) {
 		fill_mg_cmtime(stat, request_mask, inode);
 	} else {
 		stat->mtime = inode->i_mtime;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa11927..03e415fb3a7c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1114,6 +1114,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODEV        BIT(2)	/* Disallow access to device special files */
 #define SB_NOEXEC       BIT(3)	/* Disallow program execution */
 #define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
+#define SB_MGTIME	BIT(5)	/* Use multi-grain timestamps */
 #define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
 #define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
 #define SB_NOATIME      BIT(10)	/* Do not update access times. */
@@ -2105,6 +2106,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, SB_MANDLOCK)
 #define IS_NOATIME(inode)	__IS_FLG(inode, SB_RDONLY|SB_NOATIME)
+#define IS_MGTIME(inode)	__IS_FLG(inode, SB_MGTIME)
 #define IS_I_VERSION(inode)	__IS_FLG(inode, SB_I_VERSION)
 
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
@@ -2366,7 +2368,7 @@ struct file_system_type {
  */
 static inline bool is_mgtime(const struct inode *inode)
 {
-	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
+	return inode->i_sb->s_flags & SB_MGTIME;
 }
 
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
-- 
2.34.1

