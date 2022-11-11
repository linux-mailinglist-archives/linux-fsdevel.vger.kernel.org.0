Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C135B624F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 02:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiKKBQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 20:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKKBPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:15:19 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDC3D27FDB;
        Thu, 10 Nov 2022 17:14:44 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1B69E454;
        Fri, 11 Nov 2022 02:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1668129284;
        bh=MoO/mUS5QNTMdZjDy+3p1P3o4Hu+RTNLEIKcnT/Qc4M=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=bwTSyNh/k3T4mHiVjl8qy7gY/YvacL9rTyoGH4wcsDXjKeT2P98D43lFDh22tJSCv
         8Wrjii10haT2EvB1m7M4gGm9Sym/ULurTisyxMHoUdk/brts8x2Zg0vbSuoY4XdE56
         yQNz+1Sj0rb3WfvkdyZtERrUHAj/Y+PYFd5KP3QwVg2Rp7dIhcNnfDEJ8RZocP+oF6
         l/cCJWJKDy53gF+VSxABsfr3r8ij2n/TG4xtf8mVltUYBPRoY6BfsiEdlK9+OEPwF7
         6mPSSyQ1NdHTr48J7kmcqnpyj7T0xQgJZQdI1f/bA5qlVV9/wCfwmndz8YyPVvR6id
         +ZoVJXnHshBdw==
Date:   Fri, 11 Nov 2022 02:14:43 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/15] fcntl: remove FASYNC_MAGIC
Message-ID: <756e6016fab23e95d891b6284fbf52184135ee46.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ex6cawgqxz56lbn5"
Content-Disposition: inline
In-Reply-To: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ex6cawgqxz56lbn5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have largely moved away from this approach, and we have better
debugging instrumentation nowadays: kill it.

Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 Documentation/process/magic-number.rst                    | 1 -
 Documentation/translations/it_IT/process/magic-number.rst | 1 -
 Documentation/translations/zh_CN/process/magic-number.rst | 1 -
 Documentation/translations/zh_TW/process/magic-number.rst | 1 -
 fs/fcntl.c                                                | 6 ------
 include/linux/fs.h                                        | 3 ---
 6 files changed, 13 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index e59c707ec785..6e432917a5a8 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -68,6 +68,5 @@ Changelog::
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 Magic Name            Number           Structure                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 37a539867b6f..7d4c117ac626 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -74,6 +74,5 @@ Registro dei cambiamenti::
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 Nome magico           Numero           Struttura                File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index 8a3a3e872c52..c17e3f20440a 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -57,6 +57,5 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 =E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97      =
       =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
index 7ace7834f7f9..e2eeb74e7192 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -60,6 +60,5 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 =E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97      =
       =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 146c9ab0cd4b..e366a3804108 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -924,7 +924,6 @@ struct fasync_struct *fasync_insert_entry(int fd, struc=
t file *filp, struct fasy
 	}
=20
 	rwlock_init(&new->fa_lock);
-	new->magic =3D FASYNC_MAGIC;
 	new->fa_file =3D filp;
 	new->fa_fd =3D fd;
 	new->fa_next =3D *fapp;
@@ -988,11 +987,6 @@ static void kill_fasync_rcu(struct fasync_struct *fa, =
int sig, int band)
 		struct fown_struct *fown;
 		unsigned long flags;
=20
-		if (fa->magic !=3D FASYNC_MAGIC) {
-			printk(KERN_ERR "kill_fasync: bad magic number in "
-			       "fasync_struct!\n");
-			return;
-		}
 		read_lock_irqsave(&fa->fa_lock, flags);
 		if (fa->fa_file) {
 			fown =3D &fa->fa_file->f_owner;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..acfd5db5341a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1345,15 +1345,12 @@ static inline int locks_lock_file_wait(struct file =
*filp, struct file_lock *fl)
=20
 struct fasync_struct {
 	rwlock_t		fa_lock;
-	int			magic;
 	int			fa_fd;
 	struct fasync_struct	*fa_next; /* singly linked list */
 	struct file		*fa_file;
 	struct rcu_head		fa_rcu;
 };
=20
-#define FASYNC_MAGIC 0x4601
-
 /* SMP safe fasync helpers: */
 extern int fasync_helper(int, struct file *, int, struct fasync_struct **);
 extern struct fasync_struct *fasync_insert_entry(int, struct file *, struc=
t fasync_struct **, struct fasync_struct *);
--=20
2.30.2

--ex6cawgqxz56lbn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNtogIACgkQvP0LAY0m
WPEH2w//T2hWSD7xn3M02K7FydhyW0/rTvoslgeyEBz5PkqXLjvZvoq1o1dCBGtB
az7GTffbbkzp4v7R5Zu1BNEvhFXrBYLqcpzDBtHYk488u8tDNSP303WutiAfbqu2
tv6mqHdCu3gzgAeXCZdHakMOrQST1kXh5TFkMqC09qDvm8L/kLFyp5U4gGY2haCC
DNe24a/HnS0bIGPOKH4bJHZaTzJi7omVEweIdTNaxQV9NGtGMK/x7tHWC47M2TJM
7M/u6z1rbObQeU/2YAmgFylXurL5VPfSev4r8oI2uOqB3Z5dlC7HacDXxLmHAfcg
3ckJ5oW4Qn65nJeOMfwFyXUWSq/XKbtWvituM2nHVS6tzcx8SagGs0EbTqIo2f1U
ZjeFt7Q+P2w55lf1zz8+tdQtj84yFcS4hXvtx5q6Ybx6OWZ0gpITmtoPjb26pvwV
Q7p8ZoMAp+2t8aOzWVsNtBksqoCbraahvBJ0FDKQ6dSohu/uzGMleOBlcyOpi4fm
o3HRA3zwz6kdygG/2TFmMa5yp3SyyGuwv91drX883f7v1Oa47soaS5uDgCAd54aI
RCVmFtI6zr/25f/35FpaKxAHipWYd1oVPe3vr/kTs//0/bvXhx2YtI8Vh6L3rKqr
tYmhLLfawlakpQ769ntxNY+wrqTTLZTWav4mdhrkPwwyctQ1ETo=
=4RTi
-----END PGP SIGNATURE-----

--ex6cawgqxz56lbn5--
