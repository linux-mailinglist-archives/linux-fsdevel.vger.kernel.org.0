Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B365B67F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 08:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiIMGfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 02:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiIMGex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:34:53 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD72F2181;
        Mon, 12 Sep 2022 23:34:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPeAMF._1663050886;
Received: from 30.221.130.76(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPeAMF._1663050886)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 14:34:47 +0800
Message-ID: <b9794188-f1e1-20ab-6aec-04312cbb02bf@linux.alibaba.com>
Date:   Tue, 13 Sep 2022 14:34:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 2/5] erofs: introduce fscache-based
 domain
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-3-zhujia.zj@bytedance.com>
 <ac567b29-dd30-7b65-aefb-3f23e59781cb@linux.alibaba.com>
 <fe9199a2-a8d5-98c9-461b-e7a2cbf87516@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <fe9199a2-a8d5-98c9-461b-e7a2cbf87516@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/13/22 12:31 PM, Jia Zhu wrote:
> 
> 
> 在 2022/9/9 16:42, JeffleXu 写道:
>>>   int erofs_fscache_register_cookie(struct super_block *sb,
>>>                     struct erofs_fscache **fscache,
>>>                     char *name, bool need_inode)
>>> @@ -495,7 +581,8 @@ int erofs_fscache_register_fs(struct super_block
>>> *sb)
>>>       char *name;
>>>       int ret = 0;
>>>   -    name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
>>> +    name = kasprintf(GFP_KERNEL, "erofs,%s",
>>> +            sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
>>
>> Do we also need to encode the cookie name in the "<domain_id>,<fsid>"
>> format? This will affect the path of the cache files.
>>
> I think even though the cookies have the same name, they belong to
> different volumes(path). Cookies do not affect each other.
> Are there other benefits to doing so?

Okay. The current implementation is correct. Please ignore the noise.


-- 
Thanks,
Jingbo
