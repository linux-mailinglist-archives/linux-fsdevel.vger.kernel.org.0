Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A578CDE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbjH2U7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjH2U6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:58:54 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986BECC0;
        Tue, 29 Aug 2023 13:58:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 33E6F6418DB5;
        Tue, 29 Aug 2023 22:58:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qs0Nv5zehD6Y; Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DE64B623489F;
        Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dENrN-Y_-S_h; Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (84-115-238-89.cable.dynamic.surfer.at [84.115.238.89])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 6A94D6418DB5;
        Tue, 29 Aug 2023 22:58:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com
Cc:     acl-devel@nongnu.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/3] man: Document pitfall with negative permissions and user namespaces
Date:   Tue, 29 Aug 2023 22:58:33 +0200
Message-Id: <20230829205833.14873-4-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230829205833.14873-1-richard@nod.at>
References: <20230829205833.14873-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is little known that user namespaces and some helpers
can be used to bypass negative permissions.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
This patch applies to the shadow project.
---
 man/subgid.5.xml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/man/subgid.5.xml b/man/subgid.5.xml
index e473768d..8ed281e5 100644
--- a/man/subgid.5.xml
+++ b/man/subgid.5.xml
@@ -55,6 +55,15 @@
       <filename>/etc/subgid</filename> if subid delegation is managed vi=
a subid
       files.
     </para>
+    <para>
+      Additionally, it's worth noting that the utilization of subordinat=
e group
+      IDs can affect the enforcement of negative permissions. User can d=
rop their
+      supplementary groups and bypass certain negative permissions.
+      For more details see
+      <citerefentry>
+	<refentrytitle>user_namespaces</refentrytitle><manvolnum>7</manvolnum>
+      </citerefentry>.
+    </para>
   </refsect1>
=20
   <refsect1 id=3D'local-subordinate-delegation'>
--=20
2.35.3

