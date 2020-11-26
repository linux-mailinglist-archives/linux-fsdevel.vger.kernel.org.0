Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5292C5E2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbgKZXdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:40 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55286 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391953AbgKZXdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 781C518191062;
        Fri, 27 Nov 2020 00:33:38 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cF12J7oxYFjU; Fri, 27 Nov 2020 00:33:38 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JpRn7f_UXNiF; Fri, 27 Nov 2020 00:33:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/7] fuse: Export fuse_simple_request
Date:   Fri, 27 Nov 2020 00:32:54 +0100
Message-Id: <20201126233300.10714-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MUSE will use this function to issue requests,
so export it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 588f8d1240aa..8b7209537683 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -522,6 +522,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, st=
ruct fuse_args *args)
=20
 	return ret;
 }
+EXPORT_SYMBOL_GPL(fuse_simple_request);
=20
 static bool fuse_request_queue_background(struct fuse_req *req)
 {
--=20
2.26.2

