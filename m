Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9381445F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 21:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAUUeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 15:34:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUUeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:34:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so4875588wrq.0;
        Tue, 21 Jan 2020 12:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvURL+gVfEg8Eqm3Y43MGH+QfOTBmpitIlmBm28iq70=;
        b=YQr8bsI3WrYcpnJWuL+E4wf6VRgtPI1ia3e/h9CaQX4VPgQj010pUtsybymEAunP/x
         MpAKt8sVrw4RpT+IrhWQNCv9RrR/dEhjJFAYZfLbdrMsfsVI7KuC0lWURzvbzBFciPnO
         gLqwfb8DnukXu8pY0vXoH1RAnOzPaA+/d66xOrCy4aprFdc1VfESJ2LydXYZ/Eg7Jsve
         PUsi9zqwDAYU88X+yYWlGv1ksgWAe2AF5LMhLgPCHj0DeQrn2IowejIz9B+L5xidk7Bm
         0NNcyYZIkCiH//EMWmLviNRnb39X+Y1sKSWekxIFj2+42Kd3ggcB9aIssGcHRid2eP2q
         QJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvURL+gVfEg8Eqm3Y43MGH+QfOTBmpitIlmBm28iq70=;
        b=uIQIMWDecIr13GFj/+6xTCcQge4jX4UI9QQwt3AcEuTyIOG3NgCLSaLfilXnhUyKii
         rPei08zd0nvgnmJDeok8VJkNpO+TavEAFymFahglaevrHAoJjCOeAorTFHvRCRx4nSht
         MCVqpoXd9YS3CjFzTHRfFpq4SS3AuKJ0ya23owgJpk37d/GUAZwHC6bKHPywF1My+vf8
         kxHBrEWCnwAoWADDEXZ63gfUfnxxZWjKvcnqEaLufhcThB61S4JyUFwe35hJ7/s1jtRz
         VGaQNtPKAu1ocklykWaj8FyRbNdJNTgVcIfDqFvJB/iz2zAyr3gNQ6JJ8vpWXyQ11qAS
         PLQQ==
X-Gm-Message-State: APjAAAVPw+y8CxVuOxgCef6S2ueHEXSCPXk5AgQ43N6EfOQ0kjS2hTHu
        Tb7nJRPTpq6Zd9WqAVIpj4Y=
X-Google-Smtp-Source: APXvYqzqVmlfiFWtVZxMc8FniPdrsJEt+H9Q+t/gQ0vAmajqAaH/U111ewnE0J9+YQ1RKwAD3SLOjw==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr6664796wrq.232.1579638848283;
        Tue, 21 Jan 2020 12:34:08 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p18sm706141wmb.8.2020.01.21.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:34:06 -0800 (PST)
Date:   Tue, 21 Jan 2020 21:34:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200121203405.7g7gisb3q55u2y2f@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
 <20200120235745.hzza3fkehlmw5s45@pali>
 <20200121000701.GG8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xrwddvrjt7zdsj3"
Content-Disposition: inline
In-Reply-To: <20200121000701.GG8904@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2xrwddvrjt7zdsj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 January 2020 00:07:01 Al Viro wrote:
> On Tue, Jan 21, 2020 at 12:57:45AM +0100, Pali Roh=C3=A1r wrote:
> > On Monday 20 January 2020 22:46:25 Al Viro wrote:
> > > On Mon, Jan 20, 2020 at 10:40:46PM +0100, Pali Roh=C3=A1r wrote:
> > >=20
> > > > Ok, I did some research. It took me it longer as I thought as lot of
> > > > stuff is undocumented and hard to find all relevant information.
> > > >=20
> > > > So... fastfat.sys is using ntos function RtlUpcaseUnicodeString() w=
hich
> > > > takes UTF-16 string and returns upper case UTF-16 string. There is =
no
> > > > mapping table in fastfat.sys driver itself.
> > >=20
> > > Er...  Surely it's OK to just tabulate that function on 65536 values
> > > and see how could that be packed into something more compact?
> >=20
> > It is OK, but too complicated. That function is in nt kernel. So you
> > need to build a new kernel module and also decide where to put output of
> > that function. It is a long time since I did some nt kernel hacking and
> > nowadays you need to download 10GB+ of Visual Studio code, then addons
> > for building kernel modules, figure out how to write and compile simple
> > kernel module via Visual Studio, write ini install file, try to load it
> > and then you even fail as recent Windows kernels refuse to load kernel
> > modules which are not signed...
>=20
> Wait a sec...  From NT userland, on a mounted VFAT:
> 	for all s in single-codepoint strings
> 		open s for append
> 		if failed
> 			print s on stderr, along with error value
> 		write s to the opened file, adding to its tail
> 		close the file
> the for each equivalence class you'll get a single file, with all
> members of that class written to it.  In addition you'll get the
> list of prohibited codepoints.
>=20
> Why bother with any kind of kernel modules?  IDGI...

This is a great idea to get FAT equivalence classes. Thank you!

Now I quickly tried it... and it failed. FAT has restriction for number
of files in a directory, so I would have to do it in more clever way,
e.g prepare N directories and then try to create/open file for each
single-point string in every directory until it success or fail in every
one.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--2xrwddvrjt7zdsj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXidgOwAKCRCL8Mk9A+RD
UsYVAJ9eGXMbHPfF6iVdohbsOutnxxHVZgCgoB9GaJJVwzZ6x7iwaAG1yhXeSXk=
=iaCM
-----END PGP SIGNATURE-----

--2xrwddvrjt7zdsj3--
