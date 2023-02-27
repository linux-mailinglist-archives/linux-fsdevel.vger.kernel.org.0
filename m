Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA2B6A432D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjB0Np7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 08:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0Np6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:45:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4221B550;
        Mon, 27 Feb 2023 05:45:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so6172483pja.5;
        Mon, 27 Feb 2023 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzmZnimNpH+EYXZ0bDiVoPJjPd0s6EF9C+qx53bSQDI=;
        b=ZzJXXHoZM/CzyJMIT0Vd2FuqJwOWi3ZiAyVSIdc7G6v6HGERSoQrbFl3CmkMbEOnLe
         FbpGGrrQEHUm9Rgq6jx/+TXe15M3qf3w3Vh4q6anEQ4uAvoQfYbEt+DvWNW1KY4OIJ3p
         RBFv/zRS5jMOxUzJl2gA7gGnparcii/lfOL8ZMCau+/oUyGlMPHuyUHZGx44ZG86yclk
         tooJpJQoGp6m/BY4hx0fFafeoQ1I7ieHk1WvE45EAUPsIBlwtKLeJ9HRf3x4fsD8kwYT
         WQD3rUGs8DYYOgry/K/zvLtfBElIZKBk2AZOwe40hugW1vgw+5LzjXEF0OePfsWGm+MZ
         flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzmZnimNpH+EYXZ0bDiVoPJjPd0s6EF9C+qx53bSQDI=;
        b=mfrFxwlLMrh/dMCseBhuOsco42557x0dcvYhznE4EYeH9V2B8bWNjyHQiZCytsoMgw
         JvzBybnWxdycKALqfUbNDuguv+sM3mOzJ6NRrWHqtLoLt9MgpW66PhDfyulqbxYrQV+R
         sq04DQcnzx0i5cBHu0H26I5g0ySZzhlUsxYIY2knvbPm6UTXmhTji7T+R8pg2KKd+IEK
         cEybRbivYHQyrN6kWgE1g4ycmOrH3zZAD2JK61q5rtHNuSr6ssq+GKs3b0FPTE2xirz+
         0twIrY/4Ez52fCLuIm4pGslE73cpzynj8KgB5z7R9Qgu7RMCo9tP7mTLIJ7Y9CBiSBQ0
         +Omw==
X-Gm-Message-State: AO0yUKURHEESWkDjPkY88pkVewEV9KUhkLUf/KtMZhIJQHYS4VFB3+nZ
        77TVzcuAlfGlhAHlZhyz31M=
X-Google-Smtp-Source: AK7set90PO9ecxcI2ys6lRPTe63kfXEIBrwfCYOYDLP+DSyx0qzIGI1tHu3XlHcF06v42vC1zlg7qQ==
X-Received: by 2002:a05:6a20:9383:b0:cb:af96:9436 with SMTP id x3-20020a056a20938300b000cbaf969436mr21854292pzh.0.1677505557052;
        Mon, 27 Feb 2023 05:45:57 -0800 (PST)
Received: from [192.168.136.80] ([182.2.39.140])
        by smtp.gmail.com with ESMTPSA id u24-20020a62ed18000000b005d663989ccfsm4241295pfh.200.2023.02.27.05.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:45:56 -0800 (PST)
Message-ID: <b863f0ec-5e53-0045-cca1-c1a513e930e5@gmail.com>
Date:   Mon, 27 Feb 2023 20:45:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
 <CAL3q7H63rvF3bXNgQAhcjdjbP2q5Wxo8MjcxcT7BeA9vjxAxwQ@mail.gmail.com>
 <ff610f19-7303-f583-4e22-e526f314aaa9@gmx.com>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
In-Reply-To: <ff610f19-7303-f583-4e22-e526f314aaa9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/27/23 6:46 PM, Qu Wenruo wrote:
> On 2023/2/27 19:02, Filipe Manana wrote:
>> On Sun, Feb 26, 2023 at 4:31 PM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>>> Figure (the CPU usage when `wq_cpu_set` is used VS when it is not):
>>> https://gist.githubusercontent.com/ammarfaizi2/a10f8073e58d1712c1ed49af83ae4ad1/raw/a4f7cbc4eb163db792a669d570ff542495e8c704/wq_cpu_set.png
>>
>> I haven't read the patchset.
>>
>> It's great that it reduces CPU usage. But does it also provide
>> other performance benefits, like lower latency or higher throughput
>> for some workloads? Or using less CPU also affects negatively in
>> those other aspects?

Based on my testing, it gives lower latency for a browser app playing
a YouTube video.

Without this proposed option, high-level compression on a btrfs
storage is a real noise to user space apps. It periodically freezes
the UI for 2 to 3 seconds and causes audio lag; it mostly happens when
it starts writing the dirty write to the disk.

It's reasonably easy to reproduce by making a large dirty write and
invoking a "sync" command.

Side note: Pin user apps to CPUs a,b,c,d and btrfs workquques to CPUs
w,x,y,z.

> So far it looks like to just set CPU masks for each workqueue.
> 
> Thus if it's reducing CPU usage, it also takes longer time to finish
> the workload (compression,csum calculation etc).

Yes, that's correct.

I see this as a good mount option for btrfs because the btrfs-workload
in question is CPU bound, specifically for the writing operation.
While it may degrade the btrfs workload because we limit the number of
usable CPUs, there is a condition where users don't prioritize writing
to disk.

Let's say:
I want to run a smooth app with video. I also want to have high-level
compression for my btrfs storage. But I don't want the compression and
checksum work to bother my video; here, I give you CPU x,y,z for the
btrfs work. And here I give you CPU a,b,c,d,e,f for the video work.

I have a similar case on a torrent seeder server where high-level
compression is expected. And I believe there are more cases where this
option is advantageous.

Thank you all for the comments,

-- 
Ammar Faizi
