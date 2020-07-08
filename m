Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2D2181AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGHHrx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 8 Jul 2020 03:47:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHHrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:47:53 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MCKO2-1k2OCC2vkg-009Tzk; Wed, 08 Jul 2020 09:47:50 +0200
Received: by mail-qt1-f172.google.com with SMTP id e12so33761106qtr.9;
        Wed, 08 Jul 2020 00:47:49 -0700 (PDT)
X-Gm-Message-State: AOAM532QhPf3S6YmnJkCrqd7T4mtSEWxZpWEFGxDS/7NJFyNC+4nNHmT
        NlTdO8TrSG9eqELI16Ui1AN1+/ml99mcq0WaQJo=
X-Google-Smtp-Source: ABdhPJwJ7bU/Pv3kW4ZV6dqofAWrDLTCi8XHvPobkRXOzurHnagr3TngzbBTEHTIVieA5Q2mcy/tSnvloWa3hIIuPE8=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr58818246qtq.304.1594194469018;
 Wed, 08 Jul 2020 00:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-10-mic@digikod.net>
 <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com> <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
In-Reply-To: <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 09:47:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
Message-ID: <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Icrsh0mC3bAQKFyB4VE2qo4aKKy+ZA1A9ib/ejxxFIqzH1RAOKn
 penst3TphTVidMyURXogrAolNNxvYg3ueob3GXJ57i+dcPzud3M6FOaVE/1z5cVpjZqMHTU
 HMLO5w64LNa6l1OCdf5lbDNfMiPCYRQaHbuB46l5be2Kkg7WxGcLfbDDi5Y00gMTEoGvGo7
 1ZtPSL9WM44wPVMp6xovg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPluZrwySps=:GUXjDTVVVga3OTdEi2pLLE
 /dCG1/4aSyDQxIoiIcpsHhi9hIrJDPlEKRT8Z7nJeB3mhYqleJixw9qSffZ29S9kx2H7q7KPh
 MtiizC8lmjEZLUCZF4gJLmhogyeNt5HRxc5eYHydk6XYG6IPUKsTXSCVZKZzNkCjb+Q0Gwyeh
 OWBPZ5mT3lv9WKZpQmfd3daDuYl4CVUhD8bswWDMeFUkaehf86+vQi2daoLEl7SetO9fFGNwV
 F8sO3eq7a0P+0IVhSesXNCZCI1gUespgxKIzcwmPZCyaPvSpNWT/ePRmrfmdHvXzgeCqBsKVB
 wvLs0Z1czNW2d/YX4qZouATcfHGUc4bcGxEboQoDSdbXC75dDhVw4pfqKJCyjYWZ3k+4Us36u
 wCfpAXVdEsIgafm0vUWwJ2XLwfvsCk9VwHn8ElBnjYb7QJGAUEua0pM8ti3xAao2PXAEJI0FI
 Rh+jtOg7CdK1Rmxa2BTf8vOR7ZUO0frI0lpqmH/LNdToiwg5qOd8X+DCAUmD4mwNbVDuhBVGP
 STdGGIAR7L/ZJ5U8nR/kMj/3xxDWtSBlX8XbGSolKCDz8h7lv84+ahSjks4vBpo1VRxVWZ5pm
 aBATcxNKBl6FIga/hDFJO9u2D/i8MSjbTnSsRHrW8Eiy3Wyl1aONYLnK8w1WnK6AXNp+cxP50
 t8yvr4d2NC0g7vWxbGQABJLyq1FW4bekvAdBTciq1c1Q4Au7GK88fF+SYTH2EqnZumrQyQhCh
 0puZ2PnYNJ3qyi5M3JxrOK/whkL96HYmwG8xatanXAnFkXM5iMtTpDO2fEjmoD9gDxUNwgSwD
 VAfhLgJwI7BWJ+YO/r4mCsp1WkuaC9f124ursXBh5zP+ANEdME6fnbHL6rwcu4/VhwVvUXGWV
 /3heJDV5oZmCIcgGp6d/eJEUKY4wnOG1k9HjV2sXpTDUHT8BZAkyTG9vWz/mDTJjtIjUGEarh
 TN0dpp7vWHvulUrm7u2nd07TwdnRIysmRNjZQLFX9yBnTz0jI3x9e
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 8, 2020 at 9:31 AM Mickaël Salaün <mic@digikod.net> wrote:
> On 08/07/2020 09:22, Arnd Bergmann wrote:
> > On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> >> index f4a01305d9a6..a63a411a74d5 100644
> >> --- a/include/uapi/asm-generic/unistd.h
> >> +++ b/include/uapi/asm-generic/unistd.h
>
> OK, I'll rebase the next series on linux-next.

Just change the number to the next free one, without actually rebasing.
It's always a bit messy to have multiple syscalls added, but I think that
causes the least confusion.

> Do you know if there is other syscalls on their way to linux-next?

None that I'm aware of.

> Are the other parts of arch/syscall OK for you?

The arch/* and include/uapi/asm-generic changes look ok to me.
I'll reply to the syscall implementation separately/

     Arnd
