Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91FE3A63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394061AbfJXRvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 13:51:55 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34046 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392609AbfJXRvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:51:54 -0400
Received: by mail-pl1-f173.google.com with SMTP id k7so12238694pll.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=tF/2SELAonCjUta1zWhD10pXJwE2qHwIT91x2FMVMcU=;
        b=ItcTVGWcgUBL7MH8dVFfdUkhXO0Z0i5PPWM/g8sKszgo8cLrwFQNCQ3A4dnQsb2TE1
         LUOdjP21CWEkS247RR26lBtQyX1H18zZRj/ImqY0cYa7GkMxGB3Ant1YrT6e6dZ33W2V
         88YByfanT0NuQLkjmn7eIX+8E521sNaBCBhz96gORCFhs0DDDdVQDzLASxSoYc5Qk5Jg
         Un6MjocSvGg9L8ILwpIHVmaBdeZpVfSA/46ukWobRZ9OjHLnwA5b2C9FLKXhwir/Fn3m
         OY5TaaxCypa9cJeip8fSeYtKgX7UZAy0EL0MQCs+73WNolOjA1aEZHcSYiPB8Vrv3VuH
         EbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=tF/2SELAonCjUta1zWhD10pXJwE2qHwIT91x2FMVMcU=;
        b=iYDuVqY6kF8bqu0ncxBllyPlQu9ueAM13SHA8llOKjND02+BUvOivD0dnplOHaPWs6
         sD0DB76OjaCqOgcGz/ehT/C4qxfL+LE16yJDLwkky42Vbr+djNS1i/oNK6wULB0kQqFZ
         wj0bKD3cRaX6wIq3ci20sJGyUR0VUps+feRA0f2zGAoW8LOVeblSaAbRcaYYgV3XXOHH
         vJQ4OCeufPnhJldsFzxhYtXEuS1LXHwQvnZXK9hkjXMOQahTfzKnBETS0KNeCnepAmvt
         gbRPGq0n8OK8D3J7ec8f+5Yb/K9QZHFkvgeugZEbgKHHJrgB0lxWhjaBBtUEsQfvPhad
         H6Tw==
X-Gm-Message-State: APjAAAX9+souaeQEa07bi6Wvn6EyQh8bis8rLYTgjqDYftrPdTF3Qc+T
        wrtMHL1A4gHvDzoNi0i5xKyVFw==
X-Google-Smtp-Source: APXvYqxEeiS8Do8r+HAuQAZh96z/nEPdQmOdhWd+IVg9M6wNaQvIpVjKYpFMoL00QXvKV1g32bqB7Q==
X-Received: by 2002:a17:902:8606:: with SMTP id f6mr851241plo.226.1571939514002;
        Thu, 24 Oct 2019 10:51:54 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z7sm10546493pfr.165.2019.10.24.10.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:51:52 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2794A217-0A93-44C1-B0A2-A67504A711F0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6B12323D-80C7-4522-AF86-AF0E0F6C2E2D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: File system for scratch space (in HPC cluster)
Date:   Thu, 24 Oct 2019 11:51:51 -0600
In-Reply-To: <e143071a-b1dc-56a4-a82e-865bae4c60c1@molgen.mpg.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
References: <e143071a-b1dc-56a4-a82e-865bae4c60c1@molgen.mpg.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_6B12323D-80C7-4522-AF86-AF0E0F6C2E2D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Oct 24, 2019, at 4:43 AM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> Dear Linux folks,
>=20
>=20
> In our cluster, we offer scratch space for temporary files. As
> these files are temporary, we do not need any safety
> requirements =E2=80=93 especially not those when the system crashes or
> shuts down. So no `sync` is for example needed.
>=20
> Are there file systems catering to this need? I couldn=E2=80=99t find
> any? Maybe I missed some options for existing file systems.

How big do you need the scratch filesystem to be?  Is it local
to the node or does it need to be shared between nodes?  If it
needs to be large and shared between nodes then Lustre is typically
used for this.  If it is local and relatively small you could
consider using tmpfs backed by swab on an NVMe flash device
(M.2 or U.2, Optane if you can afford it) inside the node.

That way you get RAM-like performance for many files, with a
larger capacity than RAM when needed (tmpfs can use swap).

You might consider to mount a new tmpfs filesystem per job (no
formatting is needed for tmpfs), and then unmount it when the job
is done, so that the old files are automatically cleaned up.

Cheers, Andreas






--Apple-Mail=_6B12323D-80C7-4522-AF86-AF0E0F6C2E2D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl2x5LcACgkQcqXauRfM
H+AO/BAAhhassljSPZNXP7jy6M2GM78gdwO+QEkZxI8+iC2Qh8ObAQt26DhtP7QA
A0RimYBaT4yeKy5Fg5n+WVVgpUzos1s9Jb9hHSQyb49RIgSnDppfojTcfXrr5xeL
yVzFqXsvAxDiDF15jTYyq9k8FG0BUuUgmV0BmtXUsCoRd+dQQqMW2r8QPxfKvKrI
ue588jhz+inlYVzQM3V5GZdV+h/Dk+ztqYsCp6f/OIRuQ41gxs3+XmZm9+Vj/yaO
3X9uOVM9uLqe8H31DDGdiRI0InDc08AlXYOhu2N9ioJrk54LYFSX4Tfo/Z1hvuPC
CmrakEBt1y4NRiB9vOUJBhBbxx8jGXf+uqy5RYIkWuwxF5r/jeqUDl7rAR65I5MX
SWz8AS37fubkc712L7JZoFQn/CN0U/1xoWTGH/8J5D9QeoeFl2TvK/ArLae6pC2u
2CsmpIhVcHeSAawb4wLFYa/u6S/APiyqMY1towyWfLpDZO0ohMT5IjNE7YwIugP5
IrtNUJEAMri58Anvrceaf8Fy2ZHeuQLRJ8uSSbkccEkSMGq6GIRXS3JkkbUJ6lsO
9bwsJRiBmKT1yu5x1iemJlu3zJ9P0z1J+J8XMmc5mISkw1ZmR5sUY+LB3O/2zfa6
9XVbxMVcqXAbOiTr3J/jycaBHFUtRjx9sAYeajJEoEp83osYyf4=
=LytI
-----END PGP SIGNATURE-----

--Apple-Mail=_6B12323D-80C7-4522-AF86-AF0E0F6C2E2D--
