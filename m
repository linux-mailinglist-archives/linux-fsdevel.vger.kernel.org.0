Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4D2C7484
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgK1Vta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbgK1S57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D107C02B8F0;
        Sat, 28 Nov 2020 01:04:49 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d8so5717552ioc.13;
        Sat, 28 Nov 2020 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AGnrWYiumdXafgcLifADEbB8pfQT5OzqYJQsv7KOwc=;
        b=FPnRfdiLLw5wVk7CiuBbqzz+/6V7lzE0yO93m1B1TvQv+87eNEOKe/6uLyG2jVq3Vw
         dOyr+feVK1LVbRL57sp1M2iS935WuT8X2BxrMMw8kPHJCqd2atbIeLTCxkBhatzLlvWb
         WgSyNcMeMKT4Z6gzHFxlN+Hk49WquySj+VaFsraciwXqAvFNZ8GLrNyeobOZb6SMrzbz
         aHtltylOiXxdPh5UBibVHJUI8cIZTTUdgsurww2MlQ40zU2NVlaFDsqFBfUPCiJDdOax
         bUqRUpiflFpTW11h0a3xk5D/Mg1QwCGrM3POS458wq0+2WOZhP1eR/7S0rjCTpdyF7G8
         dvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AGnrWYiumdXafgcLifADEbB8pfQT5OzqYJQsv7KOwc=;
        b=ltkUZGr2W1nzqWGlIJJGA1Jg0Wl0Kln3nac4WKJQZ5EacgsbzzbfGPXmv7xHOePKjc
         80MHc10kTki8xkBrkTsyRyi+PBUonbpouh6dNnpT/iMvT5dIpBIKK4Ks4mmUgT1y0P2A
         wfscCkX0alCjESBhARFmV/dQywxnNrTJDBzv6oujKZzTXlTdbrhh/UeRGR/lhweAg8/L
         xcAR2Q4vWLOItGXEvTOM/wpt1D9sh7BLBKsWyT1bZ5nIihb4FFo0Iqjbgw5WU1OuMuxy
         LbAWALeJymrGVP7jKRwLNGfAEw1A/rRAIJll38o6tzMoPc6BkCi9EHkM5DyshVGDIzKU
         f3tw==
X-Gm-Message-State: AOAM530rNtS+XIBFwWy25igNSi5mu+aPVc2WGWlqCJHRXLCpYfZNw4Bt
        t01k75aHg7QfGyaaoQfTEXbGtx9AaKICYmge0Qk=
X-Google-Smtp-Source: ABdhPJxEaU7n183i+2OtQoiTo9EP+n6e7u2ckH6pjcpA/PVT0nESydya52Qc10oxkXChJabkUbXMGwmXvJSPZsJjTQw=
X-Received: by 2002:a02:a60a:: with SMTP id c10mr11057629jam.123.1606554288643;
 Sat, 28 Nov 2020 01:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-3-sargun@sargun.me>
 <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
 <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal>
 <1338a059d03db0e85cf3f3234fd33434a45606c6.camel@redhat.com>
 <20201128044530.GA28230@ircssh-2.c.rugged-nimbus-611.internal>
 <CAOQ4uxjT6FF03Sq3qXuqDcqJQnzQq2dD_XVbuj_Fb9A2Ag585w@mail.gmail.com> <20201128085227.GB28230@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201128085227.GB28230@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 28 Nov 2020 11:04:37 +0200
Message-ID: <CAOQ4uxjKRL0Pime7BO9gr_sVfmdhV2XrPhSzOPdDoaCAcRYHBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] overlay: Document current outstanding shortcoming
 of volatile
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Jeff Layton <jlayton@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > What I suggested was a solution only for the volatile overlay issue
> > where data can vaporise without applications noticing:
> > "...the very minimum is to check for errseq since mount on the fsync
> >  and syncfs calls."
> >
> Yeah, I was confusing the checking that VFS does on our behalf and the checking
> that we can do ourselves in the sync callback. If we return an error prior to
> the vfs checking it short-circuits that entirely.
>
> > Do you get it? there is no pre-file state in the game, not for fsync and not
> > for syncfs.
> >
> > Any single error, no matter how temporary it is and what damage it may
> > or may not have caused to upper layer consistency, permanently
> > invalidates the reliability of the volatile overlay, resulting in:
> > Effective immediately: every fsync/syncfs returns EIO.
> > Going forward: maybe implement overlay shutdown, so every access
> > returns EIO.
> >
> > So now that I hopefully explained myself better, I'll ask again:
> > Am I wrong saying that it is very very simple to fix?
> > Would you mind making that fix at the bottom of the patch series, so it can
> > be easily applied to stable kernels?
> >
> > Thanks,
> > Amir.
>
> I think that this should be easy enough if the semantic is such that volatile
> overlayfs mounts will return EIO on syncfs on every syncfs call if the upperdir's
> super block has experienced errors since the initial mount. I imagine we do not
> want to make it such that if the upperdir has ever experienced errors, return
> EIO on syncfs.
>
> The one caveat that I see is that if the errseq wraps, we can silently begin
> swallowing errors again. Thus, on the first failed syncfs we should just
> store a flag indicating that the volatile fs is bad, and to continue to return
> EIO rather than go through the process of checking errseq_t, but that's easy
> enough to write.

I agree. I sent another reply to your question about testing.
The test I suggested generic/019, only tests that the first fsync
after writeback
error fails and that umount succeeds, so logic is good for volatile overlay.

Thanks,
Amir.
