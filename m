Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3C7AEFF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjIZPtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjIZPtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:49:14 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060F11F
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 08:49:08 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4527d7f7305so3781973137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695743347; x=1696348147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhrtpkzPWw4xItCFAhuSJUb5BIxZ6GHF9KiEeAtrJvw=;
        b=MEpzazpYIpGyQxXISESh78OzrBk9fpjwC/Jb0HhkV3Yck3BE769mKxA+Xm1Q3ritaJ
         PVlVZVdnu4o+HetrCeFjRKdqC61OtIlc0HPBNiEaX3UgTXdc588OdSFGMq/hnan//2ii
         aDjv+QEORheeWzcW34vPwSvHL2h+5x/T1UQIA/u/f02poW9VpqJKfZMrg5IsxfUT2USc
         goST2n8T8154Xrc12DEGgs2IWIAnfXFB0qJrte5nZQxU0wNbRkmWwVce72kiqjQACnns
         gqshZ5bEaqQn2502dYsceyFyJUWxR0EH7bl8Lj7bSX9Rud3WzXqOU/iBBFS5Wj/B0Du2
         WPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695743347; x=1696348147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhrtpkzPWw4xItCFAhuSJUb5BIxZ6GHF9KiEeAtrJvw=;
        b=iwwOd82VmebLxkBFghoj+NIscFa0UBkZ0lDNzw9nZd8cDhwrSFqp8BY/XX07nfZhO1
         fJEQ5A2qr3ZavCJdVbz2IXnGQ4tesSJYOJtk0SmUCiY/v/2xVy9zAyDz5vrRQRWmXpvA
         9+hm9QWQZtY/pBUMrlGoPKSe0kW7WIKLt0u84OQfECl0G7RMgSlfz2D228uAccrrp8s5
         s7GBbXxshepq0ufsNMueMO4Zl1uhRPW1/5rsCmB+94FWrijs77wiTjS7/9B9pLY9t1Kf
         C4Mxau1DXq9cRJhCPTXEQKYTmFC0DjBum8Dg1Jm+tUKqLaOlLzftsl9BWg5ZOzzZbyPe
         wXnQ==
X-Gm-Message-State: AOJu0YzbH2LIuwbDYkfwmhpFbVa2CW/k2N4iyRzDx+ux+zS83T/HAKGx
        E3wB7qEdpibHItghEWd9ft+J+EUzbzQLToCTK/w=
X-Google-Smtp-Source: AGHT+IHvwbzpKQJvN5Ttcyitq0YJO+fSiJwCJmUNktAbJX7wt9Cdcxl0xcLgehNf/9C0Ufhhx02jak3zB0OgD2sTNDQ=
X-Received: by 2002:a67:fe86:0:b0:452:7232:5c22 with SMTP id
 b6-20020a67fe86000000b0045272325c22mr6914575vsr.18.1695743347101; Tue, 26 Sep
 2023 08:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-9-amir73il@gmail.com>
 <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
 <CAOQ4uxh5EFz-50vBLnfd0_+4uzg6v7Vd_6Wg4yE7uYn3+i3uoQ@mail.gmail.com> <1dea57e7-87d0-4ed7-9142-3a46dab73805@kernel.dk>
In-Reply-To: <1dea57e7-87d0-4ed7-9142-3a46dab73805@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Sep 2023 18:48:56 +0300
Message-ID: <CAOQ4uxgdUjr7JLDViyf_c3is69KCuTg46WS+pkJXxgqCH5_=Bg@mail.gmail.com>
Subject: Re: [External] [PATCH v13 08/10] fuse: update inode size/mtime after
 passthrough write
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 6:31=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/25/23 4:43 AM, Amir Goldstein wrote:
> > Jens,
> >
> > Are there any IOCB flags that overlayfs (or backing_aio) need
> > to set or clear, besides IOCB_DIO_CALLER_COMP, that
> > would prevent calling completion from interrupt context?
>
> There are a few flags that may get set (like WAITQ or ALLOC_CACHE), but
> I think that should all work ok as-is as the former is just state in
> that iocb and that is persistent (and only for the read path), and
> ALLOC_CACHE should just be propagated.
>
> > Or is the proper way to deal with this is to defer completion
> > to workqueue in the common backing_aio helpers that
> > I am re-factoring from overlayfs?
>
> No, deferring to a workqueue would defeat the purpose of the flag, which
> is telling you that the caller will ensure that the end_io callback will
> happen from task context and need not be deferred to a workqueue. I can
> take a peek at how to wire it up properly for overlayfs, have some
> travel coming up in a few days.
>

No worries, this is not urgent.
I queued a change to overlayfs to take a spin lock on completion
for the 6.7 merge window, so if I can get a ACK/NACK until then
It would be nice.

https://lore.kernel.org/linux-unionfs/20230912173653.3317828-2-amir73il@gma=
il.com/

> > IIUC, that could also help overlayfs support
> > IOCB_DIO_CALLER_COMP?
> >
> > Is my understanding correct?
>
> If you peek at fs.h and find the CALLER_COMP references, it'll tell you
> a bit about how it works. This is new with the 6.6-rc kernel, there's a
> series of patches from me that went in through the iomap tree that
> hooked that up. Those commits have an explanation as well.
>

Sorry, I think my question wasn't clear.
I wasn't asking specifically about CALLER_COMP.

Zhang Tianci commented in review (above) that I am not allowed
to take the inode spinlock in the ovl io completion context, because
it may be called from interrupt.

I wasn't sure if his statement was correct, so this is what I am
asking - whether overlayfs can set any IOCB flags that will force
the completion to be called from task context - this is kind of the
opposite of CALLER_COMP.

Let me know if I wasn't able to explain myself.
I am not that fluent in aio jargon.

Thanks,
Amir.
