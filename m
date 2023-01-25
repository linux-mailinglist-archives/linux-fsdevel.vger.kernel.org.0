Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CF67B5EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjAYPaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjAYP3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:50 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059D59E54
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:44 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-J2YxgZukPJadicB8_9FLOw-1; Wed, 25 Jan 2023 10:29:38 -0500
X-MC-Unique: J2YxgZukPJadicB8_9FLOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97A4E800B30;
        Wed, 25 Jan 2023 15:29:37 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D290B2026D4B;
        Wed, 25 Jan 2023 15:29:35 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: [RFC PATCH v1 6/6] doc: proc: Add description of subset=allowlist
Date:   Wed, 25 Jan 2023 16:28:53 +0100
Message-Id: <bd6f2882a63521a33d68e3f6dc1fb1e71c7c37d2.1674660533.git.legion@kernel.org>
In-Reply-To: <cover.1674660533.git.legion@kernel.org>
References: <cover.1674660533.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e224b6d5b642..c2598bca8193 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2213,6 +2213,16 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+subset=allowlist allows you to specify a list of files and directories to
+which you want to provide access. If the option is specified, then the
+/proc/allowlist will appear at the top level of the filesystem. By default, this
+file contains only its name. The user can add or remove other filenames and
+directories. To prohibit editing the allowlist, you need to exclude its name
+from the list of allowed ones.
+
+Different subset= option arguments can be combined using the plus(+) delimiter.
+For example: subset=pid+allowlist
+
 Chapter 5: Filesystem behavior
 ==============================
 
-- 
2.33.6

