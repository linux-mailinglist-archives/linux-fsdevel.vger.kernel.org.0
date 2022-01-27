Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D967949DB2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 08:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiA0HHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 02:07:05 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51914 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbiA0HHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:07:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2z08g._1643267220;
Received: from 30.225.24.48(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2z08g._1643267220)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Jan 2022 15:07:02 +0800
Message-ID: <8f73d28e-db30-f2e4-0143-9d75c4b13087@linux.alibaba.com>
Date:   Thu, 27 Jan 2022 15:07:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read
 semantics
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
 <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2815558.1643127330@warthog.procyon.org.uk>
 <100895.1643187095@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <100895.1643187095@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/26/22 4:51 PM, David Howells wrote:
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
>> "/path/to/file+offset"
>> 		^
>>
>> Besides, what does the 'offset' mean?
> 
> Assuming you're storing multiple erofs files within the same backend file, you
> need to tell the the cache backend how to find the data.  Assuming the erofs
> data is arranged such that each erofs file is a single contiguous region, then
> you need a pathname and a file offset to find one of them.
> 

Alright. In fact one erofs file can contain multiple chunks, which can
correspond to different backing blob files. Thus currently I will use
fscache_read() directly, to push this feature forward.

Thanks a lot.


-- 
Thanks,
Jeffle
