Return-Path: <linux-fsdevel+bounces-3337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA97F37CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 22:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C818B217EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB851038;
	Tue, 21 Nov 2023 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sqTMrify"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF1188
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 13:00:40 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso5569930276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700600440; x=1701205240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Et1T/4CIg1bn0RJ/0qLXSU1v0CZNumbOb0QRnvPzlCY=;
        b=sqTMrifyIFlkQGEO9spnXBEulrX28mcMN54AstPJ5v8VVBii6IQ5b4aZyadwdnpbxr
         Gx2/Nq/r4Aoa47XZ3+Cv9zI1ZsL7bhFUWkR/twLRdDb6Oj3KHjfhRs9CAC13v3RseLyk
         i1E3PyHBkZwXxsNnC4QZ6QveS86HaheG8fW8Oexpo5Up7z8RpcpRt1hE4oTIKPwsseQl
         wAVn3iYJF0WGaPGbPWUjlk7h6XTedKNeIZND8K2H2uJH2SXuBh32bYCpXzvVUCCO1yBd
         HQtwXpZTdj1FTO+WgiQLRru9rCMlY67YdtlEfuS+acjeR2P2p37nxFvrgpyiGX+UJpfT
         hiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700600440; x=1701205240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et1T/4CIg1bn0RJ/0qLXSU1v0CZNumbOb0QRnvPzlCY=;
        b=OU2eNfmmk5EZVEnahQp6OD82cjcAU3jrGKLenrBUaZojpaWmZs9nFQGoVcHv3YJyC6
         B3tnlh83LyE1VNa10xZAukQBSi2mz2KY7gRC7R2btxvf7XWF3ZcgoyCRgTpMxYmXe3cN
         d9L0bBkjzPzf27c1acHDsAQBHMg5VlVoj1iSy82frW6oOd7/AWtdiAsJgBFDEnN1m29v
         o/jZyUlrnT5so/d7I41eINyi96i51/lyjQhk/wcvT1M6Aud7P1GjFht9z0G4BDF1bnUr
         87LEBfaeo/n36IEy4pFpzCRuz1PGpOUS3xnEh9X/bn2DXZc9Se4xAaOd6WsQIVYsqUwp
         Xtyg==
X-Gm-Message-State: AOJu0YwJUCRELMKhN9FG/JOXF7o7pAGTobhjQWicmYsaj3fUNbMlFmBB
	bOfezOQSwLGq/ZnYA3V9vV7RsA==
X-Google-Smtp-Source: AGHT+IHA0vyj1VjKT6uNBssGhzuHuXq63pevVtGPB6A2hsws/7W0yt51WcO77L+7tzeaMlzsN0NNmg==
X-Received: by 2002:a25:60d6:0:b0:d9a:66a1:a957 with SMTP id u205-20020a2560d6000000b00d9a66a1a957mr184606ybb.13.1700600439791;
        Tue, 21 Nov 2023 13:00:39 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v127-20020a254885000000b00da041da21e7sm932379yba.65.2023.11.21.13.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:00:38 -0800 (PST)
Date: Tue, 21 Nov 2023 16:00:32 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: allow calling kiocb_end_write() unmatched with
 kiocb_start_write()
Message-ID: <20231121210032.GA1675377@perftesting>
References: <20231121132551.2337431-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121132551.2337431-1-amir73il@gmail.com>

On Tue, Nov 21, 2023 at 03:25:51PM +0200, Amir Goldstein wrote:
> We want to move kiocb_start_write() into vfs_iocb_iter_write(), after
> the permission hook, but leave kiocb_end_write() in the write completion
> handler of the callers of vfs_iocb_iter_write().
> 
> After this change, there will be no way of knowing in completion handler,
> if write has failed before or after calling kiocb_start_write().
> 
> Add a flag IOCB_WRITE_STARTED, which is set and cleared internally by
> kiocb_{start,end}_write(), so that kiocb_end_write() could be called for
> cleanup of async write, whether it was successful or whether it failed
> before or after calling kiocb_start_write().
> 
> This flag must not be copied by stacked filesystems (e.g. overlayfs)
> that clone the iocb to another iocb for io request on a backing file.
> 
> Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH1UfEeP8AtP+w@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

This is only a problem for cachefiles and overlayfs, and really just for
cachefiles because of the error handling thing.

What if instead we made vfs_iocb_iter_write() call kiocb_end_write() in the ret
!= EIOCBQUEUED case, that way it is in charge of the start and the end, and the
only case where the file system has to worry about is the actual io completion
path when the kiocb is completed.

The result is something like what I've pasted below, completely uncompiled and
untested.  Thanks,

Josef

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 009d23cd435b..5857241c5918 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -259,7 +259,8 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 
 	_enter("%ld", ret);
 
-	kiocb_end_write(iocb);
+	if (ki->was_async)
+		kiocb_end_write(iocb);
 
 	if (ret < 0)
 		trace_cachefiles_io_error(object, inode, ret,
@@ -319,8 +320,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 		ki->iocb.ki_complete = cachefiles_write_complete;
 	atomic_long_add(ki->b_writing, &cache->b_writing);
 
-	kiocb_start_write(&ki->iocb);
-
 	get_file(ki->iocb.ki_filp);
 	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 131621daeb13..19d2682d28f9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -295,11 +295,6 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE) {
-		kiocb_end_write(iocb);
-		ovl_file_modified(orig_iocb->ki_filp);
-	}
-
 	orig_iocb->ki_pos = iocb->ki_pos;
 	ovl_aio_put(aio_req);
 }
@@ -310,6 +305,11 @@ static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
 						   struct ovl_aio_req, iocb);
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
+	if (iocb->ki_flags & IOCB_WRITE) {
+		kiocb_end_write(iocb);
+		ovl_file_modified(orig_iocb->ki_filp);
+	}
+
 	ovl_aio_cleanup_handler(aio_req);
 	orig_iocb->ki_complete(orig_iocb, res);
 }
@@ -458,7 +458,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
 		refcount_set(&aio_req->ref, 2);
-		kiocb_start_write(&aio_req->iocb);
 		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
 		ovl_aio_put(aio_req);
 		if (ret != -EIOCBQUEUED)
diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..6ec3abed43dc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -821,7 +821,10 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
+	kiocb_start_write(iocb);
 	ret = call_read_iter(file, iocb, iter);
+	if (ret != -EIOCBQUEUED)
+		kiocb_end_write(iocb);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);

