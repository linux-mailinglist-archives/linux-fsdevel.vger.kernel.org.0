Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0381312ABF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLZLhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 06:37:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZLhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 06:37:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so23426584wrn.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UynJllCPVtrjyC65t2ZR1HY6vgG7zj7cww2RsGQVo0A=;
        b=YfZIvjIl64O0hSQ8mkH7U8UR1dp8CHhER9Ead06LK6s8vlm/q4HUYeVWalr8xmkU9X
         9su5gKxTuhkCnXRyeqwOOs7AoQuCDsdwe1s/Xg+R1szSHmbJjPjYlyW0ghFEnI+NDTyj
         86f5hNKepG/eJIaSBDTk/7EvYaQSvjC0Sc1ehZTMgQCpbeTXJB9JxxYfJI+uC28EvEXQ
         egRqS1v6e/fwwQ4HZqWCC3Wx0IS3iss05gA16x6ZmmUaj0dJOfZz6HsHwPQfQT35Swee
         T29PFAQFs+JsXJZRZlKiTmxGa65wikasvJEzid6mpFEHdX6Q1gVWECPrf2J1y5nUCnh1
         BXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UynJllCPVtrjyC65t2ZR1HY6vgG7zj7cww2RsGQVo0A=;
        b=mKROPNohgGlyV+9IYHySSGliLQOYcpCaO+iznCyrxBEWtrkH9EPitR7ZGLS88lyWvo
         F++Cnb4LrjF/T9rlCrA6XdsnGOPoEKTKx9jWsBF4+/hjXTf7eMIfLRijRNofthPYvezT
         3CGrAgvsNIMeh29c/FBXvCdUnbadO2v+do3i/Qb5hLW3negJO7YroDd8fcCL+i9hmi8O
         Y/vh4mpb+ecWKpMe/ByETMuJJt+KZpor8h5S8wHBzPgi6/tyILX/HxPz8vn8+XvGfWIR
         c91ow3zFzSYStxF+d7BGyI7YLQBoKKN4svPUvKqE5mJR3Epblzm7EhmF8OIzvfSO926p
         UZNA==
X-Gm-Message-State: APjAAAU+ewrKwjB2lqIOmRwqv0afxYr4CPxs4KueGqb3XltlVbqxI8Sl
        P8TUu6oJEQd8x2lNiDwLezwCIwkvzek=
X-Google-Smtp-Source: APXvYqwp1Q3DkJVStc6cr6IXtyFQHk31wmFUWeyLHgNM7InmBCAJAQ2DyZGl0ukHqBYYrE5wmsNRMg==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr43708980wrs.369.1577360272577;
        Thu, 26 Dec 2019 03:37:52 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r6sm30810892wrq.92.2019.12.26.03.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Dec 2019 03:37:51 -0800 (PST)
Date:   Thu, 26 Dec 2019 12:37:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: udf_count_free() and UDF discs with Metadata partition
Message-ID: <20191226113750.rcfmbs643sfnpixq@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rbl3b76yfkgufbch"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rbl3b76yfkgufbch
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

During testing of udfinfo tool (from udftools project) I found that
udfinfo's implementation for calculating free space does not work when
UDF filesystem has Metadata partition (according to OSTA UDF 2.50).

Year ago in udfinfo for calculating free space I used same algorithm as
is implemented in kernel UDF driver, function udf_count_free(). So I
suspect kernel driver could have it incorrectly implemented too, but I'm
not sure. So I'm sending this email to let you know about it.

What is the problem? UDF Metadata partition is stored directly on UDF
Physical partition and therefore free space calculation needs to be done
=66rom Physical one (same applies for Virtual partition). But Metadata
partition contains mapping table for logical <--> physical blocks, so
reading data needs to be done always from Metadata partition. Also in
UDF terminology are two different things: Partition and Partition Map.
And "partition number" is a bit misleading as sometimes it refers to
"Partition" and sometimes to "Partition Map" what are two different
things.

Calculation problem in udfinfo I fixed in this commit:
https://github.com/pali/udftools/commit/1763c9f899bdbdb68b1a44a8cb5edd51411=
07043

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rbl3b76yfkgufbch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgSbjAAKCRCL8Mk9A+RD
UqBOAJ40KEu+rza/e9ogCM0CQ9UPswTtNACfeGir+cwyCbwNXX0TlztPZuq/G10=
=jCHD
-----END PGP SIGNATURE-----

--rbl3b76yfkgufbch--
