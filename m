Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1F14FB36
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 03:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBBCQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 21:16:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40278 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBBCQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 21:16:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so4386707plp.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2020 18:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YdIQTRK4jxj79GTFYVoRuBUKuQUyOIcAPKo43gVIN98=;
        b=Zph8hywTRDdX/jA2QVuRfkYloFinE2U268oinWpVUSJsO2LU1dc0Myh3Qw00tQJqk0
         24jX+zrtFwxwy2CzVxR3Nt3gxiJfcIOeZmCqaer4qARY33y6TS843dY/9Xx2VaqhKnn9
         ChKlJk8tS4nyN7gLWpq9ljXRnBhM4UFKSzseIomzIl3q64BlbTxN98QQApqBfyMfal/7
         SRVx1RwhVV/fVtqgFA2uiSNTc4LZkZEDDuN0iE7DfRc3iz1EhKsPdnupHorQcdZyreyL
         I2aSBXt1B/No27G2r0aU2zXOSAXebXLbrFYBNhyITDps0UwDW8Jkjn3mbFiQcSjkraYR
         Kbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YdIQTRK4jxj79GTFYVoRuBUKuQUyOIcAPKo43gVIN98=;
        b=ptHMDAPwgKfqzcXioPcHKTj8q3CXiqz9OYnSWJ3JgEU9f1ergisbKoOUfwzICVrGjl
         /w6c4B3eQI+LmucSRwnTDGckvZkKRCntsolNTssLttBLgXxT61HYc7RUyQh98yrmJT7N
         ALvc8mwuFyJSfacO19BGKSG+F79vG+bLZut1VkH7Y5RqADZg5dQcKS+pAJKmtozmbH9p
         IZlnAsNGGzIfcqI30Jtajmc9PV8KlsO4974ewytQY5gm/DYPmENYHuzyXid5pSNv4JoQ
         ch/oaIPZTScgVvNy//6QWjAT8E0AUCYUrDbgPRJN+OjIz7XD02gEhNIHQfNUM4PZ+2vi
         onhQ==
X-Gm-Message-State: APjAAAV0XhJYIv5kloFe3lwNxtVlU0AGyuGVJZqLayUGdlsdZe+lzGyi
        6L4jjt2+UWLnUKAmFPZQvgiKeA==
X-Google-Smtp-Source: APXvYqw55Qq7yZ9J/1lwT7tGm+YK1IoI+i7p2G+M8jbum5GrEElhO1eaiMfzgOytepAv6Dh/WYmNBg==
X-Received: by 2002:a17:90a:5801:: with SMTP id h1mr8686190pji.121.1580609792715;
        Sat, 01 Feb 2020 18:16:32 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id p5sm15114181pga.69.2020.02.01.18.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Feb 2020 18:16:31 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F933761F-D748-4FD9-9FC3-2C52D7CA205D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E26B7161-ABF9-47FF-AD20-30D089BD5809";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: About read-only feature EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS
Date:   Sat, 1 Feb 2020 19:16:27 -0700
In-Reply-To: <4697ab8d-f9cf-07cc-0ce9-db92e9381492@gmx.com>
Cc:     linux-ext4@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <4697ab8d-f9cf-07cc-0ce9-db92e9381492@gmx.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_E26B7161-ABF9-47FF-AD20-30D089BD5809
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 1, 2020, at 7:02 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
> Hi ext4 guys,
> 
> Recently I found an image from android (vendor.img) has this RO feature
> set, but kernel doesn't support it, thus no easy way to modify it.
> (Although I can just modify the underlying block for my purpose, it's
> just one line change, I still want a more elegant way).
> 
> Thus it can only be mounted RO. So far so good, as from its name, it's
> kinda of deduped (BTW, both XFS and Btrfs supports RW mount for
> reflinked/deduped fs).
> 
> But the problem is, how to create such image?
> 
> Man page of mke2fs has no mention of such thing at all, and obviously
> for whoever comes up with such "brilliant" way to block users from
> modifying things, the "-E unshare_blocks" will just make the image too
> large for the device.
> 
> Or we must go the Android rabbit hole to find an exotic tool to modify
> even one line of a config file?

I believe that this feature was only implemented inside Google.

However, if you want to make changes to some files in this filesystem
there should be a number of ways to do it:
- use "dd" to dump file block(s) from image, edit them, then write back.
  use "debugfs -c -R 'stat /path/to/file' vendor.img" for block addresses
- use debugfs to clear the flag, mount the filesystem normally, then
  overwrite the file *in place* (using "dd" or similar) so that the
  blocks for the shared file are not reallocated due to unlink, write
- make a simple patch for the kernel to "support" this feature, then
  mount it and modify the file in a similar manner

Cheers, Andreas






--Apple-Mail=_E26B7161-ABF9-47FF-AD20-30D089BD5809
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl42MPsACgkQcqXauRfM
H+Bwkw/+N0E88yxZRmHucLUPVYX9cEAZV0z1KbPwbwD6JcLV/fdFqBW5gYwpjDSs
Cn7BAOM04sbt6y7Yn61S6DOTxRMlQ5oPuI7qObhS8s6gK5eWTRDhqhlFcKnQk60N
WcUFXvuu1bW6A9GrrDwW15ebbVopNk3Y+E3uVD+KWTGMw6A1UyEIbGIngQDh0kAo
9JYr7wSN3Z+UhyQoEhZOUAP47uRJvgRwHAyNbET+xaBkgURBNZfs8LDliBJ7QuOC
ANED2jUzYSywCjtKslHYwNBZUhfoOJa2zl8qRM4hbj7HuEvVSzodAM/b7csVwqKe
sGxU6E8tNO5oBQXzGQfMqAuZM5tcCndS6eT0P1zIj7vEQe0FaZ3ptXmomG0m+/rs
V5UrTgQa8VAHs608lzJusKrr0DiPV64IitrmnoQmN1AKNMxbz4BshpNk198k5SsB
q9qsqbYI3mgESSb54E6Aa8MgWBYL/vmHsEbpSwRrkXyEEl6P5dDcbeqByngdSisk
GzhSiCvK81Qjx/ASmMiwQEtufis/msbIpE1e/TiIKA9g0mN4U0q3Z+p1PVJiP0H1
2xof0BSr2VAngylBO/H3iYuhy2KdH9r8qWYlXVn7Sbx5My7UKMbwuJnBhJDweUxr
Lf2jE2qg7WJtX7ii8JpvMDPIdTNu66OU8U/Kq2CLrh75cOLk01A=
=iNtk
-----END PGP SIGNATURE-----

--Apple-Mail=_E26B7161-ABF9-47FF-AD20-30D089BD5809--
