Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE35F98C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGDOBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 10:01:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfGDOBK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:01:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 808E05FCF004B354299B;
        Thu,  4 Jul 2019 22:01:04 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul 2019
 22:00:55 +0800
Subject: Re: [PATCH] erofs: promote erofs from staging
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>
References: <20190704133413.43012-1-gaoxiang25@huawei.com>
 <20190704135002.GB13609@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <29e713d5-8146-80cf-8ffd-138b15349489@huawei.com>
Date:   Thu, 4 Jul 2019 22:00:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190704135002.GB13609@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On 2019/7/4 21:50, Greg Kroah-Hartman wrote:
> On Thu, Jul 04, 2019 at 09:34:13PM +0800, Gao Xiang wrote:
>> EROFS file system has been in Linux-staging for about a year.
>> It has been proved to be stable enough to move out of staging
>> by 10+ millions of HUAWEI Android mobile phones on the market
>> from EMUI 9.0.1, and it was promoted as one of the key features
>> of EMUI 9.1 [1], including P30(pro).
>>
>> EROFS is a read-only file system designed to save extra storage
>> space with guaranteed end-to-end performance by applying
>> fixed-size output compression, inplace I/O and decompression
>> inplace technologies [2] to Linux filesystem.
>>
>> In our observation, EROFS is one of the fastest Linux compression
>> filesystem using buffered I/O in the world. It will support
>> direct I/O in the future if needed. EROFS even has better read
>> performance in a large CR range compared with generic uncompressed
>> file systems with proper CPU-storage combination, which is
>> a reason why erofs can be landed to speed up mobile phone
>> performance, and which can be probably used for other use cases
>> such as LiveCD and Docker image as well.
>>
>> Currently erofs supports 4k LZ4 fixed-size output compression
>> since LZ4 is the fastest widely-used decompression solution in
>> the world and 4k leads to unnoticable read amplification for
>> the worst case. More compression algorithms and cluster sizes
>> could be added later, which depends on the real requirement.
>>
>> More informations about erofs itself are available at:
>>  Documentation/filesystems/erofs.txt
>>  https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei
>>
>> erofs-utils (mainly mkfs.erofs now) is available at
>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>>
>> Preliminary iomap support has been pending in erofs mailing
>> list by Chao Yu. The key issue is that current iomap doesn't
>> support tail-end packing inline data yet, it should be
>> resolved later.
>>
>> Thanks to many contributors in the last year, the code is more
>> clean and improved. We hope erofs can be used in wider use cases
>> so let's promote erofs out of staging and enhance it more actively.
>>
>> Share comments about erofs! We think erofs is useful to
>> community as a part of Linux upstream :)
> 
> I don't know if this format is easy for the linux-fsdevel people to
> review, it forces them to look at the in-kernel code, which makes it
> hard to quote.
> 
> Perhaps just make a patch that adds the filesystem to the tree and after
> it makes it through review, I can delete the staging version?  We've
> been doing that for wifi drivers that move out of staging as it seems to
> be a bit easier.

OK, I will resend the whole patchset later as you suggested, but it will
lack of information about some original authors and I'd like to know who
is responsible to merge this kind of request to Linux upstream... maybe Linus?

And it could be more consistent to leave staging version for linux-5.3
because we still use it, but anyway, I will do it now.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
