Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D624163A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 08:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHKGPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 02:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgHKGPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:15:24 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C5C06174A;
        Mon, 10 Aug 2020 23:15:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BQjHW61Pqz9sTM;
        Tue, 11 Aug 2020 16:15:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597126520;
        bh=vmA+U6yYordllIlIbbA0NQplZPeDri+hoiMGp1wkbEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rVFvNdvDn+0X42UKxMtre6LFZycz0m0HXH2n0WFRWQRcQ1MZ0ga42i8Ev/4GGN8lw
         gJDXFsgo1OwUATt9NCedr7N+sBd9p5GCHyU3O4ewmhU0wXa3kwLiLtNZgiguByjJ5P
         b+cPlHiyw8iRsyQhnab+mX+ShF2qJW6WtWeIHZGlAJKWo3kUoe8Kq0om6YRcOoawmN
         5YDjIz1btmZ2UNs8Nc53etiG2rshjvYlyJN0FBfcgnThzb3EWxyfONA8ny00FD0bwT
         +tK1ZWbPukfWkvcqtUjDs8hm2wj8X94mTaSliePXUOiQPtILPMclAZwuOtexzF268L
         ef+8mu0DXqqfg==
Date:   Tue, 11 Aug 2020 16:15:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Subject: Re: Please pull NFS server updates for v5.9
Message-ID: <20200811161518.0896c1e8@canb.auug.org.au>
In-Reply-To: <EC1AA9E7-4AC1-49C6-B138-B6A3E4ED7A0B@oracle.com>
References: <F9B8940D-9F7B-47F5-9946-D77C17CF959A@oracle.com>
        <20200810090349.64bce58f@canb.auug.org.au>
        <EC1AA9E7-4AC1-49C6-B138-B6A3E4ED7A0B@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uT/4_Xdt=yeslqAXJ+Bf_QJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/uT/4_Xdt=yeslqAXJ+Bf_QJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Mon, 10 Aug 2020 08:25:14 -0400 Chuck Lever <chuck.lever@oracle.com> wro=
te:
>=20
> Is there something I need to change? The public copy of the cel-testing
> branch has had this content for the past 12 days.

You just need to keep your cel-next branch up to the top commit that is
ready.  That is the branch you told me to fetch.  It is currently at commit

  0a8e7b7d0846 ("SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim(=
)")")

It looks like that is what Linus merged into v5.7-rc2.
--=20
Cheers,
Stephen Rothwell

--Sig_/uT/4_Xdt=yeslqAXJ+Bf_QJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8yN3YACgkQAVBC80lX
0GwXGwf/X1xza4u2L2jJX6O8CmpIPjjZeO69GKzmnyVVRoOXVzjthv1JJk+wg+7l
7FxHlD8dqgtxuxE+A2Y4OGzpnG+phqoA15e6k5dxscbV9r7LRcweAZNeNO1E/05q
iXJgeV32+PTsRQFLuTQyfyCQjYZDqUt9H2Uh2m4F7xOot+FY8t9PTDw4gbwoYTPT
rZJH1myqDPB++EIWdsZhb3xJuY6I6znFLIceYia+b55DMF7nCATpjOeZxq7sSHIo
2gZlAv7pYw/eANhL+mSn9xgnsYS/VVdEu0BhDoWgJLKWMPjM3f8ZvzuEpaIkoguD
qscoOtH3WIqd5h1S8GFUpOkM920XTA==
=iHxj
-----END PGP SIGNATURE-----

--Sig_/uT/4_Xdt=yeslqAXJ+Bf_QJ--
