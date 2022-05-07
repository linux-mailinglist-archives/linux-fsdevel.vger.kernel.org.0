Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106A451E74F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiEGNMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiEGNMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 09:12:06 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640CE13CE8
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 06:08:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCWsufy_1651928895;
Received: from 30.32.88.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCWsufy_1651928895)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 21:08:16 +0800
Message-ID: <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
Date:   Sat, 7 May 2022 21:08:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v2] erofs: change to use asyncronous io for fscache
 readpage/readahead
Content-Language: en-US
To:     Xin Yin <yinxin.x@bytedance.com>, hsiangkao@linux.alibaba.com,
        dhowells@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20220507083154.18226-1-yinxin.x@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220507083154.18226-1-yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/7/22 4:31 PM, Xin Yin wrote:
> Use asyncronous io to read data from fscache may greatly improve IO
> bandwidth for sequential buffer read scenario.
> 
> Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> and read data from fscache asyncronously. Make .readpage()/.readahead()
> to use this new helper.
> 
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---

s/asyncronous/asynchronous/
s/asyncronously/asynchronously/

BTW, "convert to asynchronous readahead" may be more concise?

Apart from that, LGTM

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jeffle
