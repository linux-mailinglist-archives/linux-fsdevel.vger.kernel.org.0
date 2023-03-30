Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D256D0CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjC3RdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 13:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjC3RdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:33:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37E5FD9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 10:33:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3230125dde5so731935ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680197598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/hPMNeLBjXyU6ORF4SAk/4kNnocpsN7/YICHvDc8s=;
        b=PeYznC0sF7uoVu8d1h6Tdr7mgd3p1M3d/JMJX2Fm2Ab6jnCoUOTm79QDOqMbWImjmw
         VxpQG97Eq7x8cqM7cNuSnzu8hSHBgXs/xwUylPwaLsLe9NnQf4/BDtPpe8PWa7GO1RNk
         e4JRrL1XjRzL/EVSlzmpiqZsAk0HGtHnXc0jSrD3MAtnWFtGfki9cGsiOCjUKClcXfTE
         J9SsaUkj9du4L23RopvR037c5ckif2wwn0GmaLcSBKHKwegcf+rwc/87ns8MFzYMVc0K
         aab50s/lDWbwgri8gCUKVbe64kkLqRhwetNphJ1EDjHu5qNJQJUjpv5AN11czhypel8j
         YfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/hPMNeLBjXyU6ORF4SAk/4kNnocpsN7/YICHvDc8s=;
        b=XVVCqc9RfNGKHG8MF+p1oGp8Dg8dp8K9l8gxNXYwWzE/fNbZkqHkw7r/vG3VOQ/4D1
         XwMRszC3kkdHRiR5qWqzwbopEHwBlW79EbJxk+UqG+zfCD/v3NSkRbRgrS1D3ViFEj9R
         IINYyLC49UMvY3rIU9MbEmxPeH2PqJbmaxPf5ZHYSXyUYSB1KGSJ6tw6LID0WSJC6Yej
         7p/71u8FfTrCGx0EP2y/W7kjRxO1ZdURRJAYbSDWRozXbXiwUO2bVD/gJ3li/Tn8RVMj
         sKKNp/MuL/yalu2osBLyacCxndZl7Kei6iZNhGVSijPIF7Elif3Obru87dgFF8a6vVXn
         Xlgw==
X-Gm-Message-State: AAQBX9eQ47gbRWCB1RQbKApgo60STvp+TcKEjeWzww4mq8sulCmNvVkT
        PZUi5I+bDtCBGNoHmHp4iamCCA==
X-Google-Smtp-Source: AKy350broBEvJ77a5cr53tqp8/b0QbJ7XyOrmcsSu3qJOo1vv5WBL8DmbDTvGBXl7jVH9hR3S151rQ==
X-Received: by 2002:a05:6602:459:b0:740:7d21:d96f with SMTP id e25-20020a056602045900b007407d21d96fmr1457550iov.1.1680197597969;
        Thu, 30 Mar 2023 10:33:17 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d97-20020a0285ea000000b003c4f5f9f577sm58720jai.25.2023.03.30.10.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:33:17 -0700 (PDT)
Message-ID: <de35d11d-bce7-e976-7372-1f2caf417103@kernel.dk>
Date:   Thu, 30 Mar 2023 11:33:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230330164702.1647898-1-axboe@kernel.dk>
 <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 11:11?AM, Linus Torvalds wrote:
> On Thu, Mar 30, 2023 at 9:47?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Sadly, in absolute numbers, comparing read(2) and readv(2),
>> the latter takes 2.11x as long in the stock kernel, and 2.01x as long
>> with the patches. So while single segment is better now than before,
>> it's still waaaay slower than having to copy in a single iovec. Testing
>> was run with all security mitigations off.
> 
> What does the profile say? Iis it all in import_iovec() or what?
> 
> I do note that we have some completely horrid "helper" functions in
> the iter paths: things like "do_iter_readv_writev()" supposedly being
> a common function , but then it ends up doing some small setup and
> just doing a conditional on the "type" after all, so when it isn't
> inlined, you have those things that don't predict well at all.
> 
> And the iter interfaces don't have just that iterator, they have the
> whole kiocb overhead too. All in the name of being generic. Most file
> descriptors don't even support the simpler ".read" interface, because
> they want the whole thing with IOCB_DIRECT flags etc.
> 
> So to some degree it's unfair to compare read-vs-read_iter. The latter
> has all that disgusting support for O_DIRECT and friends, and testing
> with /dev/null just doesn't show that part.

Oh I agree, and particularly for the "read from /dev/zero" case it's
not very interesting, as it does too different things there as well.
It was just more of a "gah it's potentially this bad" outburst than
anything else, the numbers I did care about was readv before and
after patches, not read vs readv.

That said, there might be things to improve here. But that's a task
for another time. perf diff of a read vs readv run below.


# Event 'cycles'
#
# Baseline  Delta Abs  Shared Object         Symbol                               
# ........  .........  ....................  .....................................
#
              +40.56%  [kernel.vmlinux]      [k] iov_iter_zero
              +12.59%  [kernel.vmlinux]      [k] copy_user_enhanced_fast_string
    21.56%    -11.10%  [kernel.vmlinux]      [k] entry_SYSCALL_64
               +7.67%  [kernel.vmlinux]      [k] _copy_from_user
               +7.40%  libc.so.6             [.] __GI___readv
     3.76%     -2.22%  [kernel.vmlinux]      [k] __fsnotify_parent
               +2.13%  [kernel.vmlinux]      [k] do_iter_read
               +2.02%  [kernel.vmlinux]      [k] do_iter_readv_writev
               +1.89%  [kernel.vmlinux]      [k] __import_iovec
               +1.59%  [kernel.vmlinux]      [k] do_readv
     3.15%     -1.43%  [kernel.vmlinux]      [k] __fget_light
               +1.42%  [kernel.vmlinux]      [k] vfs_readv
               +1.32%  [kernel.vmlinux]      [k] read_iter_zero
     2.39%     -1.30%  [kernel.vmlinux]      [k] syscall_exit_to_user_mode
     1.89%     -1.17%  [kernel.vmlinux]      [k] exit_to_user_mode_prepare
     2.01%     -1.10%  [kernel.vmlinux]      [k] do_syscall_64
     2.04%     -1.06%  [kernel.vmlinux]      [k] __fdget_pos
     1.93%     -0.99%  [kernel.vmlinux]      [k] syscall_enter_from_user_mode
               +0.81%  [kernel.vmlinux]      [k] __get_task_ioprio
     1.03%     -0.56%  [kernel.vmlinux]      [k] fpregs_assert_state_consistent
     0.85%     -0.49%  [kernel.vmlinux]      [k] syscall_exit_to_user_mode_prepare
               +0.45%  [kernel.vmlinux]      [k] import_iovec
               +0.20%  [kernel.vmlinux]      [k] kfree
               +0.18%  [kernel.vmlinux]      [k] __x64_sys_readv
               +0.06%  read-zero             [.] readv@plt
               +0.01%  [kernel.vmlinux]      [k] filemap_map_pages
               +0.01%  ld-linux-x86-64.so.2  [.] check_match
     0.00%     +0.00%  [kernel.vmlinux]      [k] memset_erms
     0.00%     -0.00%  [kernel.vmlinux]      [k] perf_iterate_ctx
               +0.00%  [kernel.vmlinux]      [k] xfs_iunlock
     0.49%     -0.00%  read-zero             [.] main
               +0.00%  [kernel.vmlinux]      [k] arch_get_unmapped_area_topdown
               +0.00%  [kernel.vmlinux]      [k] pcpu_alloc
               +0.00%  [kernel.vmlinux]      [k] perf_event_exec
               +0.00%  taskset               [.] 0x0000000000002ebd
     0.00%     +0.00%  [kernel.vmlinux]      [k] perf_ibs_handle_irq
     0.00%     -0.00%  [kernel.vmlinux]      [k] perf_ibs_start
    32.88%             [kernel.vmlinux]      [k] read_zero
    15.22%             libc.so.6             [.] read
     6.27%             [kernel.vmlinux]      [k] vfs_read
     2.60%             [kernel.vmlinux]      [k] ksys_read
     1.02%             [kernel.vmlinux]      [k] __cond_resched
     0.41%             [kernel.vmlinux]      [k] rcu_all_qs
     0.35%             [kernel.vmlinux]      [k] __x64_sys_read
     0.12%             read-zero             [.] read@plt
     0.01%             ld-linux-x86-64.so.2  [.] _dl_load_cache_lookup
     0.01%             ld-linux-x86-64.so.2  [.] _dl_check_map_versions
     0.00%             [kernel.vmlinux]      [k] _find_next_or_bit
     0.00%             [kernel.vmlinux]      [k] perf_event_update_userpage
     0.00%             [kernel.vmlinux]      [k] native_sched_clock

-- 
Jens Axboe

