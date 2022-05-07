Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023851E6A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384832AbiEGLjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEGLjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 07:39:42 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797B424F2C;
        Sat,  7 May 2022 04:35:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B39A55C00C4;
        Sat,  7 May 2022 07:35:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 07 May 2022 07:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651923351; x=
        1652009751; bh=g92dWQAsLc4TQj4XqLH+BiQA/OMOXoYjK1h/wobDrnI=; b=n
        ZuH5uN+Jau0LHWTR0gd2fmlwT+S33ZoAJOOGg8TMwLdTBuVa/RQn78QQuTseSXiB
        M1YbU+T952sohC0+g3oHLLdRSW017TVd3OCkL/iSWWVQB/dJtNCLITqkXpp/EVmY
        SrdHN8eRkv6m3UwESLH+WPcpQMfXPZ1zK3kPGlY0PR3tb7C7KoN8cLcS5WU/kBiq
        5GGREb3KV9aOCUV7NzM31pGZHipeMHpAyqixdT7CmRcAufqYZL20xEsfBMyT86uJ
        FKAO3hn7vaRYNW6sQVr9sk1WZ59zHYrYvhRIPDf7c2ZUSF+3Uju0E9igLH06Pqg7
        x49HfAlCAAZ2BuXszGMyA==
X-ME-Sender: <xms:l1l2YqfhgmvTMmsKm2FqD5_87tIE4wF4egDN3nvRcm0KYnz6DU8p2A>
    <xme:l1l2YkM6YH2oKiP_3turEO3iTCN7y-cfi3D93YkWM9HUh8V1dWzBkWPZhvxTyL0Ci
    BtTZn76lqCgtDg>
X-ME-Received: <xmr:l1l2YrhYdZ1_VcY26yYH6AuKvkYppRlpzC-gB7XSZI8DzQxN_5LRsK4Ie9QV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffegfffg
    uddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:l1l2Yn-CLxcXchr9gJQuf9Tu8WkcSDRlEeKlIiec4xL9I4nDM8WnuQ>
    <xmx:l1l2Ymtu0Dn-BbS_7-J4mWQX6mI4iPKty0cwFIcT2Ea-ACWvuioYLg>
    <xmx:l1l2YuHBffb0f8Jfi9Yez90MZLg0TblXtHaSEA8-vXVTzNM7-jJ8lQ>
    <xmx:l1l2Yv69tA9EzFpT4YO-gpTM2ktxsU4NOvwlDHAR5vXVF35jm2hkkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 May 2022 07:35:51 -0400 (EDT)
Date:   Sat, 7 May 2022 07:35:45 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening
Message-ID: <YnZZlR7BV/cyn8xS@itl-email>
References: <Ymg2HIc8NGraPNbM@itl-email>
 <d134571f381868e1cec74aca905012d8aec9fec8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yDkSRC+vSYnqJ7uW"
Content-Disposition: inline
In-Reply-To: <d134571f381868e1cec74aca905012d8aec9fec8.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yDkSRC+vSYnqJ7uW
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 7 May 2022 07:35:45 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Block Mailing List <linux-block@vger.kernel.org>,
	Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening

On Wed, Apr 27, 2022 at 09:29:12AM -0400, James Bottomley wrote:
> On Tue, 2022-04-26 at 14:12 -0400, Demi Marie Obenour wrote:
> > Right now, opening block devices in a race-free way is incredibly
> > hard.
>=20
> Could you be more specific about what the race you're having problems
> with is?  What is racing.

If I open /dev/mapper/qubes_dom0-vm--sys--net--private, it is possible
that something has destroyed the corresponding device and created a new
one with the same kernel name, *before* udev has managed to unlink the
device node.  As a result, I wind up opening the wrong device.

> > The only reasonable approach I know of is sd_device_new_from_path() +
> > sd_device_open(), and is only available in systemd git main.  It also
> > requires waiting on systemd-udev to have processed udev rules, which
> > can be a bottleneck.
>=20
> This doesn't actually seem to be in my copy of systemd.

That=E2=80=99s because it is not in any release yet.

> >   There are better approaches in various special cases, such as using
> > device-mapper ioctls to check that the device one has opened still
> > has the name and/or UUID one expects.  However, none of them works
> > for a plain call to open(2).
>=20
> Just so we're clear: if you call open on, say /dev/sdb1 and something
> happens to hot unplug and then replug a different device under that
> node, the file descriptor you got at open does *not* point to the new
> node.  It points to a dead device responder that errors everything.
>=20
> The point being once you open() something, the file descriptor is
> guaranteed to point to the same device (or error).

That doesn=E2=80=99t help if the unplug and replug happens between passing =
the
path and udev having purged the now-stale symlink.

> > A much better approach would be for udev to point its symlinks at
> > "/dev/disk/by-diskseq/$DISKSEQ" for non-partition disk devices, or at
> > "/dev/disk/by-diskseq/${DISKSEQ}p${PARTITION}" for partitions.  A
> > filesystem would then be mounted at "/dev/disk/by-diskseq" that
> > provides for race-free opening of these paths.  This could be
> > implemented in userspace using FUSE, either with difficulty using the
> > current kernel API, or easily and efficiently using a new kernel API
> > for opening a block device by diskseq + partition.  However, I think
> > this should be handled by the Linux kernel itself.
> >=20
> > What would be necessary to get this into the kernel?  I would like to
> > implement this, but I don=E2=80=99t have the time to do so anytime soon=
=2E  Is
> > anyone else interested in taking this on?  I suspect the kernel code
> > needed to implement this would be quite a bit smaller than the FUSE
> > implementation.
>=20
> So it sounds like the problem is you want to be sure that the device
> doesn't change after you've called libblkid to identify it but before
> you call open?  If that's so, the way you do this in userspace is to
> call libblkid again after the open.  If the before and after id match,
> you're as sure as you can be the open was of the right device.

The devices I am working with are raw-format VM disks that contain
untrusted data.  They are identified not by their content, which the VM
has complete control over, but by various sysfs attributes such as
dm/name and dm/uuid.  And they need to be passed to interfaces, such as
libvirt and cryptsetup, that only accept device paths.

I can work around this in the case of cryptsetup by using the
libcryptsetup library and/or holding a file descriptor open, but neither
of those will work for libvirt since libvirtd is a separate process and
I cannot pass a file descriptor to it.  Furthermore, there is no way to
make libvirtd do any post-open() checking on the file descriptor it has
obtained.  While I plan to add a workaround in libxl and blkback for
loop and device-mapper devices, it is not reasonable to expect every
userspace tool to do the same. =20

The approach I am suggesting avoids this problem entirely, because
/dev/mapper/qubes_dom0-vm--sys--net--private is now a symlink to a
device node under /dev/disk/by-diskseq/$DISKSEQ.  Those are never, ever
reused.  When the device goes away, the device node goes away too, and
so any attempt to open the symlink (without O_PATH|O_NOFOLLOW) gets
-ENOENT as it should.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--yDkSRC+vSYnqJ7uW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmJ2WZUACgkQsoi1X/+c
IsGsNRAAp1ThDVBa0m3PvRHHToV/fkrh4yq8AFC3PBmLl5r8yNy1MqYcFHKIa+t6
BSl37mxi2HFZv7sY4xInn2tos81EqKwaMav9EH63PwJd5yMLj73j1Fq0x8RanJP/
U+bEn+FazCpgSmJjX5Ii0Kehf55AKDxveDFDqay1WYorep6L+jW4O+Yf8fsDt4WT
lKO96o7OkUdsKVhTX4jMPDRa0a9wO7+4q1ToSAUP5Cdo/wBdGJF5T0deA1bklSdb
zcoKUgL3vAxKXXM/18Eci/64+da1POENNNFfmgYhOh8R0bLgMzWPYDwTsknqPkqy
SOsEwAVJuC4wcsZixb0Q7U9jvdTixMfL0O+7iTMa3ZLjKcZZbr9DayG0kGdbyeLU
IAGMliEDW9CKJXKE82l67DsUp5Moy9eSPMTRsYfSugT7cayeYRC4x1L/LMDN5sLX
K8IjFWj5E2vySesiEaOqAyk8/B9tz3ULLgLBuPoHqXqZeaX4q+7ygvbIxql8FKag
rWaKrv5jmjww7NsRb6ZZfKEFWxoB7D+6WSK+pB/Cj8utme2gmRmejjx6UvCLHDdK
lstVXKIh8JV1IcvzHoD0ss1Axt7vOWFAC1ubVD/jtSZcJPRiMSCVpgXMOx73LVJa
jBAH2qbUUBKaZ3RzMZbxyZDrj8p9KzgjE8AS3Y0ojGcVOU6Gpoo=
=/cKD
-----END PGP SIGNATURE-----

--yDkSRC+vSYnqJ7uW--
