Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF43B1C06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFWOJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:09:48 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:50948 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhFWOJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:09:44 -0400
Received: by mail-wm1-f53.google.com with SMTP id o22so790980wms.0;
        Wed, 23 Jun 2021 07:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=4Onc+QTJqLukHn4eQW5ixWqtzC5f/yKYNWCOP13cgnA=;
        b=FAgIOH0ceq/xMAvyVRlUN2rrLZfWkBrjaIM8/AtfmjTAP4HoTSjbpbQF66AjrGnQEJ
         1+6ES1jDAvrju3gr3EAOARB693JPQ4FcKItBkXqLkbM9qlhHrXNxaf2m9YHLy8KQSyaY
         g8vI6OIuANw9SMLAmWAmtz+l9NLjl6mzhsuxlSdKWGWmeE94qjcymI6H6RkRI90AL7/f
         yvkZB+QAiCSFO/ciZDE97YOduYW7B+ABbTIxTnCn96sarmSiMqinbGmwvENTPtEWz1sX
         Bxo08s0CUoFh208T4mxedNSgdiSU1Csj7ZWXQqsR4bU4+1fDY05GdY7CIMLmfpnTpNwX
         DDog==
X-Gm-Message-State: AOAM530jJOoGBzSw74JKrO/eymT1KsOwOr4ELyTR4SS5BSbyv/2d8C+h
        NXq1dmHjbEJpixcDEfeUuxw=
X-Google-Smtp-Source: ABdhPJwq6Ee/ApjKwqmm5Yo4/2srSjv6+l0sOd6JB/pp8fgBgk8tC1zJB+bPlNcB0aEzb/UIUO+AYQ==
X-Received: by 2002:a05:600c:2483:: with SMTP id 3mr10786364wms.117.1624457244814;
        Wed, 23 Jun 2021 07:07:24 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id o20sm5938228wms.3.2021.06.23.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:07:24 -0700 (PDT)
Message-ID: <1b55bc67b75e5cf982c0c1e8f45096f2eb6e8590.camel@debian.org>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
From:   Luca Boccassi <bluca@debian.org>
To:     Hannes Reinecke <hare@suse.de>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Date:   Wed, 23 Jun 2021 15:07:22 +0100
In-Reply-To: <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
         <20210623105858.6978-2-mcroce@linux.microsoft.com>
         <YNMffBWvs/Fz2ptK@infradead.org>
         <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
         <YNM8T44v5FTViVWM@gardel-login>
         <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-GqJflGe4cEnUMU3B1xwb"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-GqJflGe4cEnUMU3B1xwb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-23 at 16:01 +0200, Hannes Reinecke wrote:
> On 6/23/21 3:51 PM, Lennart Poettering wrote:
> > On Mi, 23.06.21 15:10, Matteo Croce (mcroce@linux.microsoft.com) wrote:
> >=20
> > > On Wed, Jun 23, 2021 at 1:49 PM Christoph Hellwig <hch@infradead.org>=
 wrote:
> > > > On Wed, Jun 23, 2021 at 12:58:53PM +0200, Matteo Croce wrote:
> > > > > +void inc_diskseq(struct gendisk *disk)
> > > > > +{
> > > > > +     static atomic64_t diskseq;
> > > >=20
> > > > Please don't hide file scope variables in functions.
> > > >=20
> > >=20
> > > I just didn't want to clobber that file namespace, as that is the onl=
y
> > > point where it's used.
> > >=20
> > > > Can you explain a little more why we need a global sequence count v=
s
> > > > a per-disk one here?
> > >=20
> > > The point of the whole series is to have an unique sequence number fo=
r
> > > all the disks.
> > > Events can arrive to the userspace delayed or out-of-order, so this
> > > helps to correlate events to the disk.
> > > It might seem strange, but there isn't a way to do this yet, so I com=
e
> > > up with a global, monotonically incrementing number.
> >=20
> > To extend on this and given an example why the *global* sequence number
> > matters:
> >=20
> > Consider you plug in a USB storage key, and it gets named
> > /dev/sda. You unplug it, the kernel structures for that device all
> > disappear. Then you plug in a different USB storage key, and since
> > it's the only one it will too be called /dev/sda.
> >=20
> > With the global sequence number we can still distinguish these two
> > devices even though otherwise they can look pretty much identical. If
> > we had per-device counters then this would fall flat because the
> > counter would be flushed out when the device disappears and when a devi=
ce
> > reappears under the same generic name we couldn't assign it a
> > different sequence number than before.
> >=20
> > Thus: a global instead of local sequence number counter is absolutely
> > *key* for the problem this is supposed to solve
> >=20
> Well ... except that you'll need to keep track of the numbers (otherwise=
=20
> you wouldn't know if the numbers changed, right?).
> And if you keep track of the numbers you probably will have to implement=
=20
> an uevent listener to get the events in time.
> But if you have an uevent listener you will also get the add/remove=20
> events for these devices.
> And if you get add and remove events you can as well implement sequence=
=20
> numbers in your application, seeing that you have all information=20
> allowing you to do so.
> So why burden the kernel with it?
>=20
> Cheers,
>=20
> Hannes

Hi,

We need this so that we can reliably correlate events to instances of a
device. Events alone cannot solve this problem, because events _are_
the problem.

--=20
Kind regards,
Luca Boccassi

--=-GqJflGe4cEnUMU3B1xwb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDTQBoACgkQKGv37813
JB4m7g//eRHYj1VWBGtxLh7mAXRhkMcfC0Q7w5wtWpvHhq30WP+QrHdzXOLib3qP
QFyRTbUyvVRa5YwZq4BqW5GGOzOeDSfbt0LqcLlH4CAg+HmXyAbVKqtEWU649bvX
tgeYArenNCVewtoN49lbtGwwzdRaT6876Nud52Wmamjs/2f36XtUvbDsAj/MM2yN
MivNe+ByhnFF3ygcHA+0z0Vq4OE+BhXWL4ebXefSJ6bKd6t1OWwq0KkWHjGivDnb
SuS/2Q0Zj7OpvCVU+tnXIS6Icorp1yWxtC0yvbzTM7zfkDjmsbXD2aFhaUlelVk7
2o6CNPD6K3W0oFXptgdtZNVqsn2PWzpoMxHOTsK27lIApcGQS2VqIFeQYd+TIdzh
+7NcM/O2+xrbq5FVDn2JouGVsRR7ct8aj+30yoRjLn9ppKs5dHVd1LakD9Jt/h1H
Vef9kZLHwxBGU2oZSLnkYkWZzpukhOE1mD2YOakGiF5tr6px2VkYovJfXfhMgjQD
rtYxts+b3e0hbPorepCDK0dnum7FlCMOJOxykyLv2/8CIkp+ts2IuDqinsmPlbIb
8ISUahZ2A5phgYGGaoYTqL5Ngpiko+/7+E5PLl+i/CajMFOGMt86XGtiiH2cjXV9
IgVs63XACPMCmWgNWB4tZYQbmygnhnHX3Ah75cuTjl8WYAl2T34=
=F8xu
-----END PGP SIGNATURE-----

--=-GqJflGe4cEnUMU3B1xwb--
