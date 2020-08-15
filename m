Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B112452FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Aug 2020 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgHOV5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 17:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgHOVwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63318C0F26FE
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:16:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ep8so5764614pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aHbPQIVd/Qe2bxa2lkfj1WcJBAAINeZI/2NvgeQ+k6c=;
        b=mwPdJUOfdVE84cnkViJ5O0ph4igy8uVH0E7hwwgOHF/BGrdoxbK/wByIw5qevH0x2M
         muio9At3ebLGCKcWkeHWUcmBtz5ufryd2yUjscsDFA1D5pNLJJcl4pnKVmmRRROYTr5b
         QUwSX/+03uoubcslXaj38NkjDM6Xnrx/gzMjrdLtfNYFyXLd/31cxMVATQY4cBkAtBWe
         Y/qTjfpEoo0hukGPP5cYsdiL/O2JM53KeLMjPxCJlYgFBDJZW49mAMUwnONginKAItPH
         kppT6Bp/8IshH2hX5V5EihNt55Ey7H5bM1UN2HTXl0IgcFlrxh0JLT3xe3pKV2Z+hLb8
         3Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aHbPQIVd/Qe2bxa2lkfj1WcJBAAINeZI/2NvgeQ+k6c=;
        b=EoqoHxufo056/83vff5cUQhqkp3pW6C9KYImKWOU8B3YQtnrPls3ioDAZP6SkySXAm
         b4i6FIzNXgKsKzkUfIdyuSyLqLdGVv0j7r+G1b3NMw/6myWogxjiiZ//NkKzkWbG8c62
         uNh6pAXFGrra112mbdPj3zLVaQ7zt+FD/hUWxrITuzqsH5DlPP1QnP8PTpPTrcnBuf79
         Op1BPXPtoUY4XTbwwSsyVTtIpzbRI21RTatyErnzx7K0ZXeR1uWoVD61d+bOEmJpzz9K
         6C/GTiUTXSwtSF7EDRedfYhofL5Xa99/1qfgekCZPZ/5MLOG5Fkhx1Pc7dmNW7SjON/E
         sGRw==
X-Gm-Message-State: AOAM532rWjZOcCVKdMp3CxyEm/qBmyb4M7u17KYcuKhyUbkedz0LNa5i
        FDPi4J00HNlovznoVRQW9wXyPg==
X-Google-Smtp-Source: ABdhPJzyAKKWItm8tuF8S5WO4+K0NDvvBG1QJaQG0vGIS7rdWp7bNWczCC4l4R6jE43GBD4STmqKEQ==
X-Received: by 2002:a17:902:bd90:: with SMTP id q16mr5915763pls.196.1597515379440;
        Sat, 15 Aug 2020 11:16:19 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6299:2df1:e468:6351? ([2605:e000:100e:8c61:6299:2df1:e468:6351])
        by smtp.gmail.com with ESMTPSA id y1sm12536506pfl.136.2020.08.15.11.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 11:16:18 -0700 (PDT)
Subject: Re: general protection fault in io_poll_double_wake
To:     syzbot <syzbot+7f617d4a9369028b8a2c@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000018f60505aced798e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb1fe8ff-5c79-a020-f6ea-a28f974bde6b@kernel.dk>
Date:   Sat, 15 Aug 2020 11:16:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000018f60505aced798e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/20 10:00 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7fca4dee Merge tag 'powerpc-5.9-2' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1264d116900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=21f0d1d2df6d5fc
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f617d4a9369028b8a2c
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f211d2900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1721b0ce900000
> 
> The issue was bisected to:
> 
> commit 18bceab101adde8f38de76016bc77f3f25cf22f4
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri May 15 17:56:54 2020 +0000
> 
>     io_uring: allow POLL_ADD with double poll_wait() users

I can reproduce this, I'll fix it up. Thanks!

-- 
Jens Axboe

