Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E914B97C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 15:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgA1Ocx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 09:32:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732916AbgA1Ocw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:32:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 40FF1ACF2;
        Tue, 28 Jan 2020 14:32:51 +0000 (UTC)
Date:   Tue, 28 Jan 2020 14:53:47 +0100
From:   Petr Tesarik <ptesarik@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/Kconfig: default to no mandatory locking
Message-ID: <20200128145347.5e4fc5db@ezekiel.suse.cz>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xwm0zxcQyAV=8Dm=KND=wlp"; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/xwm0zxcQyAV=8Dm=KND=wlp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If the help text says this code is dead, the option itself should
not default to y.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..fc60b8bbebc2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -103,7 +103,7 @@ config FILE_LOCKING
 config MANDATORY_FILE_LOCKING
 	bool "Enable Mandatory file locking"
 	depends on FILE_LOCKING
-	default y
+	default n
 	help
 	  This option enables files appropriately marked files on appropriely
 	  mounted filesystems to support mandatory locking.
--=20
2.16.4


--Sig_/xwm0zxcQyAV=8Dm=KND=wlp
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl4wPOsACgkQqlA7ya4P
R6dv8ggAjkoehufY1utaFFX3CabNFkNCMx/T5zH/RQ6yheefCUP9M4gveQo9sttu
eV/km+EpZzPK4KH7h61rbG+OTtWXDvjsmKtXp4F4zBQm9sC2KzlStvgVLOzirQjh
1oPSkDC4QSSQop7ZTAUvSF6gnU5HbZch9HiD6aLfUWt7lm2qPGf/vfCVINCLBTCj
BIMhiTJBbcwT/AbADoHVyIt1S/GbslFay5RxD00g9Gv4zLY8B1EHlof8yx+URdA7
1Am7oKp2/0mpwcmzPUZyyxCKkzghN9mDZVQNzh1X1XXQkrYYjRVVck/0+oGUao3L
uqeZZOvgaoFQTcjxyqGfJNJGBG/nfA==
=d6jB
-----END PGP SIGNATURE-----

--Sig_/xwm0zxcQyAV=8Dm=KND=wlp--
