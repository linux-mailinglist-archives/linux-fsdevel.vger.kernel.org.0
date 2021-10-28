Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E979743DDF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJ1Jti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 05:49:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:36969 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1Jth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:49:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hg11S2T3qz4xbr;
        Thu, 28 Oct 2021 20:47:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1635414429;
        bh=JAy5EQiMGHwZGBz0rz91x7YvEwCL5YFS18MMfr4ubrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PHNh108rq8G4lmGpwdjVSZziH+oU62FurnqtS/qwLBowk9hHwnFgFfAJcI6Md7iMF
         CuePF4pf8ZHRKSoONBBfb/Cfqi5bvx4g18/0TGMiRr3zMUnhW3AnGAiQR59UaqVKHK
         K3fAXh8YO25yXxMMUo+I+RqS12SXkKptg3yQ4mkjOWGXbEfP5Iurf6qL/f1xOei2bf
         WBEIQPFy59LQCy6h2PMYV81bajVWVTtZXk0hM1GNYF9n0Jr3PtyLfKcRV/H7sFiv/Q
         tfEB3VfWHyRLNcw8HBbQcxNDldEJj7usToC495nI+1mQJ5wjksdxIdjG65mzvIQ+3S
         NWFWhDecOs0Dg==
Date:   Thu, 28 Oct 2021 20:47:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Track unicode tree in linux-next (was Re: [PATCH 10/11]
 unicode: Add utf8-data module)
Message-ID: <20211028204706.7c3aee30@canb.auug.org.au>
In-Reply-To: <877ddxdi20.fsf_-_@collabora.com>
References: <20210915070006.954653-1-hch@lst.de>
        <20210915070006.954653-11-hch@lst.de>
        <87wnmipjrw.fsf@collabora.com>
        <20211012124904.GB9518@lst.de>
        <87sfx6papz.fsf@collabora.com>
        <20211026074509.GA594@lst.de>
        <87mtmvevp7.fsf@collabora.com>
        <20211027090208.70e88aab@canb.auug.org.au>
        <877ddxdi20.fsf_-_@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VYwQvd5q37uHoWwiQmRtnt2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/VYwQvd5q37uHoWwiQmRtnt2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On Wed, 27 Oct 2021 23:00:55 -0300 Gabriel Krisman Bertazi <krisman@collabo=
ra.com> wrote:
>>=20
> I'd like to ask you to track the branch 'for-next' of the following repos=
itory:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
>=20
> This branch is used as a staging area for development of the Unicode
> subsystem used by native case-insensitive filesystems for file name
> normalization and casefolding.  It goes to Linus through Ted Ts'o's ext4
> tree.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/VYwQvd5q37uHoWwiQmRtnt2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmF6cZoACgkQAVBC80lX
0GxCkgf+PRokTvbLrCptDmsPCL72nWIaurHRH1t55hy8HX9+KcrrWeqGFCdw3eoe
h4hUhjAmAV9zvOJLMf+SCLcsGt4xURHCm3rXZIFfWkxJI7nDRnAnmZtBB6LsUBJV
Q/bIqQmYLQB2qBjhl4Mlf2EpbpbXFUG5MVIhVjHhTDhBVXRuiNf9mT4ZAHq3DXEo
RSgxFDlO2lBxTyfmA3JGZ+DgZEc1FZA8OC3BMBEvEtMvmAZpZtPPNdTfEGGxCZPl
Byh9b9ON4jFYXQRqOQ3oR1OWEpfaKCsWLeIKVtEAY9NOYNMKetctoA8LKzETfN3e
hHGD4pxSpBBxRTVM9RCfTMENUE/z/g==
=dAt4
-----END PGP SIGNATURE-----

--Sig_/VYwQvd5q37uHoWwiQmRtnt2--
