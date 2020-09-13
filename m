Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7B267E5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIMH0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 03:26:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:38885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgIMH0M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 03:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599981887;
        bh=99aKcspekjOIiE1dIohqbzZPMFeB5+r78KjmQ3fL2j4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=N8ep3FXJadQHM/k2+U+dv6FDZEK9jpfHx0ugUcpFHNBc70+BI2NeHIlD9PdIvN3tO
         jtqn1a2SRKAK0TlJIJi5ncvgsgNqouVetGdsqHRzoH3Bi7gVFrn4uOHEFHGh0LXI5d
         z87gAdRHAw8wiDHB+vI4icH/8MGhI7qZxzo9Z5UY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1kgDPe1ERh-011Bo0; Sun, 13
 Sep 2020 09:24:47 +0200
Date:   Sun, 13 Sep 2020 09:24:30 +0200
From:   John Wood <john.wood@gmx.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, Mel Gorman <mgorman@suse.de>
Cc:     John Wood <john.wood@gmx.com>, James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <20200913072430.GA2965@ubuntu>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <alpine.LRH.2.21.2009121002100.17638@namei.org>
 <202009120055.F6BF704620@keescook>
 <20200912093652.GA3041@ubuntu>
 <20200912144722.GE3117@suse.de>
 <CAFqZXNtwDpX+O69Jj3AmxMoiW7o6SE07SqDDFnGMObu8hLDQDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNtwDpX+O69Jj3AmxMoiW7o6SE07SqDDFnGMObu8hLDQDg@mail.gmail.com>
X-Provags-ID: V03:K1:HpjB457sek++T0MbqbEi/n5kjJ86x0yFV9KWAryC4ubpox1jgjg
 VhRcOhBqCFlvmiSB8zAdW7ExIiFFLQH2FyzB6cv6zQrzC5c7QJRatK3U46GjC5Sjh7ps9+j
 3YUuXvIPhqD7LGRVrrRXL9xIcAEooZ51xs33Q315qVFIbiVNKQrjhLG2wJxOjPGDoKR+h3Z
 X01Sj46DS1qZ3aghTigCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ahVl6Hk4D0=:4DkSuUaUp/GpmbbXx0a5fY
 Nr0OswsR92f5hbCXbkyeWRAFAmZLBiEiSSbulOUa2GF3+XCEreCZ4u4t1oivK9baWhy4IEvZi
 fnzkkIYpGitZz2r2IDT5oDSsMU/Vyss0biL6Z3jSLsbAc+M+78/4j1b2PA3YkwiqmfLKgbRaW
 kSNxffYrTVnuoiHSstN5uagXLbSHziBRgGtuQbnt6ikv6vebMplwKDGEuUVJyHD+lOMuM5UMm
 B/b17RmOpbwkPYn9wjeXrikit/kPEmWRoGMjZFd9IU40CJmpghgpjgryKtA1VZon6Giz3P0aB
 rNZbl8S+ZqSANSNa7z9KzAMbbkO5XG+yimbo5X0CO8lbqj65rAVxlx2+h0CItKCWQenDl6pCd
 7HGgM+YOggswf/f9X12fLXfW6CPeG69KCUfsLun+jyTFWFvAvvkKQNzpVR1y+oahcnW+Zmwfz
 QkuxtgrBmeLmLBHds5hqvQsngB1+8vv85z8R1Cwi5IrdaOotrVcs8IJY4Ukfc6T7qENVvss1q
 p3zWMZAlemjudQCn/DNi0aDkSEM+Cmayd08t3CFmoVJVAQ3nT0auLIiYxWwdUGY3pKwKUcE/W
 plWkRVA7rRLXg2+QBeyThhEuSt8a71+UmQw1azTZnv3SFw6YNnIx38uO+nZJQwNR3zkTZNWe6
 b74XVLlN7BdbJ07tFi3CvXPoLU0W7og9yI9Jew9Luy1cOO6GQqY4H+Qkm20kLI95vutP8x5GZ
 Go/niXT0BNrW170DiZPrhHF5ffDGGKw2dj34+0fbQ7kJpdTSjN5JFI+PbYcQLr7pPyYhi1Za6
 frkpdAHDdE3bRLRLtPFswdRCGSJyeulxQwCe5SuSAHWoyCbfaxQRua2Qq6HQj/KYE8S28J6tp
 w7z78KuIe/LTy6jDp58wr2FGgoxiJ70rUHDoq/imMMhAX1xupxqQFVGHQeBkQKeb3BjYJNEsF
 nnlt4Mq6a8JlUbwDew29H5BiwyJ0MRcCXfyvB1qi4R2ykQ+cGK45f0j3Z7NzkVZa21OmgoDC+
 WB+g+msN76x6A6foMsaU39G/EDVfi3Ud3bK76wkePjl8Vu/CeMfKGSFCHSKook0xWpXgitVmi
 IoZQ7QOOIBUp/rXxxD0+RrderfNAmwHCWlbxHYTy0l/W2BdB2gAk/+Wet+ziC3U3QSsg0FWwV
 QTxURgAgpzBKBYeMtlNKl8ksGiAX7trszmMmuIdDt69E7Zz1e4/dnRIryo+wDFlsOXQKlPmbW
 HMqxy/K4V7kHlJ0Kx0iTJgmBQ5idPnjP/s4YjRA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Sat, Sep 12, 2020 at 10:48:39PM +0200, Ondrej Mosnacek wrote:
> On Sat, Sep 12, 2020 at 4:51 PM Mel Gorman <mgorman@suse.de> wrote:
> > On Sat, Sep 12, 2020 at 11:36:52AM +0200, John Wood wrote:
> > > On Sat, Sep 12, 2020 at 12:56:18AM -0700, Kees Cook wrote:
> > > > On Sat, Sep 12, 2020 at 10:03:23AM +1000, James Morris wrote:
> > > > > On Thu, 10 Sep 2020, Kees Cook wrote:
> > > > >
> > > > > > [kees: re-sending this series on behalf of John Wood <john.woo=
d@gmx.com>
> > > > > >  also visible at https://github.com/johwood/linux fbfam]
> > > > > >
> > > > > > From: John Wood <john.wood@gmx.com>
> > > > >
> > > > > Why are you resending this? The author of the code needs to be a=
ble to
> > > > > send and receive emails directly as part of development and main=
tenance.
> > >
> > > I tried to send the full patch serie by myself but my email got bloc=
ked. After
> > > get support from my email provider it told to me that my account is =
young,
> > > and due to its spam policie I am not allow, for now, to send a big a=
mount
> > > of mails in a short period. They also informed me that soon I will b=
e able
> > > to send more mails. The quantity increase with the age of the accoun=
t.
> > >
> >
> > If you're using "git send-email" then specify --confirm=3Dalways and
> > either manually send a mail every few seconds or use an expect script
> > like
> >
> > #!/bin/bash
> > EXPECT_SCRIPT=3D
> > function cleanup() {
> >         if [ "$EXPECT_SCRIPT" !=3D "" ]; then
> >                 rm $EXPECT_SCRIPT
> >         fi
> > }
> > trap cleanup EXIT
> >
> > EXPECT_SCRIPT=3D`mktemp`
> > cat > $EXPECT_SCRIPT <<EOF
> > spawn sh ./SEND
> > expect {
> >         "Send this email"   { sleep 10; exp_send y\\r; exp_continue }
> > }
> > EOF
> >
> > expect -f $EXPECT_SCRIPT
> > exit $?
> >
> > This will work if your provider limits the rate mails are sent rather
> > than the total amount.

Yes, it seems to be what is happening.

> ...or you could keep it simple and just pass "--batch-size 1
> --relogin-delay 10" to git send-email ;)

Mel and Ondrej thanks a lot for the proposed solutions. I'm sure some of
your solutions will be used soon.

> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.

Regards,
John Wood

