Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE743753183
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 07:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjGNFuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 01:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGNFuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:50:20 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199712123;
        Thu, 13 Jul 2023 22:50:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VnKW-Oq_1689313812;
Received: from 30.221.157.198(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnKW-Oq_1689313812)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 13:50:13 +0800
Message-ID: <ac961438-2d88-e7bb-d58f-10054478fb26@linux.alibaba.com>
Date:   Fri, 14 Jul 2023 13:50:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] FUSE consistency improvements
Content-Language: en-US
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     me@jcix.top
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/11/23 12:34 PM, Jiachen Zhang wrote:
> This patchset resends some patches that related to FUSE consistency
> improvements in the mailing list.
> 
> The 1st patch fixes a staleness-checking issue, which is the v2 version
> of the patch[1].
> 
> The 2nd patch is a resend version of the patch[2] with its commit message
> rewritten.
> 
> The 3rd and 4th patches are new versions of the patch[3] and the patch[4],
> FUSE filesystems are able to implement the close-to-open (CTO) consistency
> semantics with the help of these two patches. The 5th patch is a new
> patch which improves the explanation of FUSE cache mode and consistency
> models in the documentation.
> 

Yeah our internal production environment will also benefit from this
cache consistency enhancement.  It would be great if this feature could
be improved and finally gets merged.


-- 
Thanks,
Jingbo
