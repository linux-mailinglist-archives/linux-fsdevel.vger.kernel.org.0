Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED36CCC2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjC1Viy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1Vix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:38:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D78F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:38:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id cu12so8952607pfb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680039531; x=1682631531;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJqaF2Ud/OyaKqGGpak96x1ysQpeLD8MOlYsQQPkeKM=;
        b=xe21dJcwYZrRQcJAdugjkVl2N20AsSkBVW4uZqKEBrJt9PEnG/CikK+GfGCzyY3MBL
         Om/LJm5IQEgi8Xw32FGe1xD6m5OKTllIUUYHZXpj6vbuj7tu7B8rf2p8z6V6EDa8wFQf
         +Itbl10QG0GeH4kZvYxAfcB/0AJTc4/+INjmdh2KyXpXE7Rw7uc+055XoNC8r/PMpQF2
         zuaoC2TmnmKEpfwNj086Y23OefV0/y6C6HM4tnSvOR41wLyv4vrjThbaaEJo/MWQNCOQ
         P0NctcRzJ1kwEFsrukYd8a5xkOGLSVzxKb4XKldBZvAuQGyIRJKyTkCb4VOfqCUWm4KD
         JmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680039531; x=1682631531;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJqaF2Ud/OyaKqGGpak96x1ysQpeLD8MOlYsQQPkeKM=;
        b=pWDokxCSyL9/8Rdh2X7/RCpz1b5vcDGsj410OkJ3PKCYNxApmLvTID4W8r6iZ7axck
         95k3dA5YPWfpCk2PlrrsAjDvaVhZVLDsPwq9uayyO6CLigwajQrsy/wqsOLprBu2IJHU
         +sFBcSirOaJ3v5uAxz2q3NCi6ll6NZJYmKoPZH6xowTGs6jfClP22sHRpLzki8wZkCPQ
         5bOwk2JMtnB2wf8U/J4s+hzUtiUjg7CJxmixHgS4lR5C5TRvPhMVjLwMgYWchicKQOIp
         bvxjz3azljtNgG2k+c9KD3WRTxDzUqfWwXxG/MOQPkkm9ohkNN9i3VTpCrITYuImM4XM
         OJ3A==
X-Gm-Message-State: AAQBX9cV0+YuMGjTeKSVQUssichmVl6dqsJ7fTM4gKw6Sea6GmplyVrp
        J8tauTwi7iZFXlq1+qeCWE6lwg==
X-Google-Smtp-Source: AKy350adiDPmwUzXa+vD3Fahr3gX0yV2D/dgnbSxO7qIB/1dngPxaUhWvw9/pfxlFi+MlgtyL1Vrtg==
X-Received: by 2002:a05:6a00:2e9d:b0:626:fe8b:48a6 with SMTP id fd29-20020a056a002e9d00b00626fe8b48a6mr15091751pfb.3.1680039531425;
        Tue, 28 Mar 2023 14:38:51 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v7-20020a62a507000000b005e5b11335b3sm21514110pfm.57.2023.03.28.14.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 14:38:51 -0700 (PDT)
Message-ID: <ee35b429-bc53-c070-5998-97475e0ae9ff@kernel.dk>
Date:   Tue, 28 Mar 2023 15:38:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
 <ZCM4KsKa3xQR2IOv@casper.infradead.org>
 <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
 <CAHk-=wggKW9VQSUzGGpC9Rq3HYiEEsFM3cn2cvAJsUBbU=zEzA@mail.gmail.com>
 <fc3e4956-9956-01ee-7c11-e9eef59b5e38@kernel.dk>
In-Reply-To: <fc3e4956-9956-01ee-7c11-e9eef59b5e38@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 3:21?PM, Jens Axboe wrote:
> On 3/28/23 1:16?PM, Linus Torvalds wrote:
>> On Tue, Mar 28, 2023 at 12:05?PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> But it's not like adding a 'struct iovec' explicitly to the members
>>> just as extra "code documentation" would be wrong.
>>>
>>> I don't think it really helps, though, since you have to have that
>>> other explicit structure there anyway to get the member names right.
>>
>> Actually, thinking a bit more about it, adding a
>>
>>     const struct iovec xyzzy;
>>
>> member might be a good idea just to avoid a cast. Then that
>> iter_ubuf_to_iov() macro becomes just
>>
>>    #define iter_ubuf_to_iov(iter) (&(iter)->xyzzy)
>>
>> and that looks much nicer (plus still acts kind of as a "code comment"
>> to clarify things).
> 
> I went down this path, and it _mostly_ worked out. You can view the
> series here, I'll send it out when I've actually tested it:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf
> 
> A few mental notes I made along the way:
> 
> - The IB/sound changes are now just replacing an inappropriate
>   iter_is_iovec() with iter->user_backed. That's nice and simple.
> 
> - The iov_iter_iovec() case becomes a bit simpler. Or so I thought,
>   because we still need to add in the offset so we can't just use
>   out embedded iovec for that. The above branch is just using the
>   iovec, but I don't think this is right.
> 
> - Looks like it exposed a block bug, where the copy in
>   bio_alloc_map_data() was obvious garbage but happened to work
>   before.
> 
> I'm still inclined to favor this approach over the previous, even if the
> IB driver is a pile of garbage and lighting it a bit more on fire would
> not really hurt.
> 
> Opinions? Or do you want me to just send it out for easier reading

While cleaning up that stuff, we only have a few users of iov_iter_iovec().
Why don't we just kill them off and the helper too? That drops that
part of it and it kind of works out nicely beyond that.


diff --git a/fs/read_write.c b/fs/read_write.c
index 7a2ff6157eda..fb932d0997d4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -749,15 +749,15 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 		return -EOPNOTSUPP;
 
 	while (iov_iter_count(iter)) {
-		struct iovec iovec = iov_iter_iovec(iter);
+		const struct iovec *iov = iter->iov;
 		ssize_t nr;
 
 		if (type == READ) {
-			nr = filp->f_op->read(filp, iovec.iov_base,
-					      iovec.iov_len, ppos);
+			nr = filp->f_op->read(filp, iov->iov_base,
+					      iov->iov_len, ppos);
 		} else {
-			nr = filp->f_op->write(filp, iovec.iov_base,
-					       iovec.iov_len, ppos);
+			nr = filp->f_op->write(filp, iov->iov_base,
+					       iov->iov_len, ppos);
 		}
 
 		if (nr < 0) {
@@ -766,7 +766,7 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 			break;
 		}
 		ret += nr;
-		if (nr != iovec.iov_len)
+		if (nr != iov->iov_len)
 			break;
 		iov_iter_advance(iter, nr);
 	}
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 4c233910e200..585461a6f6a0 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -454,7 +454,8 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 			iovec.iov_base = iter->ubuf + iter->iov_offset;
 			iovec.iov_len = iov_iter_count(iter);
 		} else if (!iov_iter_is_bvec(iter)) {
-			iovec = iov_iter_iovec(iter);
+			iovec.iov_base = iter->iov->iov_base;
+			iovec.iov_len = iter->iov->iov_len;
 		} else {
 			iovec.iov_base = u64_to_user_ptr(rw->addr);
 			iovec.iov_len = rw->len;
diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d08c03..0701a3bd530b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1456,7 +1456,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
 	ssize_t ret;
-	struct iovec iovstack[UIO_FASTIOV], iovec;
+	struct iovec iovstack[UIO_FASTIOV];
+	const struct iovec *iovec;
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
 	struct task_struct *task;
@@ -1503,12 +1504,12 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
-		iovec = iov_iter_iovec(&iter);
-		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
-					iovec.iov_len, behavior);
+		iovec = iter.iov;
+		ret = do_madvise(mm, (unsigned long)iovec->iov_base,
+					iovec->iov_len, behavior);
 		if (ret < 0)
 			break;
-		iov_iter_advance(&iter, iovec.iov_len);
+		iov_iter_advance(&iter, iovec->iov_len);
 	}
 
 	ret = (total_len - iov_iter_count(&iter)) ? : ret;

-- 
Jens Axboe

