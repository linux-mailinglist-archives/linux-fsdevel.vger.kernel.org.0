Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83F678FFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjAXFi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 00:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXFi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:38:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56841305C2;
        Mon, 23 Jan 2023 21:38:50 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1pLZjb1fdD-007WQY; Tue, 24
 Jan 2023 06:38:45 +0100
Message-ID: <08def3ca-ccbd-88c7-acda-f155c1359c3b@gmx.com>
Date:   Tue, 24 Jan 2023 13:38:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: What would happen if the block device driver/firmware found some
 block of a bio is corrupted?
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <5be2cd86-e535-a4ae-b989-887bf9c2c36d@gmx.com>
 <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y89iSQJEpMFBSd2G@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OnHRkK6Ufy+A6GdbA/ZyeDj7v76sAtsb6avQnynhspvGL/K1HVr
 UvsxyTLxn7m5yD9muCMijc06+PFGH0b31QQRyALg+DukHKC7Mk2uh2lQ4N66NtU1czGjafe
 5VX+omeI/Ekt5vy/z/xOZ7+c3EFXeL65M0Htb04+nVQ/s4C8KUadTa01RTpaIOMOXUU3gC/
 P4wpQ0nelbo8eMhg9TVkQ==
UI-OutboundReport: notjunk:1;M01:P0:9FBSNmEB+dI=;v9AnZ4eusnuI42yFWm5ZmNDQati
 r/mkOLGGHjndTvZCewXsBCv4wMgGEwbBT9vpdshtoKW/cgQqJuDWNlk+QZriksvWQ2zRlH3Nx
 yiM2kp0LqZSzo0tnuqWUwjinAzED/CajEnKbkXMkgLw2LW0glymiR4bALi9CPAXdLvIaKcr0/
 EWvUQYPm7gjEgv8jQA8EqN5b05+lXsVOgLidZanZJQabjXK1ClFk7RshOA4DruUhumQ3NOQdx
 WKvWv86E7Z3u2g+du/11tTNxWQw6xBcmKClnhTcChlP+JeqL+c4QIF3n+78BcDfByHjW6hSKl
 0ioK70Su/aDg+7XUZxgFOLsh2Cg2nBortdO3W/YLw8mxk/9haUGCrgDVYc0pFnE46MgJQuC9P
 EhQa1aWLaqBlGX82qJuqqVBDYgQzQcFDUxO1Dligg/KKl4FELM8djkNCeytNBWilufIFpMO+Y
 aEn5+5amEZebRgrwFED3QS4ivL99DwBLr6WmIUwzMvrBYgnehIWDVlijqxhrgZJpX+TWzAoYG
 WZfGzYaH1cfnSmPFhB2o3Q9k7QRETF1e9IMhFuZ6RdriwIf8IccKG0MgfxTZFAeOvMUJ9sQcZ
 cXl9TIuop3QW/VDTk6Y2iQxZU2xZQsTxY5Kjgg6wpnZrAhuC43RkhPo7ojZbO4lkgv/9MrIu2
 Gspk/N+4JvMzLsbinJzSAkGAYXrfKeE9a210xeOLvs6JknRsV7h8mor4epkCUNEnvN6v+QIgT
 MWbhoGD5MYCikakXX++BU7D8KXVi9fcK4tBLuBdAulDNJU8xJoXDjkJben5OLGL7+Dq/CUaX3
 gw6dlNOHs32Ga57d1nJyoTmICjP8Glsz2ZD6omP/oTwUJfv4Cf3fihKdhHOjuJhSvU32CGx4o
 xR+EpzNvTMW8+pvTTSzFYnziGnXmaFOGCj0MsHVBWfor5UqvC78psl9BTYBY8cdwx6wAlF3TQ
 utFIPu5t15z0u9f9WMaLYtYoeg0=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/24 12:44, Keith Busch wrote:
> On Tue, Jan 24, 2023 at 10:31:47AM +0800, Qu Wenruo wrote:
>> I'm wondering what would happen if we submit a read bio containing multiple
>> sectors, while the block disk driver/firmware has internal checksum and
>> found just one sector is corrupted (mismatch with its internal csum)?
>>
>> For example, we submit a read bio sized 16KiB, and the device is in 4K
>> sector size (like most modern HDD/SSD).
>> The corruption happens at the 2nd sector of the 16KiB.
>>
>> My instinct points to either of them:
>>
>> A) Mark the whole 16KiB bio as BLK_STS_IOERR
>>     This means even we have 3 good sectors, we have to treat them all as
>>     errors.
> 
> I believe BLK_STS_MEDIUM is the appropriate status for this scenario,
> not IOERR. The MEDIUM errno is propogated up as ENODATA.
> 
> Finding specific failed sectors makes sense if a partial of the
> originally requested data is useful. That's application specific, so the
> retry logic should probably be driven at a higher level than the block
> layer based on seeing a MEDIUM error.

Thanks a lot, that indeed makes more sense.

The retry for file read is indeed triggered inside VFS, not fs/block/dm 
layer itself.

Thanks,
Qu
> 
> Some protocols can report partial transfers. If you trust the device,
> you could know the first unreadable sector and retry from there.
> 
> Some protocols like NVMe optionally support querying which sectors are
> not readable. We're not making use of that in kernel, but these kinds of
> features exist if you need to know which LBAs to exclude for future
> retries.
> 
> Outside that, you could search for specific unrecoverable LBAs with
> split retries till you find them all, divide-and-conquer.
