Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94369484FBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiAEJEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 04:04:25 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55900 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231918AbiAEJEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:04:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V10Yc.y_1641373459;
Received: from 30.225.24.102(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V10Yc.y_1641373459)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 17:04:20 +0800
Message-ID: <9ab680eb-beb2-07eb-eab2-833fde48906d@linux.alibaba.com>
Date:   Wed, 5 Jan 2022 17:04:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 07/23] erofs: add nodev mode
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-8-jefflexu@linux.alibaba.com>
 <YdRattisu+ITYvvZ@B-P7TQMD6M-0146.local>
 <YdRgrWEDU8sJVExX@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YdRgrWEDU8sJVExX@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/4/22 10:58 PM, Gao Xiang wrote:
> On Tue, Jan 04, 2022 at 10:33:26PM +0800, Gao Xiang wrote:
>> On Mon, Dec 27, 2021 at 08:54:28PM +0800, Jeffle Xu wrote:
>>> Until then erofs is exactly blockdev based filesystem. In other using
>>> scenarios (e.g. container image), erofs needs to run upon files.
>>>
>>> This patch introduces a new nodev mode, in which erofs could be mounted
>>> from a bootstrap blob file containing the complete erofs image.
>>>
>>> The following patch will introduce a new mount option "uuid", by which
>>> users could specify the bootstrap blob file.
>>>
>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>
>> I think the order of some patches in this patchset can be improved.
>>
>> Take this patch as an example. This patch introduces a new mount
>> option called "uuid", so the kernel will just accept it (which
>> generates a user-visible impact) after this patch but it doesn't
>> actually work.
>>
>> Therefore, we actually have three different behaviors here:
>>  - kernel doesn't support "uuid" mount option completely;
>>  - kernel support "uuid" but it doesn't work;
>>  - kernel support "uuid" correctly (maybe after some random patch);
>>
>> Actually that is bad for bisecting since there are some commits
>> having temporary behaviors. And we don't know which commit
>> actually fully implements this "uuid" mount option.
>>
>> So personally I think the proper order is just like the bottom-up
>> approach, and make sure each patch can be tested / bisected
>> independently.
> 
> Oh, I may misread this patch, but I still think we'd better to
> avoid dead paths "TODO" like this as much as possible.
> 
> Just do in the bottom-up way.
> 

OK, it is better to be put at the latter part of the whole patch set.
Would be fixed in the next version. Thanks.

-- 
Thanks,
Jeffle
