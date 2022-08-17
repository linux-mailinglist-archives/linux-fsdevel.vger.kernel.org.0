Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78320596BF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiHQJQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHQJQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:16:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DB65240
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 02:16:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l10so12976471lje.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=3DB+dezKTs2JCAGBzguUfyZl/DLCkUWxqZtpuqdZ1Ig=;
        b=a+CMjTU1Hfs/YKqv3Jgo88bgN+frz1oiLfUtYEHtuULCQkGZ7vfDnPT7XzUMyrzGqn
         O4Z9CUBCo9yWVYI4Bjixu0GmQ0SwNcbP7CHwl4YHA6bgzY7utjpY7CgJS3Fud6sxLlzC
         2tYbAloUTDHRecOMyIhUbeF//jOaEaJCCSqnG6shzEC9yjs2hoTtRDwPZigwaqNv7crA
         hWLqJkM6ycpEJQJaDoutQMuxT8Af7evgvYUb5t1Fs+N/+Dk74PEZx67erSdm1ITaFeCK
         9RokDUCXKpMufKfdwcKw7huBb0APoeeUX3uYNaeNcwwsR+xpNvE3SHppVjbsDFe12pP6
         PDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=3DB+dezKTs2JCAGBzguUfyZl/DLCkUWxqZtpuqdZ1Ig=;
        b=fdWMr7YKhtOjN18qN7gmxv5tf65I1oEtAWcoXnGdZcaYwkOFN5ZdY2gmXABG2Dbygf
         ERzBf4iHnJF/JafLLDK9NkoNWf7qpoArORcrGObMMmB43O0OYIK40R/ANPRRUlGIg10J
         /NRvxQSdw//9E3Xd3UhYZqWtyJxq23cRx/l3ilQob/xCnWALPCPpsfW/jkZTKKYjt4Ns
         ly8bqaE5H7Tj7wxiK3mNQr587wT3oCbtotc064xjObTiJJYX56reSnn3t2YNlwoC4t6Y
         hZZZvH4Ja0uJaFwnvLJq9UGiZirDbTq6eDSPT/KsOzYd+FDBoOc2GT5AFLpCcCxM2TFW
         6NcA==
X-Gm-Message-State: ACgBeo0eFBH/+HX3wRm8i82RPCm1ZpVc6BHmvjslBXYj5Tm4WUpvilwo
        M0t+wZNBAKb8zFJ2SgHrNrNbAxLX89w1NmQ9M7qS2g==
X-Google-Smtp-Source: AA6agR69SoivTyNvZmZ8AtneNCxMvWh/r0/M/Zc73nYj7O/drQ8x3YGn6lycqk+TJCknMGEudSX4lwzY0NWVE2T30jk=
X-Received: by 2002:a05:651c:179c:b0:261:8fbe:b729 with SMTP id
 bn28-20020a05651c179c00b002618fbeb729mr3499949ljb.114.1660727796282; Wed, 17
 Aug 2022 02:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220817065200.11543-1-yinxin.x@bytedance.com> <YvyVOfzkITlvgtQ6@B-P7TQMD6M-0146.local>
In-Reply-To: <YvyVOfzkITlvgtQ6@B-P7TQMD6M-0146.local>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Wed, 17 Aug 2022 17:16:25 +0800
Message-ID: <CAK896s71E8a_iAYwEtzp7XKopQnVT5-YnkuC3yTewOfdmvf2VQ@mail.gmail.com>
Subject: Re: [External] Re: [Linux-cachefs] [PATCH] cachefiles: make on-demand
 request distribution fairer
To:     Xin Yin <yinxin.x@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, zhujia.zj@bytedance.com,
        linux-cachefs@redhat.com, Yongqing Li <liyongqing@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 3:14 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi Yin,
>
> On Wed, Aug 17, 2022 at 02:52:00PM +0800, Xin Yin wrote:
> > For now, enqueuing and dequeuing on-demand requests all start from
> > idx 0, this makes request distribution unfair. In the weighty
> > concurrent I/O scenario, the request stored in higher idx will starve.
> >
> > Searching requests cyclically in cachefiles_ondemand_daemon_read,
> > makes distribution fairer.
>
> Yeah, thanks for the catch.  The previous approach could cause somewhat
> unfairness and make some requests starving... But we don't need strict
> FIFO here.
>
> >
> > Reported-by: Yongqing Li <liyongqing@bytedance.com>
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/cachefiles/internal.h |  1 +
> >  fs/cachefiles/ondemand.c | 12 +++++++++---
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> > index 6cba2c6de2f9..2ad58c465208 100644
> > --- a/fs/cachefiles/internal.h
> > +++ b/fs/cachefiles/internal.h
> > @@ -111,6 +111,7 @@ struct cachefiles_cache {
> >       char                            *tag;           /* cache binding tag */
> >       refcount_t                      unbind_pincount;/* refcount to do daemon unbind */
> >       struct xarray                   reqs;           /* xarray of pending on-demand requests */
> > +     unsigned long                   req_id_next;
>
>         unsigned long                   ondemand_req_id_next; ?
Hi Xiang,

Thanks for the detailed review , whether "ondemand_req_id_next" is a
little long ? struct cachefiles_cache only holds on-demand requests ,
so I think "req_id_next" will not cause ambiguity. Does this make
sense?

Thanks,
Xin Yin
>
> Otherwise it looks good to me,
>
> Thanks,
> Gao Xiang
>
> >       struct xarray                   ondemand_ids;   /* xarray for ondemand_id allocation */
> >       u32                             ondemand_id_next;
> >  };
> > diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> > index 1fee702d5529..247961d65369 100644
> > --- a/fs/cachefiles/ondemand.c
> > +++ b/fs/cachefiles/ondemand.c
> > @@ -238,14 +238,19 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> >       unsigned long id = 0;
> >       size_t n;
> >       int ret = 0;
> > -     XA_STATE(xas, &cache->reqs, 0);
> > +     XA_STATE(xas, &cache->reqs, cache->req_id_next);
> >
> >       /*
> > -      * Search for a request that has not ever been processed, to prevent
> > -      * requests from being processed repeatedly.
> > +      * Cyclically search for a request that has not ever been processed,
> > +      * to prevent requests from being processed repeatedly, and make
> > +      * request distribution fair.
> >        */
> >       xa_lock(&cache->reqs);
> >       req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
> > +     if (!req && cache->req_id_next > 0) {
> > +             xas_set(&xas, 0);
> > +             req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
> > +     }
> >       if (!req) {
> >               xa_unlock(&cache->reqs);
> >               return 0;
> > @@ -260,6 +265,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
> >       }
> >
> >       xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
> > +     cache->req_id_next = xas.xa_index + 1;
> >       xa_unlock(&cache->reqs);
> >
> >       id = xas.xa_index;
> > --
> > 2.25.1
> >
> > --
> > Linux-cachefs mailing list
> > Linux-cachefs@redhat.com
> > https://listman.redhat.com/mailman/listinfo/linux-cachefs
