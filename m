Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9659211223
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbgGARmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbgGARmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:42:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4ADC08C5C1;
        Wed,  1 Jul 2020 10:42:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so28253777ljh.7;
        Wed, 01 Jul 2020 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKzsF8Jbjc+SMMY4SAymQB2Q+fuQEz+Ym10cAxHzc3A=;
        b=aPNsR72toRiBFPx4Y7En8MH9MybkqXLIkS7Ra3U/lOFOJ5pwqNLmUvyF+myjzpKJGC
         HDyVEXBzOfiH4Oo9rdqG0w2SQK0QGq0cfHxdZG8DfhPbfHhcrNONfP6RBJSXucJoE72u
         oyN4XhxXUPAHj4EFwS9An+zKPT3ODVI827KY9SNiL7cMNRGcVtu1LfpRDu68cMGEgMFC
         0aR+ypottIk697EE5AUUQF/rpVpOGtVC2ztdlPhEVw4ZN64NHBQ5kXb3uIQ0AYekGydp
         KtTRi5RZnP0SctqXC7OBdeFo4j/FGu+2A5aLX6d5gxYb6uzh0z4myZo8muFHHn35pr3X
         0i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKzsF8Jbjc+SMMY4SAymQB2Q+fuQEz+Ym10cAxHzc3A=;
        b=ZWPbEIv6a96eXJQiKGM3uZYE+dd1kK+zszD3e7y2ih4q48wa8pqDh/g0ETggslNh/O
         wp9+K1Jk7sGagy9bFFafPhLWFBbAw3ZIEkPfteZINqBtlzcPL+To4QZGJHGsAZ1ROle7
         njUXl4+LarVQtQf/SY2B6/YfexSitIziC1wpOWaK3zt3/oTEcMyCiYcCeVIKAbQ/CZLK
         bvKCLx1qXq97eV15qXBcZ84cNMd5eULg+gCl9oKOeJow0saBEcaMCaILkc4pir/hOJ5t
         YsKDgSU1qcwehfbd48oiIlVoD2uNCtbPx5VMuoXOAeAvfmmg5VsbycuRze6Hn+CqLTT0
         pfHQ==
X-Gm-Message-State: AOAM531xRxHXDgD7smc5f3ynNPjEn+Al/CmCHfKHXU2HxM1cIvT5kI8c
        RiMa6aQoUbW12qfMdQmv+3+8urW4eQZdL3lFtJgb1w==
X-Google-Smtp-Source: ABdhPJyXRzNnTdesBom2FaQtrvZWwBzsI48Pk5wl4PenJp2xToRK6/rgac8XVZ9ce9rOa1OIXlwCA5lclwX2g+aRd20=
X-Received: by 2002:a2e:9bc3:: with SMTP id w3mr5780315ljj.121.1593625367751;
 Wed, 01 Jul 2020 10:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200625095725.GA3303921@kroah.com> <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com> <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org> <87imf963s6.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com> <87ftabw3v5.fsf@x220.int.ebiederm.org>
In-Reply-To: <87ftabw3v5.fsf@x220.int.ebiederm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 10:42:36 -0700
Message-ID: <CAADnVQKwa_QGdPOrVL2Cmn3xXy5fpmpBAW3GU-zJkGUMirgHfA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] umh: Separate the user mode driver and the user
 mode helper support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 1, 2020 at 10:23 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Mon, Jun 29, 2020 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> This makes it clear which code is part of the core user mode
> >> helper support and which code is needed to implement user mode
> >> drivers.
> >>
> >>  kernel/umd.c             | 146 +++++++++++++++++++++++++++++++++++++++
> >>  kernel/umh.c             | 139 -------------------------------------
> >
> > I certainly don't object to the split, but I hate the name.
> >
> > We have uml, umd and umh for user mode {linux, drivers, helper}
> > respectively.And honestly, I don't see the point in using an obscure
> > and unreadable TLA for something like this.
> >
> > I really don't think it would hurt to write out even the full name
> > with "usermode_driver.c" or something like that, would it?
> >
> > Then "umd" could be continued to be used as a prefix for the helper
> > functions, by all means, but if we startv renaming files, can we do it
> > properly?
>
> I will take care of it.  I have to respin the patchset for a silly bug anyways.

I guess with the header name too: umd.h -> usermode_driver.h ?
