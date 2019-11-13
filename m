Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438A7FB60C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfKMRPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 12:15:06 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:33597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKMRPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:15:05 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MyseA-1hjHMA0hXe-00vzYu; Wed, 13 Nov 2019 18:15:04 +0100
Received: by mail-qk1-f169.google.com with SMTP id e2so2411410qkn.5;
        Wed, 13 Nov 2019 09:15:03 -0800 (PST)
X-Gm-Message-State: APjAAAXKVy017RrIDIj/T9Cp2Z09rm3VxMfxubOmJZGvmChO70AGR+cN
        V4uttaecy6HUKAcyyG4fD/7KH301IOqRyb1+vCk=
X-Google-Smtp-Source: APXvYqz1JUTrVDSvEkfqKwKQgdeuW6/m5+FVOgvJajj/ddv35xMMVOqxU60/ompuBnycva6tHeYnh6xzMmf/psugaVM=
X-Received: by 2002:a37:44d:: with SMTP id 74mr3397745qke.3.1573665302944;
 Wed, 13 Nov 2019 09:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20191112120910.1977003-1-arnd@arndb.de> <20191112120910.1977003-2-arnd@arndb.de>
 <20191112141600.GB10922@lst.de> <20191113050628.GS6219@magnolia>
 <CAK8P3a3c3kCXAPU-sJQvAvDQdAwVnQRiterdmqXufWkFdSSZ+g@mail.gmail.com> <20191113163401.GW6219@magnolia>
In-Reply-To: <20191113163401.GW6219@magnolia>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 18:14:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QU2fva7p=EaLJytMXyZeqc5W2m8565b06F3L+Ka_vKw@mail.gmail.com>
Message-ID: <CAK8P3a3QU2fva7p=EaLJytMXyZeqc5W2m8565b06F3L+Ka_vKw@mail.gmail.com>
Subject: Re: [RFC 1/5] xfs: [variant A] avoid time_t in user api
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D6hZ3KWgpl5ovykCl5u9MwUhvl/PgbQURHG/IPAqd2Jkknmdt5n
 bpcYr8WcrTzWmSOxyDjWmUYylnOu3t6/4N+8fTTzvPf3oq5yArFSFOjq92OvlMObHfYOJil
 tkvgbRNAnDvLMXq1c9RL+iklMxq09/tmz0B3TYf9Y1G2IwMsWNB6KbbvgQoeqySz3FckKW9
 SVBjlcl7yyKqCaMEtp+kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dzKqjGXOYzU=:OPHbrAdvlt0Mk2wnMClPDk
 HrZeg5zXCJuoyvBC4zo9W3lJtPncs30Jl/ESwnoRCEwt4tVeaf4YEnmi8ZzAQTclRDWlYGycq
 LmHbII4W+EWyOBX+xfZmUAF2e1Js3pNt00ycRL0m/iFc5uYyX2t5SCSXHEvEhRJjVVNY7wtEL
 kGGElOrYGWZifTNYtqPN/kEVI+5VEU2mV6Xlkt3+rUmkJOmPIhzET01DFKCHEdlKZuiczwugk
 HJ3b9ezXgvmJLvSd7OSnI8/k+EIy3eYJRJ84K5vCnUUolJECzPuip166fHIyirL1vwa6qCF/3
 tA2oXop+oqZxjrj8vPuPSX1xLPzrucfResr6zos4ftPCMykQ+00zXmpcDSh7e7br9ureJALAB
 5/Eu+BLl3/2Uo94bX2AKpgDMj7ohyvWFZgrJinWxZBJ0ukLlJPzOGr5gwobp+3oWc+pDhdkKD
 +9c6fJpSzax12x0Xw5fQ5Zzfjqx8NKPkL26ijR5faU9hM4opRi6l3nLZNymZ5hrtVq332XvGc
 +B/N9UsyQLlRolmUaWrszbT2Ljzy+yjVvoCmol4d/qiJ1AUgid1Uo4Tps7VnazBh/n1YTBamC
 j7Bwxmdw/i494kcY++rV6wMAkFU6Tn1B/3GExMztCuSiMi/cU64tI+IQgsCAuN9HjEE/oiqsk
 Ol7SAlig2SWFk2wq05K2b9zbGBd3LTo8EW3yorLcsA5gFvVubxqswJiqhIzob3YkNDfIwARjt
 Ri7yptpKb9QglDAKvTSWjxH1Xyl/5mTaPPQB9kXxHhRzWmSx+Nd6NPizU1UheBpLMsmsBBiXo
 MTlgVcDKI8M32ckXTfpycoDZG+kG4e23okSk7XdV3PSr0gk7LGOtStUUgTgV+Qiv9AnvNPTGI
 te3BpM07wY3Q1+/un7Ag==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 5:34 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Nov 13, 2019 at 02:42:24PM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 13, 2019 at 6:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > On Tue, Nov 12, 2019 at 03:16:00PM +0100, Christoph Hellwig wrote:
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index d50135760622..87318486c96e 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -830,6 +830,23 @@ xfs_fsinumbers_fmt(
> >         return xfs_ibulk_advance(breq, sizeof(struct xfs_inogrp));
> >  }
> >
> > +/* disallow y2038-unsafe ioctls with CONFIG_COMPAT_32BIT_TIME=n */
> > +static bool xfs_have_compat_bstat_time32(unsigned int cmd)
> > +{
>
> Wouldn't we want a test here like:
>
>         if (!xfs_sb_version_hasbigtimestamps(&mp->m_sb))
>                 return true;
>
> Since date overflow isn't a problem for existing xfs with 32-bit
> timestamps, right?

I'd say probably not.

This would be for a kernel that intentionally only supports y2038-safe
user space to ensure that we don't get any surprises later. In that
configuration, I think we're still better off not allowing broken ioctls
regardless of whether the file system is also broken. ;-)

> > +       if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
>
> Heh, I didn't know that existed.

It barely does. At the moment it is always enabled on all architectures
except for 32-bit riscv, but I submitted a patch to make it user selectable
last week.

      Arnd
