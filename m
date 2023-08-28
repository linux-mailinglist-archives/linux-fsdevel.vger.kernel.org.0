Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B438D78B10B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjH1Mvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjH1Mvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:51:37 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 05:51:34 PDT
Received: from mail1.g1.pair.com (mail1.g1.pair.com [66.39.3.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F1102;
        Mon, 28 Aug 2023 05:51:34 -0700 (PDT)
Received: from mail1.g1.pair.com (localhost [127.0.0.1])
        by mail1.g1.pair.com (Postfix) with ESMTP id DB5B35475B2;
        Mon, 28 Aug 2023 08:33:14 -0400 (EDT)
Received: from harpe.intellique.com (82-65-97-13.subs.proxad.net [82.65.97.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail1.g1.pair.com (Postfix) with ESMTPSA id 4B2AA60AE4B;
        Mon, 28 Aug 2023 08:33:14 -0400 (EDT)
Date:   Mon, 28 Aug 2023 14:33:17 +0200
From:   Emmanuel Florac <eflorac@intellique.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs: online repair is completely finished!
Message-ID: <20230828143317.1353fc3f@harpe.intellique.com>
In-Reply-To: <20230822002204.GA11263@frogsfrogsfrogs>
References: <20230822002204.GA11263@frogsfrogsfrogs>
Organization: Intellique
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wnV4DjYm.QRFJhbHv_ucyer";
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Scanned-By: mailmunge 3.11 on 66.39.3.162
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/wnV4DjYm.QRFJhbHv_ucyer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le Mon, 21 Aug 2023 17:22:04 -0700
"Darrick J. Wong" <djwong@kernel.org> =C3=A9crivait:

> Hi folks,
>=20
> I am /very/ pleased to announce that online repair for XFS is
> completely finished.  For those of you who have been following along
> all this time, this means that part 1 and part 2 are done!
>=20

As nobody chimed in to congratulate you, I'll tell it : you're a hero,
Darrick :)

cheers
--=20
------------------------------------------------------------------------
Emmanuel Florac     |   Direction technique
                    |   Intellique
                    |	<eflorac@intellique.com>
                    |   +33 1 78 94 84 02
------------------------------------------------------------------------

--Sig_/wnV4DjYm.QRFJhbHv_ucyer
Content-Type: application/pgp-signature
Content-Description: Signature digitale OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSAqoYluUD5h4D+mbZfeNBc1SJxVgUCZOyUDQAKCRBfeNBc1SJx
VlsuAKCJq7GnxD8P4diO3xL0qwmRC6lDGgCghEhuU7aSAwx1IrTtHd9RNorsTF0=
=+vht
-----END PGP SIGNATURE-----

--Sig_/wnV4DjYm.QRFJhbHv_ucyer--
