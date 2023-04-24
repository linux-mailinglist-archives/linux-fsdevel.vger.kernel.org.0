Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4648A6ED81A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjDXWpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXWpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:45:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB026A41
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:45:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b8b927f62so1176304b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682376303; x=1684968303;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyAyZvkBYkEc712cEMV3mpROJFIG+zAeVUV4dUXDvuI=;
        b=Lhx5LzsaBaoqEWqnxNW38qntF9QqpPCXaBk64MUOpxQbjWzyKsvYTPDddk5jyU5jdS
         C/unHMsPnxQqtOTk3Cl1OGQ6bEdKkQlmy+M2bwW/kGU495ZPC8MR0uEFwrLMmL9Rl0/W
         738a+UTY898TmTjE7uyG0cbllvHey6ampnGHQ0gGd60vM8+stt+PTc4R/bsvfdrOYLy1
         Wf1DtYcIM4zZJcCGfPBeacKH20QAiU7lccNAXvvJmMpZs8hESAeKOMw52KSxl1wjha8y
         GIYmAdIehEOAIuHZech7ZbiHVXrPuoDvjeZ1gY2jH19xY3uPxEtei+pJG6CS7qAVZsvQ
         x9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682376303; x=1684968303;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyAyZvkBYkEc712cEMV3mpROJFIG+zAeVUV4dUXDvuI=;
        b=Qnl5fBCuV+7nw7r9o/5XIZEY7TfneFv3w2eOmZUuOMpkF8vQMCOMWRMdyStsYZt/iC
         QrlSVU0LgYq2z8CXXr4lRJDXZsGQA9TsnvhiBbdv0D6CctrVGT1e3+cwXGVVQ8lts+fH
         MuzvoT9QuRUITqaAp8Ie4EqLQdnlad+qU5CQxt573L/5K6Ftu9L86wSbMBabjcPeEmfP
         RwTrQXtdssaO/SfEPo6bUxd5Ha98BmeePRFXvKoLM4DuuulnNYXlTykCNMdhG/ogrd08
         Jiu0SoQ04vvmzgV4OH4CEJCnDQ/WjdodlAQqgnkcL+ap3Mef/4LeZIBN8fSut55BW5OR
         Vlfw==
X-Gm-Message-State: AAQBX9eBXlf56OOL8SkbI+ZhkOxVwT1zPr0+K10ymCYD79kvl05hoaJl
        Xh59dxBDvnA49VfNBv7U+zBm2A==
X-Google-Smtp-Source: AKy350Zpt2t30t66DD9GxrwuipngBmDrdC/PFh7ol9LvVK9zpSzmcnQQeCkc0Nbggd9FVMC4bP4v3g==
X-Received: by 2002:a17:902:f690:b0:1a6:e00b:c3e5 with SMTP id l16-20020a170902f69000b001a6e00bc3e5mr18310958plg.4.1682376303317;
        Mon, 24 Apr 2023 15:45:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jw4-20020a170903278400b001a975b64c38sm2329910plb.68.2023.04.24.15.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:45:02 -0700 (PDT)
Message-ID: <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
Date:   Mon, 24 Apr 2023 16:44:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
In-Reply-To: <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 4:07?PM, Jens Axboe wrote:
> On 4/24/23 3:58?PM, Linus Torvalds wrote:
>> On Mon, Apr 24, 2023 at 2:37?PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> And I completely refuse to add that trylock hack to paper that over.
>>> The pipe lock is *not* meant for IO.
>>
>> If you want to paper it over, do it other ways.
>>
>> I'd love to just magically fix splice, but hey, that might not be possible.
> 
> Don't think it is... At least not trivially.
> 
>> But possible fixes papering this over might be to make splice "poison
>> a pipe, and make io_uring falls back on io workers only on pipes that
>> do splice. Make any normal pipe read/write load sane.
>>
>> And no, don't worry about races. If you have the same pipe used for
>> io_uring IO *and* somebody else then doing splice on it and racing,
>> just take the loss and tell people that they might hit a slow case if
>> they do stupid things.
>>
>> Basically, the patch might look like something like
>>
>>  - do_pipe() sets FMODE_NOWAIT by default when creating a pipe
>>
>>  - splice then clears FMODE_NOWAIT on pipes as they are used
>>
>> and now io_uring sees whether the pipe is playing nice or not.
>>
>> As far as I can tell, something like that would make the
>> 'pipe_buf_confirm()' part unnecessary too, since that's only relevant
>> for splice.
>>
>> A fancier version might be to only do that "splice then clears
>> FMODE_NOWAIT" thing if the other side of the splice has not set
>> FMODE_NOWAIT.
>>
>> Honestly, if the problem is "pipe IO is slow", then splice should not
>> be the thing you optimize for.
> 
> I think that'd be an acceptable approach, and would at least fix the
> pure pipe case which I suspect is 99.9% of them, if not more. And yes,
> it'd mean that we don't need to do the ->confirm() change either, as the
> pipe is already tainted at that point.
> 
> I'll respin a v2, post, and send in later this merge window.

Something like this. Not tested yet, but wanted to get your feedback
early to avoid issues down the line. Really just the first hunk, as
we're not really expecting f_mode to change and hence could just use
an xchg(). Seems saner to use a cmpxchg though, but maybe that's
too much of both belt and suspenders?

commit f10cbebf4dd7f77b0e87c77bb0191a5a07d5e7ac
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Apr 24 16:32:55 2023 -0600

    splice: clear FMODE_NOWAIT on file if splice/vmsplice is used
    
    In preparation for pipes setting FMODE_NOWAIT on pipes to indicate that
    RWF_NOWAIT/IOCB_NOWAIT is fully supported, have splice and vmsplice
    clear that file flag. Splice holds the pipe lock around IO and cannot
    easily be refactored to avoid that, as splice and pipes are inherently
    tied together.
    
    By clearing FMODE_NOWAIT if splice is being used on a pipe, other users
    of the pipe will know that the pipe is no longer safe for RWF_NOWAIT
    and friends.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/splice.c b/fs/splice.c
index 2c3dec2b6dfa..3ce7c07621e2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -37,6 +37,29 @@
 
 #include "internal.h"
 
+/*
+ * Splice doesn't support FMODE_NOWAIT. Since pipes may set this flag to
+ * indicate they support non-blocking reads or writes, we must clear it
+ * here if set to avoid blocking other users of this pipe if splice is
+ * being done on it.
+ */
+static void pipe_clear_nowait(struct file *file)
+{
+	fmode_t new_fmode, old_fmode;
+
+	/*
+	 * We could get by with just doing an xchg() here as f_mode should
+	 * not change in the file's lifetime, but let's be safe and use
+	 * a cmpxchg() instead.
+	 */
+	do {
+		old_fmode = READ_ONCE(file->f_mode);
+		if (!(old_fmode & FMODE_NOWAIT))
+			break;
+		new_fmode = old_fmode & ~FMODE_NOWAIT;
+	} while (!try_cmpxchg(&file->f_mode, &old_fmode, new_fmode));
+}
+
 /*
  * Attempt to steal a page from a pipe buffer. This should perhaps go into
  * a vm helper function, it's already simplified quite a bit by the
@@ -1211,10 +1234,16 @@ static long __do_splice(struct file *in, loff_t __user *off_in,
 	ipipe = get_pipe_info(in, true);
 	opipe = get_pipe_info(out, true);
 
-	if (ipipe && off_in)
-		return -ESPIPE;
-	if (opipe && off_out)
-		return -ESPIPE;
+	if (ipipe) {
+		if (off_in)
+			return -ESPIPE;
+		pipe_clear_nowait(in);
+	}
+	if (opipe) {
+		if (off_out)
+			return -ESPIPE;
+		pipe_clear_nowait(out);
+	}
 
 	if (off_out) {
 		if (copy_from_user(&offset, off_out, sizeof(loff_t)))
@@ -1311,6 +1340,8 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
 	if (!pipe)
 		return -EBADF;
 
+	pipe_clear_nowait(file);
+
 	if (sd.total_len) {
 		pipe_lock(pipe);
 		ret = __splice_from_pipe(pipe, &sd, pipe_to_user);
@@ -1339,6 +1370,8 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	if (!pipe)
 		return -EBADF;
 
+	pipe_clear_nowait(file);
+
 	pipe_lock(pipe);
 	ret = wait_for_space(pipe, flags);
 	if (!ret)

-- 
Jens Axboe

