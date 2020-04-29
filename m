Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E91BDC5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD2Mek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:34:40 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgD2Mek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:34:40 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N17gw-1j1lkl3Gqg-012Vyk; Wed, 29 Apr 2020 14:34:37 +0200
Received: by mail-lf1-f47.google.com with SMTP id y3so1520037lfy.1;
        Wed, 29 Apr 2020 05:34:37 -0700 (PDT)
X-Gm-Message-State: AGi0PubYk73lvsbZtU4/hOtDozH3ED0RXkeJ8fQQ0HMNsD+BiGXViM9Y
        Ovkvi/0+u2KLaiEkuiXnt9/cfMmKG/MZp+4ZJ10=
X-Google-Smtp-Source: APiQypJXpncjiHqtF8AXXyPOV1A1AQ0fvHy1iXzeMwNoTg6D5f//C9XrVCZn/K+TfKDZQ9HhN0uOyITz7H5G2DWPENU=
X-Received: by 2002:a19:3850:: with SMTP id d16mr2697623lfj.161.1588163677296;
 Wed, 29 Apr 2020 05:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200428074827.GA19846@lst.de> <20200428195645.1365019-1-arnd@arndb.de>
 <20200429115316.GA7886@lst.de>
In-Reply-To: <20200429115316.GA7886@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 14:34:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3sh9cCbdVYPaWVrOZiMuZcnw7-nsa0qgaQWPDBufqsYQ@mail.gmail.com>
Message-ID: <CAK8P3a3sh9cCbdVYPaWVrOZiMuZcnw7-nsa0qgaQWPDBufqsYQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! signal: factor copy_siginfo_to_external32 from copy_siginfo_to_user32
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3mn4P/An2ydwnHYRAK8xJSekeqcdwwsqEuXznA6Rg2fxoJWc3CV
 VRT+TzYxsKy9KrnjFAcljiJfqgkCabnODDX5B74MwKNJS4m0GAG9sdjrSyJtjFHU3Mp5TFy
 G2wl88NOyPmVCT6HF/0gExLUwfb633YkgWicQ7byWUY9gn31BplCzChXmq50KqcqycjgqSE
 W+YthH7n1FqpB86z5KZJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bb2jBtjFOvE=:8tvRQyuM7yBro1nVcX1Qts
 qkrPHFqgVOsrFM3leaU/7mtyZHpwMmhl23h56nGds2IHA+x7bVUBywmtY9+82U1xk3URgu7Pl
 wWbYTYxVu726NKzzozmgoClBnaViYnmlKnGgpn7dHrrZFj8K2iyA8ndwo/E03012Xj8n3O7Dg
 piSueKbCceaPHGNNmnPuI9R8QC2uRadll4CwqzFtvI1XGFUzq777nD1gCktxe/76bMyn4wyA7
 MFKKSyLjpB+eOE8TXGbPi5IbZ+xzIR5HdscnnvNj07vlWjSOPBOI+hVOFxScaj54NdoARrFNB
 Eznpy3iZOKXZ6vfsd+t/1PkyV4Hn68OFhfKFuAMNJjvAQjUtZMH3RAxqm3k2OKN8jVxdbZCCQ
 JdD6jyT76H/MAyfksPkHH3f4X23rm7ifAReTrfNpeusRjpcujQD1XtRv9yw6NicdHaohSZPgZ
 D0E6oPOnw+lWsHhzd05VlZeV74JvqMWgf8g0AlVyaDia6lxt+P+o2BgDw755JXJx0eV8jJtEz
 dVUw6VitUCBgsoNoFfoLEGiknThhJ3QXtpdSHFKEra0oKr9jROJTBXZbGcJuf6UAl2sCC6fTS
 6DLQQDKV+cJNEPvvopUnQJM6nAxacw1Kpb2YsONIskk8iFa5lcGtiLUZeM1Xoy8DUZooq5XSQ
 +3UfefUuqEtaPTnhkMBWBjaiPm1sSifBeRldlDNkCZDvqVvlDt1K2XcUOvLAXNuWUuVJvcg7O
 e0ixOzCIABT/TgEnHGPoplItIV6IbQ2MZ5Bi5LA0j3JjRnhMOKpM7kTHK5Eg32zVsqT44vRT6
 Yy2tdIa9XIQ2sRDvz7UTJnf9zRE4s7C0RziQi8wmPPwgwmavmE=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 1:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I did another pass at this, reducing the overhead of the x32 magic
> in common code down to renaming copy_siginfo_to_user32 to
> copy_siginfo_to_user32 and having a conditional #define to give it
> the old name back:

Nice! I guess this is about as good as it gets, so we can stop
spending more time on it now ;-)

       Arnd
