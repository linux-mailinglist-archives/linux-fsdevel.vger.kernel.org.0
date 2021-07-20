Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352333CF4A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbhGTF7l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 01:59:41 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:40882 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhGTF7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:59:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 38E546169BC2;
        Tue, 20 Jul 2021 08:40:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2vmFpKXdmr5S; Tue, 20 Jul 2021 08:40:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C12B36169BD2;
        Tue, 20 Jul 2021 08:40:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NPuSyuIQ7j5f; Tue, 20 Jul 2021 08:40:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 88A5B6169BC2;
        Tue, 20 Jul 2021 08:40:15 +0200 (CEST)
Date:   Tue, 20 Jul 2021 08:40:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Message-ID: <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com> <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at> <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com> <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF90 (Linux)/8.8.12_GA_3809)
Thread-Topic: How to get actual image size from MTD partition
Thread-Index: c6zZTS0QxRlvwgld28+UkRfD2UKnsA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> Okay thank you.
> We have tried dm-verity with squashfs (for our rootfs) but we are
> facing some mounting issues.
> [...]
> [    4.697757] device-mapper: init: adding target '0 96160 verity 1
> /dev/mtdblock34 /dev/mtdblock39 4096 4096 12020 8 sha256
> d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7'
> [    4.704771] device-mapper: verity: sha256 using implementation
> "sha256-generic"
> [...]
> [    4.727366] device-mapper: init: dm-0 is ready
> [    4.912558] VFS: Cannot open root device "dm-0" or
> unknown-block(253,0): error -5
> 
> The same works with ext4 emulation.
> So, not sure if there are any changes missing w.r.t. squashfs on 4.14 kernel ?

I don't know.

> Anyways, I will create a separate thread for dm-verity issue and keep
> this thread still open for UBI image size issue.
> We may use dm-verify for rootfs during booting, but still we need to
> perform integrity check for other nand partitions and UBI volumes.
> 
> So, instead of calculating the checksum for the entire partition, is
> it possible to perform checksum only based on the image size ?
> Right now, we are still exploring what are the best possible
> mechanisms available for this.

I still don't fully understand what you are trying to achieve.
Is it about cryptographic integrity of your storage or detecting
errors after the flashing process?

But let me advertise ubiblock a second time. If you place your squashfs on
a UBI static volume, UBI knows the exact length and you can checksum it
more easily.

Thanks,
//richard
