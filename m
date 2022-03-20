Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB224E1BC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiCTNIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 09:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTNId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:08:33 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33090ABF4E
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 06:07:10 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id r6-20020a056820038600b0032487f52effso2328416ooj.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuWwjtC/TLFLxCiJJDaWj+mLL9c44Skevcyx/zZbu9Y=;
        b=As8Vvw/ET0LUiiZiGwQuo475SombauzyqpCYcN99Hv/74t6BOkssVRqthIpokceAqY
         3xh5l5U/fVOi0NgQj4W0iBSrt9XiqEivElsDupMHT6hc/h+2Bv9tPnvGci65veaBzuz6
         /VtstA5Vry9LM6k2mYbtQphmt5j9flrTw6U6ER/lkDxHzU7aMALSY5RASRLXEz5Ipc6t
         QM66meNEJi5G03i0ALUfW7Uc6daUTX2un2cAd9kTpe7SnEreNeRNDpAftKgLPCys/4gT
         I9sBM7HYYcngZPBXOzifYobNzGkNv2H4PO+DcBSGvAYo6lhyVhp7ZELIv0ocRuOiEyS5
         qMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuWwjtC/TLFLxCiJJDaWj+mLL9c44Skevcyx/zZbu9Y=;
        b=ZNAirWEw6fP1F1NvDSzqfJJm4CBdUYlfxAaS/h0rSqfHQHKPqSLQYgAByBT/mUVsVE
         ljww+RbtI+CEdrquphj2U4nvnpscWx3AZZKJYPFQTNBD9PL9efOPLNSU66au72hlXLPF
         eyTJrU9ALpIUQ4wCpTh1lkeitVfQVZ6ZWEValK+AoIxOnNWVbZZHJsg26AsaVoCIgtPD
         +4f0IjPIjm0LBBAMSycGPtT9+Hs1t3WxR0je9hyg/2D3r3HxKCDpwKdqHOsfPAxETATP
         Uy+XcPg6R8kWuax7e5OfE9HBy+R91u8VQ/0oAg6ATPCLisMu45JIxcQOg0HZMI59ym70
         E0Lw==
X-Gm-Message-State: AOAM532MiY4GhyJpzYaK0AOb7kxw7eHzCop4uK43/vFWXlOqiQ4HL/fw
        qSxRLo8h9oB6pRUKCAL4OXJGVqrkkubuQZ/sPB9byx88l3o=
X-Google-Smtp-Source: ABdhPJy5Ou91kue9dVlacYsd5SUjP/4NO/khC9jWT7Ee2yO9zKZ1HM/xMMIp60M+hDO43oJWiQRnvFlqa1Mq3bayfyM=
X-Received: by 2002:a05:6870:d20b:b0:da:b3f:2b2c with SMTP id
 g11-20020a056870d20b00b000da0b3f2b2cmr9957091oac.203.1647781629600; Sun, 20
 Mar 2022 06:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-4-amir73il@gmail.com>
 <20220317152741.mzd5u2larfhrs2cg@quack3.lan> <CAOQ4uxhgJumhenn_KT6YRPvRQPaOyNOTQa359xwCugVc8dtbqA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhgJumhenn_KT6YRPvRQPaOyNOTQa359xwCugVc8dtbqA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 20 Mar 2022 15:06:58 +0200
Message-ID: <CAOQ4uxg8dF4ZHwPo8KE+FidJe1EjzFq_L9PHeumTgzKr28JXjg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fsnotify: allow adding an inode mark without pinning inode
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > >  void fsnotify_put_mark(struct fsnotify_mark *mark)
> > > @@ -275,6 +317,9 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
> > >               free_conn = true;
> > >       } else {
> > >               __fsnotify_recalc_mask(conn);
> > > +             /* Unpin inode on last mark that wants inode refcount held */
> > > +             if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IREF)
> > > +                     objp = fsnotify_drop_iref(conn, &type);
> > >       }
> >
> > This is going to be interesting. What if the connector got detached from
> > the inode before fsnotify_put_mark() was called? Then iref_proxy would be
> > already 0 and we would barf? I think
> > fsnotify_detach_connector_from_object() needs to drop inode reference but
> > leave iref_proxy alone for this to work. fsnotify_drop_iref() would then
> > drop inode reference only if iref_proxy reaches 0 and conn->objp != NULL...
> >
>
> Good catch! but solution I think the is way simpler:
>
> +               /* Unpin inode on last mark that wants inode refcount held */
> +               if (conn->type == FSNOTIFY_OBJ_TYPE_INODE &&
> +                   mark->flags & FSNOTIFY_MARK_FLAG_HAS_IREF)
> +                       objp = fsnotify_drop_iref(conn, &type);
>
> (iref_proxy > 0) always infers a single i_count reference, so it makes
> fsnotify_detach_connector_from_object() sets iref_proxy = 0 and
> conn->type = FSNOTIFY_OBJ_TYPE_DETACHED, so we should be good here.
>

FWIW, I completely changed the proxy iref tracking in v2 (branch fan_evictable).
There is no iref_proxy, only FSNOTIFY_CONN_FLAG_HAS_IREF flag on the
connector which is aligned with elevated inode reference.

The "virtual iref_proxy" is recalculated in __fsnotify_recalc_mask()
which allows
for the "upgrade to pinned inode" logic, but iput() is only called on
detach of mark
or detach of object, if connector had FSNOTIFY_CONN_FLAG_HAS_IREF and
the  "virtual iref_proxy" dropped to 0.

Thanks,
Amir.
