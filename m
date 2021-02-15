Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9831B85F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 12:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBOLv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 06:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhBOLvI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:51:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C06CE64DFD;
        Mon, 15 Feb 2021 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613389826;
        bh=1O2ZAfyhwnctNig5Kkji9nFvZQTlpIIhVaXrpX4Qd54=;
        h=Subject:From:To:Cc:Date:From;
        b=bfDoALhtxqsUkI5Z+E+1bklP+WEf51/Mgl8JTePLTx4vVjn97RhkSVGVOondBh6Ze
         0m/oHxdv1w2OoHKS74SAvibSGOeIMGCsuZKj6ruxFbnx0WAfr5qll539DTfXaLLGDp
         EtK09vly4A9ncjS4lFwZ4c5muWtUFf0OrNjSvEb89DX8pwgpdliMKIBcQHeUvon+af
         wZmhsnm16kLXxOQ2M8eGTFcpRmG3GdAStToIGGYrPaoXX9hV9xMuB509HCK3/aqrk1
         DU63yNlG6q9GTYcsEoLrtXiu3oJlhk+bURBjY1S6+mv9BG0seMoOjmENChTqhmSPab
         bI3wZHbz+ik+w==
Message-ID: <b811d76937408f4fded7314da18f770b88c83fe2.camel@kernel.org>
Subject: [GIT PULL] fcntl fix
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Feb 2021 06:50:24 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LNHjxsThbfUszIrk08Ao"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-LNHjxsThbfUszIrk08Ao
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3=
:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v5.12

for you to fetch changes up to cc4a3f885e8f2bc3c86a265972e94fef32d68f67:

  fcntl: make F_GETOWN(EX) return 0 on dead owner task (2021-02-08 07:36:13=
 -0500)

----------------------------------------------------------------

Just a single fix from Pavel for fcntl(F_GETOWN(_EX), ...), needed for
proper functioning of CRIU.

Thanks,
Jeff

----------------------------------------------------------------
Pavel Tikhomirov (1):
      fcntl: make F_GETOWN(EX) return 0 on dead owner task

 fs/fcntl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--=-LNHjxsThbfUszIrk08Ao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAmAqYAATHGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFZnkD/9byKXRJnPAcMf3UzFfP4imHyJugUxm
+mYLKufiNRVDW8aq1bTiwVBJcqMCepTTFs9U1MgkYemNJa/myb3BMdYFgJffF27/
NJXiccCHcZowLZKnZbsB7hn65H1QIOhCgT4ps1JCdrFJHkP3Msvco21YdsSeiepR
Y5VXTO5aMkXS3jYJ+oDlaf0nDK1D49cdYDsiHW6i/rxonKYzuRcIADZXWWq1P67M
yKsstp6zzk8GHjquslVXi5mLb5Eqne0xnJz4LOueBwg9EqepJtS4ZSeyFzEMYs9f
I0XjG8et9Rn/wy/VReiMdIQrHbhCYdImOSohaCKAIW9X6hllU15TcH3sTG1Kw1/k
MDdqRl6ETDu55oJmkAEEAT+DM0DsmiSjK6eTVsKQyjQQtoNv1xXb/qKsVgqXirID
GVRVbFHMO/8bdVNp7ik5Vp574qgy1JePWL5YCDL+YtVkv54vNhWbUx4ZkS0mBv88
jnI/iTcCm7IC33ejwbeCGNtz7suctpe5w0Hb6ykOYv6VDH5fK7T0Z2dK77sFkg+t
eNos1JBYKPSEavxsfUApdkpcSoDv8/J8qZ8aUWWeisgWUt4jWiuUYfCR36nRVXqS
x0aEF8084pJhE7EC6+4hzI7E0c3AbjCGH09oqQQlQP5ih8GPrcAMO782g4NPuyW0
VAafUnUDFAZgJw==
=/Q9X
-----END PGP SIGNATURE-----

--=-LNHjxsThbfUszIrk08Ao--

