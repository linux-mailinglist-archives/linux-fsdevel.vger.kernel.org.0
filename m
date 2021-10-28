Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7543F39D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 01:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJ1Xy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 19:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhJ1XyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 19:54:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E752C061570;
        Thu, 28 Oct 2021 16:51:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HgMlw4DB8z4xYy;
        Fri, 29 Oct 2021 10:51:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1635465102;
        bh=BBq1Yspji0vJm9R7zIGdVaVx2DU7+FD6B6UrqSLpbPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YD23+cizlmSgewjdmhU7noKEZETmDps4i3fEy4IW/h0x6VStpgpxY1SvfXRmhLtgC
         R73C2AZR/Zrym+A1IeFvOgQbitR7EGkFxQf2ORBS1apsKDtBt+EQj4fHovArvkT+kf
         nxR1Bm0IAGIfvB3B4H1UIssoHggQZvP8YWpJU7ptHk1b99ZDJ8zxYcQOkZ6KEP84P1
         vmYaqwCIDQ6FGWqA0g1ZhEHfTSfvaWL9UZW2oNOXFweire0ERYucF3+NhB82qjA5Id
         NJ/2F+0+PVhmuDV3uC5qLEVXNIGPdBL1KvnMm3S66zK15p/TeHFQGImQ+t3EncV3RW
         XO4GmcNhtz05g==
Date:   Fri, 29 Oct 2021 10:51:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211029105139.1194bb7f@canb.auug.org.au>
In-Reply-To: <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
References: <20211018044054.1779424-1-hch@lst.de>
        <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SsoWmhnAUHONY.PedkLs.lt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/SsoWmhnAUHONY.PedkLs.lt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> =
wrote:
>
> My merge resolution is here [1]. Christoph, please have a look. The
> rebase and the merge result are both passing my test and I'm now going
> to review the individual patches. However, while I do that and collect
> acks from DM and EROFS folks, I want to give Stephen a heads up that
> this is coming. Primarily I want to see if someone sees a better
> strategy to merge this, please let me know, but if not I plan to walk
> Stephen and Linus through the resolution.

It doesn't look to bad to me (however it is a bit late in the cycle :-(
).  Once you are happy, just put it in your tree (some of the conflicts
are against the current -rc3 based version of your tree anyway) and I
will cope with it on Monday.

You could do a test merge against next-<date>^^ (that leaves out
Andrew's patch series) and if you think there is anything tricky please
send me a "git diff-tree --cc HEAD" after you have resolved the
conflicts to your satisfaction and committed the test merge or just
point me at the test merge in a tree somewhere (like this one).

--=20
Cheers,
Stephen Rothwell

--Sig_/SsoWmhnAUHONY.PedkLs.lt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmF7N4sACgkQAVBC80lX
0Gxw2gf/TsRhRytrNIQkXZwCrlHR+hjJ895jJhg4Hp+ig2QzzYRjM/GrSPzXAXF3
s5SscPXv7egnMo+fHKY9d/CscYD6kDg4FtBuvoJqx/ApGN4PQLme5S3KbxrNRgd2
2vpBRjXN+26toUw0W2PK1gzHRJXaB6waOFbA6crbuWU1BDzVZoeRHfjKtlBMax7Q
g6pzcvDzs7ia50KBJvi6hNkxCy7xuNAsLlm96930v/bLvnUYo6dOGrzZ6/Kjzjcw
LpWIuVQGxkzBiILaGSiHuNfzZEbSvoSXMfMRJ5KBpAhB8M1dhuyqP4QBWMwe7+Tn
Oo6WLOwKx89LL+uStt4yje6yx9483w==
=+eTD
-----END PGP SIGNATURE-----

--Sig_/SsoWmhnAUHONY.PedkLs.lt--
