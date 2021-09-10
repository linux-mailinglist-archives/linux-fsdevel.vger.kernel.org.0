Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7769E4065C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 04:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhIJCob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 22:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhIJCo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:44:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69AC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 19:43:17 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a13so520539iol.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=02ZyrqMIMcWEGomSTPmglUtr8KQ7G6TZbRod+nJ6PZA=;
        b=TxPXCCwbR3Pvp6IyG0Ly+FhyQqaUQeIeYTpgmKUBadBHjzVRNM2Xq3i5ec8b2RNbBT
         ZoCu6AyWVHoWMsCyL3SGdLsjsrt3jTDV9El5RDYvInPUq6l99/hQ9yiX8w5UqtJcQJrb
         nkj9O/AvGAnWJ/pDaqOpspm5jqxwLnCRfx7+kHvzmLCjvIlPnFHMKQRJujQZJKYyPxll
         6Ef7tA27B7J1cp1rPIGDKTsuxrBsYKTuT6JQXizQFwpz20Oc84yw6mwi1LNotseuwuVC
         iW2KE46pt4JElMXwCSGbdWcfUJ9yVPmv8F/t4MvunhgDcr11RImhK4GBluNTdqQnLC7R
         bIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=02ZyrqMIMcWEGomSTPmglUtr8KQ7G6TZbRod+nJ6PZA=;
        b=iLfuALmXjIh57Dt9OxuM9X+diCAAAJi7dAh0fMFtAzssJceauba17EsS/9iYDBUHZQ
         l8En6/nNNMUjsqcBD3jf5fPHH+JgpNEQiQb9lkHzzQ25MmaFPr0sz/Axv/nezH0IuRx+
         mjHXXZ7DKb/ggWcpjAeymFOxa+YY4FPOY9bu54rzFCqxjcQ1x/D/UP1Mto2Wd33fBt0n
         8xEw04PVd29cYM5yS5xE/jOVvNbF3McCSbZRcHVyOkjUIwgbkjt52b4R8i52oeUQx+eh
         W0g+IGV1UvHgoV+xIXwOPpD7UocLouqK4lOv2aorgDkvAEhzFTLKlB4QL0CTV3dvJmdE
         aUkA==
X-Gm-Message-State: AOAM533vtMd0GudMjZ9B3TUjUmsTgjKX7Adpn6unP6ANPAlx1tc4dtxJ
        cHvwl/aWgis4J5hqoH255jfXqT/yovrTlg==
X-Google-Smtp-Source: ABdhPJyOv+iUkrJUzN+X8cykdtW5LZO1zT+pKoSHgUHmDasDPVIfsLM8P4hHqrN1koi3trGXpzPvww==
X-Received: by 2002:a05:6602:584:: with SMTP id v4mr5303148iox.85.1631241796273;
        Thu, 09 Sep 2021 19:43:16 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t15sm1769480ioi.7.2021.09.09.19.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 19:43:15 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
 <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
 <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
 <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
 <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
Message-ID: <f9748c63-b89d-5a00-e509-db4a6d44655a@kernel.dk>
Date:   Thu, 9 Sep 2021 20:43:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/21 7:35 PM, Jens Axboe wrote:
> On 9/9/21 4:56 PM, Linus Torvalds wrote:
>> On Thu, Sep 9, 2021 at 3:21 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 9/9/21 3:56 PM, Linus Torvalds wrote:
>>>>
>>>> IOW, can't we have  that
>>>>
>>>>         ret = io_iter_do_read(req, iter);
>>>>
>>>> return partial success - and if XFS does that "update iovec on
>>>> failure", I could easily see that same code - or something else -
>>>> having done the exact same thing.
>>>>
>>>> Put another way: if the iovec isn't guaranteed to be coherent when an
>>>> actual error occurs, then why would it be guaranteed to be coherent
>>>> with a partial success value?
>>>>
>>>> Because in most cases - I'd argue pretty much all - those "partial
>>>> success" cases are *exactly* the same as the error cases, it's just
>>>> that we had a loop and one or more iterations succeeded before it hit
>>>> the error case.
>>>
>>> Right, which is why the reset would be nice, but reexpand + revert at
>>> least works and accomplishes the same even if it doesn't look as pretty.
>>
>> You miss my point.
>>
>> The partial success case seems to do the wrong thing.
>>
>> Or am I misreading things? Lookie here, in io_read():
>>
>>         ret = io_iter_do_read(req, iter);
>>
>> let's say that something succeeds partially, does X bytes, and returns
>> a positive X.
>>
>> The if-statements following it then do not trigger:
>>
>>         if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
>>   .. not this case ..
>>         } else if (ret == -EIOCBQUEUED) {
>>   .. nor this ..
>>         } else if (ret <= 0 || ret == io_size || !force_nonblock ||
>>                    (req->flags & REQ_F_NOWAIT) || !(req->flags & REQ_F_ISREG)) {
>>   .. nor this ..
>>         }
>>
>> so nothing has been done to the iovec at all.
>>
>> Then it does
>>
>>         ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);
>>
>> using that iovec that has *not* been reset, even though it really
>> should have been reset to "X bytes read".
>>
>> See what I'm trying to say?
> 
> Yep ok I follow you now. And yes, if we get a partial one but one that
> has more consumed than what was returned, that would not work well. I'm
> guessing that a) we've never seen that, or b) we always end up with
> either correctly advanced OR fully advanced, and the fully advanced case
> would then just return 0 next time and we'd just get a short IO back to
> userspace.
> 
> The safer way here would likely be to import the iovec again. We're
> still in the context of the original submission, and the sqe hasn't been
> consumed in the ring yet, so that can be done safely.

Totally untested, but something like this could be a better solution.
If we're still in the original submit path, then re-import the iovec and
set the iter again before doing retry. If we do get a partial
read/write return, then advance the iter to avoid re-doing parts of the
IO.

If we're already in the io-wq retry path, short IO will just be ended
anyway. That's no different than today.

Will take a closer look at this tomorrow and run some testing, but I
think the idea is sound and it avoids any kind of guessing on what was
done or not. Just re-setup the iter/iov and advance if we got a positive
result on the previous attempt.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 855ea544807f..89c4c568d785 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2608,8 +2608,6 @@ static bool io_resubmit_prep(struct io_kiocb *req)
 
 	if (!rw)
 		return !io_req_prep_async(req);
-	/* may have left rw->iter inconsistent on -EIOCBQUEUED */
-	iov_iter_revert(&rw->iter, req->result - iov_iter_count(&rw->iter));
 	return true;
 }
 
@@ -3431,6 +3429,28 @@ static bool need_read_all(struct io_kiocb *req)
 		S_ISBLK(file_inode(req->file)->i_mode);
 }
 
+static int io_prep_for_retry(int rw, struct io_kiocb *req, struct iovec **vecs,
+			     struct iov_iter *iter, ssize_t did_bytes)
+{
+	ssize_t ret;
+
+	/*
+	 * io-wq path cannot retry, as we cannot safely re-import vecs. It
+	 * would be perfectly legal for non-vectored IO, but we handle them
+	 * all the same.
+	 */
+	if (WARN_ON_ONCE(io_wq_current_is_worker()))
+		return did_bytes;
+
+	ret = io_import_iovec(rw, req, vecs, iter, false);
+	if (ret < 0)
+		return ret;
+	if (did_bytes > 0)
+		iov_iter_advance(iter, did_bytes);
+
+	return 0;
+}
+
 static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -3479,9 +3499,6 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		/* no retry on NONBLOCK nor RWF_NOWAIT */
 		if (req->flags & REQ_F_NOWAIT)
 			goto done;
-		/* some cases will consume bytes even on error returns */
-		iov_iter_reexpand(iter, iter->count + iter->truncated);
-		iov_iter_revert(iter, io_size - iov_iter_count(iter));
 		ret = 0;
 	} else if (ret == -EIOCBQUEUED) {
 		goto out_free;
@@ -3491,6 +3508,13 @@ static int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		goto done;
 	}
 
+	iovec = inline_vecs;
+	ret2 = io_prep_for_retry(READ, req, &iovec, iter, ret);
+	if (ret2 < 0) {
+		ret = ret2;
+		goto done;
+	}
+
 	ret2 = io_setup_async_rw(req, iovec, inline_vecs, iter, true);
 	if (ret2)
 		return ret2;
@@ -3614,14 +3638,16 @@ static int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	if (!force_nonblock || ret2 != -EAGAIN) {
 		/* IOPOLL retry should happen for io-wq threads */
 		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && ret2 == -EAGAIN)
-			goto copy_iov;
+			goto copy_import;
 done:
 		kiocb_done(kiocb, ret2, issue_flags);
 	} else {
+copy_import:
+		iovec = inline_vecs;
+		ret = io_prep_for_retry(WRITE, req, &iovec, iter, ret2);
+		if (ret < 0)
+			goto out_free;
 copy_iov:
-		/* some cases will consume bytes even on error returns */
-		iov_iter_reexpand(iter, iter->count + iter->truncated);
-		iov_iter_revert(iter, io_size - iov_iter_count(iter));
 		ret = io_setup_async_rw(req, iovec, inline_vecs, iter, false);
 		return ret ?: -EAGAIN;
 	}

-- 
Jens Axboe

