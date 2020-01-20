Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0C14349D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 00:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgATX5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 18:57:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33038 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgATX5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:57:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so1364472wrq.0;
        Mon, 20 Jan 2020 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5QYZIUaddkQAqu0RUP+KLHfCsCgj864Qo1r0sEum0F0=;
        b=vYHX8bSYfpWC+sYRQLUDopiHu8VErwVl3RCNxpygJ3Hu+xVXKheoTzrFHlqIMG7ryP
         nMhuut3hGGyUEXuqCLVX7q3H1Ta48QbPNbySiS0LfmLQ7v8BI+xYJk1C1knpyqI+1wG8
         cgk0sVa27Jzg4bMjJqYvKiuGdl1XuIQBVuHoGGcR1XrMi3IcX0LeFgJ/Ifc38+8v4UnO
         rMH45V7GlvUDuzF7kUJ81Hma4CUiRz0YVMeZjKMLsn2w/HMlXFQ59daweicYt355pPO8
         cuTXCf0XxIrJkaVTtu8hu3if+5dqd8bUBmLiEH4G0/YrMglQ+shDL8ivVt/1WwNttYuO
         cz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5QYZIUaddkQAqu0RUP+KLHfCsCgj864Qo1r0sEum0F0=;
        b=aKXIou/4h+CfMBOiIU/+E/2A7LDFGIcnkVhaYzrJh6DPhPDELJ3griGVPSWIDzrFv1
         frFuyZC6aSenUUpAteKAw0gEZo5HrzY9D0CNhGzk0xYLcRSGVHJBGBLa3GWvASGR0Qhq
         5mrBaog3cZdTeb5eySFI2R1y62uRJzfSUE2Y3ucJ9vMISDKyrK1rolWsjo/eDW05ODTw
         bbZS4e810jWpHNQ0Kkhx+3wVl9crJbc6KEGNDrKtX7ReYsphuOcwz4DZ28XEEUdf4fwx
         lcnEj7flggvY6ynAKi1GhsPbKTLUZc6t8UWIcgZ5zLb/vQkALQV6RmSmme8AvGnumnWH
         o1aQ==
X-Gm-Message-State: APjAAAXs7d35RSOIw+I3aNlfRw8xOoikUPooemV+B3qdvSD1aITYQdVc
        /YbB+fEOuqWvTWhjNKxeaOk=
X-Google-Smtp-Source: APXvYqzx43G3GKSHcSQouLLAY0ppr3ZdgpRR3uIAPEsu23DNu0OHoKOMHuni5nlIH25QcD0ymIZrAQ==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr1976002wrv.148.1579564666799;
        Mon, 20 Jan 2020 15:57:46 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q14sm1306850wmj.14.2020.01.20.15.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 15:57:46 -0800 (PST)
Date:   Tue, 21 Jan 2020 00:57:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120235745.hzza3fkehlmw5s45@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eehs7cllwbppgvtc"
Content-Disposition: inline
In-Reply-To: <20200120224625.GE8904@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eehs7cllwbppgvtc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2020 22:46:25 Al Viro wrote:
> On Mon, Jan 20, 2020 at 10:40:46PM +0100, Pali Roh=C3=A1r wrote:
>=20
> > Ok, I did some research. It took me it longer as I thought as lot of
> > stuff is undocumented and hard to find all relevant information.
> >=20
> > So... fastfat.sys is using ntos function RtlUpcaseUnicodeString() which
> > takes UTF-16 string and returns upper case UTF-16 string. There is no
> > mapping table in fastfat.sys driver itself.
>=20
> Er...  Surely it's OK to just tabulate that function on 65536 values
> and see how could that be packed into something more compact?

It is OK, but too complicated. That function is in nt kernel. So you
need to build a new kernel module and also decide where to put output of
that function. It is a long time since I did some nt kernel hacking and
nowadays you need to download 10GB+ of Visual Studio code, then addons
for building kernel modules, figure out how to write and compile simple
kernel module via Visual Studio, write ini install file, try to load it
and then you even fail as recent Windows kernels refuse to load kernel
modules which are not signed...

So it was easier to me to look at different sources (WRK, ReactOS, Wine,
github, OSR forums, ...) and figure out what is RtlUpcaseUnicodeString()
doing here.

> Whatever
> the license of that function might be, this should fall under
> interoperability exceptions...
>=20
> Actually, I wouldn't be surprised if f(x) - x would turn out to be consta=
nt
> on large enough intervals to provide sufficiently compact representation.=
=2E.
>=20
> What am I missing here?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--eehs7cllwbppgvtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiY+dwAKCRCL8Mk9A+RD
UjV6AJ93GUeZYXGcsHMDO4i2IJLY4TDovwCfTnlZ00Tl1jxorBEPiFSGFcSiebE=
=T55m
-----END PGP SIGNATURE-----

--eehs7cllwbppgvtc--
