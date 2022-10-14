Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41965FE8E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 08:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJNGbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 02:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNGbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:31:47 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B780532B9D;
        Thu, 13 Oct 2022 23:31:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VS6XyKN_1665729101;
Received: from 30.221.130.30(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VS6XyKN_1665729101)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 14:31:43 +0800
Message-ID: <b0c874db-5d04-d1af-efdd-3f4390c2718f@linux.alibaba.com>
Date:   Fri, 14 Oct 2022 14:31:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH V2 1/5] cachefiles: introduce object ondemand state
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221014030745.25748-1-zhujia.zj@bytedance.com>
 <20221014030745.25748-2-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221014030745.25748-2-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/14/22 11:07 AM, Jia Zhu wrote:
> Previously, @ondemand_id field was used not only to identify ondemand
> state of the object, but also to represent the index of the xarray.
> This commit introduces @state field to decouple the role of @ondemand_id
> and adds helpers to access it.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/cachefiles/internal.h | 22 ++++++++++++++++++++++
>  fs/cachefiles/ondemand.c | 21 +++++++++------------
>  2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 2ad58c465208..39895bbd149a 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -17,6 +17,7 @@
>  #include <linux/security.h>
>  #include <linux/xarray.h>
>  #include <linux/cachefiles.h>
> +#include <linux/atomic.h>
     ^
This is not needed any more.

Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
