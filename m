Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A863853B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 09:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiKYIdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 03:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYIdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:33:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF0B2D77C;
        Fri, 25 Nov 2022 00:33:18 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJSmB5gZGzmVpr;
        Fri, 25 Nov 2022 16:32:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 16:33:16 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 16:33:16 +0800
Subject: Re: [PATCH v2 0/2] fs: clear a UBSAN shift-out-of-bounds warning
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, "Chris Mason" <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221121024418.1800-1-thunder.leizhen@huawei.com>
 <Y4BkJd3Jy6MY3cdu@ZenIV>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6660724c-46e8-87b7-e382-51789953242d@huawei.com>
Date:   Fri, 25 Nov 2022 16:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y4BkJd3Jy6MY3cdu@ZenIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/25 14:43, Al Viro wrote:
> On Mon, Nov 21, 2022 at 10:44:16AM +0800, Zhen Lei wrote:
>> v1 -- > v2:
>> 1. Replace INT_LIMIT(loff_t) with OFFSET_MAX in btrfs.
>> 2. Replace INT_LIMIT() with type_max().
> 
> Looks fine, except that I'd rather go for commit message
> along the lines of "INT_LIMIT tries to do what type_max does,
> except that type_max doesn't rely upon undefined behaviour;
> might as well use type_max() instead"

Very good. Do I send v3, or do you update it?

> 
> If you want to credit UBSAN - sure, no problem, just don't
> clutter the commit message with that.  As it is, it reads
> as "make $TOOL STFU"...

Okay, I'll pay attention next time. This USBAN problem is relatively
simple and can be located without relying on other information, so I
omitted the rest.

After changing to your suggested description, it seems that there is
no need to mention UBSAN, after all, it is just a false positive and
there is no real problem.

> 
> .
> 

-- 
Regards,
  Zhen Lei
