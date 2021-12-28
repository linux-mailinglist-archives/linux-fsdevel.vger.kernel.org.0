Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB48D48091E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhL1Md2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 07:33:28 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37196 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231132AbhL1Md1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 07:33:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V06qOCA_1640694803;
Received: from 30.225.24.30(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V06qOCA_1640694803)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 20:33:24 +0800
Message-ID: <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
Date:   Tue, 28 Dec 2021 20:33:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
 <YcndgcpQQWY8MJBD@casper.infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YcndgcpQQWY8MJBD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/27/21 11:36 PM, Matthew Wilcox wrote:
> On Mon, Dec 27, 2021 at 08:54:40PM +0800, Jeffle Xu wrote:
>> +	spin_lock(&cache->reqs_lock);
>> +	ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_KERNEL);
> 
> GFP_KERNEL while holding a spinlock?

Right. Thanks for pointing it out.

> 
> You should be using an XArray instead of an IDR in new code anyway.
> 

Regards.

-- 
Thanks,
Jeffle
