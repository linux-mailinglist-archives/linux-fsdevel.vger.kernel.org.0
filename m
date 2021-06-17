Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019DA3AB4A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFQNZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFQNZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:25:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556DC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 06:23:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x19so2934857pln.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0R5SaCmtdxXW+kVcSRFxfZL2+klCdmspn6GDULEyeo=;
        b=rAeLu79YFXnsayB8zTCDHeFxc3xIk1EOpccvL2+USuNCGoIY9XxjO07UgSB1y4RNxV
         y/FJetJkQdAJjT9o5o5Me4mnI/l/VqoAe75XHaN773Vkv9S/mnHnnM1jlKNh1ZMTs/sY
         Vski03bBCj/i3b/ThisF71R+lYUFcjy0YGXhl3VzVFhj5Qb9HZAhYTyhUvE3ufXcdEoF
         R9mEQktHVyEJgjg0rLLyYateJOHIG7St7ELgQ1WHx6ulG9N/JzsxIOLEm8HssFgiF1Vl
         sODOoVCpPnrhEUTZgLEDXW6hM9BfxpUC6H+qgD8jHDHLToc9511Zal4c+XHcrOcNqqtA
         pSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0R5SaCmtdxXW+kVcSRFxfZL2+klCdmspn6GDULEyeo=;
        b=WZM9Y3bzBuYYurMt2qcn/zzgE/ur7PsEfTkpHQuepHxKfcCZkPm8pEQskpW7627RXV
         WMXqK8ucHN/uZYFo2Sa/ThP74VZmJG3vSMcs/1WGS6prOUx0txMYBbOMxE1kIscmODDV
         XpkhCCf3Kz7OZINxPsLlcpiV6sXrL5OKDpabvy4on58FnhuEhONetiBJ/HLY00ZfllSs
         harD6B2KqpcKZKl3w/S+7lvhFSOY5FLo+XHAcwHx/hRJKOV6uD+bcrAuscUfIWsq3twN
         zbXeZgZDskleas/oF3iP37T7kMq+LbYXHVbAyo/kSWySCIfYciu5FTJ0wKHkwQjv5KH2
         nK4g==
X-Gm-Message-State: AOAM532XyzvHjSioALziZhRI9evBYduCyR0fenCh39gfiTVp2WWDwGXn
        +QYSeN41/KOWRnlFpPXqv+FkDHVDbVpHLjjZqACn83iMezo=
X-Google-Smtp-Source: ABdhPJxpOrQXu6ehlr/TJbYbKoOeFbIA+t5QXbSfRUuZkUeGN0CGuL9X+rIeFzhlyAuquwYo8+7qVJmpnl/KQ9qHkLo=
X-Received: by 2002:a17:902:e8cb:b029:112:6ce1:780 with SMTP id
 v11-20020a170902e8cbb02901126ce10780mr113727plg.38.1623936214065; Thu, 17 Jun
 2021 06:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com> <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net> <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
 <295cfc39-a820-3167-1096-d8758074452d@metux.net> <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
 <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net> <CA+a=Yy4iyMNK=8KxZ2PvB+zs8fbYNchEOyjcreWx4NEYopbtAg@mail.gmail.com>
 <6d58bd0f-668a-983a-bf7c-13110c02dae0@metux.net>
In-Reply-To: <6d58bd0f-668a-983a-bf7c-13110c02dae0@metux.net>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Thu, 17 Jun 2021 21:23:22 +0800
Message-ID: <CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:12 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 16.06.21 12:20, Peng Tao wrote:
> >> So, just open() a file on a fuse fs can't restore the fd directly
> >> (instead of opening a new file) ? If that's the case, that would mean,
> >> userland has to take very special actions in order to get it. Right ?
> > Yes.
>
> Then, it's not at all what I'm looking for :(
>
> > Oh, nop, that is not how the current RFC works. I see two gaps:
> > 1. /dev/fuse is not accessible to all processes by default
>
> it shouldn't necessary at all - in my use case.
>
> > 2. open() syscall doesn't take enough arguments to tell the kernel
> > which file's fd it wants.
>
> open() only works on a path name - that's exactly what I need.
>
> Could you please tell more what your use case is actually about ?
> Still struggling what you're actually going to achieve.
>
> Just keeping fd's open while a server restarts ?
> If that's what you want, I see much wider use far outside of fuse,
> and that might call for some more generic approach - something like
> Plan9's /srv filesystem.
>
1. keeping FDs across userspace restart
2. help save FD in the FUSE fd passthrough use case as implemented by
Alessio Balsini

> > It seems that a proper solution to your use case is to:
> > 1. extend the open() syscall to take a flag like FOPEN_FUSE_OPEN_FD (I
> > agree it's a bad name;)
>
> But that would still require changes in my userland. Something I do not
> want per definition - it should work transparently. The application just
> knows some file name (it might be even expecting common device names,
> but put inside its own mount ns), nothing more, and no need to change
> the application itself.
>
> > 2. FUSE kernel passes such a flag to fuse daemon
> > 3. FUSE userspace daemon opens the file in the underlying file system,
> > store it to a kernel FD store, then return its IDR in the reply to
> > FUSE_OPEN API
> > 4. FUSE kernel looks up underlying FD with the IDR, install it in the
> > calling process FD table, and return the new FD to the application
>
> Does FUSE actually manipulate the process' fd table directly, while
> in the open() callback ?

hmm, you are right. The open() callback cannot install FD from there.
So in order for your use case to work, the VFS layer needs to be
changed to transparently replace an empty file struct with another
file struct that is prepared by the file system somewhere else. It is
really beyond the current RFC patch's scope IMHO.

Cheers,
Tao


Cheers,
Tao
--
Into Sth. Rich & Strange
