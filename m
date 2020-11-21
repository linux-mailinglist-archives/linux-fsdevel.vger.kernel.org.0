Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E542BBF5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 14:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgKUN5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 08:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgKUN5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:57:49 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D088C061A4B;
        Sat, 21 Nov 2020 05:57:48 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so10129841wmg.0;
        Sat, 21 Nov 2020 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQxhkMEdQnyYr8WsxFvRrEHJSPLBuk0HpQQMWna+wtU=;
        b=XYXgafoUb29o52G8xh9L2ZFZ+KugeI8XofyMumqdgSFpurfLAV9cs05Ipy2VLHou8d
         BdAPAZMSIZk38Xn5U2WOI3u+CniV4QnPfPYRqPNa2A9usI21W9xjjF4OAk1IGYE1jS2b
         sDjXcZb7yJwSh+p/XvMFpK1eUum2gwOjVtfgaBglebricVWISyyss71YWYhjRzBGKq96
         PDD0qfJxqLFhvpFbnjB7+/ASV8pg+AtK9E2cXZpK4LeVMjuS2dPNZJQi1telxtCy0DyC
         nRDBrxHudjMAlOiDbsrFw+ztKawvTAVjKusWXV8e64/BmReWdhh2tIUGHPqYy1nq+P6b
         Q7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQxhkMEdQnyYr8WsxFvRrEHJSPLBuk0HpQQMWna+wtU=;
        b=rsUsqcoEdL9oeQRfBqsE+tnv37k+5n1WjkD2C1qbpFycirW1fMDQEWRDJEJevUaLOa
         2jc0O9hfcgkpjBDVlfbjTEHgTH2PEQzKj4kXJY1W+y4KUxUrQ2GRLhG2DE0V+Xb52Xmk
         hSoA+Q48lJuGwHm6cnrb0bj8UH5lK1Eanl1UtpgblU3q7YYhYKS7zcG6No7CJ0xBUf0n
         QqYdJRKS+pr/GkzOq2XEBo17UBgG6/FpML7O7ougPY7RTRQdtn5BYzaWGnS5Zb6IYJFw
         /DUQ67B0VY50tehk1xw0Dhp6cwpTBDAUul4TNyMJNgxBHkxocCH27SOaQMGw9QlV0ajz
         w3pg==
X-Gm-Message-State: AOAM532k6SN64k9WjAQwn3cK7dQ/liIJoH1ieoIjTTknunl1YysLMhOK
        xOCMARGUYzqoXLPh2/cI7mk=
X-Google-Smtp-Source: ABdhPJzUz8zNVI0vBTw4F/OEqz5uTbnj627pFyoEmSr7Ic0cIKL1Ag/O0tzIe5z+xeZQiBNVONZlTA==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr15763634wmf.133.1605967067308;
        Sat, 21 Nov 2020 05:57:47 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id 17sm41689951wma.3.2020.11.21.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:57:46 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] fs/binfmt_elf.c: Cosmetic
Date:   Sat, 21 Nov 2020 14:57:36 +0100
Message-Id: <20201121135736.295705-5-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201121135736.295705-1-alx.manpages@gmail.com>
References: <20201121135736.295705-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Non-trivial changes:

Invert 'if's to simplify logic.
Use 'goto' in conjunction with the above, when appropriate.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 fs/binfmt_elf.c | 115 +++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b5e1e0a0917a..dbd50b5bf238 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1079,65 +1079,68 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 */
 		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex->e_type == ET_DYN) {
-			/*
-			 * This logic is run once for the first LOAD Program
-			 * Header for ET_DYN binaries to calculate the
-			 * randomization (load_bias) for all the LOAD
-			 * Program Headers, and to calculate the entire
-			 * size of the ELF mapping (total_size). (Note that
-			 * load_addr_set is set to true later once the
-			 * initial mapping is performed.)
-			 *
-			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
-			 * and loaders (ET_DYN without INTERP, since they
-			 * _are_ the ELF interpreter). The loaders must
-			 * be loaded away from programs since the program
-			 * may otherwise collide with the loader (especially
-			 * for ET_EXEC which does not have a randomized
-			 * position). For example to handle invocations of
-			 * "./ld.so someprog" to test out a new version of
-			 * the loader, the subsequent program that the
-			 * loader loads must avoid the loader itself, so
-			 * they cannot share the same load range. Sufficient
-			 * room for the brk must be allocated with the
-			 * loader as well, since brk must be available with
-			 * the loader.
-			 *
-			 * Therefore, programs are loaded offset from
-			 * ELF_ET_DYN_BASE and loaders are loaded into the
-			 * independently randomized mmap region (0 load_bias
-			 * without MAP_FIXED).
-			 */
-			if (interpreter) {
-				load_bias = ELF_ET_DYN_BASE;
-				if (current->flags & PF_RANDOMIZE)
-					load_bias += arch_mmap_rnd();
-				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
-				if (alignment)
-					load_bias &= ~(alignment - 1);
-				elf_flags |= MAP_FIXED;
-			} else
-				load_bias = 0;
+			goto proceed_normally;
+		}
+		if (elf_ex->e_type != ET_DYN)
+			goto proceed_normally;
+		/*
+		 * This logic is run once for the first LOAD Program
+		 * Header for ET_DYN binaries to calculate the
+		 * randomization (load_bias) for all the LOAD
+		 * Program Headers, and to calculate the entire
+		 * size of the ELF mapping (total_size). (Note that
+		 * load_addr_set is set to true later once the
+		 * initial mapping is performed.)
+		 *
+		 * There are effectively two types of ET_DYN
+		 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
+		 * and loaders (ET_DYN without INTERP, since they
+		 * _are_ the ELF interpreter). The loaders must
+		 * be loaded away from programs since the program
+		 * may otherwise collide with the loader (especially
+		 * for ET_EXEC which does not have a randomized
+		 * position). For example to handle invocations of
+		 * "./ld.so someprog" to test out a new version of
+		 * the loader, the subsequent program that the
+		 * loader loads must avoid the loader itself, so
+		 * they cannot share the same load range. Sufficient
+		 * room for the brk must be allocated with the
+		 * loader as well, since brk must be available with
+		 * the loader.
+		 *
+		 * Therefore, programs are loaded offset from
+		 * ELF_ET_DYN_BASE and loaders are loaded into the
+		 * independently randomized mmap region (0 load_bias
+		 * without MAP_FIXED).
+		 */
+		if (interpreter) {
+			load_bias = ELF_ET_DYN_BASE;
+			if (current->flags & PF_RANDOMIZE)
+				load_bias += arch_mmap_rnd();
+			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
+			if (alignment)
+				load_bias &= ~(alignment - 1);
+			elf_flags |= MAP_FIXED;
+		} else {
+			load_bias = 0;
+		}
 
-			/*
-			 * Since load_bias is used for all subsequent loading
-			 * calculations, we must lower it by the first vaddr
-			 * so that the remaining calculations based on the
-			 * ELF vaddrs will be correctly offset. The result
-			 * is then page aligned.
-			 */
-			load_bias = ELF_PAGESTART(load_bias - vaddr);
+		/*
+		 * Since load_bias is used for all subsequent loading
+		 * calculations, we must lower it by the first vaddr
+		 * so that the remaining calculations based on the
+		 * ELF vaddrs will be correctly offset. The result
+		 * is then page aligned.
+		 */
+		load_bias = ELF_PAGESTART(load_bias - vaddr);
 
-			total_size = total_mapping_size(elf_phdata,
-							elf_ex->e_phnum);
-			if (!total_size) {
-				retval = -EINVAL;
-				goto out_free_dentry;
-			}
+		total_size = total_mapping_size(elf_phdata,
+						elf_ex->e_phnum);
+		if (!total_size) {
+			retval = -EINVAL;
+			goto out_free_dentry;
 		}
-
+proceed_normally:	/* FIXME: a better label name? */
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
-- 
2.28.0

