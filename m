Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370202C5E34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403879AbgKZXdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:43 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55386 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391952AbgKZXdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id C3E58181C8919;
        Fri, 27 Nov 2020 00:33:40 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uf6cIM3ZuHZ6; Fri, 27 Nov 2020 00:33:40 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OhjwzHkz5YTb; Fri, 27 Nov 2020 00:33:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/7] MAINTAINERS: Add entry for MUSE
Date:   Fri, 27 Nov 2020 00:33:00 +0100
Message-Id: <20201126233300.10714-8-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since MUSE lifes in fs/fuse/, make sure that linux-mtd@ is CC'ed
on patches such that MTD related aspects of changes can be reviewed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94ac10a153c7..92359bb8d133 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11959,6 +11959,13 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/musb/
=20
+MUSE: MTD IN USERSPACE DRIVER
+M:	Richard Weinberger <richard@nod.at>
+L:	linux-mtd@lists.infradead.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/fuse/muse.c
+
 MXL301RF MEDIA DRIVER
 M:	Akihiro Tsukada <tskd08@gmail.com>
 L:	linux-media@vger.kernel.org
--=20
2.26.2

