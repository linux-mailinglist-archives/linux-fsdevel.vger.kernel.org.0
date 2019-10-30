Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF6EA349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 19:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfJ3S0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 14:26:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35545 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfJ3S0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:26:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6so1365358pln.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Ley5zvOlqaz2Wb2k694thCubOF2e57hu9OBi77fDxEQ=;
        b=j/Xlnnb4bRZ9+4KD1WhoNvk/kS85zjuQnr4LIEdZrDVgY/LEuUTrBSqNeX1ziYwI2I
         DUo5r32HNy1rmo4RKYYx+NO2f3XC/ZJgPWC9K2zzGVDmtF/2HTrTxI1mBdHol0jfK0Ln
         sQCSBb2dejgO92c5ovM+98RbD4p4CQUAkqGYmeroASqzXhVBDJb5BOuuIuTYNDu72AwL
         vHCS1HOnobtqiIBZFDJB66iSwOslFuySvU9Q7Yeb4qLgmuldq2ov30mxnrzLX5PGHdZo
         hbNdReob4s+22r/9tmGT95z41DoSYc4cU/86Ip12mpySxbKCTx3g+01nT4m3uBFdGyho
         ou3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Ley5zvOlqaz2Wb2k694thCubOF2e57hu9OBi77fDxEQ=;
        b=syZ5NY5v63OnGpzQLQfWLQVjT27DzEa9HBC9wtWhSoncZId1Su/Ak4IYuvKrRkuWRO
         AbjSG+Jm3raNQMWUWJF6mm6gumfcbuiQlHaGScJDzPxMmEAAolwNYMzkXh7qosGXrLG7
         wCn++bSQyO2v4rQxt0DfUDAIHRA1MKymvAzuQAbX52zKMumou/ACz/cYGji629+FVthY
         yY93T/frR2jVF2k6CqGpYbl+yYYX9KShU0QTNSSzECyd1TWRL9fpUTIZSrdH6ovMpv8W
         1RyRUABHoG/aF4JRTxzKmbwFHgYaTh4yMJYqbkyOXJ1EiS9Hia/Tnn3eHXe1R60WTK3a
         h2WQ==
X-Gm-Message-State: APjAAAVG7jZlw4zvbHOAhfph12HRX8ux9Ri/Yz6bCx6iRzcuADbohTJX
        iix+a9SYk/cb1zigubMkRjIjnQ==
X-Google-Smtp-Source: APXvYqyev8sjZ1KZb/AgoF729qKcxrPe4HXmhqnJexPBMNfdbYQ15vLaVNRr2Bm6WAicApGTTJeWxQ==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr1439479plr.153.1572459977459;
        Wed, 30 Oct 2019 11:26:17 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 39sm4053067pjo.7.2019.10.30.11.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 11:26:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7C96E996-D52F-4901-9F64-B2C40A889829@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_540B1263-203B-43E9-BA92-ABF36413FD90";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] statx: define STATX_ATTR_VERITY
Date:   Wed, 30 Oct 2019 12:26:10 -0600
In-Reply-To: <20191029204141.145309-2-ebiggers@kernel.org>
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
 <20191029204141.145309-2-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_540B1263-203B-43E9-BA92-ABF36413FD90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 29, 2019, at 2:41 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> Add a statx attribute bit STATX_ATTR_VERITY which will be set if the
> file has fs-verity enabled.  This is the statx() equivalent of
> FS_VERITY_FL which is returned by FS_IOC_GETFLAGS.
>=20
> This is useful because it allows applications to check whether a file =
is
> a verity file without opening it.  Opening a verity file can be
> expensive because the fsverity_info is set up on open, which involves
> parsing metadata and optionally verifying a cryptographic signature.
>=20
> This is analogous to how various other bits are exposed through both
> FS_IOC_GETFLAGS and statx(), e.g. the encrypt bit.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> include/linux/stat.h      | 3 ++-
> include/uapi/linux/stat.h | 2 +-
> 2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 765573dc17d659..528c4baad09146 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -33,7 +33,8 @@ struct kstat {
> 	 STATX_ATTR_IMMUTABLE |				\
> 	 STATX_ATTR_APPEND |				\
> 	 STATX_ATTR_NODUMP |				\
> -	 STATX_ATTR_ENCRYPTED				\
> +	 STATX_ATTR_ENCRYPTED |				\
> +	 STATX_ATTR_VERITY				\
> 	 )/* Attrs corresponding to FS_*_FL flags */
> 	u64		ino;
> 	dev_t		dev;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7b35e98d3c58b1..ad80a5c885d598 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -167,8 +167,8 @@ struct statx {
> #define STATX_ATTR_APPEND		0x00000020 /* [I] File is =
append-only */
> #define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to =
be dumped */
> #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires =
key to decrypt in fs */
> -
> #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount =
trigger */
> +#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity =
protected file */
>=20
>=20
> #endif /* _UAPI_LINUX_STAT_H */
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>=20


Cheers, Andreas






--Apple-Mail=_540B1263-203B-43E9-BA92-ABF36413FD90
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl251cMACgkQcqXauRfM
H+DZ+xAAhLyZsNstVnuqyPFkwbCFPUlVQ0TjfHLGBCf1GxKf+I8XJCgAQdG4VJeb
H5U3+9NMn5JZP/e0hGGGCnZtE7LpLRkQ7ja4hRS3cDS1eieU5JL7j2DYhCvAplsr
+WieKbYKUXLPByc5+fRW+VIRUkNPLl03IflKpo+746OnT0KMu/NfpViWbiVyuFyd
bRoKMEwAhyRCgAgYXHQ6Rjyl/rUAA7jnI1Coau5KB9u4NdKsDheF3l7FMiENEpKc
Za3SXo6Cq7N7KDu9E2YwD6jGPZx7uD3b0tpVIkc8D2zYgxFwwzFZmmh0P8/3hVd2
UJY8adBQ4RKGtbYfjtznKPRb9kiEWeevRCwEfwtU7W5LQ0jOi37WdfSlHeIVbvqQ
FrhGKiV9jQYG4HHu42CB0mcacmOZb0xNRjivgSJQYvNCwK1VCwWn+ATLAuONN458
9ScrS0DkbBYN1k+mcz9erwA+MjWUzR+5LHgwbZ/CUNP8rlwSLzlXGxKnD0xrUHUg
i7ttSxL9LGodPt4r+pc32rCTfVFwvm6q0yS6a8WuB8uWGltW0/ofxkBHYsAwARZx
LkZIi3v8PM5G4ZuStQB0otNLudLmJXIkfmRp7vVgr8iOUNzMTT2Y/Li9zW2n9xcR
YnghFoyhVUvxNSwhudMMN1IL47pyaCEVB9aVppsYtbheS//T5/I=
=tGAO
-----END PGP SIGNATURE-----

--Apple-Mail=_540B1263-203B-43E9-BA92-ABF36413FD90--
