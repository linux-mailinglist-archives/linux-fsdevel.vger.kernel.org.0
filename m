Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54DE464B03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbhLAJyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 04:54:52 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:51511 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348392AbhLAJyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:54:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uz1Lkdd_1638352275;
Received: from 30.240.100.124(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Uz1Lkdd_1638352275)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Dec 2021 17:51:17 +0800
Message-ID: <23eec1ac-4fee-7386-e75d-ca9bf6cd1c88@linux.alibaba.com>
Date:   Wed, 1 Dec 2021 17:51:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] fs: Eliminate compilation warnings for misc
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
 <941c9239-3b73-c2ae-83aa-f83d4e587fc8@infradead.org>
 <e06a86b2-1624-986c-9e97-ffac121dc240@linux.alibaba.com>
 <YaTTXSTiOpL1/ymL@casper.infradead.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YaTTXSTiOpL1/ymL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 11/29/21 9:19 PM, Matthew Wilcox wrote:
> On Mon, Nov 29, 2021 at 09:06:09PM +0800, Tianjia Zhang wrote:
>> Hi Randy,
>>
>> On 11/17/21 7:00 AM, Randy Dunlap wrote:
>>> On 11/16/21 12:06 AM, Tianjia Zhang wrote:
>>>> Eliminate the following clang compilation warnings by adding or
>>>> fixing function comment:
>>>
>>> These are from clang?  They all appear to be from scripts/kernel-doc.
>>>
>>> Can someone please clarify?
>>>
>>> thanks.
>>
>> Yes, compile with W=1, clang will report this warning.
> 
> No, clang has nothing to do with it.  The warnings are from kernel-doc,
> not clang.  Nor gcc.
> 

I was negligent, you are right. Thanks for pointing it out.

Best regards,
Tianjia
