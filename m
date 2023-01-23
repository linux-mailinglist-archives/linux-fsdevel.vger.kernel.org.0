Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E76783C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjAWR6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjAWR6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:58:16 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A323D81
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:58:15 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 67ABE5616BE5; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 10/20] docs: document general_profit sysfs knob
Date:   Mon, 23 Jan 2023 09:37:38 -0800
Message-Id: <20230123173748.1734238-11-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,SUSPICIOUS_RECIPS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds documentation for the new /sys/kernel/mm/ksm/general_profit
knob.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/ABI/testing/sysfs-kernel-mm-ksm | 8 ++++++++
 Documentation/admin-guide/mm/ksm.rst          | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentatio=
n/ABI/testing/sysfs-kernel-mm-ksm
index d244674a9480..7768e90f7a8f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
@@ -51,3 +51,11 @@ Description:	Control merging pages across different NU=
MA nodes.
=20
 		When it is set to 0 only pages from the same node are merged,
 		otherwise pages from all nodes can be merged together (default).
+
+What:		/sys/kernel/mm/ksm/general_profit
+Date:		January 2023
+KernelVersion:  6.1
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Measure how effective KSM is.
+		general_profit: how effective is KSM. The formula for the
+		calculation is in Documentation/admin-guide/mm/ksm.rst.
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index fb6ba2002a4b..72189bf1283e 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -159,6 +159,8 @@ stable_node_chains_prune_millisecs
=20
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm=
/ksm/``:
=20
+general_profit
+        how effective is KSM. The calculation is explained below.
 pages_shared
         how many shared pages are being used
 pages_sharing
--=20
2.30.2

