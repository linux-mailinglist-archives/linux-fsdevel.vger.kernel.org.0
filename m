Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1ADD9770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392578AbfJPQcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 12:32:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36597 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbfJPQcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:32:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so28838817wrd.3;
        Wed, 16 Oct 2019 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1IL8KzN4eED7MJkMylgKBjULCBhCLDg5VeoFVt5LveI=;
        b=eCND4nsOyqYAezMnMU37cySOpp5nLngSuyJa0Z+cWB+wLpxW+4pdPfI3lVITMQhUVb
         +0XD4rsNM8jrLIZUuXL5R66YYOrsXgThdlFMqP7TrTVsOOaHF/Tc9nOv+ILcB8NCA2d5
         iZG0V4qY5LNwMj0a+sEydSHjRWnJRbbTDX4c8b5LveFIwo4gozQ52Ce1I/W+Fbpiywq9
         dOkRnBds7Op7Yrqqj9w2s/fcaIAs6+vYFGZtVeJEKm3PEie841QFnky0wILH1UUf++oN
         Jw+Me7HTdZBwbIONgu1mtUZ8YMv7sl+NlXYjN8Uphs74vxoqB6BQXq2nUuJkDCFsRld9
         Bbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1IL8KzN4eED7MJkMylgKBjULCBhCLDg5VeoFVt5LveI=;
        b=RwztK+pz0hUXs+5gCEch2k+gsX5UiYVae6pbDFMmM2s4gcNwZ4aQHGi/BczvjZ7A0/
         ijTZSyhJpJ3KONl7hn9Dr7GMBVSuxQGEUb024M+cLWRGK0bAvm1B8PPFmYl3n6mj4dFc
         qinXHW0ABPZ4ZY6KKfci0Xij+5PIw303WW1gbBvKNnMAwkG96ouQDIQ/1cJDRR5IX5tI
         n4FcLMMEA1DpXn+jU7izzBkWJ0v6QOsBrjlSdG4RCWv39no3KKm+v+SQYZXWvvL7c4he
         BwJjACsXJ6wtgsVGLao0pdSDw2XFGs/UoMHYfAKdQmT2RTcVcM62uc4bZ9TqBbgFyD02
         Ieow==
X-Gm-Message-State: APjAAAUnwF67LP9SQ+8uUSkBZOtoM8TP1DzaaGC+SvTlnpNtAUV9y0t6
        pWMuH0LqMM3cU8e02O7KfvA=
X-Google-Smtp-Source: APXvYqxuH63ig5G6nfHASUQgTWm3NGdPCshxv4cee3gvvED+PjjhRI5a0HIWN82XSTyHvy9sVMp4Eg==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr3352316wro.333.1571243552893;
        Wed, 16 Oct 2019 09:32:32 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v11sm2970044wml.30.2019.10.16.09.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:32:31 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:32:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org,
        Christoph Hellwig <hch@infradead.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016163231.dgvurzdqcifunw35@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016162211.GA505532@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uulki3czcfzmvzao"
Content-Disposition: inline
In-Reply-To: <20191016162211.GA505532@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uulki3czcfzmvzao
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 16 October 2019 09:22:11 Greg Kroah-Hartman wrote:
> On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Roh=C3=A1r wrote:
> > > Can I assume you will be implementing TexFAT support once the spec is
> > > available?
> >=20
> > I cannot promise that I would implement something which I do not know
> > how is working... It depends on how complicated TexFAT is and also how
> > future exfat support in kernel would look like.
> >=20
> > But I'm interesting in implementing it.
>=20
> What devices need TexFAT?  I thought it the old devices that used it are
> long obsolete and gone.  How is this feature going to be tested/used?

Hi Greg! Per 3.1.16 of exFAT specification [1], TexFAT extension is the
only way how to use more FAT tables, like in FAT32 (where you normally
have two FATs). Secondary FAT table can be used e.g. for redundancy or
data recovery. For FAT32 volumes, e.g. fsck.fat uses secondary FAT table
when first one is corrupted.

Usage of just one FAT table in exFAT is just step backward from FAT32 as
secondary FAT table is sometimes the only way how to recover broken FAT
fs. So I do not think that exFAT is for old devices, but rather
non-exFAT is for old devices. Modern filesystems have journal or other
technique to do (fast|some) recovery, exFAT has nothing.

And how is this feature going to be used? That depends on specification.

[1] - https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specifica=
tion#3116-numberoffats-field

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--uulki3czcfzmvzao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXadGHQAKCRCL8Mk9A+RD
Ukm6AJ9ab4GclmcB/R83hw/wIqInUfSArwCeLEPDX7XQcg6sMkgXJ6qqa0gQCcE=
=Ni+T
-----END PGP SIGNATURE-----

--uulki3czcfzmvzao--
