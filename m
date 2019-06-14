Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3646806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfFNTII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 15:08:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35764 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNTII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:08:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so3343538wml.0;
        Fri, 14 Jun 2019 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJnppciqjw6M4NiJW+erJedc3KCAQSIupzbo8maB6jE=;
        b=FtILNZfH+hdagSP1/xl6gu80bDXfYlo8ExHwaebJu5LDsxq5tqX6Vr1+ijmD/H+BM/
         m1hAJfq2yXvweXFvyz7vV2NXw3/HbkAHV0OHkmK1f2bwjRUpaSKC9dDZP6MU7+mWahjq
         b7KXRHibaNnYRsfPenVNW+Pcv72caTu3pse4Ssm7cROUSObTl5XborhdGYbjgRssVh5J
         5l/aw5FtSVoZp/NYqSuRNztdagRVD/gtrqYgQFCmaVM6MdMK/r8dl1K1G0kbFvG2ujBy
         1G6W7D8Py0T5Qe+RaSouxbU8amx+aL/XsFel4CamGqS8tANw6qWX/ulmlcdBVtawrejE
         NsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJnppciqjw6M4NiJW+erJedc3KCAQSIupzbo8maB6jE=;
        b=CwV7qdXS3wcajzw1HjMjDA8JgqbXQ3MgXUC5hz2U5YjYuvC2C/s+YH2KlGR3gLRDhk
         ZTjKgkrg086t70zcVTcrn6x/kLJAlbSJw3ebKWOmcJLJUVXRiTyTd8QLPcObFXVaOQWk
         Qx6J4f16TF0QffOBvdNbybHXrMOqyar89RHGzql3dolHiyH/PbR979BN9k4YNW6dM5ND
         HkXuI/MsoO9XOVzoX2gkhmV3Dnxy+nfuLKOM20LveGXhJj41MtCGfRmS95/210skRLnC
         2j9UATbSyg1HKU29B6fpRAKy2SeSd519vdDcAF36Zg6b2SwvRNRYY/znKhKA2a24R/Y0
         LF7g==
X-Gm-Message-State: APjAAAXFN/Cdcf3HpAgCdfOHhIFyyG2a9o7O6UaBkCrKt1bFV/ovzuiX
        CntkDoHgN2PxMDnngFXHBdRymiwfJ0Y=
X-Google-Smtp-Source: APXvYqwjonpCxDEc9kdNmK7fSFyC5cz95rZ3cV/f+qEnmlXeFzXmguySzdYC51X34BOBdG2EeqZiag==
X-Received: by 2002:a1c:343:: with SMTP id 64mr9590262wmd.116.1560539285449;
        Fri, 14 Jun 2019 12:08:05 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v27sm652246wrv.45.2019.06.14.12.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 12:08:04 -0700 (PDT)
Date:   Fri, 14 Jun 2019 21:08:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Help with reviewing dosfstools patches
Message-ID: <20190614190803.2wg3gky5gypge6xp@pali>
References: <20190614102513.4uwsu2wkigg3pimq@pali>
 <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
 <20190614142534.4obcytnq4v3ejdni@pali>
 <20190614143052.GA21822@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uhnyqyra6n5d7ky5"
Content-Disposition: inline
In-Reply-To: <20190614143052.GA21822@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uhnyqyra6n5d7ky5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 14 June 2019 07:30:52 Christoph Hellwig wrote:
> On Fri, Jun 14, 2019 at 04:25:34PM +0200, Pali Roh=C3=A1r wrote:
> > > Does the project already have a maillist ?
> >=20
> > No, there is no mailing list. Basically whole development is on github
> > via github pull requests where are also put review comments and where is
> > also whole discussion, including bug reports.
>=20
> That could explain why it is lacking qualified reviewers..

That is not my decision. Probably current maintainer of dosfstools like
it. But nowadays do not have much more time and gave me commit access.

Main benefit of github pull requests is that every one pull request
patch is automatically compiled and tested on i686, x86_64, x32, arm
and big endian powerpc systems via Travis CI. So author and also
reviewers/people with commit access immediately know if proposed change
could break something.

I like automated testing on more platforms, because lot of people either
do not know or do not have access to different systems just for testing.
And this can show possible problems...

Setting up a new mailing list, configuring some testing server, copying
existing patches from github to list, etc... is just tons of work for
which I basically do not have a time. Therefore I asked for help to
review existing stuff with minimal technical time setup.

I understand that it is not ideal for everybody, but for current
contributors it is probably better. I have already reviewed and merged
more patches, just those which are mine are left open, so more eyes can
look at them.

If you or somebody else have time and want to improve dosfstools
project, I'm not against it...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--uhnyqyra6n5d7ky5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXQPwkQAKCRCL8Mk9A+RD
UoiWAJ0Z13QU2KM91Gdfn4EVW7zcRUqjiwCfVP/g/rwJEfPthHkdZqpnpZjS3x0=
=c3IA
-----END PGP SIGNATURE-----

--uhnyqyra6n5d7ky5--
