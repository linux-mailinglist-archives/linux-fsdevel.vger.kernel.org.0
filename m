Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1D2B9497
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgKSO1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:27:05 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:58534 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgKSO1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:27:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A2F1F181C8902;
        Thu, 19 Nov 2020 15:18:27 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9PdE9r_0My3r; Thu, 19 Nov 2020 15:18:27 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bbDK0ihAvCod; Thu, 19 Nov 2020 15:18:27 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/5] mtd: Add MTD_MUSE flag
Date:   Thu, 19 Nov 2020 15:16:58 +0100
Message-Id: <20201119141659.26176-5-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201119141659.26176-1-richard@nod.at>
References: <20201119141659.26176-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This flag will get set if an MTD is implemeted in userspace
using MUSE.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/uapi/mtd/mtd-abi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 65b9db936557..2ad2217e3a96 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -105,6 +105,7 @@ struct mtd_write_req {
 #define MTD_NO_ERASE		0x1000	/* No erase necessary */
 #define MTD_POWERUP_LOCK	0x2000	/* Always locked after reset */
 #define MTD_SLC_ON_MLC_EMULATION 0x4000	/* Emulate SLC behavior on MLC N=
ANDs */
+#define MTD_MUSE		0x8000 /* This MTD is implemented in userspace */
=20
 /* Some common devices / combinations of capabilities */
 #define MTD_CAP_ROM		0
--=20
2.26.2

