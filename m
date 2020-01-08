Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A63134B2A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgAHTCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 14:02:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33641 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgAHTCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:02:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so315097wmd.0;
        Wed, 08 Jan 2020 11:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKyuYRQqoZHQmqzlPg1E+wM60Q1zmjCJTKBWatUXfXk=;
        b=BHmluhRLje+ldzmTar8OvemUfNfab+NKjpFXegQMxLK1sOFc8LvcISUvn2w1d7z/zG
         MuwIFw+xGnLP1BQeLzB1xipV1bdLSvnRLpcCnbrHeX3w8sMiA9Ez+1GvqJ1KdPGpR6t+
         4+CG5Ve55+QrajvbGlAtYaItP9g1sgo1ezpawJQhjYaxJqsrpgaFr9dMYeTPwGrDI3lL
         AhA6HrSyTqJmwqqzqMx6lcStZZFRNK67jhIfA86L8ErQZZ3k4jgzZym+d4FG6YelslNK
         fqi8wWcOja2Tj2IF1AxeHL3v5Eyi+ccs7OWW+cA9vE0WMHcY3c0Dc1JVe9hUN50DqQBr
         NIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKyuYRQqoZHQmqzlPg1E+wM60Q1zmjCJTKBWatUXfXk=;
        b=ZGjO5+x7YAN4MmMMUS1s1kHXiMPE/fSF9dQpACZEVJvum8UnYot+dPStGq/IFUYrpM
         0Q5JE/23MZ3NsXeOA9nIhCbD5ZGsrwnYMloPJCZ5Gu3KZdW4dB2nynqF4RvL/SVx4Yit
         eRL+cm/Utzgpc+/CJQX84Sd23D8yWMcaGDusfvO/3hZonJx5nmXjDOCCcUODYUpofxHz
         j03HrbI9kMEtBmp/ebBKUL15Wn0N7PZZ7v9m/Qjvcif1GDhFyQC1DluEcYbaxp4BumIT
         mmuoWMjbcoVvJCaDfrimAOAK8dnZjKn4ccSqfp3ILxow252r0VhK9Q3dgvvr5pCri2rA
         vnTg==
X-Gm-Message-State: APjAAAVFYj514ofv1eqD8/HSLcWsQ5ww6LZtc0GUej8RvG5eKuPJ6u4R
        zNP+XuN5K3aCD4dDX0TutCY=
X-Google-Smtp-Source: APXvYqzl0+rJwKsJeB3IpgRSeWetj8+Ny3enXPHmRQSd27kIk5j/gKXHBeYXvA8rGm/pN05qwGROOg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr68958wme.27.1578510121032;
        Wed, 08 Jan 2020 11:02:01 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f127sm71520wma.4.2020.01.08.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 11:02:00 -0800 (PST)
Date:   Wed, 8 Jan 2020 20:01:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v8 08/13] exfat: add exfat cache
Message-ID: <20200108190159.rfizxzi3tujpp7ck@pali>
References: <CAKYAXd8Ed18OYYrEgwpDZooNdmsKwFqakGhTyLUgjgfQK39NpQ@mail.gmail.com>
 <f253ed6a-3aae-b8df-04cf-7d5c0b3039f2@web.de>
 <20200108180819.3gt6ihm4w2haustn@pali>
 <20200108184616.GA15429@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3ydy4x3myfhpwesm"
Content-Disposition: inline
In-Reply-To: <20200108184616.GA15429@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3ydy4x3myfhpwesm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 January 2020 19:46:16 Christoph Hellwig wrote:
> On Wed, Jan 08, 2020 at 07:08:19PM +0100, Pali Roh=C3=A1r wrote:
> > On Thursday 02 January 2020 11:19:26 Markus Elfring wrote:
> > > > I am planning to change to share stuff included cache with fat after
> > > > exfat upstream.
> > >=20
> > > Can unwanted code duplication be avoided before?
> >=20
> > +1 Could it be possible?
>=20
> Let's defer that until we have the code upstream.

Ok.

> Getting rid
> of the staging version and having proper upstream exfat support
> should be a priority for now, especially as sharing will involve
> coordination with multiple maintainers.  If it works out nicely
> I'm all for it, though!

Fine for me.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--3ydy4x3myfhpwesm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhYnJQAKCRCL8Mk9A+RD
Urr0AJ9sl0GoHqDf4d0r/LAkz/EY6TXsWACgiC5lR8ZgyX6u+tkMscKZDEHCtCM=
=RcXx
-----END PGP SIGNATURE-----

--3ydy4x3myfhpwesm--
