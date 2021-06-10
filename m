Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1D3A3070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 18:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJQYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:24:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA198C061574;
        Thu, 10 Jun 2021 09:22:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u20so274264qtx.1;
        Thu, 10 Jun 2021 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pNNz+TR7uerCkejgNnv3fOpxP4zk7TuOJrUF+ruy46w=;
        b=MvHuLtAhdmWz8Ud8iJPo/O3amn2DUCZzEpwG4iGFwmkuwDICJEIy5YXcS8qsblOpmj
         iYPBQuN9M6IdC5tyW0/YaJJm2QX1KZT5w/tQLOyB0cS+o1BEH2ceSU6A+55cvgheDLiq
         JKkiZdMpE2zovvf/H2L9b7spQ8MHRCdpMixjgxvLD1Hmgqjnj35ynK+bz8Krv4aYKH3O
         nizhRLrRT5WDfinXsTQMzWXCcNFNb9Fc0JR85KuOXaKVm0vNCaWap2PaDypThfkK1ww/
         0BZZI1Bu0Onk5sW+Z7sHSNzwDARAFaCz3OyqNVyrLPzaIihe9YPUxRMAiU2hn8UBYdIb
         lqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pNNz+TR7uerCkejgNnv3fOpxP4zk7TuOJrUF+ruy46w=;
        b=DTyXctdTh7yRzN3YVUFS1AqOvcYbVv8aYqisW0C/htvaT2akgKl6yakJuDpvidNZAP
         NbEWA1VRfFQbrINM3XakcU2xpHSBph18hgcoQ7UIlBYL2XZEdi0+Rjy4dSADtV8KGvZt
         lx7M9v4Igt/miaFj3cBxQqux4oMh2x6jOO85d3/FZSUUmwMB+0u3rS+C67jVhcV7YGoJ
         ZntMT7Xcf7Sx7hlG7YJG8YF6eC9LBCR4kibX5HOvaAkfDeaqoqXUd4XBXB3J6ZRzfpTE
         ee/nz55qaaPZWvr4ccw7dfPThtS6qUO/Zl4DnB22sH6ujYFJJN4krBYikkT5gc+WU41b
         o4Bg==
X-Gm-Message-State: AOAM533RebxbiGsRuUVvYiF51DbqrCBBXGPQHKZt+4J5vS9/VnbtAdtQ
        BzoWwdZPjEufTQMP+WmlGCAtJb1pfj/bq81F
X-Google-Smtp-Source: ABdhPJy4McCvo77o/uHdSungrSK9niyQ7QxO9j0zHbskrQNPlfsTwXC6H2m9xUldOjyDJ2ZcsjAJFg==
X-Received: by 2002:aed:3167:: with SMTP id 94mr434756qtg.126.1623342161439;
        Thu, 10 Jun 2021 09:22:41 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-195-35.bstnma.fios.verizon.net. [173.48.195.35])
        by smtp.gmail.com with ESMTPSA id q190sm2431954qkf.133.2021.06.10.09.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:22:41 -0700 (PDT)
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
To:     Jaegeuk Kim <jaegeuk.kim@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <CAOtxgyeRf=+grEoHxVLEaSM=Yfx4KrSG5q96SmztpoWfP=QrDg@mail.gmail.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <eafad7a6-4784-dd9c-cc1d-36e463370aeb@gmail.com>
Date:   Thu, 10 Jun 2021 12:22:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOtxgyeRf=+grEoHxVLEaSM=Yfx4KrSG5q96SmztpoWfP=QrDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/21 5:32 PM, Jaegeuk Kim wrote:
> On Wed, Jun 9, 2021 at 11:47 AM Bart Van Assche <bvanassche@acm.org 
> <mailto:bvanassche@acm.org>> wrote:
>
>     On 6/9/21 11:30 AM, Matthew Wilcox wrote:
>     > maybe you should read the paper.
>     >
>     > " Thiscomparison demonstrates that using F2FS, a flash-friendly file
>     > sys-tem, does not mitigate the wear-out problem, except inasmuch asit
>     > inadvertently rate limitsallI/O to the device"
>
>
> Do you agree with that statement based on your insight? At least to me, that
> paper is missing the fundamental GC problem which was supposed to be
> evaluated by real workloads instead of using a simple benchmark generating
> 4KB random writes only. And, they had to investigate more details in FTL/IO
> patterns including UNMAP and LBA alignment between host and storage, which
> all affect WAF. Based on that, the point of the zoned device is quite promising
> to me, since it can address LBA alignment entirely and give a way that host
> SW stack can control QoS.

Just a note, using a pretty simple and optimal streaming write pattern, I have 
been able to burn out emmc parts in a little over a week.

My test case creating a 1GB file (filled with random data just in case the 
device was looking for zero blocks to ignore) and then do a loop to cp and sync 
that file until the emmc device life time was shown as exhausted.

This was a clean, best case sequential write so this is not just an issue with 
small, random writes.

Of course, this is normal to wear them out, but for the super low end parts, 
taking away any of the device writes in our stack is costly given how little 
life they have....

Regards,


Ric


>
> The topic has been a long-standing issue in flash area for multiple years and
> it'd be exciting to see any new ideas.
>
>
>     It seems like my email was not clear enough? What I tried to make clear
>     is that I think that there is no way to solve the flash wear issue with
>     the traditional block interface. I think that F2FS in combination with
>     the zone interface is an effective solution.
>
>     What is also relevant in this context is that the "Flash drive lifespan
>     is a problem" paper was published in 2017. I think that the first
>     commercial SSDs with a zone interface became available at a later time
>     (summer of 2020?).
>
>     Bart.
>

