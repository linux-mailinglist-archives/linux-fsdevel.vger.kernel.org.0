Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AD43BCD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 00:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhJZWGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 18:06:47 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:55517 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbhJZWEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:04:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hf5QW5Hptz4xby;
        Wed, 27 Oct 2021 09:02:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1635285733;
        bh=SK8GWLv/CoVRrpGWXO+u29Nlyt3+4mB21BnZlcosbsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s9ONVChh7b5Z1UZL6CBJ4dl0CrEZAb2+xgFIXA5Etk9C2Ob0Aggau8iCFjs6vV78O
         DpDew0LfYLkDAFZ1SMglvSPa6TxUttFYGuvA7udKdSaFwWAEftaW7cBLVyDCM0RSxF
         ElSxx13PfGnNu0SbPdEYUP1JW7XH1ySudnmMlGL5bZ7KMVV3vDbdbBF/zg1yWE2Weq
         CcQXw67ylKS9elSxIu8hh0RV+uhPtulwt4dKldaMh0ft9wIJp0rFWVCNm0JuxMuqr0
         wI+usUvrw2dV3raQSEQ1fR6va52lcErDcQn8mByfB7YHTPR0LWxVq8h7u8C1bkl3b7
         De32l9SwXvraQ==
Date:   Wed, 27 Oct 2021 09:02:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/11] unicode: Add utf8-data module
Message-ID: <20211027090208.70e88aab@canb.auug.org.au>
In-Reply-To: <87mtmvevp7.fsf@collabora.com>
References: <20210915070006.954653-1-hch@lst.de>
        <20210915070006.954653-11-hch@lst.de>
        <87wnmipjrw.fsf@collabora.com>
        <20211012124904.GB9518@lst.de>
        <87sfx6papz.fsf@collabora.com>
        <20211026074509.GA594@lst.de>
        <87mtmvevp7.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zpAG6xHoBv_D/DEo5Opsu+k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/zpAG6xHoBv_D/DEo5Opsu+k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On Tue, 26 Oct 2021 10:56:20 -0300 Gabriel Krisman Bertazi <krisman@collabo=
ra.com> wrote:
>
> Christoph Hellwig <hch@lst.de> writes:
>=20
> > On Tue, Oct 12, 2021 at 11:40:56AM -0300, Gabriel Krisman Bertazi wrote=
: =20
> >> > Does this fix it? =20
> >>=20
> >> Yes, it does.
> >>=20
> >> I  will fold this into the original patch and queue this series for 5.=
16. =20
> >
> > This series still doesn't seem to be queued up. =20
>=20
> Hm, I'm keeping it here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/log/?=
h=3Dfor-next_5.16
>=20
> Sorry, but I'm not sure what is the process to get tracked by
> linux-next.  I'm Cc'ing Stephen to hopefully help me figure it out.

You just need to send me a git URL for your tree/branch (not a cgit or
gitweb URL, please), plus some idea of what the tree include and how it
is sent to Linus (directly or via another tree).  The branch should
have a generic name (i.e. not including a version) as I will continuet
to fetch that branch every day until you tell me to stop.  When your
code is ready to be included in linux-next, all you have to do is
update that branch to include the new code.

--=20
Cheers,
Stephen Rothwell

--Sig_/zpAG6xHoBv_D/DEo5Opsu+k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmF4euAACgkQAVBC80lX
0GwceQgAi6W1qvH8e/YEFcP2VS6b/2KY5DJKr3QEo0s7wxM+T4f+jxvWcAlJ0LFk
uewS5xgi5RcGUj4HLU517ONP2w3grK5ZCKmg7XAUop+t1YX97EUZa2dNzv4Q35PC
Fmb/DOTE2i7DIs5/cIipcWqtwewutnDAHFWM1ZmnERWLeKhys3ekgTXPfIypcgxz
qVDUqUSXhPmda4FugFRfSu5OF4VGk/LmvXca2gwcXjgnrQN4LsjkrbwuQKLDhczc
A1qyzs8+g7WFGgf1KvEbcHwj5dGwIDgHg/PCxvjf5Q2dUHlELDrCrZ6kxz2f9r/C
mulbXoc/7UhUjeyrGzi/d+ZJ/YzFjg==
=a/+i
-----END PGP SIGNATURE-----

--Sig_/zpAG6xHoBv_D/DEo5Opsu+k--
