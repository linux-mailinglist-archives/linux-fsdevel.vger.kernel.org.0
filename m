Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED20D9F45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 00:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437611AbfJPVxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 17:53:54 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35902 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389855AbfJPVxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:53 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9GLrp6k014106
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 17:53:51 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9GLrkWi007501
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 17:53:51 -0400
Received: by mail-qk1-f197.google.com with SMTP id y189so76999qkb.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 14:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=gqUpgmdxzpasd7pMU+uxnneMl1+ktu9g6I4Qah8EhxI=;
        b=gTP7aWJFBqTpskzWSMNZ+IZBfwTC6D+PQzXjinpdFXAqzXsygePAG9AN18J4VK0vzZ
         +Qyqm+wsZECKBNBxOIKSmp5B6Es1sifZKaHyA9hSGNiU0pehBn9WcYuGWu3pleBuV98d
         O2kTRC1TQK4fetk4MhFSqgTdaGVZ5EVmDDgSBm32rh35n0DkeWXyDMXVmoy+tr8xRNPN
         y2ZIIhYhSDSvjD7Bt80xHvCvflh3QbNHadiZN6qW/wr49ZRQzRo5avzR/UfkZRcjSnuq
         YNQaNQcCc5HVpeswnlDC6uYS42RZy29WAiB/6MBsq5NGcs9AwXWZ2zrO8Ebv3VNFFKXw
         of/w==
X-Gm-Message-State: APjAAAXrov8Mpd8Eh8mYThlsYQMGJ+JDAuamgR61JchQKaNw2BM4vtgD
        sWlS0P6f5JFn0Z14IPbvHz8ep5y1zmMw0jzI51QjC+uPVrmpVVCV2TPl0dgJSmE+9eWhhmb2G38
        deeKasDFdg+9vQIPGDRf42kw/+B3oxh/0s6YN
X-Received: by 2002:ac8:24d4:: with SMTP id t20mr347279qtt.114.1571262826691;
        Wed, 16 Oct 2019 14:53:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpCWG1Ma5xOzqYk3ZIkraUe0CS6rlGbWN/U3tPDHeSWZQKr532KeiINo5Te24b9bVE4E5nZA==
X-Received: by 2002:ac8:24d4:: with SMTP id t20mr347249qtt.114.1571262826283;
        Wed, 16 Oct 2019 14:53:46 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::9ca])
        by smtp.gmail.com with ESMTPSA id a9sm79794qkb.94.2019.10.16.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:53:44 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20191016203317.GU31224@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190829205631.uhz6jdboneej3j3c@pali> <184209.1567120696@turing-police> <20190829233506.GT5281@sasha-vm> <20190830075647.wvhrx4asnkrfkkwk@pali> <20191016140353.4hrncxa5wkx47oau@pali> <20191016143113.GS31224@sasha-vm> <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571262823_33600P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Oct 2019 17:53:43 -0400
Message-ID: <207853.1571262823@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1571262823_33600P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2019 16:33:17 -0400, Sasha Levin said:

> It looks like the reason this wasn't made public along with the exFAT
> spec is that TexFAT is pretty much dead - it's old, there are no users
> we are aware of, and digging it out of it's grave to make it public is
> actually quite the headache.

Ahh.. For some reason I had convinced myself that base exfat implementati=
ons
used at least the 'keep a backup FAT' part of TexFAT, because on a teraby=
te
external USB drive, losing the FAT would be painful.  But if Windows 10 d=
oesn't
do that either, then it's no great sin for Linux to not do it (and may ca=
use
problems if Linux says =22currently using FAT 2=22, and the disk is next =
used on a
Windows 10 box that only looks at FAT 1....)


--==_Exmh_1571262823_33600P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXaeRZgdmEQWDXROgAQJPCA//crwtbuFdEHDJcuk9rjqzuC30MRUzo20V
1S7m1bIEl21fh/qg/JhUagKwHZxImRyN3u5Jy+J5iiq3zpQzAIGxRhqYX3e+6ykB
b+/DlAUjv0S8YNpqDpqsYaafnCOsc0omfbYNPfxFGZWOyJWdsP+II3DsxUGTKyui
TaQXR9s0ErjATdZ0kWr72Ap5HcrQ4ixI+poANMobYyq/k9Pjw50oyGCvJR2ErZSw
B9Sm246KwHBFzwSDXrxbLggNx5+uE0B7/nvMPYzSrBBeqmvDxTcOSAygfwQSK0UT
FvLmHIJiGkYHpFIY7zwa0Fs55nexKj4Rz+Uy8e05aohAOBGOTV9QxkcCSJhIf/Zw
h9KZ2tyMcsXsDOh/0lGR8DCGxCE6sqo3KK7kuxPnAzNTbh9wli98tX3sQacr0E4D
HhUYTGfeOaP12qa3ije8SZRo1yqdxs3KIyQtRhNWWZaIYL84BtFo8G4d1RSts/AH
t+rkhtsmEytHdFY32qYMkD2NSCU3FOaM90Zz/zWBr5rMIhiw1WIySVH6P1ZOr1U6
C1+TtuMeV9g1SS80ik35GX4h5wYeEWXr/vrBD8mw2HSfj78lin2d0aLAxnaHEc+H
wmfB72ECZ9Mq6SKblhcvRqhpNBHsX7WiLj1hVE8HSxufaEfT0A3Iz1Y8+oQKbX7I
8etTqEg46ZI=
=oSaw
-----END PGP SIGNATURE-----

--==_Exmh_1571262823_33600P--
