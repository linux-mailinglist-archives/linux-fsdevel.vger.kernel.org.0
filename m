Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAFA511B2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiD0Nce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiD0Ncc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:32:32 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE343F896;
        Wed, 27 Apr 2022 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651066159;
        bh=svw2QKLySLeBa5NNG/2lDGa1cC2jheHbjip4Kiq8SFo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=QLwApHFr3nCbCYTm5CWgFeivIHf2YkzTif89S0W47Cy9Y2o2vuu66MxF4aeS4ilfg
         GXAzMul1I56L0CYwOM5XA8WQ1isTAWoNasqrgdNrGpiaU3oRh+5odJiuCa127KQlIS
         3vfSlWiDzLbLMEwrOYGlP41vjdLtYhAtOBlIZGhk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 852711288C2B;
        Wed, 27 Apr 2022 09:29:19 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 66aQ9DCPgOss; Wed, 27 Apr 2022 09:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1651066158;
        bh=svw2QKLySLeBa5NNG/2lDGa1cC2jheHbjip4Kiq8SFo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=OB4HmMNFTRjCCWJIUeVZMKQsCcrkIEiWCs7jRmR5UbxTOyyWe3grkEMqiwmm3UkTl
         oCz2+xF1VurT45hfyL0kOmice0jPJcJTVwPoweLGHWNqN8HyQejxi6R/Ytvh3NIcue
         15gce1pryuw4ME8biooP3KzK9NTzL0RuN2t6B8VI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5AA8C1288C2F;
        Wed, 27 Apr 2022 09:29:15 -0400 (EDT)
Message-ID: <d134571f381868e1cec74aca905012d8aec9fec8.camel@HansenPartnership.com>
Subject: Re: Race-free block device opening
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Date:   Wed, 27 Apr 2022 09:29:12 -0400
In-Reply-To: <Ymg2HIc8NGraPNbM@itl-email>
References: <Ymg2HIc8NGraPNbM@itl-email>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-m2/yxg2jUsj/Q2J7p/Oh"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-m2/yxg2jUsj/Q2J7p/Oh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2022-04-26 at 14:12 -0400, Demi Marie Obenour wrote:
> Right now, opening block devices in a race-free way is incredibly
> hard.

Could you be more specific about what the race you're having problems
with is?  What is racing.

> The only reasonable approach I know of is sd_device_new_from_path() +
> sd_device_open(), and is only available in systemd git main.  It also
> requires waiting on systemd-udev to have processed udev rules, which
> can be a bottleneck.

This doesn't actually seem to be in my copy of systemd.

>   There are better approaches in various special cases, such as using
> device-mapper ioctls to check that the device one has opened still
> has the name and/or UUID one expects.  However, none of them works
> for a plain call to open(2).

Just so we're clear: if you call open on, say /dev/sdb1 and something
happens to hot unplug and then replug a different device under that
node, the file descriptor you got at open does *not* point to the new
node.  It points to a dead device responder that errors everything.

The point being once you open() something, the file descriptor is
guaranteed to point to the same device (or error).

> A much better approach would be for udev to point its symlinks at
> "/dev/disk/by-diskseq/$DISKSEQ" for non-partition disk devices, or at
> "/dev/disk/by-diskseq/${DISKSEQ}p${PARTITION}" for partitions.  A
> filesystem would then be mounted at "/dev/disk/by-diskseq" that
> provides for race-free opening of these paths.  This could be
> implemented in userspace using FUSE, either with difficulty using the
> current kernel API, or easily and efficiently using a new kernel API
> for opening a block device by diskseq + partition.  However, I think
> this should be handled by the Linux kernel itself.
>=20
> What would be necessary to get this into the kernel?  I would like to
> implement this, but I don=E2=80=99t have the time to do so anytime soon. =
 Is
> anyone else interested in taking this on?  I suspect the kernel code
> needed to implement this would be quite a bit smaller than the FUSE
> implementation.

So it sounds like the problem is you want to be sure that the device
doesn't change after you've called libblkid to identify it but before
you call open?  If that's so, the way you do this in userspace is to
call libblkid again after the open.  If the before and after id match,
you're as sure as you can be the open was of the right device.

James


--=-m2/yxg2jUsj/Q2J7p/Oh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCYmlFKAAKCRDnQslM7pis
hUPRAP9pjLs7yDBOO2c5Li9a7Pn7ceWfSbT5gPoE+EHnc411EAD+ILidPuqJQpgK
dqmy5RX/RG/fj7Tt6j8VKRMWYrsXFbk=
=fhrO
-----END PGP SIGNATURE-----

--=-m2/yxg2jUsj/Q2J7p/Oh--

