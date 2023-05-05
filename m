Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA686F87B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjEEReh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjEERe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:34:28 -0400
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9091A497
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 10:34:06 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-18.iol.local with ESMTPA
        id uzJjpOTgynRXQuzJjp9elU; Fri, 05 May 2023 19:34:04 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1683308044; bh=i4RVjAX5vdoOxWHuBsy73aNXjE0Om9h5vw+IjoCaun0=;
        h=From;
        b=HksrDppwBQ/f4qrORVGewgwEcgMx5VZvCGFkU9ytRUlrKxd5FV1mTNcrPd6en3rrm
         ZfPrVK0GT5V0nTgR2+oSJEAk6IGSbsnr4vallyTci470U0QHt7mhQfohAYWp5iHX8v
         d/FjYjvrux8OQgA7rKH2x3Viafbj3i+uArPj2vF+YtxnNyqImupw0du9+wS2KPnpNH
         7EvDV5C2IbP9M+iFbIhyxzZZmxYrHZklWj8AmiCK/04wEfadb0m0U4nJ6xYhL0RxJD
         kh1CuB5UCnBuWViWZPOzFSs43Wez7jdNKoTzSmgEzrwVm/Ca/xKGOE5z71ihuJYBLu
         TlIbsDY6Od5WQ==
X-CNFS-Analysis: v=2.4 cv=P678xAMu c=1 sm=1 tr=0 ts=64553e0c cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=MEzEwBlUsdFG6EfuYh8A:9 a=QEXdDO2ut3YA:10
Message-ID: <26e62159-8df9-862a-8c14-7871b2cba961@libero.it>
Date:   Fri, 5 May 2023 19:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCHJo4v9de2afuvGBGmXK4qpoa0On7Wt/2slPO9b8QpMq5NOM29K+tft0s/MzrHQsjnsemEzx1l3gZp2O9b9nUUn+4SMEMX/1PV3j4tnaQAWzMrwcuzA
 9pZnnFQxML1q4Q+u6Ql3gld4CEPznQA11UsOf98p/EUXzODjknf/Rb2g0Z+gmHBlmFNQVaGDoYMUIAVC1PQ4h0o6t9cEuxhWq6m2q1SuiocC+hPc9/df2dII
 4eqxZyaI3UdHvDl38uLDQ/Md4rZaEwl5XYJDzcs1URNlJdBfehy4P+IKmrih0lyLX3K8SsGZxvVvm1ItO4RJkhvDBuEax8Ag/y7w/7OvgBMvJ6ARoXGpg25H
 ajnQHC+e3v7QYyo7qyccvLLKIdvfz/AffKhkzfUjITZuFTYjpBX6NDy3nH9aSgxqKEy1u4IKi7MZv0si741IAwaCwizWuf0RbLhvApma+OjisoNKfeFzNbWw
 Af4n00gKnKoR2WkxxgrP42kShfEtQzfXL/a2K08LKmKd39WP8kChr31RFfg8ZM+5e9KyEK6G2Mr1ixWKGQO5OqyZnEnKRXLLP1MW9FeaZfe67qICrcXtll00
 AJE=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 09.21, Qu Wenruo wrote:
> 
> I would prefer a much simpler but more explicit method.
> 
> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.

It is not clear to me if we need that.

I don't understand in what checking for SINGLE_DEV is different from
btrfs_super_block.disks_num == 1.

Let me to argument:

I see two scenarios:
1) mount two different fs with the same UUID NOT at the same time:
This could be done now with small change in the kernel:
- we need to NOT store the data of a filesystem when a disk is
   scanned IF it is composed by only one disk
- after the unmount we need to discard the data too (checking again
   that the filesystem is composed by only one disk)

No limit is needed to add/replace a disk. Of course after a disk is
added a filesystem with the same UUID cannot be mounted without a
full cycle of --forget.

I have to point out that this problem would be easily solved in
userspace if we switch from the current model where the disks are
scanned asynchronously (udev which call btrfs dev scan) to a model
where the disk are scanned at mount time by a mount.btrfs helper.

A mount.btrfs helper, also could be a place to put some more clear error
message like "we cannot mount this filesystem because one disk of a
raid5 is missing, try passing -o degraded"
or "we cannot mount this filesystem because we detect a brain split
problem" ....

2) mount two different fs with the same UUID at the SAME time:
This is a bit more complicated; we need to store a virtual UUID
somewhere.

However sometime we need to use the real fsid (during a write),
and sometime we need to use the virtual_uuid (e.g. for /sys/fs/btrfs/<uuid>)

Both in 1) and 2) we need to/it is enough to have btrfs_super_block.disks_num == 1
In the case 2) using a virtual_uuid mount option will prevent
to add a disk.


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

