Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C38263A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 04:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgIJCQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 22:16:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbgIJCNq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:13:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B68A2AC1F;
        Wed,  9 Sep 2020 22:51:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 10 Sep 2020 08:50:42 +1000
Cc:     milan.opensource@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
In-Reply-To: <f4d38a20cb0f25b137fe07a7f43358ab3a459038.camel@kernel.org>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <f4d38a20cb0f25b137fe07a7f43358ab3a459038.camel@kernel.org>
Message-ID: <87mu1yk1j1.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08 2020, Jeff Layton wrote:

>
> Yep.
>
> My only comment is that there is nothing special about EIO and ENOSPC.

There are two type of errors that fsync can return.
 EBADF EROFS EINVAL  - these are usage errors.
 EIO ENOSPC EDQUOT   - these are functional failures.

So I would say there *is* something special about those errors, though
it isn't *very* special, and it isn't *just* those errors. EDQUOT should
be included in the list.

NeilBrown


> All errors are the same in this regard. Basically, issuing a new fsync
> after a failed one doesn't do any good. You need to redirty the pages
> first.
> --=20
> Jeff Layton <jlayton@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl9ZXEMOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmtzxAAhBP7kWRRvSM5FxqzA6R1/UmOSLt/LHYytyww
brm0loAU/lStB6kJcF7eTUBo+4hQaKNyTwfoAQCVTi+u3oEhvz/TsR1Zmc8qLY5X
6N0f0bFjIbRghPVBjqi1HZX08ZPJkiQF1XsYRKwnijf6WChLZy8Fh6bi5hPo61KU
KyG6Lt0S2NQj62lPvCdy6JfxXDeQPZ4nMRu99d5of8yShcdPyIhH1nTRg0gnLsvF
4HDmxYiY6DzJwdjvHOohTMIvQNd8v+fUWLP8TbI7F6xJeqSEWpi2SMs9q5HL/rGq
Dn6DA3xkS4kqH1iWRZYdhvPSoWHLeHMl6z5GIvKsc1PuxGuek1sqR9Lw9KQSFBY6
QMf2RkBSQnmm5PFPq1xQsm3SDDS9YIFHt+GRDZWtD6yHzUoz8xe27g9j4uUqDVNn
lzG2v+Ae7UcyhJIOJjiYh3n+JysUgUhEbx/1VSc0Sykg7O778OWafouAsp9UEoDD
zyWNp2n9cltcjJ4cRA0qmWNYcSf6tTeJSaCkfsqnsYdVMmpjRM04MHm1K7nlYs2L
dBbAfwXLw3aMkZFXuFLhigFyjgqj0+OBLR4imrfbYn83OfH/im3Hd6umhP05eaZ+
HbJi7W0Vj9xUavYd09qkrdRD/JHJnqazKD4o6FIV4jvfcMfl0iRnTK6Y5aq1WcQ1
T4ak25w=
=8VKx
-----END PGP SIGNATURE-----
--=-=-=--
