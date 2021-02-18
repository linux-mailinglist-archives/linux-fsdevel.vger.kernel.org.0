Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6938931EA31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhBRNBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 08:01:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:37931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231527AbhBRM56 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613652937;
        bh=bdZMak31fNteVwVQpsTlJ3yYqmsz2U3hqxKSwUySlaI=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=UiN3DTss3b7oWPSUOM8Yht8Y4hKv36/XuAt6sSoMFmTGRg08/pavhLsJZKrwofSD2
         ndYQwVlbmOK+OpmkxA7OIq9DdiCt80o+1xYJU08KzlJcNQCEkULSlQr26AG6kJOFAo
         6Yc3H/em5srXf75am0uRFh/4BFsj5ufdP4g0d5q4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwQT9-1m2lSK1svd-00sKHp; Thu, 18
 Feb 2021 13:42:22 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
Date:   Thu, 18 Feb 2021 20:42:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218121503.GQ2858050@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YigMLcX2lUV+ifuKcbDIWzJBK5Q3F4eyrJleuoNZYXSa8Gop4e4
 /kmPXfVvJsvQ413GEWUe+Tsuf62z90cCT5xGFFKjmxzjhNYm7eT2QmS/ZmwQhPHCSqajTbu
 kfD1vusiCZPjeJa6tD012pX6ou1aSNss9e8ER5EbW7bQ34RCRKR+cFpDYeJXTKF8VNU1rA3
 AQmz5eviJAVLaxhTmnYMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ZltDiB8MrE=:K9fInWENN02G/F+FH+kDDr
 Jun0gcmYcRS3skkuak7uDpIyDv5syugf6MtiL2NaKhcYt+HIlwHdHmE9uUBLtQX//mKrA5jNU
 DgDHhfZE8pvqEutMdTx2zcyhpon5HkYZssVcmpnOPW78C/VtV2Rf5swXkOYsa5EVz2TgKygly
 99NTc83931xhm3qqeXR8aODejVJ7traouBag10zE5jvNnoi4XsdF6DoQB/SOJU8yOJd5yw3cR
 w+JJpU4BHlKqZdwk3gkftl0rKr4XcGt0TLFUviJ/38FHVGyt/fRTxD2mgsfuSaObc/pq9KyeN
 Ten5JIxrsUdF9bzgFk/VyGGx7D/5UTKYZl+Q6EbyhvfBdIk6in7PDBDB4PtSiKp6HsppIt7vm
 SZaisjTBLB1TbKdrtAAHxtFa8wZUkjTUPGd5jkQXeqAsatDKgyBWKkEO0SZi8xMAwrE6oi9nn
 vAjbPjXZDcJvzKf1EcOKKTAr1+3SuBoOyWLc0qCqBGUs1rDVgaRa3Yvc98sPL8uWhTbTPYbe2
 crRlXjnYl6zRXas3F3WI0BJ/9P00dqFA+ZHQp0EnIGM8vGdGrSZG5+gY2SJSJUUyYz0WECsBX
 uRJoWAPrGygPlQ8yI8iSGeqkwm9Ecm/3SRuArwb3M8L0wUMjzKydfmK4jgvYanZl0sbM8DC9w
 pluF6MVaKdSkwFO81ak3WXM7hqbhqrowj3gHll0siO3JCAwQ0APN+wEsiT16h39gC05NeJoGY
 tLdmIKePHnQpj0KuMHIJRomf09lcDnSPvR76g0xnFdOgPpl0ndZvWJkvLNU50U/ZXJfTnvCd1
 FILtUACHOxH9YuRPKGe2vuQP6GF8ytl4r3v6ZTB0YYCZ1Ihei4epjEeOxSdKAS3VmZfu0ehXV
 lb+0fdKpfAVbOKB+u4jg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=888:15, Matthew Wilcox wrote:
> On Thu, Feb 18, 2021 at 04:54:46PM +0800, Qu Wenruo wrote:
>> Recently we got a strange bug report that, one 32bit systems like armv6
>> or non-64bit x86, certain large btrfs can't be mounted.
>>
>> It turns out that, since page->index is just unsigned long, and on 32bi=
t
>> systemts, that can just be 32bit.
>>
>> And when filesystems is utilizing any page offset over 4T, page->index
>> get truncated, causing various problems.
>
> 4TB?  I think you mean 16TB (4kB * 4GB)

Oh, offset by 2...

>
> Yes, this is a known limitation.  Some vendors have gone to the trouble
> of introducing a new page_index_t.  I'm not convinced this is a problem
> worth solving.  There are very few 32-bit systems with this much storage
> on a single partition (everything should work fine if you take a 20TB
> drive and partition it into two 10TB partitions).
What would happen if a user just tries to write 4K at file offset 16T
fir a sparse file?

Would it be blocked by other checks before reaching the underlying fs?

>
> As usual, the best solution is for people to stop buying 32-bit systems.
>

They don't need a large single partition to even trigger it.

This is especially true for btrfs, which has its internal address space
(and it can be any aligned U64 value).
Even 1T btrfs can have its metadata at its internal bytenr way larger
than 1T. (although those ranges still needs to be mapped inside the device=
).

And considering the reporter is already using 32bit with 10T+ storage, I
doubt if it's really not worthy.

BTW, what would be the extra cost by converting page::index to u64?
I know tons of printk() would cause warning, but most 64bit systems
should not be affected anyway.

Thanks,
Qu
