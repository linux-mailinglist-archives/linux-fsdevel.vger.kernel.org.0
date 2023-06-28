Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24F7408DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 05:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1DQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF1DQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:16:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C82110
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 20:16:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-676cc97ca74so724219b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 20:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687922194; x=1690514194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIhtuSRiqrjXezeemJprapYEprlXOItnVIuU2+4Kb0c=;
        b=if1+TA/D1PyQT9UmQ4rtsOuH2Nq4tapIkj0nVFP+G+d7FNRIf8JFHLmik8AfBb0OZ8
         GvzgaveeVgsWlpm7m8/AcBqqYcDtIfAjp3cn7vP4Qcwip2OgOL5R9pu2/FGcnOkUZJPc
         IzHEEuI2h27ORNtthM4q7GwSJsehjn6BFrA0fzSgWM7lkIMNMTHj6jYHPdTdjWTyFKf2
         +0VB4BepSLUB+mjJETAQRMYJdFgB5dCRyluwU1bVzST0DakegtRn0DJ4UqqLRlXR4UGU
         S/nkJfN6vrO3gmUlisg9rOMYQ9aBvhNRhXXtn8HEOpusszV/oxi4mH3ZYx86o8sRFF0q
         Aj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687922194; x=1690514194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIhtuSRiqrjXezeemJprapYEprlXOItnVIuU2+4Kb0c=;
        b=Pwh208Td0fbt8KQeaq0hn1wN6BqMpg5MPVYdjbbbyS5c2l0pxAL7J/lOFlgFuzs/Dp
         OlAzxEphuFfz2GHWVJE+7xgzTu6qTNEw1bhAWsYboFlx6PnL5nvUAL3jprpDQdXOP5j6
         xmUtPpQVSS5HDRplID9ZPbk/waC0KXURXEPuCH/1d0vzcz2sHnu4KAAz51zbv81Wey5v
         KjuCXrkKUD63WA14iqYnZlH2Keb7SgFnsWwUk/sf2v7eYhnMSgdzuQk+YuUw7rX20xc9
         SD8F8CCQO22wc6IaAWPza3sH56Sgyw2+pNY8p3x8CM2xFdmqoXRordJbWqz4jyEeuKpk
         G0rQ==
X-Gm-Message-State: AC+VfDwKu/AQ/XVAd2MpyL5Z7kob2AJI0+NJQ54o+zMzaajnUgSEUVU/
        PrdhdQnqqnbxYWe03IuTVTMg0w==
X-Google-Smtp-Source: ACHHUZ4ho6TEGjNA4Lk8sLA/4sGHjIfiH9fAAJnwGQA4Wp7rFiJD/shNnAMtphMHE3/+JlGN5+PkXQ==
X-Received: by 2002:a05:6a20:430c:b0:10b:e7d2:9066 with SMTP id h12-20020a056a20430c00b0010be7d29066mr42410880pzk.2.1687922193582;
        Tue, 27 Jun 2023 20:16:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q17-20020a62e111000000b006736bce8581sm4877904pfh.16.2023.06.27.20.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 20:16:32 -0700 (PDT)
Message-ID: <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
Date:   Tue, 27 Jun 2023 21:16:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230627201524.ool73bps2lre2tsz@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/23 2:15?PM, Kent Overstreet wrote:
>> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
>> failing because it assumed it was XFS.
>>
>> I suspected this was just a timing issue, and it looks like that's
>> exactly what it is. Looking at the test case, it'll randomly kill -9
>> fsstress, and if that happens while we have io_uring IO pending, then we
>> process completions inline (for a PF_EXITING current). This means they
>> get pushed to fallback work, which runs out of line. If we hit that case
>> AND the timing is such that it hasn't been processed yet, we'll still be
>> holding a file reference under the mount point and umount will -EBUSY
>> fail.
>>
>> As far as I can tell, this can happen with aio as well, it's just harder
>> to hit. If the fput happens while the task is exiting, then fput will
>> end up being delayed through a workqueue as well. The test case assumes
>> that once it's reaped the exit of the killed task that all files are
>> released, which isn't necessarily true if they are done out-of-line.
> 
> Yeah, I traced it through to the delayed fput code as well.
> 
> I'm not sure delayed fput is responsible here; what I learned when I was
> tracking this down has mostly fell out of my brain, so take anything I
> say with a large grain of salt. But I believe I tested with delayed_fput
> completely disabled, and found another thing in io_uring with the same
> effect as delayed_fput that wasn't being flushed.

I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
io_uring can end up doing. But yes, delayed_fput() is another candidate.

>> For io_uring specifically, it may make sense to wait on the fallback
>> work. The below patch does this, and should fix the issue. But I'm not
>> fully convinced that this is really needed, as I do think this can
>> happen without io_uring as well. It just doesn't right now as the test
>> does buffered IO, and aio will be fully sync with buffered IO. That
>> means there's either no gap where aio will hit it without O_DIRECT, or
>> it's just small enough that it hasn't been hit.
> 
> I just tried your patch and I still have generic/388 failing - it
> might've taken a bit longer to pop this time.

Yep see the same here. Didn't have time to look into it after sending
that email today, just took a quick stab at writing a reproducer and
ended up crashing bcachefs:

[ 1122.384909] workqueue: Failed to create a rescuer kthread for wq "bcachefs": -EINTR
[ 1122.384915] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[ 1122.385814] Mem abort info:
[ 1122.385962]   ESR = 0x0000000096000004
[ 1122.386161]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1122.386444]   SET = 0, FnV = 0
[ 1122.386612]   EA = 0, S1PTW = 0
[ 1122.386842]   FSC = 0x04: level 0 translation fault
[ 1122.387168] Data abort info:
[ 1122.387321]   ISV = 0, ISS = 0x00000004
[ 1122.387518]   CM = 0, WnR = 0
[ 1122.387676] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001133da000
[ 1122.388014] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[ 1122.388363] Internal error: Oops: 0000000096000004 [#1] SMP
[ 1122.388659] Modules linked in:
[ 1122.388866] CPU: 4 PID: 23129 Comm: mount Not tainted 6.4.0-02556-ge61c7fc22b68-dirty #3647
[ 1122.389389] Hardware name: linux,dummy-virt (DT)
[ 1122.389682] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[ 1122.390118] pc : bch2_free_pending_node_rewrites+0x40/0x90
[ 1122.390466] lr : bch2_free_pending_node_rewrites+0x28/0x90
[ 1122.390815] sp : ffff80002481b770
[ 1122.391030] x29: ffff80002481b770 x28: ffff0000e1d24000 x27: 00000000fffff7b7
[ 1122.391475] x26: 0000000000000000 x25: ffff0000e1d00040 x24: dead000000000122
[ 1122.391919] x23: dead000000000100 x22: ffff0000e1d031b8 x21: ffff0000e1d00040
[ 1122.392366] x20: 0000000000000000 x19: ffff0000e1d031a8 x18: 0000000000000009
[ 1122.392860] x17: 3a22736665686361 x16: 6362222071772072 x15: 6f66206461657268
[ 1122.393622] x14: 746b207265756373 x13: 52544e49452d203a x12: 0000000000000001
[ 1122.395170] x11: 0000000000000001 x10: 0000000000000000 x9 : 00000000000002d3
[ 1122.396592] x8 : 00000000000003f8 x7 : 0000000000000000 x6 : ffff8000093c2e78
[ 1122.397970] x5 : ffff000209de4240 x4 : ffff0000e1d00030 x3 : dead000000000122
[ 1122.399263] x2 : 00000000000031a8 x1 : 0000000000000000 x0 : 0000000000000000
[ 1122.400473] Call trace:
[ 1122.400908]  bch2_free_pending_node_rewrites+0x40/0x90
[ 1122.401783]  bch2_fs_release+0x48/0x24c
[ 1122.402589]  kobject_put+0x7c/0xe8
[ 1122.403271]  bch2_fs_free+0xa4/0xc8
[ 1122.404033]  bch2_fs_alloc+0x5c8/0xbcc
[ 1122.404888]  bch2_fs_open+0x19c/0x430
[ 1122.405781]  bch2_mount+0x194/0x45c
[ 1122.406643]  legacy_get_tree+0x2c/0x54
[ 1122.407476]  vfs_get_tree+0x28/0xd4
[ 1122.408251]  path_mount+0x5d0/0x6c8
[ 1122.409056]  do_mount+0x80/0xa4
[ 1122.409866]  __arm64_sys_mount+0x150/0x168
[ 1122.410904]  invoke_syscall.constprop.0+0x70/0xb8
[ 1122.411890]  do_el0_svc+0xbc/0xf0
[ 1122.412596]  el0_svc+0x74/0x9c
[ 1122.413343]  el0t_64_sync_handler+0xa8/0x134
[ 1122.414148]  el0t_64_sync+0x168/0x16c
[ 1122.414863] Code: f2fbd5b7 d2863502 91008af8 8b020273 (f85d8695) 
[ 1122.415939] ---[ end trace 0000000000000000 ]---

> I wonder if there might be a better way of solving this though? For aio,
> when a process is exiting we just synchronously tear down the ioctx,
> including waiting for outstanding iocbs.

aio is pretty trivial, because the only async it supports is O_DIRECT
on regular files which always completes in finite time. io_uring has to
cancel etc, so we need to do a lot more.

But the concept of my patch should be fine, but I think we must be
missing a case. Which is why I started writing a small reproducer
instead. I'll pick it up again tomorrow and see what is going on here.

> delayed_fput, even though I believe not responsible here, seems sketchy
> to me because there doesn't seem to be a straightforward way to flush
> delayed fputs for a given _process_ - there's a single global work item,
> and we can only flush globally.

Yep as mentioned I don't think it's delayed_fput at all. And yeah we can
only globally flush that, not per task/files_struct.

-- 
Jens Axboe

