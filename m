Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5940371F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbhIHJnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 05:43:10 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:52069 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347681AbhIHJnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:43:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UngJFte_1631094117;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UngJFte_1631094117)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 17:41:58 +0800
Subject: Re: [PATCH 1/2] fuse: disable atomic_o_trunc if no_open is enabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
 <20210812054618.26057-2-jefflexu@linux.alibaba.com>
 <CAJfpegs3QGVNa4CXt0Hayr=G50cQb1TWowRDuVf0pZv6FYV3kw@mail.gmail.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <3afa0ef8-8f69-c34a-9302-c1ea927668f6@linux.alibaba.com>
Date:   Wed, 8 Sep 2021 17:41:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegs3QGVNa4CXt0Hayr=G50cQb1TWowRDuVf0pZv6FYV3kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/7/21 4:34 PM, Miklos Szeredi wrote:
> On Thu, 12 Aug 2021 at 07:46, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> From: Liu Bo <bo.liu@linux.alibaba.com>
>>
>> When 'no_open' is used by virtiofsd, guest kernel won't send OPEN request
>> any more.  However, with atomic_o_trunc, SETATTR request is also omitted in
>> OPEN(O_TRUNC) so that the backend file is not truncated.  With a following
>> GETATTR, inode size on guest side is updated to be same with that on host
>> side, the end result is that O_TRUNC semantic is broken.
>>
>> This disables atomic_o_trunc as well if with no_open.
> 
> I don't quite get it why one would want to enable atomic_o_trunc with
> no_open in the first place?

Oops..We didn't realize that it could also be worked around by fuse
daemon side. Please ignore this.

-- 
Thanks,
Jeffle
