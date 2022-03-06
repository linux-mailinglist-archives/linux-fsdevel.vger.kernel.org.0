Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C174CEC6A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 18:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiCFRMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiCFRMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 12:12:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CF66CAA
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 09:11:49 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so262090pfc.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Mar 2022 09:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fxcCv+x1enWDahxdqxWnpZzQVrhBKNa2OQIkL1qCENI=;
        b=eB8u4hZSp7IzMCTfziZOjl5sRWIDTZmkFYf8nKcNix5lfJh87Nc3GHNuIJ6SWLyok/
         odw1PcW3xWk4Nfz4F6LEK7zkrN3VxhJ3smQHLmxAd5HZCdrshjR3HeeqBcJhGbdbN5TL
         cj+nrolpfcg8enoZ6aASIeYflheIAhR3o/LE5sXf0bAQtMy8bDNT4HO3engxgD5i8LWz
         jv5VtmedqHYzJ3BbcltxDhVQ4LT5tCJS4j+HGVugu57SALqOJ1FMbuw7PIqGvhx6v2mR
         4k6JFWpM8C0Q7sS6PmxV0Svp0U6o+uGW7+sQOYLPMs3B/jvVIuF+51E+Bk46OdCDuK0Q
         y1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxcCv+x1enWDahxdqxWnpZzQVrhBKNa2OQIkL1qCENI=;
        b=LNfwq4GTeV1MzBCE0Vlklbms+pLFWxm7UPnBPSxmxGlZNrHWW0NuX0iFF5i5sEJPkK
         ClwSwaHtAWmHpkKdxnG9b2gOpvqRd2WcZVh0P2S+oVlHP8fxv4iNCc4BojXKcEgEyLDz
         e8+sAt17EgbGJIugFHwxdpocuds1hrlZ/jZ5aEip0xuD7d/EKxgocmg5Zdt1EHVdSfBQ
         +KSh2Fd8n+JDr92xFRFqHusZZpjSdSFXxy9FyxMR63FHCQuMhxPDU+XlRuvdyhg62HkN
         fiHsXHq18vZ7KJWKn8oyBar4iAw+jYNNF8Yo/0VWXmq86Rrfdaqkhn4d54TN8XUGhca+
         Opkg==
X-Gm-Message-State: AOAM532cLCtN1GivUc0LOs+yIPT8ijnr1I6ancuUctyScK7LC4rDG4r8
        FENSZi9ZOOldHGydVo1gnZ7vCg==
X-Google-Smtp-Source: ABdhPJxWc8Qb/xZyPyqF7cWiGAyTFX0lWQzeaEwnT9nQBp2BRDVUR0VvkBxhkfNBD5w97JBXjn2vSQ==
X-Received: by 2002:a05:6a00:a0c:b0:4f6:661e:8dda with SMTP id p12-20020a056a000a0c00b004f6661e8ddamr8869238pfh.66.1646586709291;
        Sun, 06 Mar 2022 09:11:49 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004e17b1da847sm12696723pfw.167.2022.03.06.09.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 09:11:48 -0800 (PST)
Message-ID: <2241127c-c600-529a-ae41-30cbcc6b281d@kernel.dk>
Date:   Sun, 6 Mar 2022 10:11:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
Cc:     sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220305214056.GO3927073@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/22 2:40 PM, Dave Chinner wrote:
> On Sat, Mar 05, 2022 at 06:19:29AM +0100, Christoph Hellwig wrote:
>> On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
>>> AFAICT, all the filesystem/IO path passthrough plumbing for hints is
>>> now gone, and no hardware will ever receive hints.  Doesn't this
>>> mean that file_write_hint(), file->f_write_hint and iocb->ki_hint
>>> are now completely unused, too?
>>
>> No, for the reason tha you state below.  f2fs still uses it.
> 
> My point is that f2fs uses i_write_hint, not f_write_hint or
> ki_hint. IOWs, nothing in the IO path use the iocb or file write
> hints anymore because they only ever got used to set the hint for
> bios. It's now unused information.
> 
> According to the io_uring ppl, setup of unnecessary fields in the
> iocb has a measurable cost and they've done work to minimise it in
> the past. So if these fields are not actually used by anyone in the
> IO path, why should we still pay the cost calling
> ki_hint_validate(file_write_hint(file)) when setting up an iocb?

Yes, I think we should kill it. If we retain the inode hint, the f2fs
doesn't need a any changes. And it should be safe to make the per-file
fcntl hints return EINVAL, which they would on older kernels anyway.
Untested, but something like the below.


diff --git a/fs/aio.c b/fs/aio.c
index 4ceba13a7db0..eb0948bb74f1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1478,7 +1478,6 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_flags = iocb_flags(req->ki_filp);
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
-	req->ki_hint = ki_hint_validate(file_write_hint(req->ki_filp));
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
 		/*
 		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 753986ea1583..bc7c7a7d9260 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -138,7 +138,6 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos + skipped;
 	ki->iocb.ki_flags	= IOCB_DIRECT;
-	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->skipped		= skipped;
 	ki->object		= object;
@@ -313,7 +312,6 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	ki->iocb.ki_filp	= file;
 	ki->iocb.ki_pos		= start_pos;
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
-	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->object		= object;
 	ki->inval_counter	= cres->inval_counter;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3c98ef6af97d..45076c01a2ba 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4479,10 +4479,8 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	const bool do_opu = f2fs_lfs_mode(sbi);
-	const int whint_mode = F2FS_OPTION(sbi).whint_mode;
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
-	const enum rw_hint hint = iocb->ki_hint;
 	unsigned int dio_flags;
 	struct iomap_dio *dio;
 	ssize_t ret;
@@ -4515,8 +4513,6 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		if (do_opu)
 			down_read(&fi->i_gc_rwsem[READ]);
 	}
-	if (whint_mode == WHINT_MODE_OFF)
-		iocb->ki_hint = WRITE_LIFE_NOT_SET;
 
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
@@ -4539,8 +4535,6 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ret = iomap_dio_complete(dio);
 	}
 
-	if (whint_mode == WHINT_MODE_OFF)
-		iocb->ki_hint = hint;
 	if (do_opu)
 		up_read(&fi->i_gc_rwsem[READ]);
 	up_read(&fi->i_gc_rwsem[WRITE]);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de5..e26444e977e1 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -292,21 +292,8 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case F_GET_FILE_RW_HINT:
-		h = file_write_hint(file);
-		if (copy_to_user(argp, &h, sizeof(*argp)))
-			return -EFAULT;
-		return 0;
 	case F_SET_FILE_RW_HINT:
-		if (copy_from_user(&h, argp, sizeof(h)))
-			return -EFAULT;
-		hint = (enum rw_hint) h;
-		if (!rw_hint_valid(hint))
-			return -EINVAL;
-
-		spin_lock(&file->f_lock);
-		file->f_write_hint = hint;
-		spin_unlock(&file->f_lock);
-		return 0;
+		return -EINVAL;
 	case F_GET_RW_HINT:
 		h = inode->i_write_hint;
 		if (copy_to_user(argp, &h, sizeof(*argp)))
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 23e7f93d3956..02400fd00501 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3790,7 +3790,6 @@ static int io_write_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	if (unlikely(!(req->file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	req->rw.kiocb.ki_hint = ki_hint_validate(file_write_hint(req->file));
 	return io_prep_rw(req, sqe);
 }
 
diff --git a/fs/open.c b/fs/open.c
index 9ff2f621b760..1315253e0247 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -835,7 +835,6 @@ static int do_dentry_open(struct file *f,
 	     likely(f->f_op->write || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
 
-	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..a1fc3b41cd82 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -327,7 +327,6 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret);
 	void			*private;
 	int			ki_flags;
-	u16			ki_hint;
 	u16			ki_ioprio; /* See linux/ioprio.h */
 	struct wait_page_queue	*ki_waitq; /* for async buffered IO */
 	randomized_struct_fields_end
@@ -967,7 +966,6 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
-	enum rw_hint		f_write_hint;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
@@ -2215,31 +2213,13 @@ static inline bool HAS_UNMAPPED_ID(struct user_namespace *mnt_userns,
 	       !gid_valid(i_gid_into_mnt(mnt_userns, inode));
 }
 
-static inline enum rw_hint file_write_hint(struct file *file)
-{
-	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
-		return file->f_write_hint;
-
-	return file_inode(file)->i_write_hint;
-}
-
 static inline int iocb_flags(struct file *file);
 
-static inline u16 ki_hint_validate(enum rw_hint hint)
-{
-	typeof(((struct kiocb *)0)->ki_hint) max_hint = -1;
-
-	if (hint <= max_hint)
-		return hint;
-	return 0;
-}
-
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
-		.ki_hint = ki_hint_validate(file_write_hint(filp)),
 		.ki_ioprio = get_current_ioprio(),
 	};
 }
@@ -2250,7 +2230,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = kiocb_src->ki_flags,
-		.ki_hint = kiocb_src->ki_hint,
 		.ki_ioprio = kiocb_src->ki_ioprio,
 		.ki_pos = kiocb_src->ki_pos,
 	};
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f701bb23f83c..1779e133cea0 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -956,12 +956,11 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 		__entry->rw	= rw;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_hint = %x ki_ioprio = %x rw = %d",
+	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
 		__entry->iocb->ki_pos,
 		__entry->len,
 		__entry->iocb->ki_flags,
-		__entry->iocb->ki_hint,
 		__entry->iocb->ki_ioprio,
 		__entry->rw)
 );

-- 
Jens Axboe

