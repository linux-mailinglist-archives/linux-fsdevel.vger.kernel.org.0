Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24309510B5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 23:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355537AbiDZVfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 17:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350389AbiDZVe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:34:58 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE925E97;
        Tue, 26 Apr 2022 14:31:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BBFD6320077A;
        Tue, 26 Apr 2022 17:31:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Apr 2022 17:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651008694; x=
        1651095094; bh=rl/NHP2oD4sp6ECi7EVTmE2rgidwcQ/cFlzC5k4PUI0=; b=D
        WGe05FdH3TEhdm3F1IlrcpFen3yIGk4WAc5suW3U3R29Is0pyTtp//+EMs/rv6y2
        E6Ng0xzJeWkQ9YNq0hGcXbwOUmAupjvyneOE4m0DA0Eyhs1GkXNejJyHDXh2hFtN
        qjGrPaOAwGkk/1ThBadlczVmElrkMqlQs/qFfSq0pOp7lzebdCMee5sRRfNulnxT
        fCxQ2hfEUS1yVE3NjF5HmHNQ0Js1gU2komgLiRIOStGPjm0anl9SC+U8U3581XG6
        h9Y7tNkzCf5TKDWiY2alut8CXSZIJJ2vvrNHN2mPRN2+/Ub/MzR3t68QlkM+Vz9u
        MaD3Hv+5hiKOQrIqhMj1A==
X-ME-Sender: <xms:tmRoYrGAvdV7qFmljuEnyy7iijVyU9N1jHUAgWlabcUPbP7iwzPpdQ>
    <xme:tmRoYoXtcKzooBu2A7X3ZPicWnzTUA6PAIiHW49fFLyq0DMJ5VV81ek6_SiH4an0f
    -aNELS4Ex95uWg>
X-ME-Received: <xmr:tmRoYtL3diVhdKSOGVCb-taDrPK-a9uMdTqhRhsI4vw1vp-z1cR9cHlbo9_l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:tmRoYpGcyazOcCDTPsBAoYmkBpM22mkAMTWaFJsJ9CvvRCdI0d1btQ>
    <xmx:tmRoYhW0cQQCA85S9r00RmwebVwzm7kREQcxb1z7zgPbLERHoK2YZQ>
    <xmx:tmRoYkMnd8azwnhRLn1Kr6uUVYGSCZjZtb0TKVteINPxPqAhnI9zuw>
    <xmx:tmRoYgdJh0mKddpKIkvp9x1h4AYIo0OQKNmc1p7wqiDHcuAH0v5lcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Apr 2022 17:31:33 -0400 (EDT)
Date:   Tue, 26 Apr 2022 17:31:29 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening
Message-ID: <YmhktF/9DyEQpatZ@itl-email>
References: <Ymg2HIc8NGraPNbM@itl-email>
 <Ymg7dihxLG923vs3@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="39PzE90C3ycWfUxS"
Content-Disposition: inline
In-Reply-To: <Ymg7dihxLG923vs3@kroah.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--39PzE90C3ycWfUxS
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2022 17:31:29 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Mailing List <linux-block@vger.kernel.org>,
	Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening

On Tue, Apr 26, 2022 at 08:35:34PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 02:12:22PM -0400, Demi Marie Obenour wrote:
> > Right now, opening block devices in a race-free way is incredibly hard.
> > The only reasonable approach I know of is sd_device_new_from_path() +
> > sd_device_open(), and is only available in systemd git main.  It also
> > requires waiting on systemd-udev to have processed udev rules, which can
> > be a bottleneck.  There are better approaches in various special cases,
> > such as using device-mapper ioctls to check that the device one has
> > opened still has the name and/or UUID one expects.  However, none of
> > them works for a plain call to open(2).
>=20
> Why do you call open(2) on a block device?

There are many reasons to do so:

- Some programs invoke ioctls on the block device FD.
- Some programs perform I/O using a block device (or a partition)
  directly.  mkfs, fsck, dd, lvm, cryptsetup, and Ceph all fall in this
  category.
- Some programs need to use the block device=E2=80=99s major and minor numb=
ers
  in device-mapper ioctls, and need to make sure that the major and
  minor number won=E2=80=99t be recycled behind their back.
- Some programs need to pass the assign the device to a virtual machine.

> > A much better approach would be for udev to point its symlinks at
> > "/dev/disk/by-diskseq/$DISKSEQ" for non-partition disk devices, or at
> > "/dev/disk/by-diskseq/${DISKSEQ}p${PARTITION}" for partitions.
>=20
> You can do that today with udev rules, right?

One can make udev create a symlink with that path pointing to the kernel
device name, but not make udev=E2=80=99s other symlinks point to that path.=
  It
is also still necessary to check (with BLKGETDISKSEQ) that the device
one opened is what one intended to open.

> > A
> > filesystem would then be mounted at "/dev/disk/by-diskseq" that provides
> > for race-free opening of these paths.
>=20
> How would it be any less race-free than just open("/dev/sda1") is?

Assuming you meant "more race-free", the answer is that /dev/sda1 is not
guarnateed to always point to the same device.  This could happen if the
user unplugs their USB hard drive and plugs in a new one.  The problem
is much more severe for virtual devices, such as /dev/loop* or
/dev/dm-*, which can be created and destroyed quite frequently.
If a diskseqfs is implemented and mounted on /dev/disk/by-diskseq,
opening /dev/disk/by-diskseq/1 will always either return the same device
every time, or return an error if the original device no longer exists.

> > This could be implemented in
> > userspace using FUSE, either with difficulty using the current kernel
> > API, or easily and efficiently using a new kernel API for opening a
> > block device by diskseq + partition.  However, I think this should be
> > handled by the Linux kernel itself.
> >=20
> > What would be necessary to get this into the kernel?
>=20
> Get what exactly?  I don't see anything the kernel needs to do here
> specifically.  Normally block devices are accessed using mount(2), not
> open(2).  Do you want a new mount(2)-type api?

I would like to have a filesystem, which will typically be mounted on
/dev/disk/by-diskseq, such that:

- Opening /dev/disk/by-diskseq/$DISKSEQ always returns a device with
  sequence number $DISKSEQ or an error.
- Opening /dev/disk/by-diskseq/${DISKSEQ}p${PARTITION} always returns
  partition $PARTITION of the device with diskseq $DISKSEQ or an error.
- If a device with diskseq $DISKSEQ exists, opening
  /dev/disk/by-diskseq/$DISKSEQ will return a file descriptor to the
  device, provide the user has sufficient permissions and no errors
  happen.
- If a device with diskseq $DISKSEQ exists and has a partition
  $PARTITION, opening /dev/disk/by-diskseq/${DISKSEQ}p${PARTITION} will
  return a file descriptor to partition $PARTITION of the device
  $DISKSEQ, provide the user has sufficient permissions and no errors
  happen.
- Listing /dev/disk/by-diskseq will enumerate all path names for which
  an open could succeed.

Obviously /dev/disk/by-diskseq can be replaced with any other path at
which diskseqfs is mounted, but I expect diskseqfs to typically be
mounted at that path.

--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--39PzE90C3ycWfUxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJoZLMACgkQsoi1X/+c
IsHDeBAAjgnVtoEcNir9XBnVca8JPK2Z2U6UJ77xziw75FGUnxvZK9O+vjDdD/Uh
Z4qeU6hfljnhRNSEJQkk8pOR/EUPuCFeF71WkUi35Ob2oSInTEm/xKn61Tu2df3l
08r/xFbXaFcKZHR626fryWKz3qnqQrXChrjkY9tkVmiLGwtG2YDJgKrwz5TmoWmp
6xR58f5SyiKukY9R80z8ApbVvYgdg2aE6NZ+3Tulf+OC+QzrhhMpayiZ5UmKIGt0
nUPDBRJcb8xyCcWTKKgDyO7kRL4fuRL7itqPW+wRffjAaqpezh00wcy/Z5uXnzgN
AgXwdF1StYqpvSxUgNk/7foFD2ho54Ic6sPOdhrtogDF+YC4U716rFnaSAKmemty
aFmwFBHOqNmk0L7g9ZJPqG/Z52866B4gWVOQpQmY+W+9vNFoZL0yAzRxMChXEDfa
xdpPFWI2FQHhojD1L+yIc4GLlsl0VGSr4UxlNX53OuwgqRGTetckhmQptMfQ+DO+
X4XM5Wfe+2O9AJljUvRqXwwwNunB4w6T3S9Tq3dU1AeP3jVj9cPhoph7jbePDRuO
19zBXJBhkVhoSNrHlnrMNA0K65ciW2/5xfdoEdrej/mQFR53CS8pcsrCoPpSda4q
/vuImlmbeUa3J/uvxXW2we//MUSMRP1G/orULUj8u70NzIGehs8=
=1uUx
-----END PGP SIGNATURE-----

--39PzE90C3ycWfUxS--
