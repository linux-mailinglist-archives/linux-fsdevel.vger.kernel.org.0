Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA64AEBD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 09:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiBIIHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 03:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBIIHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:07:39 -0500
X-Greylist: delayed 274 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:07:42 PST
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CEDC0613CA;
        Wed,  9 Feb 2022 00:07:41 -0800 (PST)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 2B6A0CA913;
        Wed,  9 Feb 2022 08:03:12 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 447D540013;
        Wed,  9 Feb 2022 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644393785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kA7zyjjd/UqaeOL0y3OaVUdPRii6jxTKcWJ8icBD3Jc=;
        b=VcpR0WbO4Txvr6QJ94SdrWy+TAxMDUnNi9jUO5NtGxfzQpV2u3X3KUjrXQEXlHY8ybgigm
        QpKS/Sz7hsrBrcCxlAt4VxB01eHFNvI/E9SxcIocc9C/sNrOC+n5Sq/RYT5VgxacI80mdP
        qLNxmgro5fTRyyH3Zw0HJg7RWglNVx/6XxmqeIu5mtGc22CFgqcG7ZE9+FjoVCOWQ59IDM
        GAh2+I92rvJMWD6D8w76geG2NS3fXHpCq0mjbWIz5zVNkUiPfcHglE7UUSiydpYnsJexAJ
        /oAp8tzdlgtZL6qD23Q0dqqGlQgrj4LcC/3cEIoSlMxJ49WY6SFxnyB98hQRqQ==
Date:   Wed, 9 Feb 2022 09:03:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        linux-mtd@lists.infradead.org,
        Uwe =?UTF-8?B?S2xl?= =?UTF-8?B?aW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: mmotm 2022-02-08-15-31 uploaded (drivers/mtd/nand/raw/Kconfig)
Message-ID: <20220209090300.43241711@xps13>
In-Reply-To: <b18fc937-9cc2-bb7b-fb58-3ba2555371c7@infradead.org>
References: <20220208233156.E2CA6C004E1@smtp.kernel.org>
        <b18fc937-9cc2-bb7b-fb58-3ba2555371c7@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

rdunlap@infradead.org wrote on Tue, 8 Feb 2022 22:30:23 -0800:

> On 2/8/22 15:31, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2022-02-08-15-31 has been uploaded to
> >=20
> >    https://www.ozlabs.org/~akpm/mmotm/
> >=20
> > mmotm-readme.txt says
> >=20
> > README for mm-of-the-moment:
> >=20
> > https://www.ozlabs.org/~akpm/mmotm/
> >=20
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >=20
> > You will need quilt to apply these patches to the latest Linus release =
(5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> > https://ozlabs.org/~akpm/mmotm/series
> >=20
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is =
to
> > be applied. =20
>=20
> on i386:
>=20
> WARNING: unmet direct dependencies detected for OMAP_GPMC
>   Depends on [n]: MEMORY [=3Dy] && OF_ADDRESS [=3Dn]
>   Selected by [y]:
>   - MTD_NAND_OMAP2 [=3Dy] && MTD [=3Dy] && MTD_RAW_NAND [=3Dy] && (ARCH_O=
MAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST [=3Dy]) && HAS_IOMEM [=
=3Dy]
>=20
>=20
> Full randconfig file is attached.

+ Uwe, + K3 people + Krzysztof

Uwe already raised the issue, and this was proposed:

https://lore.kernel.org/linux-mtd/20220127105652.1063624-1-miquel.raynal@bo=
otlin.com/T/

Maybe we should have added K3 people in Cc but their MAINTAINERS entry
is incomplete so get_maintainers.pl did not immediately found them.

Thanks,
Miqu=C3=A8l
