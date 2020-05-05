Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719F41C5AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgEEPYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:24:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgEEPYI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:24:08 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M9FX5-1jSykT1exr-006SC5; Tue, 05 May 2020 17:24:06 +0200
Received: by mail-qk1-f172.google.com with SMTP id b188so2634428qkd.9;
        Tue, 05 May 2020 08:24:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuZofJxDsVk7DZM6CZRjy54NDmJHYlyQT1a4sy+13J8R5RiSggRJ
        WlWs4uObIcjBdU7easa/tOAJENLuO8ML/9vpYsk=
X-Google-Smtp-Source: APiQypKhap7TF0CQ9mN+DMz02nXdNhjzOlhOx+BgGIhdFRxuj9O1I2Y2F83fBPHpGQMBrhSAJnOl90CE0/ch/mx43cE=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr3881450qke.3.1588692245113;
 Tue, 05 May 2020 08:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200505143028.1290686-1-arnd@arndb.de> <b287bb2f-28e2-7a41-e015-aa5a0cb3b5d7@embeddedor.com>
 <CAK8P3a0v-hK+Ury86-1D2_jfOFgR8ZTEFKVQZBWJq3dW=MuSzw@mail.gmail.com> <1f33eec3-4851-e423-2d04-e02da25e2e6e@embeddedor.com>
In-Reply-To: <1f33eec3-4851-e423-2d04-e02da25e2e6e@embeddedor.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 17:23:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wd2DxnUFFOBCC_SVsZCGTYO3ZBU9amMtK_uR+kvQXFA@mail.gmail.com>
Message-ID: <CAK8P3a3wd2DxnUFFOBCC_SVsZCGTYO3ZBU9amMtK_uR+kvQXFA@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PqjIn5mmdoB3qDWJNLAzfg3hwQBy3pDZJh8Hp5sVAaJyyBbRRRj
 nwC3iP+70lvzyc2d2r29OZ6hJ44x7Ies+ER7pYSLs3Jb3E2/rx3ORw/VQhzeFX8DVklWuxI
 S6QvwsUWDegAeBXc9M8G1s3eYhpvyiF7xxa2bPxodH2iiGStvEJAfRqH/1tn0rr/FoXIvuy
 jXtwvfULeEzaU6M8KXijQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJsUqPw+XU4=:lHOBbfFK/lxER2Jq1g2EjT
 xvd8PeutsuEsImgTc0FE+lBjyYABOwJ+SYKPdDknDMZ7NvxmYnSco2XDAV0uDnj9fJSD1xtdK
 0sfbtexQhBa51PApLqKI1E9P5t71fMGbuh1lcWHo3IZE2od+KnCA11z2HssAHZgRhwlbK0Est
 x3snH/4fK1OYfd/574EsW2fvsUJD1PQh9mbrRofODBEb02d9Yhln5ydPY5cAHhZOyGOfKGb9x
 rY086dfxaFi1qmd7KoHLiapQH/RJydslj8VeYklMDWtipVDzgpaBLtow90mcVjiyW0kpIaAox
 lnAbC0H/GwENjvEjpQciHy8m3UgNErnS2gfABdcP3yL41MIkiluuqpXV5tfYKLJgPb6bNeu1x
 Kf7j3YP4y2k3SZ5unysDW3EjglPNiVtOd3L7h7/g24qoubcaUyN4SfmizyEneqebFrdox/zCc
 BW9LiLK0RF93EGYzezjEQ2JObtnTINv7jZ89jN61eCg+68mqP6f20p0geN4JSBJrIHPtPgXc5
 Wf5PW13YCU/9rjSbpA34XeRRL2rXUIl5RezQx1GWpYVWiPMd2rotkR8bdoMhsaQFcgkiz5E+f
 m0MolD3ln3s7vmlnBVvrFr8Kacp0en8w8d9JCo0TeAby8ImVqR8IYQa8fQy8xavjQO7mJ4Iks
 fonHAaBx5+vFf5JfatUHAEj4qUcaK6rY+VMPM+EvWJArLDrbIi8YP0HfL+DrOhxl+5K/o61jM
 2aZJpAAP8ffardu/IGlURxuYL8SJbu0qudyhlD4wL3tpkoYU0XbSyUdv+usZbA1mvXBgTbgMd
 Z2XQqM1EbTZ8bWDByGZWl0wn+GNICmxdESgDKgYzcPP0rnnbYg=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 5:07 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 5/5/20 10:00, Arnd Bergmann wrote:
> > On Tue, May 5, 2020 at 4:35 PM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >> On 5/5/20 09:30, Arnd Bergmann wrote:
> >> I wonder why would we need to backport these changes to -stable... merely
> >> because of the use of a new version of GCC?
> >
> > Yes, we usually backport trivial warning fixes to stable kernels to allow
> > building those with any modern compiler version.
> >
>
> OK. So, if you anticipate that this is going to happen, I can split up my
> treewide patch into separate per-subsystem patches.  I can replace the
> treewide patch in my tree today, so the changes are reflected in tomorrow's
> linux-next.

I only needed a few patches to address all the warnings, so you don't need to
split up the patch for this purpose, though it may be easier to get it merged
anyway.

I see now that Linus has already applied the same fix as part of
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d82973e032e2
It's just not yet in today's linux-next, but  my patch is now obsolete.

Linus, let me know if you would like me to Cc you on the other gcc-10
warning fixes I have and possibly apply some directly. I have patches
for all gcc-10 and clang-10 warnings now, and am in the process of
getting them out to the subsystem maintainers.

     Arnd
