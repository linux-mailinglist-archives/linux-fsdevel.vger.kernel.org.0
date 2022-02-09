Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FCD4AF3A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiBIOHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 09:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiBIOHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:07:07 -0500
X-Greylist: delayed 21838 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 06:07:09 PST
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C1AC0613C9;
        Wed,  9 Feb 2022 06:07:09 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1887B40009;
        Wed,  9 Feb 2022 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644415628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFd4Jm9GVCcXp1h6wfnUeSFs7Eqix0iSEKe+49FbexI=;
        b=jSJWS74p5j5+xT+MwPPEQpw2fPh9PNeUGUBSEnd2pe12T6yAtOFLrJ13olpNbfDAuE/eR1
        HSr+f0PoYvtQ5Z3tCpbRlm42B3jIBnvvvN11aXyEhyaOjVIkocFdjammvOD76OEKxtB35J
        CSNfMjn2nVFbPWUKbYHZGvPnAFoJddZyMMUVJT8iOJi06jL/p95vbzKiETQpJ4sIKwzG0c
        CyvuPZ1pMfupxorlbMzOJdecv0FYFl9hCjCjee8G3F5WeI51Sad+RwNyNI8/xyTFmAqSHK
        LoIsJsTRq1RMHBY863GhWbRg0MppttvvuECLrtGBouW1UgiRk4fS6QKqNOku0g==
Date:   Wed, 9 Feb 2022 15:07:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <broonie@kernel.org>, <mhocko@suse.cz>, <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mm-commits@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Uwe =?UTF-8?B?S2xl?= =?UTF-8?B?aW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: mmotm 2022-02-08-15-31 uploaded (drivers/mtd/nand/raw/Kconfig)
Message-ID: <20220209150703.253b16bd@xps13>
In-Reply-To: <20220209135439.qcyge32xinvazn43@chewer>
References: <20220208233156.E2CA6C004E1@smtp.kernel.org>
        <b18fc937-9cc2-bb7b-fb58-3ba2555371c7@infradead.org>
        <20220209090300.43241711@xps13>
        <20220209135439.qcyge32xinvazn43@chewer>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nishanth,

nm@ti.com wrote on Wed, 9 Feb 2022 07:54:39 -0600:

> On 09:03-20220209, Miquel Raynal wrote:
> > Hi Randy,
> >=20
> > rdunlap@infradead.org wrote on Tue, 8 Feb 2022 22:30:23 -0800:
> >  =20
> > > On 2/8/22 15:31, Andrew Morton wrote: =20
> > > > The mm-of-the-moment snapshot 2022-02-08-15-31 has been uploaded to
> > > >=20
> > > >    https://www.ozlabs.org/~akpm/mmotm/
> > > >=20
> > > > mmotm-readme.txt says
> > > >=20
> > > > README for mm-of-the-moment:
> > > >=20
> > > > https://www.ozlabs.org/~akpm/mmotm/
> > > >=20
> > > > This is a snapshot of my -mm patch queue.  Uploaded at random hopef=
ully
> > > > more than once a week.
> > > >=20
> > > > You will need quilt to apply these patches to the latest Linus rele=
ase (5.x
> > > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplic=
ated in
> > > > https://ozlabs.org/~akpm/mmotm/series
> > > >=20
> > > > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > > > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-m=
m-ss,
> > > > followed by the base kernel version against which this patch series=
 is to
> > > > be applied.   =20
> > >=20
> > > on i386:
> > >=20
> > > WARNING: unmet direct dependencies detected for OMAP_GPMC
> > >   Depends on [n]: MEMORY [=3Dy] && OF_ADDRESS [=3Dn]
> > >   Selected by [y]:
> > >   - MTD_NAND_OMAP2 [=3Dy] && MTD [=3Dy] && MTD_RAW_NAND [=3Dy] && (AR=
CH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST [=3Dy]) && HAS_IOM=
EM [=3Dy]
> > >=20
> > >=20
> > > Full randconfig file is attached. =20
> >=20
> > + Uwe, + K3 people + Krzysztof =20
>=20
> Thanks for looping me in.
>=20
> >=20
> > Uwe already raised the issue, and this was proposed:
> >=20
> > https://lore.kernel.org/linux-mtd/20220127105652.1063624-1-miquel.rayna=
l@bootlin.com/T/ =20
>=20
> I will respond to the patch.
>=20
> >=20
> > Maybe we should have added K3 people in Cc but their MAINTAINERS entry
> > is incomplete so get_maintainers.pl did not immediately found them. =20
>=20
> What are we missing there?

Actually nothing is missing, I overlooked the file name. I touched
arch/arm64/Kconfig.platforms in my patch and of course
get_maintainers.pl didn't look at the symbol owners. I should have
checked that myself manually in the first place.

Thanks,
Miqu=C3=A8l
