Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E27749BEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGFMgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFMgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:36:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02F6173F;
        Thu,  6 Jul 2023 05:36:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82D5A1FF2F;
        Thu,  6 Jul 2023 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/DW+D2T23iXIdidWQGW8IEELQazdx5hMZJQ3Lbkqow=;
        b=JYowUIym7ZuvUeYqBWNAxxtOcsBVebnNiU9ybNeoz0lIEolI8lcPq7rimOKDvjHUrjllfC
        okvI4A1MGmR9RCfsjRpJU5VG/xHlrotl2ovwGpfcYarHDH4JDZbfHGGeq9PDCcxm/DZx7O
        EKPi/i49jEVbBigfLHDZmPbZetfgx9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/DW+D2T23iXIdidWQGW8IEELQazdx5hMZJQ3Lbkqow=;
        b=/yui8KtJLWEvDsZC5u25FZUPh/Ue/2vkgq8wZ7hQ9lNSsbh30L6/2BnbfNIab5bdp6N6bc
        OhQXR4a3HidoozAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DA03138FC;
        Thu,  6 Jul 2023 12:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JKG7Gly1pmQjPAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:36:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 05E40A0707; Thu,  6 Jul 2023 14:36:43 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:36:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 42/92] ext4: convert to ctime accessor functions
Message-ID: <20230706123643.3pumra5f4fthz3qq@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-40-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hcdubtmx6fqvvmlf"
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-40-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hcdubtmx6fqvvmlf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 05-07-23 15:01:07, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Some comment below:

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0a2d55faa095..d502b930431b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3823,6 +3823,27 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  	return buffer_uptodate(bh);
>  }
>  
> +static inline void ext4_inode_set_ctime(struct inode *inode, struct ext4_inode *raw_inode)
> +{
> +	struct timespec64 ctime = inode_get_ctime(inode);
> +
> +	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra)) {
> +		raw_inode->i_ctime = cpu_to_le32(ctime.tv_sec);
> +		raw_inode->i_ctime_extra = ext4_encode_extra_time(&ctime);
> +	} else {
> +		raw_inode->i_ctime = cpu_to_le32(clamp_t(int32_t, ctime.tv_sec, S32_MIN, S32_MAX));
> +	}
> +}
> +
> +static inline void ext4_inode_get_ctime(struct inode *inode, const struct ext4_inode *raw_inode)
> +{
> +	struct timespec64 ctime = { .tv_sec = (signed)le32_to_cpu(raw_inode->i_ctime) };
> +
> +	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra))
> +		ext4_decode_extra_time(&ctime, raw_inode->i_ctime_extra);
> +	inode_set_ctime(inode, ctime.tv_sec, ctime.tv_nsec);
> +}
> +

This duplication is kind of unpleasant. I was looking into it for a while
and I think we can rather do some initial cleanup (attached patch 1) and
then your conversion patch would not need to duplicate the conversion code
(see attached patch 2).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--hcdubtmx6fqvvmlf
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-deduplicate-macros-for-converting-inode-timesta.patch"

From b9fd173302ca572f0160d8d41d13fa4792fe2720 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 6 Jul 2023 14:07:16 +0200
Subject: [PATCH 1/2] ext4: deduplicate macros for converting inode timestamps

In ext4 we have macros that convert between on-disk and in-memory time
stamps and due to various configuration details that is a non-trivial
task. We have two flavors of these macros - one for atime, mtime, and
ctime and one for crtime. Deduplicate implementation of these two
flavors. I will also simplify introduction of ctime accessor functions.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h       | 70 +++++++++++++++++++-------------------------
 fs/ext4/inode-test.c |  6 ++--
 2 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..99d145259d5a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -868,64 +868,54 @@ struct ext4_inode {
  * affected filesystem before 2242.
  */
 
-static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
+static inline __le32 ext4_encode_extra_time(struct timespec64 ts)
 {
-	u32 extra =((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK;
-	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
+	u32 extra = ((ts.tv_sec - (s32)ts.tv_sec) >> 32) & EXT4_EPOCH_MASK;
+	return cpu_to_le32(extra | (ts.tv_nsec << EXT4_EPOCH_BITS));
 }
 
-static inline void ext4_decode_extra_time(struct timespec64 *time,
-					  __le32 extra)
+static inline struct timespec64 ext4_decode_extra_time(__le32 base,
+						       __le32 extra)
 {
+	struct timespec64 ts = { .tv_sec = le32_to_cpu(base) };
+
 	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK)))
-		time->tv_sec += (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
-	time->tv_nsec = (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
+		ts.tv_sec += (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
+	ts.tv_nsec = (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
+	return ts;
 }
 
-#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
+#define EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, ts)			\
 do {										\
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     {\
-		(raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);	\
-		(raw_inode)->xtime ## _extra =					\
-				ext4_encode_extra_time(&(inode)->xtime);	\
-		}								\
-	else	\
-		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (inode)->xtime.tv_sec, S32_MIN, S32_MAX));	\
+	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra)) {	\
+		(raw_inode)->xtime = cpu_to_le32((ts).tv_sec);			\
+		(raw_inode)->xtime ## _extra = ext4_encode_extra_time(ts);	\
+	} else									\
+		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX));	\
 } while (0)
 
+#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
+	EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, (inode)->xtime)
+
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
-do {									       \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))		       \
-		(raw_inode)->xtime = cpu_to_le32((einode)->xtime.tv_sec);      \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime ## _extra))	       \
-		(raw_inode)->xtime ## _extra =				       \
-				ext4_encode_extra_time(&(einode)->xtime);      \
-} while (0)
+	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einode)->xtime)
+
+#define EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode)			\
+	(EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra) ?	\
+		ext4_decode_extra_time((raw_inode)->xtime,				\
+				       (raw_inode)->xtime ## _extra) :		\
+		(struct timespec64) {						\
+			.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime)	\
+		})
 
 #define EXT4_INODE_GET_XTIME(xtime, inode, raw_inode)				\
 do {										\
-	(inode)->xtime.tv_sec = (signed)le32_to_cpu((raw_inode)->xtime);	\
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra)) {	\
-		ext4_decode_extra_time(&(inode)->xtime,				\
-				       raw_inode->xtime ## _extra);		\
-		}								\
-	else									\
-		(inode)->xtime.tv_nsec = 0;					\
+	(inode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode);	\
 } while (0)
 
-
 #define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
 do {									       \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))		       \
-		(einode)->xtime.tv_sec = 				       \
-			(signed)le32_to_cpu((raw_inode)->xtime);	       \
-	else								       \
-		(einode)->xtime.tv_sec = 0;				       \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime ## _extra))	       \
-		ext4_decode_extra_time(&(einode)->xtime,		       \
-				       raw_inode->xtime ## _extra);	       \
-	else								       \
-		(einode)->xtime.tv_nsec = 0;				       \
+	(einode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode), raw_inode);	\
 } while (0)
 
 #define i_disk_version osd1.linux1.l_i_version
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index 7935ea6cf92c..f0c0fd507fbc 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -245,9 +245,9 @@ static void inode_test_xtimestamp_decoding(struct kunit *test)
 	struct timestamp_expectation *test_param =
 			(struct timestamp_expectation *)(test->param_value);
 
-	timestamp.tv_sec = get_32bit_time(test_param);
-	ext4_decode_extra_time(&timestamp,
-			       cpu_to_le32(test_param->extra_bits));
+	timestamp = ext4_decode_extra_time(
+				cpu_to_le32(get_32bit_time(test_param)),
+				cpu_to_le32(test_param->extra_bits));
 
 	KUNIT_EXPECT_EQ_MSG(test,
 			    test_param->expected.tv_sec,
-- 
2.35.3


--hcdubtmx6fqvvmlf
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-ext4-convert-to-ctime-accessor-functions.patch"

From 6a46b34c5f5b71a327a88fc3425e37fd67706a52 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 6 Jul 2023 14:20:31 +0200
Subject: [PATCH 2/2] ext4: convert to ctime accessor functions

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/acl.c     |  2 +-
 fs/ext4/ext4.h    |  9 +++++++++
 fs/ext4/extents.c | 12 ++++++------
 fs/ext4/ialloc.c  |  2 +-
 fs/ext4/inline.c  |  4 ++--
 fs/ext4/inode.c   | 16 +++++++---------
 fs/ext4/ioctl.c   |  9 +++++----
 fs/ext4/namei.c   | 26 ++++++++++++--------------
 fs/ext4/super.c   |  2 +-
 fs/ext4/xattr.c   |  6 +++---
 10 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 27fcbddfb148..3bffe862f954 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -259,7 +259,7 @@ ext4_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	error = __ext4_set_acl(handle, inode, type, acl, 0 /* xattr_flags */);
 	if (!error && update_mode) {
 		inode->i_mode = mode;
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		error = ext4_mark_inode_dirty(handle, inode);
 	}
 out_stop:
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 99d145259d5a..d63543187359 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -897,6 +897,9 @@ do {										\
 #define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
 	EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, (inode)->xtime)
 
+#define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
+	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode))
+
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
 	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einode)->xtime)
 
@@ -913,6 +916,12 @@ do {										\
 	(inode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode);	\
 } while (0)
 
+#define EXT4_INODE_GET_CTIME(inode, raw_inode)					\
+do {										\
+	inode_set_ctime_to_ts(inode,						\
+		EXT4_INODE_GET_XTIME_VAL(i_ctime, inode, raw_inode));		\
+} while (0)
+
 #define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
 do {									       \
 	(einode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode), raw_inode);	\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e4115d338f10..202c76996b62 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4476,12 +4476,12 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		map.m_lblk += ret;
 		map.m_len = len = len - ret;
 		epos = (loff_t)map.m_lblk << inode->i_blkbits;
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		if (new_size) {
 			if (epos > new_size)
 				epos = new_size;
 			if (ext4_update_inode_size(inode, epos) & 0x1)
-				inode->i_mtime = inode->i_ctime;
+				inode->i_mtime = inode_get_ctime(inode);
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -4617,7 +4617,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
@@ -4642,7 +4642,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		goto out_mutex;
 	}
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	if (new_size)
 		ext4_update_inode_size(inode, new_size);
 	ret = ext4_mark_inode_dirty(handle, inode);
@@ -5378,7 +5378,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
@@ -5488,7 +5488,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	/* Expand file to avoid data loss if there is error while shifting */
 	inode->i_size += len;
 	EXT4_I(inode)->i_disksize += len;
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	ret = ext4_mark_inode_dirty(handle, inode);
 	if (ret)
 		goto out_stop;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 754f961cd9fd..48abef5f23e7 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1250,7 +1250,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	inode->i_ino = ino + group * EXT4_INODES_PER_GROUP(sb);
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	ei->i_crtime = inode->i_mtime;
 
 	memset(ei->i_data, 0, sizeof(ei->i_data));
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a4b7e4bc32d4..003861037374 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1037,7 +1037,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	return 1;
@@ -1991,7 +1991,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 		ext4_orphan_del(handle, inode);
 
 	if (err == 0) {
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		err = ext4_mark_inode_dirty(handle, inode);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43775a6ca505..86696b40c58f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3986,7 +3986,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(ret2))
 		ret = ret2;
@@ -4146,7 +4146,7 @@ int ext4_truncate(struct inode *inode)
 	if (inode->i_nlink)
 		ext4_orphan_del(handle, inode);
 
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	err2 = ext4_mark_inode_dirty(handle, inode);
 	if (unlikely(err2 && !err))
 		err = err2;
@@ -4249,7 +4249,7 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 	}
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 
-	EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+	EXT4_INODE_SET_CTIME(inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
@@ -4858,7 +4858,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		}
 	}
 
-	EXT4_INODE_GET_XTIME(i_ctime, inode, raw_inode);
+	EXT4_INODE_GET_CTIME(inode, raw_inode);
 	EXT4_INODE_GET_XTIME(i_mtime, inode, raw_inode);
 	EXT4_INODE_GET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_GET_XTIME(i_crtime, ei, raw_inode);
@@ -4981,7 +4981,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
-		EXT4_INODE_SET_XTIME(i_ctime, inode, raw_inode);
+		EXT4_INODE_SET_CTIME(inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 		ext4_inode_csum_set(inode, raw_inode, ei);
@@ -5376,10 +5376,8 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 * Update c/mtime on truncate up, ext4_truncate() will
 			 * update c/mtime in shrink case below
 			 */
-			if (!shrink) {
-				inode->i_mtime = current_time(inode);
-				inode->i_ctime = inode->i_mtime;
-			}
+			if (!shrink)
+				inode->i_mtime = inode_set_ctime_current(inode);
 
 			if (shrink)
 				ext4_fc_track_range(handle, inode,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 331859511f80..b0349f451863 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -449,7 +449,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	diff = size - size_bl;
 	swap_inode_data(inode, inode_bl);
 
-	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
+	inode_set_ctime_current(inode_bl);
 	inode_inc_iversion(inode);
 
 	inode->i_generation = get_random_u32();
@@ -663,7 +664,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 
 	ext4_set_inode_flags(inode, false);
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	inode_inc_iversion(inode);
 
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
@@ -774,7 +775,7 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 	}
 
 	EXT4_I(inode)->i_projid = kprojid;
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	inode_inc_iversion(inode);
 out_dirty:
 	rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
@@ -1266,7 +1267,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		err = ext4_reserve_inode_write(handle, inode, &iloc);
 		if (err == 0) {
-			inode->i_ctime = current_time(inode);
+			inode_set_ctime_current(inode);
 			inode_inc_iversion(inode);
 			inode->i_generation = generation;
 			err = ext4_mark_iloc_dirty(handle, inode, &iloc);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..07f6d96ebc60 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2203,7 +2203,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	 * happen is that the times are slightly out of date
 	 * and/or different from the directory change time.
 	 */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	ext4_update_dx_flag(dir);
 	inode_inc_iversion(dir);
 	err2 = ext4_mark_inode_dirty(handle, dir);
@@ -3197,7 +3197,8 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	 * recovery. */
 	inode->i_size = 0;
 	ext4_orphan_add(handle, inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_ctime_current(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (retval)
 		goto end_rmdir;
@@ -3271,7 +3272,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		retval = ext4_delete_entry(handle, dir, de, bh);
 		if (retval)
 			goto out_handle;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
+		dir->i_mtime = inode_set_ctime_current(dir);
 		ext4_update_dx_flag(dir);
 		retval = ext4_mark_inode_dirty(handle, dir);
 		if (retval)
@@ -3286,7 +3287,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		drop_nlink(inode);
 	if (!inode->i_nlink)
 		ext4_orphan_add(handle, inode);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (dentry && !retval)
 		ext4_fc_track_unlink(handle, dentry);
@@ -3463,7 +3464,7 @@ int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	ext4_inc_count(inode);
 	ihold(inode);
 
@@ -3641,8 +3642,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	if (ext4_has_feature_filetype(ent->dir->i_sb))
 		ent->de->file_type = file_type;
 	inode_inc_iversion(ent->dir);
-	ent->dir->i_ctime = ent->dir->i_mtime =
-		current_time(ent->dir);
+	ent->dir->i_mtime = inode_set_ctime_current(ent->dir);
 	retval = ext4_mark_inode_dirty(handle, ent->dir);
 	BUFFER_TRACE(ent->bh, "call ext4_handle_dirty_metadata");
 	if (!ent->inlined) {
@@ -3941,7 +3941,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	old.inode->i_ctime = current_time(old.inode);
+	inode_set_ctime_current(old.inode);
 	retval = ext4_mark_inode_dirty(handle, old.inode);
 	if (unlikely(retval))
 		goto end_rename;
@@ -3955,9 +3955,9 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (new.inode) {
 		ext4_dec_count(new.inode);
-		new.inode->i_ctime = current_time(new.inode);
+		inode_set_ctime_current(new.inode);
 	}
-	old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
+	old.dir->i_mtime = inode_set_ctime_current(old.inode);
 	ext4_update_dx_flag(old.dir);
 	if (old.dir_bh) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
@@ -4053,7 +4053,6 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	};
 	u8 new_file_type;
 	int retval;
-	struct timespec64 ctime;
 
 	if ((ext4_test_inode_flag(new_dir, EXT4_INODE_PROJINHERIT) &&
 	     !projid_eq(EXT4_I(new_dir)->i_projid,
@@ -4147,9 +4146,8 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 * Like most other Unix systems, set the ctime for inodes on a
 	 * rename.
 	 */
-	ctime = current_time(old.inode);
-	old.inode->i_ctime = ctime;
-	new.inode->i_ctime = ctime;
+	inode_set_ctime_current(old.inode);
+	inode_set_ctime_current(new.inode);
 	retval = ext4_mark_inode_dirty(handle, old.inode);
 	if (unlikely(retval))
 		goto end_rename;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..b54c70e1a74e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7103,7 +7103,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	}
 	EXT4_I(inode)->i_flags &= ~(EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
-	inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 321e3a888c20..dbe54cddda3d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -356,13 +356,13 @@ ext4_xattr_inode_hash(struct ext4_sb_info *sbi, const void *buffer, size_t size)
 
 static u64 ext4_xattr_inode_get_ref(struct inode *ea_inode)
 {
-	return ((u64)ea_inode->i_ctime.tv_sec << 32) |
+	return ((u64) inode_get_ctime(ea_inode).tv_sec << 32) |
 		(u32) inode_peek_iversion_raw(ea_inode);
 }
 
 static void ext4_xattr_inode_set_ref(struct inode *ea_inode, u64 ref_count)
 {
-	ea_inode->i_ctime.tv_sec = (u32)(ref_count >> 32);
+	inode_set_ctime(ea_inode, (u32)(ref_count >> 32), 0);
 	inode_set_iversion_raw(ea_inode, ref_count & 0xffffffff);
 }
 
@@ -2459,7 +2459,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 	}
 	if (!error) {
 		ext4_xattr_update_super_block(handle, inode->i_sb);
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		inode_inc_iversion(inode);
 		if (!value)
 			no_expand = 0;
-- 
2.35.3


--hcdubtmx6fqvvmlf--
