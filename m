Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A416317C418
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 18:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCFRSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 12:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgCFRSj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:18:39 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D179E2084E;
        Fri,  6 Mar 2020 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583515119;
        bh=UltXGOsa7bHzrhE8tvZXHxykcnPio34Cv7/Wbz7SWXg=;
        h=Subject:From:To:Cc:Date:From;
        b=0A2/qG+m7/cH9ADsqiokgIqsJr7j7Nsx3wHX3wXg3qmF/AEC5M9b9Cc3Ge2ZFu1fo
         MsY43O0yhUmxm/dcESl+Pj/r8EkZ3xWqyiP6Co73HyXyWRD4rDfveb4/U4I9C6QttP
         XLFibcVs/6CsVa04j+dfVRLH5em+A3Roughiqk/I=
Message-ID: <a14229cc7aabebfdffd405018d939d7a0ae1f1cd.camel@kernel.org>
Subject: [GIT PULL] file locking changes for v5.6
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 06 Mar 2020 12:18:15 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-34XoMFCiUFMKGzbgYQmp"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-34XoMFCiUFMKGzbgYQmp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b=
:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/file=
lock-v5.6-1

for you to fetch changes up to 6d390e4b5d48ec03bb87e63cf0a2bff5f4e116da:

  locks: fix a potential use-after-free problem when wakeup a waiter (2020-=
03-06 11:54:13 -0500)

----------------------------------------------------------------
Just a couple of late-breaking patches for the file locking code. The
second patch (from yangerkun) fixes a rather nasty looking potential
use-after-free that should go to stable.

The other patch could technically wait for 5.7, but it's fairly
innocuous so I figured we might as well take it.

Thanks,
Jeff
----------------------------------------------------------------
Kees Cook (1):
      fcntl: Distribute switch variables for initialization

yangerkun (1):
      locks: fix a potential use-after-free problem when wakeup a waiter

 fs/fcntl.c |  6 ++++--
 fs/locks.c | 14 --------------
 2 files changed, 4 insertions(+), 16 deletions(-)

--=20
Jeff Layton <jlayton@kernel.org>

--=-34XoMFCiUFMKGzbgYQmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAl5ihdcTHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFYOMEACsbq0GmEER7l4x9BxClX1TbFIKxBk3
eUP3QyW6F0QrGSaWQl8uIEf2oo0dLI8lzUazcRVsoAQbdd0mvod0U0rpCwTW2r4P
2WL1lttQOTfEgTLiWBHp50nAA96AfSKeBvHzWtvrLyQfl7fRmVSGDMwhaDAvd/Gy
5l9kZOgqqb/G0P4OqZqRUfTDCfGSvDq0RKyPlWdrSVXR6RcvsIsZJNShRMLD80j7
466Xf7qLGeBOpYyXG+c+/UC44rmaEkeD7AqCzP3KfIpP/SvT5demJPHCo61sc/Fo
F5cP3uR5N/JjXsK7NlOBfm+vWpNuSDmrgyLuKWX+yX0bRXqAfBurYfK7F9C1LcSv
258pmm2DoOmRJJhdPzC2UBrpwFlBVncuoSkbQj7ABcoYubYMpAbkWZZRDSKMOaEn
IAPmRU8Cc41f6EexNQ47YO3x31iLYpEoIBHpN+YUvkdJnmzVGR6ZZewh71aIauX6
sNSk4hVqEeRIcU22JLcWHs3CnA3/RH8kx8/9HnKiXsK7XnA1P+VevNchwt2evp2E
rB8Nhz3UcyqvIE+gYQFldoKa2J9szMedBMwoA8zgaFxul3tyknc2bmHewA39C+ic
zNvK4nNfixNX+eQfHG5tcYlAMDCR9PLA3RUGiCOKxuYHvMbdQ6G9D1u/wVLO9Xd+
hcnRAiFzzjaXJw==
=yX6r
-----END PGP SIGNATURE-----

--=-34XoMFCiUFMKGzbgYQmp--

