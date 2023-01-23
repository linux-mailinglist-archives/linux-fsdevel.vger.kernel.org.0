Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D16783C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjAWR6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjAWR63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:58:29 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC923D88
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:58:28 -0800 (PST)
Received: by dev0134.prn3.facebook.com (Postfix, from userid 425415)
        id 7BBE85616BF1; Mon, 23 Jan 2023 09:37:56 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     linux-mm@kvack.org
Cc:     shr@devkernel.io, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v1 15/20] docs: document new procfs ksm knobs
Date:   Mon, 23 Jan 2023 09:37:43 -0800
Message-Id: <20230123173748.1734238-16-shr@devkernel.io>
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

This documents the ksm_process_profit and ksm_merge_type settings in
ksm_stat.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/admin-guide/mm/ksm.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index 72189bf1283e..70896f01d641 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -211,7 +211,8 @@ several times, which are unprofitable memory consumed=
.
 			  ksm_rmap_items * sizeof(rmap_item).
=20
    where ksm_merging_pages is shown under the directory ``/proc/<pid>/``=
,
-   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``.
+   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process =
profit
+   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
=20
 From the perspective of application, a high ratio of ``ksm_rmap_items`` =
to
 ``ksm_merging_pages`` means a bad madvise-applied policy, so developers =
or
@@ -222,6 +223,9 @@ so if the ``ksm_rmap_items/ksm_merging_pages`` ratio =
exceeds 64 on 64-bit CPU
 or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dr=
opped,
 because the ksm profit is approximately zero or negative.
=20
+The ksm_merge_type in ``/proc/<pid>/ksm_stat`` shows the merge type of t=
he
+process. Valid values are ``none``, ``madvise`` and ``process``.
+
 Monitoring KSM events
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.30.2

