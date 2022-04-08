Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47BC4F8C88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiDHCir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 22:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiDHCiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:38:46 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE4C1017F0
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 19:36:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9TXbj2_1649385400;
Received: from 30.225.24.70(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9TXbj2_1649385400)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Apr 2022 10:36:41 +0800
Message-ID: <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
Date:   Fri, 8 Apr 2022 10:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Content-Language: en-US
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     miklos@szeredi.hu, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yk7w8L1f/yik+qrR@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/7/22 10:10 PM, Vivek Goyal wrote:
> On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
>> Move dmap free worker kicker inside the critical region, so that extra
>> spinlock lock/unlock could be avoided.
>>
>> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Looks good to me. Have you done any testing to make sure nothing is
> broken.

xfstests -g quick shows no regression. The tested virtiofs is mounted
with "dax=always".

-- 
Thanks,
Jeffle
