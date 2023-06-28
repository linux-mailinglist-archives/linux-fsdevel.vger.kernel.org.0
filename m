Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6CE741021
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjF1LgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 07:36:04 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97]:60541 "EHLO
        out30-97.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbjF1LgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:36:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vm9oH34_1687952160;
Received: from 30.97.48.252(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm9oH34_1687952160)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 19:36:01 +0800
Message-ID: <389f333b-3ec3-63ef-2dcb-3fe5b8b07702@linux.alibaba.com>
Date:   Wed, 28 Jun 2023 19:35:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: ask for help: Overlay FS - user failed to write when lower
 directory has no R-bit but only W-bit
To:     Sam Wong <sam@hellosam.net>, linux-fsdevel@vger.kernel.org
References: <CAMohUi+3r3YCQrqA_v05LLVyRcjBS+D8N+JP_P0Tda3hvD4hCg@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMohUi+3r3YCQrqA_v05LLVyRcjBS+D8N+JP_P0Tda3hvD4hCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Sam,

On 2023/6/28 17:55, Sam Wong wrote:
> Hello,
> 
> I hope this is the write mailing list. I was debugging a container
> problem after upgrading kubernetes nodes on my cloud provider, and
> turns out it's an overlay fs related issue and has nothing to do with
> the container technology.
> 
> I made a repro script and it consistently reproduce the issue. Thing
> breaks in the newer kernel version (5.10.134-13.1.al8.x86_64), and
> works in the older version (5.10.84-10.2.al8.x86_64). Test cases and
> the situation is explained in the script.
> 
> ---
> 
> #### Synopsis
> ## Things work as expected in 5.10.84-10.2.al8.x86_64
> ## Things break as expected in 5.10.134-13.1.al8.x86_64

It seems those are our maintained kernels.

-fsdevel is not the place to report downstream kernel (Alibaba Cloud
Linux) bugs, could you help file the bug to:

https://bugzilla.openanolis.cn/
(or I could help you file a bug there if needed).

and we could discuss the root cause of this there and find a solution
to resolve your current issue.

> 

...

> I have not yet bisect or upgraded to the latest kernel version, that's
> something I might be doing next, but since I am on Alicloud, upgrading
> the kernel is not the easiest thing I could do. I did some searches
> here and there for similar problems but to no avail. I am also> reaching out to Alicloud support. I hope if this is a known problem

Very sorry to hear that.

Thanks,
Gao Xiang
