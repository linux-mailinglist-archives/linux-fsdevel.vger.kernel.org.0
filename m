Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D41447E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 23:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAUWqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 17:46:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45409 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUWqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:46:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so5192997wrj.12;
        Tue, 21 Jan 2020 14:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UBYOajZFQ3V+s2bJkDi2U5d2rgFirZvgM1biPMut9Xo=;
        b=XCkPJPbb6Hohj9m89nhcTFD8FbGBQgg/blekJU719rLH9bHzsaBm7tNoi/JcYVfLRt
         qjcSvn7XRvcYiOZ9Cm/y/GZgDYw4rXu3pOBNGo2tGkgPiLl4l1upxSZsMEOQpLSVnUGl
         cP+B0VgXdizT2XXj86x82vwSH+Y75kQDk8KCWFQfppMdt2yC7w8NYs8q4ADbeKPyrmjh
         0gqCjR/2Y7RPWnKYq/2S0aUO84Q++7HffXsXG//50zlE5KdD4nzyMlmo8pWw81ylwvbh
         hiAVoKScnAUz17UGQ1TxYDea4HN503AUbgqDyT7YCP3ZdeeNmNffyz4ZcR8s40Wlgn8b
         V5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UBYOajZFQ3V+s2bJkDi2U5d2rgFirZvgM1biPMut9Xo=;
        b=tVMkFpkMsN3GaiquZS0W60pKLY8ivvN5/bNdMQxfGzanAGqmPnJFfBVcpbJ+7H2k7W
         aa2CWK4mH5I8yZiyYzXftnq0a1UlbXprCALl26HZGgVvK1Vc2oHXfIoR5S4rnxL4b4it
         xUm+DGB896/0RJBRJJFAEzqDtITV5jv/U2NqY4FwY8Uy7QOn0df8pJf7zBdltvPtYA+4
         aZlw48XHi8SJpC7lI/X0ThqRrukeMqodZvMXrye0rCAtkE/LBdsvzpxdSMwkwH18FVfF
         +U8blI0eimhHeuQeH3aik69V/wpfFJi02izqZAzni6LxPGXUerfLJ/+oTbk6mYehZGnS
         Ti4A==
X-Gm-Message-State: APjAAAXXc6vHsFVJnJcugGWD0VYPlf3AzeeYhnSvm9UJ+WRtA7tl6/2H
        hU15lE9EuH0tWqduQiRA/gU=
X-Google-Smtp-Source: APXvYqwDloEMHNGozU7IDMT6LDf8vfuj9HwBRLP9tYhGmyGmcGDyta4L/papW6zsSFcYUukadz4eVw==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr7293542wrv.364.1579646796116;
        Tue, 21 Jan 2020 14:46:36 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y17sm1211701wma.36.2020.01.21.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:46:34 -0800 (PST)
Date:   Tue, 21 Jan 2020 23:46:33 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200121224633.lxitgyx6bw47crri@pali>
References: <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
 <20200120235745.hzza3fkehlmw5s45@pali>
 <20200121000701.GG8904@ZenIV.linux.org.uk>
 <20200121203405.7g7gisb3q55u2y2f@pali>
 <20200121213625.GB23230@ZenIV.linux.org.uk>
 <20200121221447.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tgwileuqcht3qamq"
Content-Disposition: inline
In-Reply-To: <20200121221447.GD23230@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--tgwileuqcht3qamq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 January 2020 22:14:47 Al Viro wrote:
> On Tue, Jan 21, 2020 at 09:36:25PM +0000, Al Viro wrote:
> > On Tue, Jan 21, 2020 at 09:34:05PM +0100, Pali Roh=C3=A1r wrote:
> >=20
> > > This is a great idea to get FAT equivalence classes. Thank you!
> > >=20
> > > Now I quickly tried it... and it failed. FAT has restriction for numb=
er
> > > of files in a directory, so I would have to do it in more clever way,
> > > e.g prepare N directories and then try to create/open file for each
> > > single-point string in every directory until it success or fail in ev=
ery
> > > one.
> >=20
> > IIRC, the limitation in root directory was much harder than in
> > subdirectories...  Not sure, though - it had been a long time since
> > I had to touch *FAT for any reasons...

IIRC limit for root directory entry was only in FAT12 and FAT16. But I
already used subdirectories. Also VFAT name occupies at least two
entries (shortname + VFAT).

> Interesting...  FWIW, Linux vfat happily creates 65536 files in root
> directory.  What are the native limits?

Interesting... When I tried to create a new file by Linux vfat in that
directory where Windows created 32794 files, Linux vfat returned error
"No space left on device" even FS has only 39% used space. Into upper
directory linux vfat can put new file without any problem.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--tgwileuqcht3qamq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXid/RwAKCRCL8Mk9A+RD
Uu0gAKC+2Ziu8iUBxOaitdPc8Qfiy6uMVACgguDPdIIg+TJPNExEOflwGOvMmjU=
=VG/T
-----END PGP SIGNATURE-----

--tgwileuqcht3qamq--
