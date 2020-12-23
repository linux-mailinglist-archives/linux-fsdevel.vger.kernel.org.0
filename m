Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEED72E10FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 02:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLWBCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 20:02:45 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41699 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgLWBCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:02:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UJUPqoO_1608685323;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UJUPqoO_1608685323)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Dec 2020 09:02:03 +0800
Subject: Re: [PATCH] block: move definition of blk_qc_t to types.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20201222031154.62150-1-jefflexu@linux.alibaba.com>
 <20201222133053.GA2935@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <fa513197-06d8-8391-77a6-82d86c741348@linux.alibaba.com>
Date:   Wed, 23 Dec 2020 09:02:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222133053.GA2935@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/22/20 9:30 PM, Christoph Hellwig wrote:
>> -typedef unsigned int blk_qc_t;
>>  #define BLK_QC_T_NONE		-1U
>>  #define BLK_QC_T_SHIFT		16
>>  #define BLK_QC_T_INTERNAL	(1U << 31)
> 
> I think we need a comment here explaining these are the values for
> blk_qc_t at least.
> 

Regards. Thanks.

-- 
Thanks,
Jeffle
