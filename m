Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536E2366BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbhDUNHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbhDUNGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64D7C061346;
        Wed, 21 Apr 2021 06:05:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q22so4306849lfu.8;
        Wed, 21 Apr 2021 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=JmUkovJ4PF+YyKy/jY+0gRoy2D+XF6hMzgTd5ze+4xg=;
        b=aImxsQYwp6kUAL2GogTKXZeIFbCiw845KWa6WLKWiH2R2pDvvWqyuEd08Swnrz79LQ
         htxKev6DLtaTTPhelPLHcbGoGJKsyYFIPAkMX1k5pvGtOrgQ4fTFnzbSzgE4kTihGi8Z
         pDA+WRoBlkKmN5kQ9M6PMwC7T+74JIiOovWl5o/2GZTxrwrohmjxQHNR7mQNIyCIsiT8
         joRMrpfFiJZ2hR5D4vC4VxlfK8UpCC1Xx0RZhU04sYRV0V5izQkrOu3xszroITfthKjB
         J6m8juZ2EOK4xE2ywgum61B8ahqR+v/2ykHY/Wcki2yWmJLn3jwBTlCFP140P67oH6Ld
         1cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=JmUkovJ4PF+YyKy/jY+0gRoy2D+XF6hMzgTd5ze+4xg=;
        b=JXlfCg5sxxG1uA9PU92L52Sm9/EhaD13WxHBjKgSMAsm1p07IUc1DKTB1zhufEDMiZ
         6h9CEmx6N+dBS3kwGaZRXD/p3S6BHCct3mcY5cpDUHYJ5UyrIAOkb15g+0Az7h04IABa
         bFju9yojTYe9SAuHuOFQ580W2pQLD7niTqEmDUwo07ddw6ahE/9LqfzoG8xxB3H31R3y
         jY40z5FHbFb/1h6+eJwDIC7KGO6c7KheOU4XX6xoSt12lMuJxhBE0dKQp5QTcoYa6aVG
         LSY7NuJ6/5ceY+KewRIizowyAKzl+wLLh7fuWGkxZIw/en1Yu6f3hb6UhJex3cqPtqYZ
         FVsQ==
X-Gm-Message-State: AOAM532k8SM0T4osVAtREWUmQZlLaJdhOG1a9vAqtO5KLPKj0eauGFSa
        gyufvitzFtNeSw/a/aSjN48=
X-Google-Smtp-Source: ABdhPJw2O58VpMVpU+gR1j223w9p5DmKGY1H7WzcXBxLkb3E7wEvrE/DzxeCxpyIHOSevNFox4N+Uw==
X-Received: by 2002:a19:e4a:: with SMTP id 71mr19781865lfo.218.1619010358462;
        Wed, 21 Apr 2021 06:05:58 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id b10sm199558ljr.109.2021.04.21.06.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 06:05:57 -0700 (PDT)
Date:   Wed, 21 Apr 2021 16:05:46 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     <Peter.Enderborg@sony.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <songmuchun@bytedance.com>, <guro@fb.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <neilb@suse.de>, <samitolvanen@google.com>,
        <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <willy@infradead.org>
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <20210421160546.7045245f@eldfell>
In-Reply-To: <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
        <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
        <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
        <YH63iPzbGWzb676T@phenom.ffwll.local>
        <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
        <YH/tHFBtIawBfGBl@phenom.ffwll.local>
        <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T2Q=aDoIbEuzeKlHNow=Dcn"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/T2Q=aDoIbEuzeKlHNow=Dcn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Apr 2021 10:37:11 +0000
<Peter.Enderborg@sony.com> wrote:

> On 4/21/21 11:15 AM, Daniel Vetter wrote:
> > On Tue, Apr 20, 2021 at 11:37:41AM +0000, Peter.Enderborg@sony.com wrot=
e: =20

> >> But I dont think they will. dma-buf does not have to be mapped to a pr=
ocess,
> >> and the case of vram, it is not covered in current global_zone. All of=
 them
> >> would be very nice to have in some form. But it wont change what the
> >> correct value of what "Total" is. =20
> > We need to understand what the "correct" value is. Not in terms of kern=
el
> > code, but in terms of semantics. Like if userspace allocates a GL textu=
re,
> > is this supposed to show up in your metric or not. Stuff like that. =20

> That it like that would like to only one pointer type. You need to know w=
hat
> you pointing at to know what it is. it might be a hardware or a other poi=
nter.

To clarify the GL texture example: a GL texture consumes "graphics
memory", whatever that is, but they are not allocated as dmabufs. So
they count for resource consumption, but they do not show up in your
counter, until they become exported. Most GL textures are never
exported at all. In fact, exporting GL textures is a path strongly
recommended against due to unsuitable EGL/GL API.

As far as I understand, dmabufs are never allocated as is. Dmabufs
always just wrap an existing memory allocation. So creating (exporting)
a dmabuf does not increase resource usage. Allocation increases
resource usage, and most allocations are never exported.

> If there is a limitation on your pointers it is a good metric to count th=
em
> even if you don't=C2=A0 know what they are. Same goes for dma-buf, they
> are generic, but they consume some resources that are counted in pages.

Given above, I could even argue that *dmabufs* do not consume
resources. They only reference resources that were already allocated
by some specific means (not generic). They might keep the resource
allocated, preventing it from being freed if leaked.

As you might know, there is no really generic "dmabuf allocator", not
as a kernel UAPI nor as a userspace library (the hypothetical Unix
Device Memory Allocator library notwithstanding).

So this kind of leaves the question, what is DmaBufTotal good for? Is
it the same kind of counter as VIRT in 'top'? If you know your
particular programs, you can maybe infer if VIRT is too much or not,
but for e.g. WebKitWebProcess it is normal to have 85 GB in VIRT and
it's not a problem (like I have, on this 8 GB RAM machine).


Thanks,
pq

--Sig_/T2Q=aDoIbEuzeKlHNow=Dcn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmCAIyoACgkQI1/ltBGq
qqdgcA/+OU3upziPx5lqynmqoiFPG1bUHAZHL5yi5T2jmhfS7JPQT5Hkjv3wUtNe
1liYgsv2ATY/B6EPnwB85cH7mwBdWa2b20cbgld3yoUrTYbGVD6mG5C9xGwgnT/3
Yu7gABmOPTmnBwjYDpQm/C98QhWDTTeizPYUJzIeb36+Zf1cItMjUhG1dcokslp3
T0LcPJnttN5WKbmZCPVvAZJ02mWDx6/k6VYbT77NvSRJ+GPMZBL3wNxkY4hzMC4l
LAmZm2biGahXtgsG93kblsM4DjWppAti0ToJF9OQlnTdzeFWEm8OMuZMrDj7gT6X
MPfMDR3l+pmfB3VM6QeBxhWC6swl3RvWIEpti6gaHy/JcNdhuDYWuYBFVPosLxQV
zHEe+wXTuUoQyGtINR0F8aU+pgT7lHp6BBZxHbQyHlxoxo05mM7hSupHt1yFfY+U
vUvggaM50URJjG+t88DLyYaB0tX3APSkUY8wVuKB/vO3VYb3v9g+dgCN+GJBD4/q
Yqhjf7PWG3aHU6kwEWIJDHXiXOMKVZnALodzAloRck/vh4zs8QDgGE7MGDnj5NUI
GdPjTDK6xMx7Xhx0tlZgtkPhbiQdkhN+r0jqgeNlNm2VTUv/T6UerfWOkN9BlS2k
/6Es9bwDrvvL+MKC2XCylqSNRHQkDMmayMtymQCEIitRZLTYbVg=
=1pAh
-----END PGP SIGNATURE-----

--Sig_/T2Q=aDoIbEuzeKlHNow=Dcn--
