Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C901A7F14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbgDNOBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 10:01:20 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbgDNOBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:01:15 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MbRXj-1iqxJQ0zN3-00bsIH; Tue, 14 Apr 2020 16:01:13 +0200
Received: by mail-qt1-f169.google.com with SMTP id c16so4381681qtv.1;
        Tue, 14 Apr 2020 07:01:12 -0700 (PDT)
X-Gm-Message-State: AGi0Pub8VFe2W+VnzrN30YSstRYzJJ+7jMaZrqvRlBc9Z3oRJH4a1njH
        lWE6uozpmFAob3OVRZ6f2XTOvreGi/7xKi8djnc=
X-Google-Smtp-Source: APiQypJnCxnYmw722mKV+S9ulqw05gvvCTLTPiReXurJiDepLa1M4UQL7fvv7Hr4QeMwCm32MRni4rllUWyjgXsOVOQ=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr15912388qtb.142.1586872871915;
 Tue, 14 Apr 2020 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-4-hch@lst.de>
In-Reply-To: <20200414070142.288696-4-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Apr 2020 16:00:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2iHD4tzaNunA2FFpxpQg9DFCKROnrtUR7=1scO76+oCw@mail.gmail.com>
Message-ID: <CAK8P3a2iHD4tzaNunA2FFpxpQg9DFCKROnrtUR7=1scO76+oCw@mail.gmail.com>
Subject: Re: [PATCH 3/8] signal: replace __copy_siginfo_to_user32 with to_compat_siginfo
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ukxhwA5NdxBemLbDSsRcAhObRe1CWAeAW5tNRCWtLREQYVmahJA
 5dQJGh5A9FGzCiCtH0lK2w1LTUaiBYNq+KRfQNzuBZynd1ydil7uVEpMcGhaJtOnrxuPlNT
 1zkhd9ZqLQ6gf0jdqvW7baDPJTBh2RWXbabwVkzGsBOniz/vgITwUZcDH/mA96Q7gubEdtD
 q+uVbqmI/a9MkwfKYXn0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G8s8f7/LAVs=:dMF36GmlK9xwLQ4VUvXmSf
 aEwBLKeNCK0/7rpqQtXnEK9U1lHn57P/gMUHzqRTjxGJyc7hkKHbWUfSOTg9H9h7mSMSSXb8P
 0hht68vF+80E6P+mgvG0BQXnL3NEGl88tw0T0pdLZkYES48AEJoiWx/YKcJBxD6ph6BZq9Inj
 UBH3w9tp/FCL9J6/itE5dN67Fk0aVr0oYc0r5vdcCOpoVk06Wwcnvti6t4CJ/OEeU+Z4A3PzI
 hTW2XxhymmWA/ozfuXXriynzZ+bUD/mm02S3l0hPjECKPpmlxASIBtnF/FBO2saOYqj2pkI51
 Qq6PgSqNi3eJPnbL7FUHsl6v6GOORoxv2uZ2RAAiTCUrroRKneaH0EBZaQ+mMAsmftgSQYx54
 rzMsOOZzbH578VuuB45zP5F526O0GsQxcMjWmqlffk94FUc6wXWy8mew7GQ68+ILxa+E7FqZa
 P2D0tcp3BNF/FtfkroYdhw5vHz+CdABUnSC59VXyl4mlvbfscHf1JLY1olzt86xiLsNZkr+dD
 bOplD5YiY+xgDi501oJOQ979cV8pn2kZFHV/kcws3Mio6otsaLWJNzP+9GEJFS3la8JFJW/8X
 aNrql/tgp8cx3o4yhJvt9gHfw1Dfdyss8pk1QpszaYvUhhASUWjpqd7qN91DNJ9x4joReHdeY
 EJBnV8nadLzQz8q/rBRGW3n1dpGkgohxsGA1L2jX7RHb+H4AfTPc4zUuIwgz1jmhZEhdLVNBq
 N0Gj8Rsc9Z+XpEpOzyjq272Z3ShnMUAMBkQUCmmrNrysVpEVdfl9M7tAA2MIvA2/m7ZbGV3a3
 qrKkRlAeaBtsVMX3z7giUZi9TZWgeDfkQGv4CkBsNH0dyqH2XU=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Move copying the siginfo to userspace into the callers, so that the
> compat_siginfo conversion can be reused by the ELF coredump code without
> set_fs magic.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks all good to me, but I noticed that the naming is now a bit
inconsistent. to_compat_siginfo() is basically the reverse of
post_copy_siginfo_from_user32(), but the names are very different.

I suppose this can always be cleaned up later though, as your
naming choice is more consistent with how things are in the
rest of the kernel these days.

    Arnd
