Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB27F50A37C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiDUPAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353404AbiDUPAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:00:33 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6743EF0;
        Thu, 21 Apr 2022 07:57:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VAgCg.U_1650553055;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VAgCg.U_1650553055)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 22:57:37 +0800
Message-ID: <e2a38f8c-ba20-0368-c3cb-aeb4d5212cc6@linux.alibaba.com>
Date:   Thu, 21 Apr 2022 22:57:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 04/21] cachefiles: notify user daemon when withdrawing
 cookie
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com,
        zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-5-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1445104.1650549959@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1445104.1650549959@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/21/22 10:05 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	 * It's possiblie that object id is still 0 if the cookie looking up
> 
> possiblie -> possible

Thanks.

> 
> Otherwise:
> 
> Acked-by: David Howells <dhowells@redhat.com>

-- 
Thanks,
Jeffle
