Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF711061E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 21:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfLCUrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 15:47:05 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfLCUrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:47:05 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M3lsh-1iby5d3Iv5-000sKw; Tue, 03 Dec 2019 21:47:03 +0100
Received: by mail-qk1-f174.google.com with SMTP id d124so4891472qke.6;
        Tue, 03 Dec 2019 12:47:02 -0800 (PST)
X-Gm-Message-State: APjAAAXXAJY26MQBYJk/CfYVmnFjW3E5gDKr01ljkfIEcOXXjuQhNRAR
        2mS2PNL7iIdn3oDQ7djN0ikm8wussPasfXIMhq0=
X-Google-Smtp-Source: APXvYqyCL1nx3H8yloTzwg1qIvaIaWi+0O78fCl00vzsL0T2m7PxololIGC/m3cyRi/77ySVOb4TUODjZNeQxdqki54=
X-Received: by 2002:a37:84a:: with SMTP id 71mr7167297qki.138.1575406021507;
 Tue, 03 Dec 2019 12:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20191201184814.GA7335@magnolia> <CAHk-=wi+0suvJAw8hxLkKJHgYwRy-0vg4-dw9_Co6nQHK-XF9Q@mail.gmail.com>
 <20191202235821.GF7335@magnolia>
In-Reply-To: <20191202235821.GF7335@magnolia>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Dec 2019 21:46:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2rrTN=ZED4pHX1WLCV+RUitN3G5XKSt5ZC20TUoB_TZA@mail.gmail.com>
Message-ID: <CAK8P3a2rrTN=ZED4pHX1WLCV+RUitN3G5XKSt5ZC20TUoB_TZA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.5
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IzqS+0q5AgCDjh/XU9VEFNWJmQ9QaNbxXgycHP+0Hy6dTqbYWSN
 664IrJVqPd9tG8iEujSsm1vaVUV5yy+nZKIZzWEFEi4MkAR5huJboYb8GnfjFAsabcvDmBR
 r818Rw4JUJZNwZDKzPDwp4Xz2Dy4v6lh/e2vMhciOo6kb/zo846CSBi/ToQkYdsLZKcXEYI
 EAaSKYNSF0zQZYi2noYCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gNLw0+BIRCI=:5jya/Vkje2O+w3lC2YrHmz
 gXa3/7Q8nRdBMorSAhsBtWh5P/dhDmHSZcHzYhusYWRn4FzhhDIG+FiGSKenXD9P9alS5VLWv
 8R+4JmYL47JJNPvrIYwzKIiqPkKHbmdg3uLufrFXChGTYHDg2uRSd3mzt1SDIYuBHR0wglkK7
 6Oi3r3YpkvronU62hrsKny7WCcP0N4r17azIosnmRP7Mbys8Yq6IMerReHCDKQFewo/lBmIVI
 Fjd+LSt3LKmIdRKRIdoBLXcOcnHzdY00NfOgiOOao15EsOhIbK5KUnJdcZAUmDLtTNKmEw8CL
 14N5Ut1XP4bzi96eAmft6RZ1K3Toa/peHMSnBohSmyWNHt5XQcsLy4oqCUzUTDNDfmHWMB26V
 kXr2Vwh7NT29Z/zpwXKsqmZ+PvFg5PL1bi6PqTUlCia5G2JUvBHwQ234/9a+MG+hlCR8kgglr
 fRC76TNQIWG5NPVka3IHW/WPJZCK2kY9ci9bMnBRZJ8cL5Ey1ZTbzNTurE7ybW23g2PVl3iO+
 2So2XCu5laXlwpQTBSCewYIrTiZTP9sN7kLzwYprU+/wOrCfgzSP5eIKgePvlrLFtXx7Lmwwh
 LVGgYyTLV0+kYyHCE0ULyUxDKnpO5UJHqbsNZpXXlgprtg9uF0XOALmw20JBh0YxydN3dyPYo
 XEzuZipJ+6j4osqaqTrl7bmEuiEYJGoee6Od1nlMiyXo/3nLTJhivflEbYeHHW8skyR6fVugD
 hBbYC/Jn2lF3/kB7isrJU+BQxiJy3WTO2zxGOBUMrAE6eSdnWeuJP8ezIuS9h+dJvdNoULQfM
 KLIO0vUGcd9izEKxEofuJSnnyUKbas5+4jDvQ9x4ruTmZmxqK27W5u/CVg8P+/yB4KJYDx8Af
 OiHS3lFgitMdAJGsI3zw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 3, 2019 at 12:59 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Mon, Dec 02, 2019 at 03:22:31PM -0800, Linus Torvalds wrote:
> Yeah, that looks correct to me.  Stephen's solution backed out the
> changes that Arnd made for the !x86_64 compat ioctl case, so I or
> someone would have had to re-apply them.
>
> > There was some other minor difference too, but it's also possible I
> > could have messed up, so cc'ing Stephen and Arnd on this just in case
> > they have comments.
>
> <nod> Thanks for sorting this out.

Yes, this is the right solution. Note that this part of the series originally
came from Al Viro, but I added more patches following the same idea.

While working on a follow-up series, I now also noticed that the
FS_IOC_RESVSP compat handler has always been broken for
x32 user space. I don't think anyone cares, but my series in [1]
addresses this as well by handling FS_IOC_RESVSP/
FS_IOC_UNRESVSP/FS_IOC_ZERO_RANGE on x86-64 as
well, in addition to FS_IOC_RESVSP_32 etc.

       Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
compat-ioctl-endgame
