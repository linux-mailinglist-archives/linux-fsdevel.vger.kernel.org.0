Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C21510BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355638AbiDZWKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiDZWKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:10:38 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A878B1ED;
        Tue, 26 Apr 2022 15:07:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4527C3200915;
        Tue, 26 Apr 2022 18:07:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 18:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651010848; x=
        1651097248; bh=h/r6mqxxO8CGeQeYBV/T4XnCBd2vSsImhikCpYpQ254=; b=c
        YypQLUUfXsYTcz6o9Udfvm/qe4Nn05wll+0A9csMAwVxo5xt5QqjdB2b/Yyk2Fk+
        Mc7ucKXKs6E5zgYWzoB8a1nmh+gaxiKEY/Klg16WJhYhywT21yqVPlGHsjbGELRG
        JjiW8Fi1k0j4a2ZzqoqJV8woNGBN5zsNRIT6dxYL2vWa2qexUKgFVALrjX19ZmSu
        t7uAmMNjd/bCaj2Ud0qwNTFQ858HYN1B6Cd0EbLwVCJZ5eAbvYuTzy8U/cPx4hjq
        PilLVmkX159bl+ymxiiaX4Hs568cx4ien2ChSqisNJKE2wTX8RNydahQYNq+ioan
        Whi8WLkHjfL0Eva1wThKw==
X-ME-Sender: <xms:IG1oYr7tB8X8VHhQuCPIXTSQrW4HoVCxRaEvWBSeTbkxzki_r7MWaQ>
    <xme:IG1oYg4KFzuLj8oX-3JY1Jr2l0_mrmlM9OZMjhOMcpe57a8cqZwkopdVwfwpej-Kp
    gEEr-e4So-C1Ls>
X-ME-Received: <xmr:IG1oYic0IDxNLyD9uJInZA3hErzMmV6HarUcakAZN3M698HufI0X8UeN394g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffejgeej
    geffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:IG1oYsKqaLNox9Y-AHjoTTSkZukzU6K7fXD056oTXSeUTBzqdvEtkg>
    <xmx:IG1oYvLEFlCZNOmbEZ8HsGppfUPV-cla42PV7--2CKVRyuFM2mCHLw>
    <xmx:IG1oYlzjoXoZ88OXBvqk8D8U5I0MP9RVRY_x-RF-SC8y3FKGnvcyqg>
    <xmx:IG1oYmW-BvkYDvyZ2GpVU072mNFcO1fFD0LZ9FUIw7rdUflJ4xn81w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 18:07:28 -0400 (EDT)
Date:   Tue, 26 Apr 2022 18:07:26 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lennart Poettering <lennart@poettering.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening
Message-ID: <YmhtHgaJaw0wfzY6@itl-email>
References: <Ymg2HIc8NGraPNbM@itl-email>
 <Ymg7dihxLG923vs3@kroah.com>
 <YmhktF/9DyEQpatZ@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gTBYkXogsP2+mBjf"
Content-Disposition: inline
In-Reply-To: <YmhktF/9DyEQpatZ@itl-email>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gTBYkXogsP2+mBjf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2022 18:07:26 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lennart Poettering <lennart@poettering.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Mailing List <linux-block@vger.kernel.org>,
	Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening

Also bringing in Lennart Poettering.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--gTBYkXogsP2+mBjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJobR4ACgkQsoi1X/+c
IsE22g//eP5BToabrRG6R01WwqEnt6LQZHk9en1xjSGr6X5hiKJ1Sc+/r3bbF3VN
WElHab/etgpidX48krogtoNasrk3ck/SKFes/GIQTnLcWdBJ6Syhnb94jMOgNbFk
qkVyrKNvKX9XtNhgq5PolVXV+VUuT6PEz0LmPvZKdEKwpjS0kEL+jIDUxdYRMRdm
icbIbHx769PQiOyEyOYuq8ZxGRsN0TVuUJtNwlBxD6dlYGSAkA4KIujfe5ntN5gA
DOgXJqd9cwyEpi7hTWvyZcQmeJnMwZWbuFuYnwSIlvLuLTPvlEdr3K37SoziBlky
+3l71tzU3EJwQfMsfBBgPqj60cAEv8WZWubTyG7gjx+xZa+aJvcrY4+3tyH1Yapk
5dVBcY53DYM1Lo7tOySfUUTuq7byfo0Bx9ZwyksWptcSg/v9C4NqIFJcSzdOixPA
HXcnnyQ+zK4ikGRvFC9t89sbXpK5j7koC7PAQ844bdkRMKkodOk0EyMCfPOVrBz9
1Yxy8yqrLa6SaDf0M5oY3W3Aghzmw2cGDqXCtIB317ewBOKuuCbf5z/dUyKP62Bt
7SrZTRy97ZBAfMrTLPHrEyDe+SzG1Yg3hf/pAo9A1ZAw91I1WMB0yDo/Zi96omRH
MHhZ+bgTu8oNVxOVFLmYsOW11MIsTcxQnPmbljm3Sg6YOd1mvgE=
=8Wnx
-----END PGP SIGNATURE-----

--gTBYkXogsP2+mBjf--
