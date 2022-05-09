Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FDA51F301
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 05:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiEIDfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 23:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiEIDdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 23:33:39 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA2A204E
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 20:29:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCcZKZu_1652066971;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCcZKZu_1652066971)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 11:29:33 +0800
Date:   Mon, 9 May 2022 11:29:29 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] erofs: change to use asyncronous io
 for fscache readpage/readahead
Message-ID: <YniKmToYBm5Nmbk6@B-P7TQMD6M-0146.local>
Mail-Followup-To: Xin Yin <yinxin.x@bytedance.com>,
        JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <20220507083154.18226-1-yinxin.x@bytedance.com>
 <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
 <CAK896s68f5Snrip8TYPfDbObOpNoTtWW+0WBXzTiJbadAShGrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK896s68f5Snrip8TYPfDbObOpNoTtWW+0WBXzTiJbadAShGrg@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 11:05:47AM +0800, Xin Yin wrote:
> On Sat, May 7, 2022 at 9:08 PM JeffleXu <jefflexu@linux.alibaba.com> wrote:
> >
> >
> >
> > On 5/7/22 4:31 PM, Xin Yin wrote:
> > > Use asyncronous io to read data from fscache may greatly improve IO
> > > bandwidth for sequential buffer read scenario.
> > >
> > > Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> > > and read data from fscache asyncronously. Make .readpage()/.readahead()
> > > to use this new helper.
> > >
> > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > > ---
> >
> > s/asyncronous/asynchronous/
> > s/asyncronously/asynchronously/
> >
> Thanks for pointing this out , I will fix it.
> 
> > BTW, "convert to asynchronous readahead" may be more concise?
> >
> You mean the title of this patch?  But, actually we also change to use
> this asynchronous io helper for .readpage() now , so I think we need
> to point this in the title. right ?

No worries, I pushed this for 0day ci yesterday, Jeffle may send out
another v11 with this patch included if needed.

Thanks,
Gao Xiang

> 
> Thanks,
> Xin Yin
> > Apart from that, LGTM
> >
> > Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >
> >
> > --
> > Thanks,
> > Jeffle
