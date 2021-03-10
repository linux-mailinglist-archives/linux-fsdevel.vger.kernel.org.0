Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18D33468E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhCJSUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:20:49 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:56536 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233701AbhCJSUW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:20:22 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 6054641781;
        Wed, 10 Mar 2021 18:20:21 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v5 5/5] docs: proc: add documentation about relaxing visibility restrictions
Date:   Wed, 10 Mar 2021 19:20:00 +0100
Message-Id: <ae5b7c21a54aee1f348f63679522aec2b5cc4b51.1615400395.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615400395.git.gladkov.alexey@gmail.com>
References: <cover.1615400395.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [0.0.0.0]); Wed, 10 Mar 2021 18:20:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Documentation/filesystems/proc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 3daf0e7d1071..9d2985a7aad6 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2190,6 +2190,8 @@ available to you and will not allow procfs to be mounted if:
   2. Mount is prohibited if a new mount overrides the readonly option or family
      of atime options.
   3. If any file or non-empty procfs directory is hidden by another filesystem.
+     You can still mount procfs even with overlapped directories if the
+     subset=pid option is used.
 
 Chapter 5: Filesystem behavior
 ==============================
-- 
2.29.2

