Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD351065C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiDZSP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243018AbiDZSP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:15:58 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CFC6C95A;
        Tue, 26 Apr 2022 11:12:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 412CF3200921;
        Tue, 26 Apr 2022 14:12:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Apr 2022 14:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650996766; x=1651083166; bh=FoXxjU8nj5OyQ
        ZTDi0+cMPk2c57q/JulhiAlrYHMtqQ=; b=YtrIn+InMSf7ZfLfQIXqVvCmz99l2
        dAEx9S7XdopkNOpWJWx9XzZL0OpCM+/qkZqDjL3ixzkMsajbUC1LHXq17UK6kDDg
        D3uPGyTi/9xDZEh7Vu2ZLf4KUaJ56fLcEZORQl0dtWsSZHF+HNvVFnHjXF+mNd9Z
        /JNQPbsWhJrDJ3VlhmMrtgLYOf5gFqOzEOH+IxtOTXoGBGzY1HSkbv1rz9Jo2oay
        OOt2Y6HfgHPfcvgpFGS5qC9K0L16RgTGcJDQ6WDCRPdKSH9E1me5nCycIhYrdoCa
        yR5vOBuv3/w+e2BKMgKs945yCOPLy/sCHE+YWPU8flc/WWTwbKFuUKGBg==
X-ME-Sender: <xms:HjZoYj4VK49vIvGJsPZ65a_62cWDHcs9m9VdvdPivudcE0dCzUDV0w>
    <xme:HjZoYo7bi0t2_WITtT65QUucC0J8PxuGIpQqCPAEnkZqgCYt4W4BdI85UzprNXi7G
    nmGNyeRFVXt8rQ>
X-ME-Received: <xmr:HjZoYqdnFlQwQp5vwMolQubfcGXF2HqKMIuXIeQY-CukMnJ5xBF3bERdyaWW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtjeenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepueevleffkeefueelieeuveehfeeigfff
    gefgudeiueejveevheffgfdthfeijefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:HjZoYkKYgZODmpoYPL1FpToobZ-fD6JK236k2PsR2gU9gZIlPfNB1A>
    <xmx:HjZoYnLkFBKwRsM7-4unnKssZSjqXwkbuoUOEZQPVt2NNRe9wYCa3Q>
    <xmx:HjZoYtxMIm7KLVFtos1PrwaISxGpcwdLX2AFN-EGoULXczDj2pbsCA>
    <xmx:HjZoYtipJpzYO0rbcrbGPzu1A1DPN-gZQaqaQguSt2egPvE1A1xaZg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 14:12:46 -0400 (EDT)
Date:   Tue, 26 Apr 2022 14:12:22 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Race-free block device opening
Message-ID: <Ymg2HIc8NGraPNbM@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ay6JliYvyxonDHXL"
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Ay6JliYvyxonDHXL
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2022 14:12:22 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Mailing List <linux-block@vger.kernel.org>,
	Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Race-free block device opening

Right now, opening block devices in a race-free way is incredibly hard.
The only reasonable approach I know of is sd_device_new_from_path() +
sd_device_open(), and is only available in systemd git main.  It also
requires waiting on systemd-udev to have processed udev rules, which can
be a bottleneck.  There are better approaches in various special cases,
such as using device-mapper ioctls to check that the device one has
opened still has the name and/or UUID one expects.  However, none of
them works for a plain call to open(2).

A much better approach would be for udev to point its symlinks at
"/dev/disk/by-diskseq/$DISKSEQ" for non-partition disk devices, or at
"/dev/disk/by-diskseq/${DISKSEQ}p${PARTITION}" for partitions.  A
filesystem would then be mounted at "/dev/disk/by-diskseq" that provides
for race-free opening of these paths.  This could be implemented in
userspace using FUSE, either with difficulty using the current kernel
API, or easily and efficiently using a new kernel API for opening a
block device by diskseq + partition.  However, I think this should be
handled by the Linux kernel itself.

What would be necessary to get this into the kernel?  I would like to
implement this, but I don=E2=80=99t have the time to do so anytime soon.  Is
anyone else interested in taking this on?  I suspect the kernel code
needed to implement this would be quite a bit smaller than the FUSE
implementation.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--Ay6JliYvyxonDHXL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJoNhsACgkQsoi1X/+c
IsFsBhAAxFDevKdVqxQVy7pmHR3w9W+Mtd8P8n7g9gfgJMzABZFPhByB8WVofZ+6
BaCJbpVQ4YSPW0izihmc0TB8mLrXt5/mojCwsJSprpjJANy5GVYJ1s2HVa+rWN2u
6gj0ozaPlLXk8iCHy8PLZ/b/4egr/6T+Jh1ASPLyyFmqZF9SEBnJQNVhl9HRbLxs
LC4Y6+IKWcG7S/V6V9uHE7lR1VoBLEzMai/a9CJRnxicRvILUNeYzB+NsR0cvSLv
v0VTlmkge9Kmgxsyt21nGSlTak3rjUmoHO0QRRRDVYyIlVrNbFY8/Z+OGEtlIOKi
2JRIkiYI1uJRsNAh4AZtX8Slygwpys9UC8Un3uPCE6nOCEUL1qyS3NFjGqnhPtRA
wESfa/AAPoBXTwR8oRqSQNccfpmcw2WP4qP9Bu7EWT0pE7hJh3Sn/19ertOjB8P1
HF/MCSEt43UY/Wa00Fs7dtrnRfSEX27+jAFC31Arvd19xjdV1J6C+KUsl8Gor906
0dsC0aQj4PMhKBP5eWlw0I2q9QszVRoxKp49a8STKvYQL27Kkkzhqv9k+qsGnoho
BidUJBjQwcMPGQ7La32I/CQTn+57JGSNRqSU+dNQONDDulfoNLcxGD+U8mjGVk3l
lmgL43ksh+9ZpkTXspByeHrvOuOSh8fTGflhZjyhp7xO5jjMy/A=
=OUC7
-----END PGP SIGNATURE-----

--Ay6JliYvyxonDHXL--
