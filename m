Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF67D3CB059
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 03:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhGPBVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 21:21:31 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47803 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhGPBVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:21:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfvfgsD_1626398314;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfvfgsD_1626398314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 09:18:35 +0800
Subject: Re: [RFC PATCH 3/3] fuse: add per-file DAX flag
To:     Vivek Goyal <vgoyal@redhat.com>, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
 <20210715093031.55667-4-jefflexu@linux.alibaba.com>
 <20210716004028.GA30967@rsjd01523.et2sqa> <YPDX9S3/TD3CL0CZ@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <6d956097-47c1-5193-bbaa-faf14f0989ef@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 09:18:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPDX9S3/TD3CL0CZ@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/16/21 8:51 AM, Vivek Goyal wrote:
> On Fri, Jul 16, 2021 at 08:40:29AM +0800, Liu Bo wrote:
>> On Thu, Jul 15, 2021 at 05:30:31PM +0800, Jeffle Xu wrote:
>>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>>> this file.
>>>
>>> When the per-file DAX flag changes for an *opened* file, the state of
>>> the file won't be updated until this file is closed and reopened later.
>>>
>>> Currently it is not implemented yet to change per-file DAX flag inside
>>> guest kernel, e.g., by chattr(1).
>>
>> Thanks for the patch, it looks good to me.
>>
>> I think it's a good starting point, what I'd like to discuss here is
>> whether we're going to let chattr to toggle the dax flag.
> 
> I have the same question. Why not take chattr approach as taken
> by ext4/xfs as well.
> 
> Vivek

Thanks.

We can implement the chattr approach as ext4/xfs do, if we have this use
scenario. It's an RFC patch, and I want to collect more feedback as soon
as possible.

-- 
Thanks,
Jeffle
