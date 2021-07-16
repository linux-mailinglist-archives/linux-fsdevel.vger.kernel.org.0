Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242C3CB64E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhGPKtt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239574AbhGPKtq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A2D61405;
        Fri, 16 Jul 2021 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626432412;
        bh=wDuexvxEC2rIJP88DlnY8HPEBQ/wvLgTXob8ZeiyHnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCxHPQjnS+Wfa6mWb2UJSDt1wA5P+Yi83Bk4U3gaof62yLXsIhXyNObO+Ibact5tt
         wWEKKMgkUC9TdK04jg5ddVcfsrEw68pnvjGoaXGA58dRVdQpotBtBnliwKpnhns/BV
         q3U9cm+YQy7HTM9EHjGWvlcfkK8cbkpEuSHNyuHgM0cZDtz++Y7mqaPILr33IHWLWX
         4Yrm0PtZa2K2SmaHvQ6VhJdpIC1zMquGSy6n6QXFqlWZDNienou0s+3S0N6t3cDaWQ
         VpYE0QkcTuXf4Z+5o/M2ZyxUdGDl7EziTB7dEioh5RSGRpuZa8YmaskYu8mB0uPyk3
         MvD2HUGs+8OZg==
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH v6 5/5] docs: proc: add documentation about relaxing visibility restrictions
Date:   Fri, 16 Jul 2021 12:46:03 +0200
Message-Id: <99b06573e35bd305da4bd07a040d864a8600f20a.1626432185.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1626432185.git.legion@kernel.org>
References: <cover.1626432185.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5a1bb0e081fd..9d993aef7f1c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2182,7 +2182,8 @@ are not related to tasks.
 If user namespaces are in use, the kernel additionally checks the instances of
 procfs available to the mounter and will not allow procfs to be mounted if:
 
-  1. This mount is not fully visible.
+  1. This mount is not fully visible unless the new procfs is going to be
+     mounted with subset=pid option.
 
      a. It's root directory is not the root directory of the filesystem.
      b. If any file or non-empty procfs directory is hidden by another mount.
-- 
2.29.3

