Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C382B4A84EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350716AbiBCNOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350575AbiBCNOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44035C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 05:14:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4EE8617E9
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE40AC340ED;
        Thu,  3 Feb 2022 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894083;
        bh=FWhmJ0HWjsMoFYkIW2ebdBklYwq0CMJXlb3zKBXrK4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wz/laMYYyKqIQvgKrwURjr0PlVfagZXPFiUvvUltw3raYPhC3KkZyRVJ2yy2r764/
         D+EQi/zzaI0UhemRJmqXDIJ3esqCjv0XlDmJaJMxJdO1b4bS3nKISl1YEbNMaFfsrQ
         jHMiqDOaiXiTQyTj01ZwZVk3ZUZ1xZOeHShD3W0W0KUNtk8mlMsev0tqen5FoJoTXx
         /HvWW92ocd8+Wb+ARkDqJ4gT7HCsJKDs1Uk7dcM8IH69hpENjSE++AlSGbqTYqLxV6
         pYIARptYhE6QFYS6r5YOEI6TlsaqozhRMyNx0N1+WGkZQfE68lhG/Pv9H3CVbfcfRh
         EMM0lTG0p6eBw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/7] MAINTAINERS: add entry for idmapped mounts
Date:   Thu,  3 Feb 2022 14:14:06 +0100
Message-Id: <20220203131411.3093040-3-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; h=from:subject; bh=FWhmJ0HWjsMoFYkIW2ebdBklYwq0CMJXlb3zKBXrK4I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vspoNm9u06Tot9Xz8y153i8+uc+kfOeh4BuyVh/vnmxf LbR/ZkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE/OQZGa48/bv9tQJ7qkhQqsm0nN Q/8xpNwrkmz+72v/7V0ufDJn5GhiPLLbujuriau+UmzQ8IPf3Ozk/mkHpMhcGrvz2W0kq3GAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to continue maintaining the work that was done around idmapped,
make sure that I'm Cced on new patches and work that impacts the
infrastructure.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..0496b973bb87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9253,6 +9253,15 @@ S:	Maintained
 W:	https://github.com/o2genum/ideapad-slidebar
 F:	drivers/input/misc/ideapad_slidebar.c
 
+IDMAPPED MOUNTS
+M:	Christian Brauner <brauner@kernel.org>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
+F:	Documentation/filesystems/idmappings.rst
+F:	tools/testing/selftests/mount_setattr/
+F:	include/linux/mnt_idmapping.h
+
 IDT VersaClock 5 CLOCK DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
-- 
2.32.0

