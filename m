Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EBE18534C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgCNA2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:28:18 -0400
Received: from smtp.bonedaddy.net ([45.33.94.42]:51950 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNA2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:28:18 -0400
Received: from chianamo (n58-108-121-150.per1.wa.optusnet.com.au [58.108.121.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id 11C5D180041;
        Fri, 13 Mar 2020 20:28:39 -0400 (EDT)
Authentication-Results: smtp.bonedaddy.net; dmarc=fail (p=none dis=none) header.from=bonedaddy.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonedaddy.net;
        s=mail; t=1584145722;
        bh=Van/qq/UEi1MHg1iu9xFROdDFHfNv7eGJfIR+wXt32A=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date;
        b=V9jN3B8TfFigALFcgqQcr/mNNnZBcMT3WtDwqXBdtMRQMdP79czio7WwEWJUut6DM
         UGEqXYJigPO6abienhmS9UdDmXcVXKnI7GZ3fQ6ZT7b6p029cKNXZE+HiI6hNqj1RI
         fKSynT0kpD+h71HAJqdvCbuLsNGihJ4SIAisj5fxmydy62jCRrPHDsX7n1RnRuZyTB
         04ZcUXPmnnrnI4x8z5vtp1RDGCcFB+q3aKR5YqR7pBRCzUXz2ft9ESU0drPzAlbbDz
         nl8qguR3UnJlW2o1aMKlqVDBJVazQAOrK0H0tzdBhA11PCFpY4GumKD2yAvV0CtlWb
         /FW4tdazjtdOA==
Message-ID: <fa636317af3a38badff322ca11e437701154b1be.camel@bonedaddy.net>
Subject: Re: [PATCH 0/1] coredump: Fix null pointer dereference when
 kernel.core_pattern is "|"
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Wilk <jwilk@jwilk.net>
In-Reply-To: <87a47997-3cde-bc86-423b-6154849183e9@canonical.com>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
         <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
         <87a47997-3cde-bc86-423b-6154849183e9@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-wjM/VlUgqSfA/5jsqClr"
Date:   Sat, 14 Mar 2020 08:28:10 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.34.1-4 
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-wjM/VlUgqSfA/5jsqClr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-03-10 at 11:34 +1300, Matthew Ruffell wrote:

> Can I please get some feedback on this patch? Would be good to clear
> up the null pointer dereference.

I had a thought about it, instead of using strlen, what about checking
that the first item in the array is NUL or not? In the normal case this
should be faster than strlen.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-wjM/VlUgqSfA/5jsqClr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl5sJRcACgkQMRa6Xp/6
aaOUCQ/9HWhAyOFpANVuKcuFZJ8krfZikVbHQzgXUc3lFnW+vWPuHfBlPtk0tsNR
L8zxu1mmjaD87+bp6HWGi2diWJokQLf0EnfY3qhOF3q9GC7Dp5wgMznt7/oxbNCU
PubopAaER5HYpgTdJrsQNskeKNxKUpynnyR3y7nJpbbslxFXUnNM2VlDYa/YIUN2
Zz8CVPzqZnMwlU9PquwZYqutX+h2P++yv+67U0dlTDxmr+L/QAhuKF33szHEYa2L
3HSoVj+Uu0CsIfkq6xijztcnWkrbotsBugEtHO/3P/2LMoj7zDAWD80RG0YZ/Pzd
uP3fS88gmTSynr5CKrcdhdCSh2v8FnidwhFX2VWurvb2eSWqnx5l6nW1KqIvYCTd
TnscH9UZXPk9l84UTRMIxiKKTJVfqeZT1+1mlT4KFHSiOQ2jECvUiO2jKHr/3A1a
kiNEVzGAY68G7c3uwTVOe77NEp32O02Nw3VY0e/F4l6GGvRP+/GaZNiCbhs36UTs
wxMzv+cu0g9BigoiEh8RlgG7+OxUDqPl1f1RefOPRcz102ZX0r3n7yAR7zI26Qv4
cz0NG1nQtfVrMFy7bnB+s1Vvt8K/qlMljK2eto9Op9mFC4q7ehjTY+3qlZS+uDj5
CyWWwjuQD77Oh9zPviEIpZQ8cPweBlBeu5UDZvLiG0+/Qc8W34w=
=J9Qs
-----END PGP SIGNATURE-----

--=-wjM/VlUgqSfA/5jsqClr--

