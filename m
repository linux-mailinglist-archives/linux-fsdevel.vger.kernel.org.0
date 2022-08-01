Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE25867E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiHALID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHALIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:08:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAA25EB9;
        Mon,  1 Aug 2022 04:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69D6FB81015;
        Mon,  1 Aug 2022 11:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10DC433D7;
        Mon,  1 Aug 2022 11:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659352079;
        bh=yhvvbg6GF1sEgC1dFsVO2YGfdbo91aaJfzHhGKT/T5Q=;
        h=Subject:From:To:Cc:Date:From;
        b=foRyyHoOA69mTCsjGKUbto7dyt3Th2qzXXge69tlrsEBR/XGz3wR50NoJVIcENggW
         4y7Zz83UF6L+gtRNXh3V6QiVyI8s++gSJvPYrXwnw7LW/VaiXDYuH36Z07/ui0Ae2v
         H/iKWQEtflQHlofqFCD4uDTdCtP15rWd8/b58h4QqFip1CuI2xmACrr7zghz262f3L
         BbLLYmX27PzN64Y6uUtfzMi2agrIcWGpy0q3JMqzFJkTloMcC7HRs/p1HWBGuco5c5
         hZfDCBdL5wxZbQpbqvKfEVGLSixstwSCPqa2lC+rCHmJioBhcLxcuD34w0A+RWz2jf
         VnUCF5FAB5WSw==
Message-ID: <6dfd152d3643c568b928a96d334b50754cd752d4.camel@kernel.org>
Subject: [GIT PULL] file locking changes for v6.0
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 01 Aug 2022 07:07:57 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JJ/ZILuXfnDP7WXpxKjl"
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-JJ/ZILuXfnDP7WXpxKjl
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28=
:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/file=
lock-v6.0

for you to fetch changes up to db4abb4a32ec979ea5deea4d0095fa22ec99a623:

  fs/lock: Rearrange ops in flock syscall. (2022-07-18 10:01:47 -0400)

----------------------------------------------------------------
Just a couple of flock() patches from Kuniyuki Iwashima. The main
changes are that this moves a file_lock allocation from the slab to the
stack.
----------------------------------------------------------------
Kuniyuki Iwashima (2):
      fs/lock: Don't allocate file_lock in flock_make_lock().
      fs/lock: Rearrange ops in flock syscall.

 fs/locks.c | 77 ++++++++++++++++++++++++++++------------------------------=
-------------------
 1 file changed, 28 insertions(+), 49 deletions(-)
--=20
Jeff Layton <jlayton@kernel.org>

--=-JJ/ZILuXfnDP7WXpxKjl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAmLntA0THGpsYXl0b25A
a2VybmVsLm9yZwAKCRAADmhBGVaCFUlREACUrULlM4SporlHDF85svm+S3sBIiDz
q2cb+k+KzybCYSZ9Nxv7KtVbFrRXa4B3vu7sEm2X+sjc7tc9uD4yJpwx7bfMq7vS
0eOtuYWQMLe/KCzS2IS7l5LMnnzbjkg5LwsKR1REnsddqMHWELU6E3RbPdTLiZli
uzMaC1yin2BFC6kWcWGxIxHkuwz4lGTnN7RfG42vToX6CRPb8J4k4LmBFaCLmij1
rsluYto9wrBuvARH9EN032tz+1cIIrcIBJS76PLjURv87bRKPvK3vKPQm2CPgG7H
9k3FWV8c1C9J6Wvnp+Iiy0xcvGDqqDqpfDPw00qNJ3E0m03zVqiUfeWoffhlQeSK
eZZY11UNhsmaKx0JUDtH96DVOSRy72lLpeeDtTacOd4ruYdJ9Zr7xM2BRHUTbytM
hPTzuz2rF6n0Z+/pY+MugSvTrvBNOnYDi4LLNQ8mkefIWPtQn9SaSMriTlm3JSkx
Sm1ERxC+lrhQkDX36UIsz3pAzYDvYOYizVk/zxutDpK3JJOgtXMaD7pHLaK83AVA
GbnLJr54visdq9QfXSV6tBbKcOtnbDmSE9pbiVDRtkdQsOo/PVtzNUHoC4vrF1xN
OmUw56kkeA2PziiYDJPXwd3yOFYpOSabQDALbv4eJQy0jUTJBlXQ2p8n6t2BBZ/0
S3BETpRMQMp5cw==
=OOlp
-----END PGP SIGNATURE-----

--=-JJ/ZILuXfnDP7WXpxKjl--
