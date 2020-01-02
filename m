Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C112EBA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgABWIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 17:08:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38521 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgABWIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:08:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so40741693wrh.5;
        Thu, 02 Jan 2020 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSkCZSCwVDDUrbTtmDApYqi12CUPtLMPAOuxrPvJKGM=;
        b=g4fnXkQZ6tQvKDJCtac9JIAAN3qok68nbRZH+Ug/JaKrjdH00nsqlLJUkFEBJCKqsu
         dmoif8pslECzeKCb5JAMGtNhSVtuaboSJC6Q18T87ttI6PKPgBxJsirHN7HDhtayf/Nk
         knm+LExorhsD5Ngn7JbZxb02mJNUo0+8RsEFFDMUjtoX5eo/bPuoUQbX+OVvcYhgj0xu
         JhCyOi6C3gA6/mVB8fdbqZS6V64bI22THEIQNABRvxtw69YpQ6+5vsRjLosoAFx4CTar
         b5IPh2l86VfYGudHcEQYhiXmwyFmEUOW48SLd+fOtH1xBECvbRpp4omc3Qqfn28yMgdp
         emEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSkCZSCwVDDUrbTtmDApYqi12CUPtLMPAOuxrPvJKGM=;
        b=j2GVDzcBm2z2aI9JialtlBcVlZcy2wkCfe178co4dWVL7I+KiQR+MMCPaSj22hWwIh
         W1Ux2FdEgx04OLHow+TydDh9qPb4awEx81ZsTmN8yKmg6GANtN7dmqdH8pZl+oeUCPiz
         9v+GIs7BjQmh6Mna+tUduJzRQOhuGqtkxNNxV+LLPbJ3d2WpP1nCvhc+6KOvnWQaF63k
         48WOtqRQYnTqNNLAymndOwoKrxE8p9HlfltVXR1J28Gnfv0Q28cYa5rhPMWYF7ERXFDL
         RgjgliS2UewBdeiU2h2zABC4Ri3asPoTu1ymQ/e84RFsXSw1a8XbWVAi57O6cMY+RRZZ
         ImuA==
X-Gm-Message-State: APjAAAVv5KN5dnN05ZgiCAlnp6ZKtp8nf9Iu1hlyFU0xJi3Cofydrah9
        TcTIrfP/bx1zz6sbIQP24KI=
X-Google-Smtp-Source: APXvYqy52IHkgh40mflvMKl6Meyj6hzKveJQJrwEcbpDiar3fGS4/Q6qnjD0W9jPOKaQc2u89W0IMw==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr82186374wrr.21.1578002882675;
        Thu, 02 Jan 2020 14:08:02 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e8sm57670997wrt.7.2020.01.02.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 14:08:01 -0800 (PST)
Date:   Thu, 2 Jan 2020 23:08:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20200102220800.nasrhtz23xkqxxkg@pali>
References: <20191228143651.bjb4sjirn2q3xup4@pali>
 <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
 <20200101181054.GB191637@mit.edu>
 <20200101183920.imncit5sllj46c22@pali>
 <20200102215754.GA1508646@magnolia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l7bzeipaopuephkr"
Content-Disposition: inline
In-Reply-To: <20200102215754.GA1508646@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--l7bzeipaopuephkr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 January 2020 13:57:54 Darrick J. Wong wrote:
> On Wed, Jan 01, 2020 at 07:39:20PM +0100, Pali Roh=C3=A1r wrote:
> > On Wednesday 01 January 2020 13:10:54 Theodore Y. Ts'o wrote:
> > > On Tue, Dec 31, 2019 at 04:54:18PM -0600, Eric Sandeen wrote:
> > > > > Because I was not able to find any documentation for it, what is =
format
> > > > > of passed buffer... null-term string? fixed-length? and in which
> > > > > encoding? utf-8? latin1? utf-16? or filesystem dependent?
> > > >=20
> > > > It simply copies the bits from the memory location you pass in, it =
knows
> > > > nothing of encodings.
> > > >=20
> > > > For the most part it's up to the filesystem's own utilities to do a=
ny
> > > > interpretation of the resulting bits on disk, null-terminating maxi=
mal-length
> > > > label strings, etc.
> > >=20
> > > I'm not sure this is going to be the best API design choice.  The
> > > blkid library interprets the on disk format for each file syustem
> > > knowing what is the "native" format for that particular file system.
> > > This is mainly an issue only for the non-Linux file systems; for the
> > > Linux file system, the party line has historically been that we don't
> > > get involved with character encoding, but in practice, what that has
> > > evolved into is that userspace has standardized on UTF-8, and that's
> > > what we pass into the kernel from userspace by convention.
> > >=20
> > > But the problem is that if the goal is to make FS_IOC_GETFSLABEL and
> > > FS_IOC_SETFSLABEL work without the calling program knowing what file
> > > system type a particular pathname happens to be, then it would be
> > > easist for the userspace program if it can expect that it can always
> > > pass in a null-terminated UTF-8 string, and get back a null-terminated
> > > UTF-8.  I bet that in practice, that is what most userspace programs
> > > are going to be do anyway, since it works that way for all other file
> > > system syscalls.
>=20
> "Null terminated sequence of bytes*" is more or less what xfsprogs do,
> and it looks like btrfs does that as well.
>=20
> (* with the idiotic exception that if the label is exactly 256 bytes long
> then the array is not required to have a null terminator, because btrfs
> encoded that quirk of their ondisk format into the API. <grumble>)
>=20
> So for VFAT, I think you can use the same code that does the name
> encoding transformations for iocharset=3D to handle labels, right?

Yes I can! But I need to process also codepage=3D transformation (details
in email <20191228200523.eaxpwxkpswzuihow@pali>). And I already have
this implementation in progress.

> > > So for a file system which is a non-Linux-native file system, if it
> > > happens to store the its label using utf-16, or some other
> > > Windows-system-silliness, it would work a lot better if it assumed
> > > that it was passed in utf-8, and stored in the the Windows file system
> > > using whatever crazy encoding Windows wants to use.  Otherwise, why
> > > bother uplifting the ioctl to one which is file system independent, if
> > > the paramters are defined to be file system *dependent*?
> >=20
> > Exactly. In another email I wrote that for those non-Linux-native
> > filesystem could be used encoding specified in iocharset=3D mount
> > parameter. I think it is better as usage of one fixing encoding (e.g.
> > UTF-8) if other filesystem strings are propagated to userspace in other
> > encoding (as specified by iocharset=3D).
>=20
> I'm confused by this statement... but I think we're saying the same
> thing?

Theodore suggested to use UTF-8 encoding for FS_IOC_GETFSLABEL. And I
suggested to use iocharset=3D encoding for FS_IOC_GETFSLABEL. You said to
use for VFAT "same code that does the name encoding", so if I'm
understanding correctly, yes it is the same thing (as VFAT use
iocharset=3D and codepage=3D mount options for name encoding). Right?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--l7bzeipaopuephkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXg5pvgAKCRCL8Mk9A+RD
Ukr4AJ98GAta9U2OaTiGsrOMG9ps/7zVSwCfStjpkSU7g+R0WVUO3TWvEWLJuTk=
=oufg
-----END PGP SIGNATURE-----

--l7bzeipaopuephkr--
