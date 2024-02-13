Return-Path: <linux-fsdevel+bounces-11431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A65853C95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0343285C80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845056166A;
	Tue, 13 Feb 2024 21:01:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2C5DF3C;
	Tue, 13 Feb 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858116; cv=none; b=M7z+6qOZcFV51sdC5SesMZFIToL5PmjX8stTJW6GzW0ABI/4xKobRLyssIByozu0z8OdPRhW8+DSn69C+Oo3pXMnCRCAP095b1y5UEhweaWzmWhEKlepE6LLxiaEAoctqAePDgiVbtpYcO+s3+CKvfj1K0/B7vMt43bqicYBDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858116; c=relaxed/simple;
	bh=o7+6gUMfCgFkn+ZhV4RScqPHO3sa/QXuGPZsTH6M3eo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=saEmZv3BRU1iMtYO79V+Z1kbrpFLGDNhwTWbwPyMp7SpUwnB3gcEWk17d7bjIiuAS/9FAIIVCKB1PdgBulO7nUiRsf4f1RWAsoeExo7WWzzxWjM0uy07cIaYJzuIbV8Ncmd+XQyt0fYtHYJWFY3bBiFSfuYssewzyzLnrBuV68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93ddd76adso34526495ad.2;
        Tue, 13 Feb 2024 13:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858114; x=1708462914;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkZcQXtyypvexqT1ZYOLU6OKg8/PnPd/S57/jAViE0c=;
        b=axrFYqvJ330XlyPdLwwNiByAcnT8p9PxoyWlJA1pgS1X6Mb0fSYKOcVnTTLSv9waMZ
         FgwhwkdB4KZfY3+ICj/8p6l7Vpof5UQZynrrT112TKhg2KT+vYN09RkDDHnv5uAi5Tro
         fJrA/1ojVHbp1fGmUojjPpYpvoCUZyNygbSi2pwHjBbqptxly6xpokyNvGg1ejT3mL7A
         q2h6IlQNxwx9Ntk6MeixOgVPBoqb2J912JmDD/MnR6tq7FzuTBgYDI2s764PTdIcIpxJ
         j5bpfAHTudCuU9zqIglFc/KquiSsOTFVL1KekAUmSAX6ytRLZjdlsc+DhCMaS7ItoAWa
         NqMA==
X-Forwarded-Encrypted: i=1; AJvYcCVMBt82cWrrMMOYhUwdWU6c80pvdUmbUcBBTz8YJlin0JeSYNuj1CNJ3jsM+LReg49fnBE4lxvfN3sr/tsZaQ+B854XU0fjT0GK9tXWr5xY/hTJPsDrWcZ5/0YNvqEYG9+oiy4w+A==
X-Gm-Message-State: AOJu0Yyf+YsgP05QC6JDyt34aycifcocr4SIoutbHdZEcAUwIctvBlZX
	u35tCu6ok5Lc1I1hdsH2OqXfvUugnvU1XE2CR4lan5wVx8GvQalEiE7BZHTa
X-Google-Smtp-Source: AGHT+IG5gtFeFrrFXsWLDOPPJU8Zm0y9uwr26PVR9xfFcMLudtc/wi9q09qo+1w2YO7Jg2UqWWdNcQ==
X-Received: by 2002:a17:902:e88e:b0:1da:25a9:ba12 with SMTP id w14-20020a170902e88e00b001da25a9ba12mr872572plg.28.1707858113526;
        Tue, 13 Feb 2024 13:01:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUO87Tyd+JhdaVueCDppafVrVIrm/BzUnWA7c5c7vrQLM1Njb9B4iVDOMfPRkMRXZRrMIHzSzb2fr0aE+aiII+s1rJjm56vsa/viWTFhm2G3DwgDjmO4UNJ8xjbq6lXgg2pllTQX8Z3KmWZYcPb/rAYXPyjoF7wdsgkN9AXU5lt/qFzGO50aHZSVa34qxeyPIfQwhmse1oAq85uA6XRp9s17weltjD9ntEWCj8H14rS2M4MgIU7xBkk0zpIg==
Received: from ?IPV6:2620:0:1000:8411:85a5:575d:be51:8037? ([2620:0:1000:8411:85a5:575d:be51:8037])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170902f98600b001db4e014ed9sm475956plb.149.2024.02.13.13.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:01:53 -0800 (PST)
Message-ID: <3304d956-9273-4701-91ce-08248ffd5007@acm.org>
Date: Tue, 13 Feb 2024 13:01:51 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
 <20240209-katapultieren-lastkraftwagen-d28bbc0a92b2@brauner>
 <9a7294ef-6812-43bb-af50-a2b4659f2d15@kernel.dk>
 <4e47c7d4-ece3-4b8e-a4df-80d212f673fb@acm.org>
In-Reply-To: <4e47c7d4-ece3-4b8e-a4df-80d212f673fb@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 11:28, Bart Van Assche wrote:
> On 2/9/24 10:12, Jens Axboe wrote:
>> Greg, can you elaborate on how useful cancel is for gadgets? Is it one
>> of those things that was wired up "just because", or does it have
>> actually useful cases?
> 
> I found two use cases in the Android Open Source Project and have submitted
> CLs that request to remove the io_cancel() calls from that code. Although I
> think I understand why these calls were added, the race conditions that
> these io_cancel() calls try to address cannot be addressed completely by
> calling io_cancel().

(replying to my own e-mail) The adb daemon (adbd) maintainers asked me to
preserve the I/O cancellation code in adbd because it was introduced recently
in that code to fix an important bug. Does everyone agree with the approach of
the untested patches below?

Thanks,

Bart.

-----------------------------------------------------------------------------
[PATCH 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted
  by libaio

If kiocb_set_cancel_fn() is called for I/O submitted by io_uring, the
following kernel warning appears:

WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
Call trace:
  kiocb_set_cancel_fn+0x9c/0xa8
  ffs_epfile_read_iter+0x144/0x1d0
  io_read+0x19c/0x498
  io_issue_sqe+0x118/0x27c
  io_submit_sqes+0x25c/0x5fc
  __arm64_sys_io_uring_enter+0x104/0xab0
  invoke_syscall+0x58/0x11c
  el0_svc_common+0xb4/0xf4
  do_el0_svc+0x2c/0xb0
  el0_svc+0x2c/0xa4
  el0t_64_sync_handler+0x68/0xb4
  el0t_64_sync+0x1a4/0x1a8

Fix this by setting the IOCB_AIO_RW flag for read and write I/O that is
submitted by libaio.

Suggested-by: Jens Axboe <axboe@kernel.dk>
---
  fs/aio.c           | 9 ++++++++-
  include/linux/fs.h | 2 ++
  2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..da18dbcfcb22 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -593,6 +593,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
  	struct kioctx *ctx = req->ki_ctx;
  	unsigned long flags;

+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
  	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
  		return;

@@ -1509,7 +1516,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
  	req->ki_complete = aio_complete_rw;
  	req->private = NULL;
  	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = req->ki_filp->f_iocb_flags;
+	req->ki_flags = req->ki_filp->f_iocb_flags | IOCB_AIO_RW;
  	if (iocb->aio_flags & IOCB_FLAG_RESFD)
  		req->ki_flags |= IOCB_EVENTFD;
  	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..c2dcc98cb4c8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -352,6 +352,8 @@ enum rw_hint {
   * unrelated IO (like cache flushing, new IO generation, etc).
   */
  #define IOCB_DIO_CALLER_COMP	(1 << 22)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)

  /* for use in trace events */
  #define TRACE_IOCB_STRINGS \

-----------------------------------------------------------------------------

[PATCH 2/2] fs/aio: Make io_cancel() generate completions again

The following patch accidentally removed the code for delivering
completions for cancelled reads and writes to user space: "[PATCH 04/33]
aio: remove retry-based AIO"
(https://lore.kernel.org/all/1363883754-27966-5-git-send-email-koverstreet@google.com/)
 From that patch:

-	if (kiocbIsCancelled(iocb)) {
-		ret = -EINTR;
-		aio_complete(iocb, ret, 0);
-		/* must not access the iocb after this */
-		goto out;
-	}

This leads to a leak in user space of a struct iocb. Hence this patch
that restores the code that reports to user space that a read or write
has been cancelled successfully.
---
  fs/aio.c | 27 +++++++++++----------------
  1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index da18dbcfcb22..28223f511931 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2165,14 +2165,11 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
  #endif

  /* sys_io_cancel:
- *	Attempts to cancel an iocb previously passed to io_submit.  If
- *	the operation is successfully cancelled, the resulting event is
- *	copied into the memory pointed to by result without being placed
- *	into the completion queue and 0 is returned.  May fail with
- *	-EFAULT if any of the data structures pointed to are invalid.
- *	May fail with -EINVAL if aio_context specified by ctx_id is
- *	invalid.  May fail with -EAGAIN if the iocb specified was not
- *	cancelled.  Will fail with -ENOSYS if not implemented.
+ *	Attempts to cancel an iocb previously passed to io_submit(). If the
+ *	operation is successfully cancelled 0 is returned. May fail with
+ *	-EFAULT if any of the data structures pointed to are invalid. May
+ *	fail with -EINVAL if aio_context specified by ctx_id is invalid. Will
+ *	fail with -ENOSYS if not implemented.
   */
  SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
  		struct io_event __user *, result)
@@ -2203,14 +2200,12 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
  	}
  	spin_unlock_irq(&ctx->ctx_lock);

-	if (!ret) {
-		/*
-		 * The result argument is no longer used - the io_event is
-		 * always delivered via the ring buffer. -EINPROGRESS indicates
-		 * cancellation is progress:
-		 */
-		ret = -EINPROGRESS;
-	}
+	/*
+	 * The result argument is no longer used - the io_event is always
+	 * delivered via the ring buffer.
+	 */
+	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
+		aio_complete_rw(&kiocb->rw, -EINTR);

  	percpu_ref_put(&ctx->users);


-----------------------------------------------------------------------------

