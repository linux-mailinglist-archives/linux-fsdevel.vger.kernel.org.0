Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA61EEB7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgFDUEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 16:04:38 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:54048 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgFDUEf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:04:35 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id CB15620A01;
        Thu,  4 Jun 2020 20:04:33 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] docs: proc: update documentation about subset= parameter
Date:   Thu,  4 Jun 2020 22:04:13 +0200
Message-Id: <20200604200413.587896-3-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200604200413.587896-1-gladkov.alexey@gmail.com>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 04 Jun 2020 20:04:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Documentation/filesystems/proc.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e2ecf248feb5..68acd335cd8c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2177,6 +2177,12 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+subset=NAME[:NAME...] allows to give access to the listed file names or
+directories located at the top level of procfs. These files and directories
+do not have to be present at the time of mounting procfs. They may appear later
+when the kernel module that creates them loads. The list of names can be
+combined with subst=pid.
+
 5	Filesystem behavior
 ----------------------------
 
-- 
2.25.4

