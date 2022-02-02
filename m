Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA044A70E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 13:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbiBBMi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 07:38:29 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38323 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231748AbiBBMi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:38:29 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id AD506580255;
        Wed,  2 Feb 2022 07:38:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 07:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=TI6TXWscOT8zoXJHYAzpfg+zf/n6iD
        eklYvo47/89uQ=; b=NSuTjVrtEuFkF9P1RQXHIoM9kjTSQZdfZgSzzltnEhfykL
        3hDgc/CvT9TAFZwEAcTMo19o8xUhTrvEp7fyq5/dai4pkgheXKl5wtSTiTuSrlu0
        Oc+X0+9Nid+CLCWGqgpu0BEu2bVyGckvyRZg5403BS1NzFSfvfxDNTtC62CbazEB
        XdBG7SWzYN934CO2/RtevYk79zKwsCII80O/ip5RrpFkORJJs4XVtlG2cckSZQGB
        SjaYds5WYCLoX5lZ8AIeUYd5a/+YyrDZzBF1GbUNwQy1mZd+XGNZ4GZQBqJhDIpX
        Cuum6RHdHBxgL5OX4rhURLhw41E7RJ1OWIhtBApQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TI6TXWscOT8zoXJHY
        Azpfg+zf/n6iDeklYvo47/89uQ=; b=kkgR0M9m6xohXUUZX4sHhzZo1LDKxfehY
        4oyiLTc2ypl7uNrBi/lk0DGr9+Sk8//KkVMyRTXtRV+lMyY872xAzGHFFmkYWtL8
        Ms5/EoNbK2z7XZanj9djjoPF4JK3V7tKglyM/N6uEzFGbgpD/3GZbCCpGhAKTMzW
        ggnHq9W1U5rNZpd7PA3mdvkNJJ06mepNGKyuFhW88XeyetFaSLJ140jiCfFb+F4U
        Ge70aP5G+T1uLKiMVgL4+SFvBFlZKWDCacm3JDkeMIsqmoaULn0+wd3ZoJyTdW7q
        mWdV3ftBE6p6GhFiz5vb0jaKLsTXhflbYXOq80jNcvR3CyRy/ei5A==
X-ME-Sender: <xms:Qnv6YThkxq6g0NSoo7yRdSioGALXe38JJ7Q9ZqduRkYmx6uRvx-KiQ>
    <xme:Qnv6YQAYGeSvA8tNDLsfyNoT75PGKyoKFpIi9xh5RVdeWg49OveDxTrjtkIk6Lknz
    uX6BvwBtQ-KYJ0QDMI>
X-ME-Received: <xmr:Qnv6YTGQn8H-sR-GlYK51ChR39WV9vx2shDM2XR4bM3nMceoa9jDw-cI-G69H3mdTXrQQ5buPqeKTVydPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
    lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
    hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
    esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Qnv6YQTXi3yZ2hTKcURW_XPzTDaok_tT-TkL58MjdJj6LGgqJEguqg>
    <xmx:Qnv6YQzpq5YXl85avgPHhMt_rY23Ulf7N6T0is6pHr_A-BdwVLQg7g>
    <xmx:Qnv6YW6eiVpTE7mkTcW7zW4upxNAAxwCirxV3oICVUC6FAuPOYX2bQ>
    <xmx:RHv6YcHCYCRhDZYsCHv0PYUEMnutoRthAMP4L8jgDyTRkUxjlnTSXg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 07:38:23 -0500 (EST)
Date:   Wed, 2 Feb 2022 13:38:21 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <Yfp7Pfzh/ZFViiX+@apples>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="biJ/6P2G5BMLSrxz"
Content-Disposition: inline
In-Reply-To: <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--biJ/6P2G5BMLSrxz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb  2 08:00, Chaitanya Kulkarni wrote:
> Mikulas,
>=20
> On 2/1/22 10:33 AM, Mikulas Patocka wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > This patch adds a new driver "nvme-debug". It uses memory as a backing
> > store and it is used to test the copy offload functionality.
> >=20
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >=20
>=20
>=20
> NVMe Controller specific memory backed features needs to go into
> QEMU which are targeted for testing and debugging, just like what
> we have done for NVMe ZNS QEMU support and not in kernel.
>=20
> I don't see any special reason to make copy offload an exception.
>=20

FWIW the emulated nvme device in QEMU already supports the Copy command.

--biJ/6P2G5BMLSrxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmH6ezYACgkQTeGvMW1P
DelzXwgAgnSeMxSCsGMKZO6Usm9hGbg0gntCPBhyXiv5no4XiYSDSdW+BuiEHxSB
rwMYnKqzBYrREbT0L3q5lXXNZZJpS0PDk8VJVLXdb4CWG2MZXMRTviWtuN3aKJJi
xlqvrgA4PUXAqJwA6X/CzCmO2cuD/uGTIz08Y/Z8Tp4+kBEqpAUD0awnSRhRaGZd
OtcAXe6BKjzB3iZXqAYXL4XKAn+apQIWh9dKPsc20hbg0TGcDvLISWTAqBm6CkSt
KzaOTnnYmPXEFds7v/4OD3sHhO7yd+zmIvv8l3zitGCveRgZVu2D/nFVszms0s2r
lmvaVEUbaIVS7rRqcTlG0ROMYT80wQ==
=T0BG
-----END PGP SIGNATURE-----

--biJ/6P2G5BMLSrxz--
