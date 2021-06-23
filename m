Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69483B1A71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWMtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 08:49:09 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46054 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:49:09 -0400
Received: by mail-wr1-f44.google.com with SMTP id j2so2480783wrs.12;
        Wed, 23 Jun 2021 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=XOmIPJRzFakO/w4XtkertpgFPMyFgjY86X1TO7dNDw0=;
        b=pL3LHzVCpLmFfrrj3Aeqvm/N6M24GFlC/mHho83Fpto3pl4/CYKNK4wrRWgRnM/UFF
         oQCuEv6rhoNlI9kuONdfEo/UEL0wt6KEBvfskhufBm6m1fZitL/eSgU/KhpMNphbW5Ra
         sehYr/MeyortaeQytuKrW6a45jvNC5zhTS8WebQ0Ix/oilXWsDrhgx4BKBMI4KdM7tNj
         gwhtf31ab6Jm5jaPMOkNzRgqkhXHxQ0xrE7vQA6Q3WzMJN5nMZqCL5hRnLdZ9EQspzsg
         k4vBrmLY5GyFMfDD58ToVxz/7HJRhOLYUcDCCPi5DZyqRQdDSLgA3nxQVhNU5RYS6rd3
         ZsVQ==
X-Gm-Message-State: AOAM530LN1Y6OIji1K3bi3LBIfRyZEEkdy6oPC/Uie7UF2nTozJ1SKKP
        /7kl7bgATUcOy27tUpWYSzU=
X-Google-Smtp-Source: ABdhPJxx8aaV8qjN7hGJFoqGJB5GJgItepkdKJ0B8XDDzEJkL3WD1H4tDQdxmiclFkDQtwxCuXg02g==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr11075087wrx.22.1624452410585;
        Wed, 23 Jun 2021 05:46:50 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id x1sm2971082wrv.49.2021.06.23.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 05:46:49 -0700 (PDT)
Message-ID: <aa0ed29d1d15d06fc125bee1af0c40425bd5c6f4.camel@debian.org>
Subject: Re: [PATCH v3 0/6] block: add a sequence number to disks
From:   Luca Boccassi <bluca@debian.org>
To:     Hannes Reinecke <hare@suse.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Date:   Wed, 23 Jun 2021 13:46:48 +0100
In-Reply-To: <bfdd6f56-ce2b-ef74-27b1-83b922e5f7d9@suse.de>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
         <bfdd6f56-ce2b-ef74-27b1-83b922e5f7d9@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-siui0wSAomKlfQSo0RJc"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-siui0wSAomKlfQSo0RJc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-23 at 14:03 +0200, Hannes Reinecke wrote:
> On 6/23/21 12:58 PM, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >=20
> > With this series a monotonically increasing number is added to disks,
> > precisely in the genhd struct, and it's exported in sysfs and uevent.
> >=20
> > This helps the userspace correlate events for devices that reuse the
> > same device, like loop.
> >=20
> I'm failing to see the point here.
> Apparently you are assuming that there is a userspace tool tracking=20
> events, and has a need to correlate events related to different=20
> instances of the disk.
> But if you have an userspace application tracking events, why can't the=
=20
> same application track the 'add' and 'remove' events to track the=20
> lifetime of the devices, and implement its own numbering based on that?
>=20
> Why do we need to burden the kernel with this?
>=20
> Cheers,
>=20
> Hannes

Hi,

It is not an assumption, such tool does exist, and manually tracking
does not work because of the impossibility of reliably correlating
events to devices (we've tried, again and again and again), which is
the purpose of this series - to solve this long standing issue, which
has been causing problems both in testing and production for a long
time now, despite our best efforts to add workaround after workaround.

For more info please see the discussion on the v1:

https://lore.kernel.org/linux-fsdevel/20210315201331.GA2577561@casper.infra=
dead.org/t/#m5b03e48013de14b4a080c90afdc4a8b8c94c30d4

and the bug linked in the cover letter:

https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

--=20
Kind regards,
Luca Boccassi

--=-siui0wSAomKlfQSo0RJc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDTLTgACgkQKGv37813
JB6A6Q//Z3SDBBRi6Ukl05ygOgOcNyIVCHNpxCzx+wViA4Q7RUCXnc7Q+oQwaib4
sz7IGa0rauYCgdr1y1PF5VAqqqxZpB7iWt+qDekOY5E0q+GQfjAuKJclS/C1J4JT
pXhvELaWFISS+OhS1HhETcEzxXBQ9htOUjKMeilFKPetv5NPZTbvITK5vtIu+Toh
+wT1OW0WU2OE1oIALmTgouqHyrhPjgVPS1oL32E7yYmsuTbbN4GrJP57NkLKx5xZ
oF718/1sgwXeGMuk53GQ1ntjGfze4E4eBPJxuVXsJpSLOSiW0gSAK65ZcGP03C4G
m6bcMWFxLCSlWpZ+diGgJgJuygvglv0sU2WVY+S0gifrZXSwm/Op8N38XorZFQ/L
5dYO+DkbyhSul1rPfG2W7OW7YYze/Xg+Gl1qqoy/vcc4Zfl0uJyxRuPHtsXd0AQs
kpu4jtuY5BUmoM+SoULx9Bm+DpvgNbgR6kOLHBWrBvt87rppJlReFhBS0jTG85H4
uwl8EzLCNePGRij/UzmLjTdblJSxiOlpws55A1GgGELp2sjMlyXmo5TkS97F7I70
mK/LjFaiK3mSoE9Yl6xoj2b4PSf67PNDxCl7DGsLGkXk13NePGLcfynO8LkXUZwH
Eas6LnpxQeuovYdmxx0ZHYJ3LoLPGwAWRdprWvcPu87hOTIs+Do=
=z3th
-----END PGP SIGNATURE-----

--=-siui0wSAomKlfQSo0RJc--
