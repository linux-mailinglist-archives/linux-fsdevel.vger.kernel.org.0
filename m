Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F9FB80F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 19:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfKMSsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 13:48:30 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:40576 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727607AbfKMSsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:48:30 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xADImSbB005533
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 13:48:28 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xADImNmk011763
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 13:48:28 -0500
Received: by mail-qt1-f199.google.com with SMTP id j18so2073804qtp.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 10:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Fo4fEZjebs1UemMYCiGaOExD0sFqQ4EojFlLMcKIhuc=;
        b=Roye/DlbgzjBxiH80BZ58qlteaLYaeDriOTG8bqM2BDYK8ArANd2vvJyp4FquaZ7LO
         qfMRBQPsyTFzChMwCTwh9FXxcv4pIFPUSPIwz55OYk9ravPcEwr8h7SzkFPYICMcXj3N
         B1Y1GeVLedWUKzyyJ//dBBafQsjL5XdXtGhn6lF0HMkp0F8gMzin86ntEL9ILYZFVQFY
         tuSGCeh9SY2OveKaBQw+RnGm7cHyccO9HAOSkgfjNcj9n7jpoi4Rb5haQYE1gqnsybbs
         2mD8Mx0zQoyX3vRBc7BPacTyxy2Oj4i9lJWzrDgxW6RPVPczqHKHRI8ru3uV+3igFDwU
         EaLw==
X-Gm-Message-State: APjAAAXVnGM6P2GfGCK7Jwj9InTd3dNJM3zLVHdQBtqaMYzriAY49tSS
        CVuiaTxlXaMsCrixPmyzF1TWW6sTTbiLc6DS08IgRko6WA5gHSjbo2lVyoHgdeVxJdaQjGO+JUQ
        zaJYqELNBYq/fyxm2MfmOrkIXGO68uAuutI+A
X-Received: by 2002:a37:c40a:: with SMTP id d10mr3876430qki.126.1573670903314;
        Wed, 13 Nov 2019 10:48:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZyh3b02hf6ZQ5jDLWJPKaioEx6Et1AVdxUCjjrElpChyEZAr5poVO19WsI1sCXDYpXO7E8w==
X-Received: by 2002:a37:c40a:: with SMTP id d10mr3876412qki.126.1573670902961;
        Wed, 13 Nov 2019 10:48:22 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x39sm1788053qth.92.2019.11.13.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:48:21 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        linkinjeon@gmail.com
Subject: Re: [PATCH 00/13] add the latest exfat driver
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
References: <CGME20191113082216epcas1p2e712c23c9524e04be624ccc822b59bf0@epcas1p2.samsung.com>
 <20191113081800.7672-1-namjae.jeon@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1573670900_10801P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 13:48:20 -0500
Message-ID: <286809.1573670900@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1573670900_10801P
Content-Type: text/plain; charset=us-ascii

On Wed, 13 Nov 2019 03:17:47 -0500, Namjae Jeon said:
> This adds the latest Samsung exfat driver to fs/exfat. This is an
> implementation of the Microsoft exFAT specification. Previous versions
> of this shipped with millions of Android phones, an a random previous
> snaphot has been merged in drivers/staging/.
>
> Compared to the sdfat driver shipped on the phones the following changes
> have been made:
>
>  - the support for vfat has been removed as that is already supported
>    by fs/fat
>  - driver has been renamed to exfat
>  - the code has been refactored and clean up to fully integrate into
>    the upstream Linux version and follow the Linux coding style
>  - metadata operations like create, lookup and readdir have been further
>    optimized
>  - various major and minor bugs have been fixed
>
> We plan to treat this version as the future upstream for the code base
> once merged, and all new features and bug fixes will go upstream first.

For the record, I'm totally OK with this and glad to see more up-to-date code
than the codebase I was working from.

--==_Exmh_1573670900_10801P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcxP8wdmEQWDXROgAQIzfRAArTNRIzzMJEFimFdo3I3pwBAyCZYffO3D
1gyYXolrSmLn/8QhOzrtDQKIM/ZMTIps1PGNQlH3WeLDxvlojnq0QXb0mu1QHdbW
WQDF0hnAZKOzRNVdkafXlflXrFZN8gB+/YKRYn20xOjOVh4TQdVutKT6PvKvQPnf
Uskad/slaxp70rpnqswpi+qr6ukKtU6TEfE5mW+OKhZ/PsH76DK9ihUfC3AsGK3V
T1v2JYkxElw4WX75j7wNocz9opuDGJn273MkmrtWhI2egn3/kMASgAwZmUOLmueG
WkHKYYNHmyY78f+IcYj1IffC4Db/8nmmue/4OSUaEGq9qXL1AVbZ4T39rqv9qtaD
3c3BF6XLMctNTzMXNe6QIa+0UyMhEGv2fksmI5H0JL98YMcyKuzc7TcRadNzwCQu
7o/5NwwGyf6d30VxrzPPx9b1bOlFOh+28m28r56nFxvgV+mQyLf7PG7Enpmbz85l
tkH/KbzrjbQ4JAmItrY0bCkDKaiFgcDBnW/Ao7QEgSPtrVTCpXuCzyXwQqtO2VVY
Uw1FZn7j0FWrpdTynKCTm5DQX9g/PyS1uMAawoSK7chVNsk3+H/e4s4hiIT9vFb7
Oapyot3eKZcYXhRH5tcj5DzAx3iA0vmNpjHhBmzcHpMqBxcWN5hJ/MpaOwvaFq8e
FB2ihtmGWwY=
=1doZ
-----END PGP SIGNATURE-----

--==_Exmh_1573670900_10801P--
