Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86744777A55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjHJOTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjHJOTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:19:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBBE2698
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:19:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcf2de59cso139376366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1691677180; x=1692281980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6On6ezVfaROM5J4WEorsBdUSC1QZ8obRIX68wfrY3ZA=;
        b=RL+AX595VUrjAZm2kiKmXG+mcT9KJIWfJDWVh41r6BpkM8GKa6O3mp+2zE5wa3LPcx
         RN8bepIbr6llmNKj0Bb8ukjVRwhbdsqgS9aYEYgq3yoZwx8pGbiWEYS5ZhpBovYlcVYs
         y6LIw7+wkAoDk9QkIsxBBnG87iNNsM6Ak1eaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677180; x=1692281980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6On6ezVfaROM5J4WEorsBdUSC1QZ8obRIX68wfrY3ZA=;
        b=c09WKvjsZ1Tj+8CZUbK9eb7jPiIAUu6n8/kn40AD897/P3wI/c+WXmpaPAw+iFKROY
         z97BbPk9SRWAdCm5SvsVMKg8jZ3BjVraUJH37upszS/ZNXZ+EuI34zzfFixK+rhsRNYh
         Dy8w7mwQhhUFGU+xt11UxrjD5ZnOlCLq9DPeZHWtWcWXO1jajh8ZgcVci2zkKDnaKBSj
         ZIV0zQlwZ1vQap/DSkL7pd51vQMyguEia0gLJa6cw/rCf6GSur7baZy4vYKqWUfOaAMH
         3HkrTqdMCemRdX7WjwVnnXJ8Cv9fNVYEhY/NcSOzr3AwopJDGjQJVcmvdJwu6hNS5t8D
         ssrw==
X-Gm-Message-State: AOJu0YzDlCY0XFkF5trDUhdQq5VDLFnPYJXPobHK7oVI3urU+ncFQ0db
        Y6MT1mVpopdl5LNyxSs0yJoEIQ==
X-Google-Smtp-Source: AGHT+IG/M12saXXYvv6V8yCWNlTe93WDc6PDWJ2laxX2+mY2xULH2kMH+loPBTHxhgJ/FaTVrmJ2aw==
X-Received: by 2002:a17:906:5a55:b0:98d:5ae2:f1c with SMTP id my21-20020a1709065a5500b0098d5ae20f1cmr2025914ejc.34.1691677179527;
        Thu, 10 Aug 2023 07:19:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906365800b00992e94bcfabsm996414ejb.167.2023.08.10.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:19:38 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:19:37 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     kernel test robot <lkp@intel.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/5] fuse: implement statx
Message-ID: <ZNTx+Zol0UX7y5Gk@miu.piliscsaba.redhat.com>
References: <20230810105501.1418427-5-mszeredi@redhat.com>
 <202308102130.EEqF5GG3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308102130.EEqF5GG3-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:34:59PM +0800, kernel test robot wrote:
> Hi Miklos,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on mszeredi-fuse/for-next]


Thanks.

Updated patch:

---
From: Miklos Szeredi <mszeredi@redhat.com>
Subject: fuse: implement statx

Allow querying btime.  When btime is requested in mask, then FUSE_STATX
request is sent.  Otherwise keep using FUSE_GETATTR.

The userspace interface for statx matches that of the statx(2) API.
However there are limitations on how this interface is used:

 - returned basic stats and btime are used, stx_attributes, etc. are
   ignored

 - always query basic stats and btime, regardless of what was requested

 - requested sync type is ignored, the default is passed to the server

 - if server returns with some attributes missing from the result_mask,
   then no attributes will be cached

 - btime is not cached yet (next patch will fix that)

For new inodes initialize fi->inval_mask to "all invalid", instead of "all
valid" as previously.  Also only clear basic stats from inval_mask when
caching attributes.  This will result in the caching logic not thinking
that btime is cached.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c    |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h |    3 +
 fs/fuse/inode.c  |    5 +-
 3 files changed, 107 insertions(+), 7 deletions(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -350,10 +350,14 @@ int fuse_valid_type(int m)
 		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
 }
 
+static bool fuse_valid_size(u64 size)
+{
+	return size <= LLONG_MAX;
+}
+
 bool fuse_invalid_attr(struct fuse_attr *attr)
 {
-	return !fuse_valid_type(attr->mode) ||
-		attr->size > LLONG_MAX;
+	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
 }
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
@@ -1143,6 +1147,84 @@ static void fuse_fillattr(struct inode *
 	stat->blksize = 1 << blkbits;
 }
 
+static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
+{
+	memset(attr, 0, sizeof(*attr));
+	attr->ino = sx->ino;
+	attr->size = sx->size;
+	attr->blocks = sx->blocks;
+	attr->atime = sx->atime.tv_sec;
+	attr->mtime = sx->mtime.tv_sec;
+	attr->ctime = sx->ctime.tv_sec;
+	attr->atimensec = sx->atime.tv_nsec;
+	attr->mtimensec = sx->mtime.tv_nsec;
+	attr->ctimensec = sx->ctime.tv_nsec;
+	attr->mode = sx->mode;
+	attr->nlink = sx->nlink;
+	attr->uid = sx->uid;
+	attr->gid = sx->gid;
+	attr->rdev = new_encode_dev(MKDEV(sx->rdev_major, sx->rdev_minor));
+	attr->blksize = sx->blksize;
+}
+
+static int fuse_do_statx(struct inode *inode, struct file *file,
+			 struct kstat *stat)
+{
+	int err;
+	struct fuse_attr attr;
+	struct fuse_statx *sx;
+	struct fuse_statx_in inarg;
+	struct fuse_statx_out outarg;
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	u64 attr_version = fuse_get_attr_version(fm->fc);
+	FUSE_ARGS(args);
+
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outarg, 0, sizeof(outarg));
+	/* Directories have separate file-handle space */
+	if (file && S_ISREG(inode->i_mode)) {
+		struct fuse_file *ff = file->private_data;
+
+		inarg.getattr_flags |= FUSE_GETATTR_FH;
+		inarg.fh = ff->fh;
+	}
+	/* For now leave sync hints as the default, request all stats. */
+	inarg.sx_flags = 0;
+	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	args.opcode = FUSE_STATX;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(outarg);
+	args.out_args[0].value = &outarg;
+	err = fuse_simple_request(fm, &args);
+	if (err)
+		return err;
+
+	sx = &outarg.stat;
+	if (((sx->mask & STATX_SIZE) && !fuse_valid_size(sx->size)) ||
+	    ((sx->mask & STATX_TYPE) && (!fuse_valid_type(sx->mode) ||
+					 inode_wrong_type(inode, sx->mode)))) {
+		make_bad_inode(inode);
+		return -EIO;
+	}
+
+	fuse_statx_to_attr(&outarg.stat, &attr);
+	if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
+		fuse_change_attributes(inode, &attr, ATTR_TIMEOUT(&outarg),
+				       attr_version);
+	}
+	stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
+	stat->btime.tv_sec = sx->btime.tv_sec;
+	stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+	fuse_fillattr(inode, &attr, stat);
+	stat->result_mask |= STATX_TYPE;
+
+	return 0;
+}
+
 static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 			   struct file *file)
 {
@@ -1194,13 +1276,18 @@ static int fuse_update_get_attr(struct i
 				unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err = 0;
 	bool sync;
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
-	/* FUSE only supports basic stats */
-	request_mask &= STATX_BASIC_STATS;
+
+	/* FUSE only supports basic stats and possibly btime */
+	request_mask &= STATX_BASIC_STATS | STATX_BTIME;
+retry:
+	if (fc->no_statx)
+		request_mask &= STATX_BASIC_STATS;
 
 	if (!request_mask)
 		sync = false;
@@ -1215,7 +1302,16 @@ static int fuse_update_get_attr(struct i
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		err = fuse_do_getattr(inode, stat, file);
+		/* Try statx if BTIME is requested */
+		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
+			err = fuse_do_statx(inode, file, stat);
+			if (err == -ENOSYS) {
+				fc->no_statx = 1;
+				goto retry;
+			}
+		} else {
+			err = fuse_do_getattr(inode, stat, file);
+		}
 	} else if (stat) {
 		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		stat->mode = fi->orig_i_mode;
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -792,6 +792,9 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	/* Is statx not implemented by fs? */
+	unsigned int no_statx:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -77,7 +77,7 @@ static struct inode *fuse_alloc_inode(st
 		return NULL;
 
 	fi->i_time = 0;
-	fi->inval_mask = 0;
+	fi->inval_mask = ~0;
 	fi->nodeid = 0;
 	fi->nlookup = 0;
 	fi->attr_version = 0;
@@ -172,7 +172,8 @@ void fuse_change_attributes_common(struc
 
 	fi->attr_version = atomic64_inc_return(&fc->attr_version);
 	fi->i_time = attr_valid;
-	WRITE_ONCE(fi->inval_mask, 0);
+	/* Clear basic stats from invalid mask */
+	set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
 
 	inode->i_ino     = fuse_squash_ino(attr->ino);
 	inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
