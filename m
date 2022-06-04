Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70153D64F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jun 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiFDJun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiFDJuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:50:39 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94012AD9;
        Sat,  4 Jun 2022 02:50:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFIW1-m_1654336231;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VFIW1-m_1654336231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jun 2022 17:50:32 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH] proc: export page young and skip_kasan_poison flag via
 kpageflags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     changbin.du@intel.com, sashal@kernel.org,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602154302.12634-1-xhao@linux.alibaba.com>
 <YpkBQTWWUuOzagvd@casper.infradead.org>
Message-ID: <55263fe2-f8ae-f681-69fd-1064a74f2bb6@linux.alibaba.com>
Date:   Sat, 4 Jun 2022 17:50:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YpkBQTWWUuOzagvd@casper.infradead.org>
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


On 6/3/22 2:28 AM, Matthew Wilcox wrote:
> On Thu, Jun 02, 2022 at 11:43:02PM +0800, Xin Hao wrote:
>> Now the young and skip_kasan_poison flag are supported in
> Why do we want userspace to know about whether skip_kasan_poison is set?
> That seems like a kernel-internal detail to me.

the  skip_kasan_poison also a page flags, we use page_types tool to 
display them not only include user-internal,

but also  kernel-internal, add them, the page-types tool can more detail 
display the kernel-internal page flags,

just in case we don't miss some page flags when check the whole memory.

-
Best Regards!
Xin Hao

