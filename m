Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E659F84A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiHXLAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiHXLAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:00:14 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C8D1F2C9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 04:00:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VN7IkSi_1661338808;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VN7IkSi_1661338808)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 19:00:10 +0800
Date:   Wed, 24 Aug 2022 19:00:08 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Xin Yin <yinxin.x@bytedance.com>, xiang@kernel.org,
        jefflexu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, linux-cachefs@redhat.com,
        Yongqing Li <liyongqing@bytedance.com>
Subject: Re: [Linux-cachefs] [External] Re: [PATCH] cachefiles: make
 on-demand request distribution fairer
Message-ID: <YwYEuLju8hixxMZT@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Xin Yin <yinxin.x@bytedance.com>, xiang@kernel.org,
        jefflexu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, linux-cachefs@redhat.com,
        Yongqing Li <liyongqing@bytedance.com>
References: <Yvy2LWrMMktWPAdk@B-P7TQMD6M-0146.local>
 <20220817065200.11543-1-yinxin.x@bytedance.com>
 <YvyVOfzkITlvgtQ6@B-P7TQMD6M-0146.local>
 <CAK896s71E8a_iAYwEtzp7XKopQnVT5-YnkuC3yTewOfdmvf2VQ@mail.gmail.com>
 <3711027.1661336669@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3711027.1661336669@warthog.procyon.org.uk>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Wed, Aug 24, 2022 at 11:24:29AM +0100, David Howells wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > If David is fine with "req_id_next", I'm okay with that as well.
> 
> I can live with it.
> 
> Did you want to give me an R-b line?

Yeah, thanks, much appreciated!  As far as I know, such unfairness can
cause starvation in Bytedance's test environment, it would be better
to fix it as above.

Thanks,
Gao Xiang

> 
> David
