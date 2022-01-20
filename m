Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9527E494E1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbiATMoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 07:44:06 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34658 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242871AbiATMoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:44:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V2MYYzM_1642682637;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2MYYzM_1642682637)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Jan 2022 20:43:59 +0800
Message-ID: <a5b495d3-cafe-548a-2130-b7aa9e597f41@linux.alibaba.com>
Date:   Thu, 20 Jan 2022 20:43:57 +0800
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
 <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
 <99c94a78-58c4-f0af-e1d4-9aaa51bab281@linux.alibaba.com>
 <YegQOHs9yjIgu1Qi@casper.infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YegQOHs9yjIgu1Qi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/19/22 9:20 PM, Matthew Wilcox wrote:
> On Wed, Jan 12, 2022 at 05:02:13PM +0800, JeffleXu wrote:
>> I'm afraid IDR can't be replaced by xarray here. Because we need an 'ID'
>> for each pending read request, so that after fetching data from remote,
>> user daemon could notify kernel which read request has finished by this
>> 'ID'.
>>
>> Currently this 'ID' is get from idr_alloc(), and actually identifies the
>> position of corresponding read request inside the IDR tree. I can't find
>> similar API of xarray implementing similar function, i.e., returning an
>> 'ID'.
> 
> xa_alloc().
> 

Oh yes. Thanks. I will try to convert to xarray API...

-- 
Thanks,
Jeffle
