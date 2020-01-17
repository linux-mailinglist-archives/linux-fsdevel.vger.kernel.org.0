Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01898141431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 23:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgAQWft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 17:35:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36132 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgAQWft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:35:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so24190404wru.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vLgunkFEXuAv5DTLZy+d4xErAb/TM8gb6wqM7lnCQ7k=;
        b=oZLPhLCNRIgC457ctolBnOULl06DEuv5tfchvI7pTImD+Cqkey6OMq7QyrZVBv6u2q
         xTYNEbJcdxwbjs1A7+iiqDBIUf6k+A+AkabhGUF1mIns4gXRrD4azNkKN5e9kBOjjDbQ
         tG9eA2NFXpL5ChmRGmNv5VVw+92M/83QODF7ORqlGmqn9wTZqZlNSZPdfw9F1JaC50p1
         C8ZcNapwyJDS4289duLEzlpMa1jLfCKP9nfJNFiYJ2yPEXVb/RitDm9sTl+FRN29nqOd
         zS6kvKMheLQSsojpDm3AfPxBxMkrueElHg5ytTH8GgRqSUJAxMoVCpqPxI4qbfJMzbeq
         9tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vLgunkFEXuAv5DTLZy+d4xErAb/TM8gb6wqM7lnCQ7k=;
        b=m7hKQ9Zi2jFoyjwpvx4o6ixQhJxYCFrFqV1OlJLS5H3o6AfI2js0z9MlvG1qwD9ENV
         HBR4RpCEcePrGURapd+LCW+FA0AZBtean7iCMKi4oATialU0VHUXGrXkKj4XMXM6x+VF
         ioKQGvI6ERcQEDzoLZOV9D3uXBt36IGd4AXeynvIb0eFwMiow9TcOjt55dOGH/OwfrtD
         CvLz/azDnbIHGbaP3v+LxqGv6Mv53odtujqFvHuld4+rPdeqRvaRl5OASHXmv1X49qM6
         btKTJxS3xs9XQdNKov+jRGqktQRtnr/kPfUmYzc2PnLajP0stOgI63unTABwb1IalBZF
         teEw==
X-Gm-Message-State: APjAAAUvrr1RJpwkOFqSb9N0r4n2ClnucCtAJZoBzFoYH+/TzO/fySzr
        /0gj+UzfP5ERjos+zMyDIfg=
X-Google-Smtp-Source: APXvYqxWU5LFga7J9HnvoIPzyxOTQ8T/V6zsEIPyTr7J7q88/t5fhe0fdN22jG+0En7u9fIdfVsvKg==
X-Received: by 2002:a05:6000:1047:: with SMTP id c7mr5412347wrx.341.1579300546763;
        Fri, 17 Jan 2020 14:35:46 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r62sm12979057wma.32.2020.01.17.14.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:35:45 -0800 (PST)
Date:   Fri, 17 Jan 2020 23:35:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200117223544.g5ldmlkfgvdgfpli@pali>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
 <20200113120851.GG23642@quack2.suse.cz>
 <20200116153019.5awize7ufnxtjagf@pali>
 <20200117113833.GG17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5hrrinrzsfibytet"
Content-Disposition: inline
In-Reply-To: <20200117113833.GG17141@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5hrrinrzsfibytet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 17 January 2020 12:38:33 Jan Kara wrote:
> On Thu 16-01-20 16:30:19, Pali Roh=C3=A1r wrote:
> > On Monday 13 January 2020 13:08:51 Jan Kara wrote:
> > > > Second one:
> > > >=20
> > > > 	buf->f_files =3D (lvidiu !=3D NULL ? (le32_to_cpu(lvidiu->numFiles=
) +
> > > > 					  le32_to_cpu(lvidiu->numDirs)) : 0)
> > > > 			+ buf->f_bfree;
> > > >=20
> > > > What f_files entry should report? Because result of sum of free blo=
cks
> > > > and number of files+directories does not make sense for me.
> > >=20
> > > This is related to the fact that we return 'f_bfree' as the number of=
 'free
> > > file nodes' in 'f_ffree'. And tools generally display f_files-f_ffree=
 as
> > > number of used inodes. In other words we treat every free block also =
as a
> > > free 'inode' and report it in total amount of 'inodes'. I know this i=
s not
> > > very obvious but IMHO it causes the least confusion to users reading =
df(1)
> > > output.
> >=20
> > So current code which returns sum of free blocks and number of
> > files+directories is correct. Could be this information about statvfs
> > f_files somewhere documented? Because this is not really obvious nor for
> > userspace applications which use statvfs() nor for kernel filesystem
> > drivers.
>=20
> Well, I can certainly add a comment to udf_statfs().

Adding comment directly to udf_statfs() would really help.

> Documenting in some
> manpage might be worth it but I'm not 100% sure where - maybe directly in
> the statfs(2) to the NOTES section? Also note that this behavior is not
> unique to UDF - e.g. XFS also does the same.

I think it make sense to write these information into statfs(2) manpage.
And specially if this is implemented in more filesystems. Also this
structure is exported into statvfs(3) call too.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5hrrinrzsfibytet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiI2vAAKCRCL8Mk9A+RD
UjE5AJ0WTzsBsdBbjRIcCdOcsyuzAhZFdgCbBNQSfK9sGQ/snZ8kMHLz89dxcI8=
=/+SH
-----END PGP SIGNATURE-----

--5hrrinrzsfibytet--
