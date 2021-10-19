Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6267433072
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhJSIGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234712AbhJSIGk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A095C61391;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=kT+onznJm4uj9/bJWP0tZZgq/f5Io63eILB7+ifUduU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeUPqY5Y8OiFwXJV3Mq7ZWA6vN14QhvjUMSWrq3a8qGtmcIFtvCRC9i3fWUaH5kiJ
         VPMrCFw0St084L+L5Pej2L4j9s9jva1U1jaiZM/WymDMJfEMYQCYSSl8CCDuQeE4ep
         c2/mMqxk8tYWE0ylmSyo1EcFTWsRQrp3/voxgg6JGFlq86aymPqzc1gJAPDPSF6QRm
         mx6dHG3D4ftDEShdHsmpvkzatbD8uVZO/n7x0Z+4Dqjs2mTiS4jMIPSvLKA0Zjg1vf
         NCTxBztxT+w4cbummjNk4DMh2kXSPQBVXOe3v6vscAKK+p7bQuk2IYf6Fhx1awHFR7
         BAlHybavHE0jw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJg-90; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/23] fs: remove a comment pointing to the removed mandatory-locking file
Date:   Tue, 19 Oct 2021 09:04:17 +0100
Message-Id: <887de3a1ecadda3dbfe0adf9df9070f0afa9406c.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mandatory file locking got removed due to its problems, but
there's still a comment inside fs/locks.c pointing to the removed
doc.

Remove it.

Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 fs/locks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index d397394633be..94feadcdab4e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -61,7 +61,6 @@
  *
  *  Initial implementation of mandatory locks. SunOS turned out to be
  *  a rotten model, so I implemented the "obvious" semantics.
- *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
  *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
  *
  *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
-- 
2.31.1

