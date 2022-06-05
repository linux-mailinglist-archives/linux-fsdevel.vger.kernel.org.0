Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324AF53DA40
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 07:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiFEFZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 01:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFEFZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 01:25:09 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6562E1403F;
        Sat,  4 Jun 2022 22:25:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFM728m_1654406700;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VFM728m_1654406700)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 05 Jun 2022 13:25:01 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH] proc: export page young and skip_kasan_poison flag via
 kpageflags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     sashal@kernel.org, akpm@linux-foundation.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602154302.12634-1-xhao@linux.alibaba.com>
 <YpkBQTWWUuOzagvd@casper.infradead.org>
 <55263fe2-f8ae-f681-69fd-1064a74f2bb6@linux.alibaba.com>
 <Ypt1eFD5QDteH1RS@casper.infradead.org>
Message-ID: <a64d6c6b-ae07-ed49-8185-0381b6e2d37b@linux.alibaba.com>
Date:   Sun, 5 Jun 2022 13:25:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ypt1eFD5QDteH1RS@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Matthew:

On 6/4/22 11:08 PM, Matthew Wilcox wrote:
> On Sat, Jun 04, 2022 at 05:50:31PM +0800, Xin Hao wrote:
>> On 6/3/22 2:28 AM, Matthew Wilcox wrote:
>>> On Thu, Jun 02, 2022 at 11:43:02PM +0800, Xin Hao wrote:
>>>> Now the young and skip_kasan_poison flag are supported in
>>> Why do we want userspace to know about whether skip_kasan_poison is set?
>>> That seems like a kernel-internal detail to me.
>> the  skip_kasan_poison also a page flags, we use page_types tool to display
>> them not only include user-internal,
>>
>> but also  kernel-internal, add them, the page-types tool can more detail
>> display the kernel-internal page flags,
>>
>> just in case we don't miss some page flags when check the whole memory.
> So you're just being completist?  You don't have a reason to expose this
> information?

Yes, about the skip_kasan_poison, i just want the kpageflags to support 
it,  i think it should be included,

the mainly  region is i want get the page node info from the kpageflags 
in my next patch,  when i check these

codes,  i see there lost some info about the skip_kasan_poison and young 
flags,  the page_types tool also check

the kasan pages, so i think it should be included.

Thanks.

-- 
Best Regards!
Xin Hao

