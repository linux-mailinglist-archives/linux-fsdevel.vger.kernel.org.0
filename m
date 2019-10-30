Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B9EA350
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJ3S10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 14:27:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43745 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfJ3S10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:27:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so2145849pfb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=zqRb5h0FZotKYrLGPgVqV+ei/tmuW2bpGS2eRYH4owI=;
        b=nMFZo0oR9BSVl/QIn6KlviDK8yXugG2ibCXQLj4/NJWifE2WBpxAXRlrDBMn7bgsKJ
         W0Oyt0AezQMrSE0hmZZrsGlw9kFm+lkrwX3IEO9CVZ2jiOhCiUd2LkijZ1AfikPb5TZV
         uEm6vD35ZTHaFqT+vAI5lZI/bnPQ1RYT7s9qYtxxLG5JIWhVaGQuoAoYdme2ttnX5mu8
         cZnOctXbrtE8GiPzBDd7vSTicuM5VHhyn0ZLQUAj4Yd0BXLJ9uwfKBK2Jei46CYaZJxD
         3mn+2uw0rEiCLT8uEKu3d3R67aefIlUl5NVyEUFoolbPAxbPSSP3IdbzQ0Wim7ppPtpz
         ZJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=zqRb5h0FZotKYrLGPgVqV+ei/tmuW2bpGS2eRYH4owI=;
        b=UZp4dFa+6iYM8KPKzGGReU8toDV+Rx9+Bh7nF98Xc0vnvBOdoPTPmpeC2UGFkxSGCc
         eLOHsTG8KKlM2terbfSmjbO7PNE1bp/IwLUB7eJdWnjV8ScQ4CX7l9nShTvUB90tAyh2
         2DsjY2/4+WhYOaMr57+05lpA18yakpVlV5trY/vBo7L3S/l9mw3N3CGjLXFWmbV7F2q0
         61K+dV1uuq1+K5eWLGiTdn9GNPJt0EJ5UTs1sZqsULQ662aVogiU5H1QWeN1zCJyb9ak
         HTx3frEDV00zarQYRykwM4Q+KZC7OwGMFrnOW4kdzDvbmHWpd+2oInmgl8nX0Mg/bOXh
         awaw==
X-Gm-Message-State: APjAAAWjMfvcCdWMKcgLZXTLi0s2vKO+hqFM5L/7MlhHRm2bgfOCzUMe
        2Dot7WJopHp3nLtKx5Dn/t4EYw==
X-Google-Smtp-Source: APXvYqwcuTsQcrGo9vz9m5vlRPzxvSOwIZemB21Y43ubn0lwUQg1p3TLAdOOkMuM6mgJc3+VEJbjFA==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr906068pgt.428.1572460045075;
        Wed, 30 Oct 2019 11:27:25 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u1sm573241pfm.158.2019.10.30.11.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 11:27:24 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DC633400-06B3-4235-9AC6-0B9C5B373F86@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1748A5B2-1D9C-4E09-B80C-71E64067F5A7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] ext4: support STATX_ATTR_VERITY
Date:   Wed, 30 Oct 2019 12:27:19 -0600
In-Reply-To: <20191029204141.145309-3-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
References: <20191029204141.145309-1-ebiggers@kernel.org>
 <20191029204141.145309-3-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_1748A5B2-1D9C-4E09-B80C-71E64067F5A7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 29, 2019, at 2:41 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> Set the STATX_ATTR_VERITY bit when the statx() system call is used on =
a
> verity file on ext4.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


> ---
> fs/ext4/inode.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ceda8..a7ca6517798008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5717,12 +5717,15 @@ int ext4_getattr(const struct path *path, =
struct kstat *stat,
> 		stat->attributes |=3D STATX_ATTR_IMMUTABLE;
> 	if (flags & EXT4_NODUMP_FL)
> 		stat->attributes |=3D STATX_ATTR_NODUMP;
> +	if (flags & EXT4_VERITY_FL)
> +		stat->attributes |=3D STATX_ATTR_VERITY;
>=20
> 	stat->attributes_mask |=3D (STATX_ATTR_APPEND |
> 				  STATX_ATTR_COMPRESSED |
> 				  STATX_ATTR_ENCRYPTED |
> 				  STATX_ATTR_IMMUTABLE |
> -				  STATX_ATTR_NODUMP);
> +				  STATX_ATTR_NODUMP |
> +				  STATX_ATTR_VERITY);
>=20
> 	generic_fillattr(inode, stat);
> 	return 0;
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>=20


Cheers, Andreas






--Apple-Mail=_1748A5B2-1D9C-4E09-B80C-71E64067F5A7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl251ggACgkQcqXauRfM
H+CBiQ/8DR7koM8zWum1v34NVctPdQBxC5kWLThstWcXhh+YyJ45MbKhexyKldZM
TVZuj1B+ziTBnpCT3C6mfZMa8Ht1ZJ0AZRoopAIKdziRiktk7Sr62GDDqjjhyQkF
MlAUxCl9rOlQFmoNHAuBXLcgmzHcMufQih6U+qCfv2A0E5Zkn/q9klcxPOuQT1mK
Oj1i5FQuQEna+PGDR6D4MaRZJGG4y4ZAqQFR6Q1t7ennqFCUdyZ1HMm8wh3LbB4K
pGztj1UGvu7Wt01Mbk8YH2CCVJaudM+QDnwFqltLFvBjuFc4cjx703GZt5FuvxW/
phIoNjKQJMRaulnBwwf9Mr8F+FXVpiSc9f/tx+d0AK4s9VHKRn7pjkQA3yI23PMc
SeNpZC36KHc7C6e37WUXpJqM4Vwl5HW/6lavzDK5lEZmyQX3aEL7Ua+AsnObv7GF
MhN2uw5up5qfHTsnpWUt5qas7ikCJvTGCwzw+C3QW7fUGGs+zvX545V1PDpAvYAb
3A1uryDgsF0ZSffD9M16uWp+Jqu99zGyocqQCNtGEwd1eLNg728V2jnu7E+BSCYg
FM60AUOXuiUhsS8ZvyVRLS493caNO7YTctq/qDa4hOA3+UNYFq5ikEJLD5/E1lyN
hfQiqTrvDTvN8NQUUGLRXEOU+QrgoL6APtSTuWi92jD4fBwzhrM=
=cSDw
-----END PGP SIGNATURE-----

--Apple-Mail=_1748A5B2-1D9C-4E09-B80C-71E64067F5A7--
