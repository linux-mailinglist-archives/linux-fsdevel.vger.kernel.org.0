Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE852193B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbiEJNoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbiEJNmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 09:42:01 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB92CBE72;
        Tue, 10 May 2022 06:30:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VCrRO54_1652189383;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCrRO54_1652189383)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 21:29:46 +0800
Date:   Tue, 10 May 2022 21:29:42 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: Re: [PATCH v11 06/22] cachefiles: enable on-demand read mode
Message-ID: <YnpoxvLk3us94C9I@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
References: <20220509074028.74954-7-jefflexu@linux.alibaba.com>
 <20220509074028.74954-1-jefflexu@linux.alibaba.com>
 <3509457.1652187396@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3509457.1652187396@warthog.procyon.org.uk>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 01:56:36PM +0100, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
> > Enable on-demand read mode by adding an optional parameter to the "bind"
> > command.
> > 
> > On-demand mode will be turned on when this parameter is "ondemand", i.e.
> > "bind ondemand". Otherwise cachefiles will work in the original mode.
> > 
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Thank you very much, David! Thanks for your so much time and patience!

Many thanks!
Gao Xiang
