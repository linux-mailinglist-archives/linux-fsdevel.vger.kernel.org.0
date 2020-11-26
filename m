Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313F52C5E3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbgKZXdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:54 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55350 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391956AbgKZXdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 7F3AC1815EF9C;
        Fri, 27 Nov 2020 00:33:39 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id huVm_zYbsoic; Fri, 27 Nov 2020 00:33:39 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jl_Vnuij2GT2; Fri, 27 Nov 2020 00:33:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/7] mtd: Add MTD_MUSE flag
Date:   Fri, 27 Nov 2020 00:32:57 +0100
Message-Id: <20201126233300.10714-5-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
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

