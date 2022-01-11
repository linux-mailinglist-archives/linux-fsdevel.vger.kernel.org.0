Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F20548BB70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 00:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiAKXcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 18:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiAKXcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:32:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC41C06173F;
        Tue, 11 Jan 2022 15:32:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYRmM5gZ5z4xmx;
        Wed, 12 Jan 2022 10:31:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641943919;
        bh=4Z3sqpGIFVL84J+SH3/JqcsCmk3/t539vZt80mjQAn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CAL+VhB7tnGuerjBXg+KBrIXNM5L47Grr2Z7MctVembeA/rhXP/4Qlff+eCDzsasV
         m07b4UblcBcm43Gt6g+CJaaPiTBASmT/8BpIYuXG0NheZif123+Jx3mSG4ghjD5Bnr
         vKKAPvQRgL6gxoRfQc3w+t52HyU2Os/2DuZKOZTS1fOqFAoDtgP7C2312g4o2oCT9E
         ERz+u6FsuLxtJw9CYnZASZbrKyZ1A31xsC+V69GzuN44Trb8RVnjGBHrbSpTbGiYjQ
         FJEC1IE7aJxnO2oJnV8uNmJItDD1jVnRm6IH/ot9+21m/9tIAwlSSUqFWNTrs1TqXI
         8mSVssM+Jlbjw==
Date:   Wed, 12 Jan 2022 10:31:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Daire Byrne <daire@dneg.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Omar Sandoval <osandov@osandov.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fscache, cachefiles: Rewrite
Message-ID: <20220112103146.03c88319@canb.auug.org.au>
In-Reply-To: <510611.1641942444@warthog.procyon.org.uk>
References: <510611.1641942444@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TSD_6X.o4QL4mtle5E/6NvU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/TSD_6X.o4QL4mtle5E/6NvU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 11 Jan 2022 23:07:24 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
>     I think also that a conflict[10] spotted by Stephen Rothwell between =
my
>     series and some changes that went in since the branching point
>     shouldn't be an issue with this removed.

There is also this conflict against the pifdf tree (which may or may
not be merged before this):

https://lore.kernel.org/all/20211206090755.3c6f6fe4@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/TSD_6X.o4QL4mtle5E/6NvU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHeE2IACgkQAVBC80lX
0GykKgf+LY4OWHMyvWj+UkQIEcaKG5r9OhPcLyt0zfDe0PRZQmlxXnY3gTri4emO
7Fj3IMkvEOSOP3VZlIRTpYauhwuCpB+yQDB/8X303z+a2aF9f/K1wrt0wvfGAqUY
qlGXd0zwWB9XPkGCkYEMi5oVP6TbMKajCMkq5rFhZcQS7YfHrWS/uJhpcmeVU0gn
BYKtZyQ5RBY8RImGGBnhGjQLxhXBn90mi729iNaFVPzeonasUxYQzZaiWSMGxWov
a2RcKHhg+dwlj1BTgB3lEnny9EM57priTBX8HnJwconRDhrWaGBv+k973nnHHZq0
x1fteziRSjCPvg4mlWtvA8XrBSjL1g==
=alke
-----END PGP SIGNATURE-----

--Sig_/TSD_6X.o4QL4mtle5E/6NvU--
