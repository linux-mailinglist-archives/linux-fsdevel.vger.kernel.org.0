Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE712C2AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL2O2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 09:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfL2O2G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:28:06 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9012071E;
        Sun, 29 Dec 2019 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577629685;
        bh=OBaK02stK6fkBOfYCl6FpDaImQZSgaTTehgNnd1jZtc=;
        h=Subject:From:To:Cc:Date:From;
        b=KifPqGEcZmRiA7zYbkHBgj7yc3XyJ/rCKhz9o4Fgmi/jI5GN+O8qpTw7CB3rSR0Rd
         wEWNz4hfIgojiN7arGbcbit3p+FAFJOyrWdz7hsa3t605Du0W9HfC/3o7R/tN5F4K2
         nG2F3S4N4DBdWnqPHayItciFHXUXBiFgLGhxQS+k=
Message-ID: <e5d1c0a5e5e92083d8ce0bc1e48194a6d70fb918.camel@kernel.org>
Subject: [GIT PULL] /proc/locks formatting fix for v5.5
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <linus971@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Date:   Sun, 29 Dec 2019 09:27:58 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bz/QcxZUAolwbvJE3Ox5"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-bz/QcxZUAolwbvJE3Ox5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46=
:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v5.5-1

for you to fetch changes up to 98ca480a8f22fdbd768e3dad07024c8d4856576c:

  locks: print unsigned ino in /proc/locks (2019-12-29 09:00:58 -0500)

----------------------------------------------------------------

This is a trivial fix for a _very_ long standing bug in /proc/locks
formatting. Ordinarily, I'd wait for the merge window for something like
this, but it is making it difficult to validate some overlayfs fixes.

I've also gone ahead and marked this for stable. My hope is that no one
is actually depending on seeing these values represented as negative
numbers, but if that assumption is too risky we can drop the Cc.

----------------------------------------------------------------
Amir Goldstein (1):
      locks: print unsigned ino in /proc/locks

 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
Jeff Layton <jlayton@poochiereds.net>
--=20
Jeff Layton <jlayton@kernel.org>

--=-bz/QcxZUAolwbvJE3Ox5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAl4It+4THGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFVCUD/4qtUNCAMGXCkIswTcGQc3sKWfBPjWG
KQ/cUzMaYRLdMfm5WhpVKa1Ml4ER1h/otHX/fGC1kHq8IU1osFPhxlTI/PSNdUyE
msxPInk2zYCkBJVMM7OD/fHA2E0juajO/Mh2oF7t2X3eGYrj+eDwP/9LUyw6v/RH
1XdmVKg7jgWGi7pWukvl8eXlqrDGl9kZHTil4+amTsfeWo+fioMt9c21nSiGOyNp
F+beMmf83sKbaVSs4luv9D6PX2BbWlEJkwcQjTnczVnQSx3p6hODqPn6y1DCTsxQ
1MFFtK5xzzeru/oIrUBwhtqBvZVJJfjHFP65BNM5fpQ9gyyQQXlV3eN+Ug+MpE5Z
quElSVWa/0AdV7nGx5Kq7LCWcrLwjf7QMuXJrupkWVZ/VRJuhY/pelV5l5DPV4lj
Pl5Z/AnEy2zv1rLRWZIKvdwnJhUvnd4xfRktxImksPDJn0LPz5GdzXj0h1noOweB
38Uti10M+TeCfZVPqes0O2u2uo9m7h2R5KOfQiAu8i/jzS9yRo3cyxhTv4gMAsja
BY5YRN4+dMK90BpeaaI0jCZW+51l+Nf9IGx13eKHAHveNSErp+WHhsXiKVTaVKlC
1NQhbF7sTtk+aJVZLDRRuCBvyLFFaOU4hXj6JD4eq+TN6VUyWMOEvxC5I/s1s5Ml
mwrHpR1Jz/kB7Q==
=05sj
-----END PGP SIGNATURE-----

--=-bz/QcxZUAolwbvJE3Ox5--

