Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6E4B82CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 09:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiBPISA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 03:18:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiBPIR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:17:59 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB6163D53;
        Wed, 16 Feb 2022 00:17:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V4cQ8KA_1644999462;
Received: from 30.225.24.51(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4cQ8KA_1644999462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:17:44 +0800
Message-ID: <b33d4e29-bf89-13cf-17f3-63208bf8f70d@linux.alibaba.com>
Date:   Wed, 16 Feb 2022 16:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3 05/22] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-6-jefflexu@linux.alibaba.com>
 <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <YguCYmvdyRAOjHcP@kroah.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YguCYmvdyRAOjHcP@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/15/22 6:37 PM, Greg KH wrote:
> On Tue, Feb 15, 2022 at 05:03:16PM +0800, JeffleXu wrote:
>> Hi David,
>>
>> FYI I've updated this patch on [1].
>>
>> [1]
>> https://github.com/lostjeffle/linux/commit/589dd838dc539aee291d1032406653a8f6269e6f.
> 
> We can not review random github links :(

Thanks. The new version patch has been replied in the email.

-- 
Thanks,
Jeffle
