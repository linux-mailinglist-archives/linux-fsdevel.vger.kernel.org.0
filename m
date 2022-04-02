Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8229F4EFF10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 07:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348757AbiDBFe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 01:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiDBFeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:34:25 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD94147AF2;
        Fri,  1 Apr 2022 22:32:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8yMzNQ_1648877547;
Received: from 30.225.24.59(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8yMzNQ_1648877547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 13:32:29 +0800
Message-ID: <11bb4271-8a87-945f-96ef-be3a1acd01a5@linux.alibaba.com>
Date:   Sat, 2 Apr 2022 13:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 02/19] cachefiles: notify user daemon with anon_fd when
 looking up cookie
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
 <20220331115753.89431-3-jefflexu@linux.alibaba.com>
In-Reply-To: <20220331115753.89431-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/31/22 7:57 PM, Jeffle Xu wrote:
>  
> +	ret = cachefiles_ondemand_init_object(object);
> +	if (ret < 0) {
> +		file = ERR_PTR(ret);
> +		goto out_unuse;
> +	}
> +

Sorry, this patch really depends on [1] which introduces "out_unuse" label.

[1] https://www.spinics.net/lists/linux-cachefs/msg05972.html


My git branch has already contained this commit [2].

[2]
https://github.com/lostjeffle/linux/commit/3c71705e777fa75d37f784640a232db14ce62c31


-- 
Thanks,
Jeffle
