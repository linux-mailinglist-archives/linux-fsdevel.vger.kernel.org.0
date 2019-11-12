Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95974F9449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 16:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKLPaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 10:30:06 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:38875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:30:06 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7RDn-1hpxPE0HRl-017qBy; Tue, 12 Nov 2019 16:30:05 +0100
Received: by mail-lj1-f179.google.com with SMTP id g3so18244427ljl.11;
        Tue, 12 Nov 2019 07:30:04 -0800 (PST)
X-Gm-Message-State: APjAAAVdsqIY1uT0WeXeuZYFISWR7xHi8/ogOUPvLcGZ2cOXbPGsTHV+
        CR7kNA/EKuaS0uwgcAqtYAhsjMxNZQlzbWmwUio=
X-Google-Smtp-Source: APXvYqxF3PFVRjx7d8z6JD1uyBoBGahddwSS0JsvdpugsENVg017FKwBGm4eRZiC3uggP8kYZCahBE3pDkbOr0/JkPk=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr20162193ljj.233.1573572604507;
 Tue, 12 Nov 2019 07:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20191112120910.1977003-1-arnd@arndb.de> <20191112120910.1977003-5-arnd@arndb.de>
 <20191112141657.GC10922@lst.de> <CAOQ4uxiGsydjS-hh4ANXz45n3x_LU_uXGtP1-paeT6cS-PWbCA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiGsydjS-hh4ANXz45n3x_LU_uXGtP1-paeT6cS-PWbCA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Nov 2019 16:29:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1n4nOKQLuK5J-0f4F-mjCuzY2LMQL1YO4=vqQuk2uVEg@mail.gmail.com>
Message-ID: <CAK8P3a1n4nOKQLuK5J-0f4F-mjCuzY2LMQL1YO4=vqQuk2uVEg@mail.gmail.com>
Subject: Re: [Y2038] [RFC 4/5] xfs: extend inode format for 40-bit timestamps
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Allison Collins <allison.henderson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:syIQtJhbRxjHyzJ7AFRq/aNlcT723WFLll4tjU/BNGLt9KzK5D1
 ncO1YtTfx5FGAODTgyrKQGJykVVjDjz6ut8vTKPUVP2tHWKOdofYuMZIV8G7kDfmdkgv3A3
 4BRuRVlMn7XPQPGBeWSMkL9dE7P0zQBKTtKsMMT8b/Jxvm6567No7pGcrTiq6lIBhp3+Sua
 A3dfaF5/Qsa7s3EWCVYbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FFLP4NPgxyY=:RUlG7eotG1R+a9GUMIZ3+y
 eefDhyo2zjpbsyCJS+ZFEA46AnDF3pIRKAlEE8ixQRRHfGks2mDs0qFYZ36Bz2fvN0G2AL1q0
 cbvv1nhX5fe99hMkOWiSgC/5c1bhFrWqJNlaun8NSuiJYhJgnDl/7YtaifqzijxlSrLKwsC8Z
 ctFH+0ASl/9huSzMAR1JSqduKQeyZ0VLoeJuI96ONHCpD+khXQM5Nq9tQM0wyup66/vQBdxkz
 DQlikOExalppo7cMHrhIXuDhkHYjGOExkKxPjraNs3ov+o37kFETjF5Cse981AkU+VIuQSXmh
 uW9122u7ypU+6dzUmvSBafOAZpa6XSMstLXiYiGefv0QMFyrdKJxVx/auBC6Rwgwq2iZL6qFf
 kFVUfIuzr2a5+g9rWAThgNCXR+VmRDEDVdP95MRpS5t1/G7l/VqNYZ8/0In0ZzY6XyQvpAqsZ
 wz7HPnw0U9zEsDcpPv2ldA86BSL0wdtxDN44POVvXv0PkddV4Rd4dOm1b2NgNNxMPz4T98231
 a6j6/xP25VPgBhlmP+b5Ym+KXQkH4wmlEiVqlvQa5Nfzgmq2vlGEfV7xDztmwNMVbzR4HfUf/
 QgMoI/ccr9gZ+2VF10p1VfzyTpYVWfTJPjyef+CEOwIUvQARQOpXhlEbSdmdGZ2VFlnRnQOi7
 RaZptTr7HS73zJgz+fhy0DLErkcw6pZEp9J/q5U+YcsB3hR2ZCxMS9Qa0XgdH43xSLAJB+p3t
 TFYbpjZYePdZ2B6NKKaxR24+ynOGd+5McygoWwIrElaaOhpp5+yqC983EuCBDQSrozJzMxXvu
 c8ZsGxF5+V34Urbin6TwwOLZw3c3rfrIvVySn58tKoSikZEk4nEu3d8ub9P4PZDqlqril8L5f
 ObPN0werWyRIvrei/Vhg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 4:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 4:16 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Amir just send another patch dealing with the time stamps.  I'd suggest
> > you chime into the discussion in that thread.
>
> That's right I just posted the ext4 style extend to 34bits yesterday [1],
> but I like your version so much better, so I will withdraw mine.

Thanks! I guess we probably want part of both in the end. I considered
adding wrappers for encoding and decoding the timestamp like yours
but in the end went with open-coding that part. The difference is pretty
minimal, should we leave it with the open-coded addition?

One part that I was missing (as described in my changelog) is any
versioning or feature flag, including the dynamically set sb->s_time_max
value. From looking at your patch, I guess this is something we want.

> Sorry I did not CC you nor Deepa nor y2038 list.
> I did not think you were going to actually deal with specific filesystems.

I was not going to, but in the process of cleaning up the remaining ioctls
I came to xfs last week and thought it would be silly to extend the uapi
but not the file system ;-)

> I'd also like to hear people's thoughts about migration process.
> Should the new feature be ro_compat as I defined it or incompat?
>
> If all agree that Arnd's format change is preferred, I can assist with
> xfsprogs patches, tests or whatnot.

Awesome, that would be great indeed!

      Arnd
