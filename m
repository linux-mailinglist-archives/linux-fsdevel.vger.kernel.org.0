Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41129168F53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgBVOZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 09:25:59 -0500
Received: from smtp.bonedaddy.net ([45.33.94.42]:37686 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBVOZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 09:25:59 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 09:25:58 EST
Received: from chianamo (n58-108-121-150.per1.wa.optusnet.com.au [58.108.121.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id A518F180043;
        Sat, 22 Feb 2020 09:17:35 -0500 (EST)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1582381058;
        bh=sFZalxrzyGgpN/Td8/kt8HImdYHzCbjxAtB41PKPcDs=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=g2DTDYAAajsWyIL/efTWqJnYdhcNzemJDlTXWKbvu6E7esIf7bn0a1n8hO7xxc9QZ
         /gMWkiTWsTCij4gyyypjL/lQbtG+LUxq6bA3RLfWY/MF6qUhlOnKhvFTzPsBHiPhiu
         un/2sz0xIH2AWCf/Bf8n4lA5PLcJPjKur7lgKipzswPxfBwhJYmZ/W3U6lZwWP8eiP
         7tFZcnJPz3EMgfGGtD3PDiXN7EEJDk78k9nfGzqhouoqtLM/pu8ShLVDwNJJEK9hpD
         lQCwCVyiJQkLyOKZv6XKABIe7Vxi70mn1GzgYa8q3FMbqdDS2GENNoBiTRkaBYQERB
         mvKbu6CtJEiBg==
Message-ID: <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
Subject: Re: [PATCH 0/1] coredump: Fix null pointer dereference when
 kernel.core_pattern is "|"
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Wilk <jwilk@jwilk.net>
In-Reply-To: <20200220051015.14971-1-matthew.ruffell@canonical.com>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-NVKkbFdhyq8AeNl+7/qp"
Date:   Sat, 22 Feb 2020 22:17:14 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.34.1-4 
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-NVKkbFdhyq8AeNl+7/qp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-20 at 18:10 +1300, Matthew Ruffell wrote:

> A user was setting their kernel.core_pattern to "|" to disable coredumps

Hmm, that doesn't seem to be the right way to do that :)

> and encountered the following null pointer dereference

Thanks for forwarding that. I've bounced your mails to a few extra
folks, please include them in CC in future. Neil last touched the
coredump pipe stuff before me, Jakub reported the spaces in
core_pattern issue and Andrew merged my patch.

The patch seems like a reasonable approach but I don't have much
experience with Linux kernel internals.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-NVKkbFdhyq8AeNl+7/qp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl5RN+cACgkQMRa6Xp/6
aaOyWg//b4T0PTtUcImVqaVTd4AamfBETQG8e6Sg0dzSUWam1aubpGwPOtjVCLu9
fn0DxK44nMiksq9PO7m/9Fkg1PxgurzVvMNY7J/gO1qAH5xsZ5FJlnj5obCzTabt
dZSKmSKMMX80tMLq7HuXPHgGKQmHJofGf4Kl4pFb25KZQuP7S/z5B4q8PT2Z5875
EvJqbDUONam2EfUdLUgWTPEzfyoPy6WNajc4qjLNlG4HbRMkRaVqfdAK/R6uKjoH
gVu1yd0j+FPfez4G4q1ZEoFiIdvf0LbzV8C6gfz/f9VN1ND8kQQSWWOVhQk35eAI
umqUd1Z3/9N7/Ut16XnG7tyzAxkdFeBjrPsEbr85PX/X1/rCOnyg6uHyiovyAGrj
tbJE4ZzX9YUJ28ezsGWlviCJjfO+KmSy7M/fuEdVVOdcBrSMN8QRoO9b1W9ijRFF
URaUp077Fr+Z5wkGmuzQJUzb19XvPDa+aeeExRP1t6Wmn3urrB3+igMczTNfosYX
ejTZPYmZn4gsYsS7CDhYaXLJw8FoBIfebC0Af6ij1G0Qly5hJmJgwOHNjpborpV4
ezxssrXO55xVa40B/dIkOUvSys4hqgk4IVHMj/iSjtg1TJ1ceEReUBueiotUAQqk
tQAcdjuD6oJFOzS7d+g4XoRsC6X+crCpTzwJxppU+UJTgY4oiIs=
=klPT
-----END PGP SIGNATURE-----

--=-NVKkbFdhyq8AeNl+7/qp--

