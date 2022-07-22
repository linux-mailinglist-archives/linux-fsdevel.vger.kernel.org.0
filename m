Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111157D885
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiGVCYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 22:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiGVCYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89E97A27
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:31 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2CE863F131
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 02:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456670;
        bh=3ZWy6oO045NhmDZUgGUtDdbm4GX85RgD6xaLJzXc/eE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CTeawkRDoNBqmnB89bfRQ8Pk7CTm9cEqR2xXQtxBeYU1OW8rduk32svpVZJPdTisU
         g874cgA2+AiND2/SENKmlfq0fVllx/gWfi7fsuv1yePCH8izxAn3MRCSh4UYnTaCsh
         VzkuMJay7tQTOBQAVYjnpktjM5UhA9NDQyNyfGP/9XYprTj9j9zI+co/9Er/qegrRy
         zhNcB904EZs7z5vMcwprdN0UeWrvsA3YXwWXfLSFlp9uJr2U5xnBJloEdUTFnRG/EB
         U7HltZ/Tn9AA3sWr0NWcTWNMz8djK6QJom5Ti+cUH1TxpANA0aUVrD/OpZq0U31H3a
         A1OOIFHMddgQQ==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-10d8a13565eso1774599fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZWy6oO045NhmDZUgGUtDdbm4GX85RgD6xaLJzXc/eE=;
        b=OIi6C1790vrESwApF60HvRtbGxMko3mrfBMVZJ0DG4mwmAszPiE2+9degywAXgvJQN
         DUsknC9kX6Ef15WQ0DsGqdmvpYH1kZwOirwE/PapXwmOWolfevkHLB+CfhVRLfCpxNZY
         jW9AXpksaltpAP32a55fJpCeU6nbKkClZETPzfVwOJ4ai6XXLCVdIUT9jjR8+/UAZdYI
         UmrqKMaUJtlykVUusxJk05qoF87Wl4q1ILc/4hzpiwG/TDTJVbYLUeHPbbXrSSAFFjFB
         LZNjn+GehWh0nY8nCtiqez9M4gGAY12zBztak+CeRqnKcySkolp0RgQEthzUucqhb4Gm
         vbsw==
X-Gm-Message-State: AJIora/sv6QFNBROQ7Sz6YJMUhiDLgi2WcuBCDBGBFEWFE70GbTMev8t
        fIQEn64zMmr818ji40kYTvIH/YEcEEYzdV3KsKMfY/2Rihp0se0PBWj9vhi92K3L1ZWKoCYBQXd
        2PG4gWzJFhBzkw13ghui02PZYzm+0jSfsiGSIAUmqgeQ=
X-Received: by 2002:a05:6870:a54b:b0:10d:bd45:8acf with SMTP id p11-20020a056870a54b00b0010dbd458acfmr97012oal.137.1658456669032;
        Thu, 21 Jul 2022 19:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXOJFfZ5xySXu/jnZXD4d8EwntbgED2XgYvhxCSIhrCPaTNG1IxGQOP+0DjE3kT8h+fPFKDg==
X-Received: by 2002:a05:6870:a54b:b0:10d:bd45:8acf with SMTP id p11-20020a056870a54b00b0010dbd458acfmr97007oal.137.1658456668819;
        Thu, 21 Jul 2022 19:24:28 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:28 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 2/6] modpost: deduplicate section_rel[a]()
Date:   Thu, 21 Jul 2022 23:24:12 -0300
Message-Id: <20220722022416.137548-3-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now both functions are almost identical, and we can again generalize
the relocation types Elf_Rela/Elf_Rel with Elf_Rela, and handle some
differences with conditionals on section header type (SHT_RELA/REL).

The important bit is to make sure the loop increment uses the right
size for pointer arithmethic.

The original reason for split functions to make program logic easier
to follow; commit 5b24c0715fc4 ("kbuild: code refactoring in modpost").

Hopefully these 2 commits may help improving that, without an impact
in understanding the code due to generalization of relocation types.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 scripts/mod/modpost.c | 61 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4c1038dccae0..d1ed67fa290b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1794,63 +1794,49 @@ static int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
 	return 0;
 }
 
-static void section_rela(const char *modname, struct elf_info *elf,
+/* The caller must ensure sechdr->sh_type == SHT_RELA or SHT_REL. */
+static void section_relx(const char *modname, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
 	Elf_Sym  *sym;
-	Elf_Rela *rela;
+	Elf_Rela *relx; /* access .r_addend in SHT_RELA _only_! */
 	Elf_Rela r;
+	size_t relx_size;
 	const char *fromsec;
 
 	Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
 	Elf_Rela *stop  = (void *)start + sechdr->sh_size;
 
 	fromsec = sech_name(elf, sechdr);
-	fromsec += strlen(".rela");
+	if (sechdr->sh_type == SHT_RELA) {
+		relx_size = sizeof(Elf_Rela);
+		fromsec += strlen(".rela");
+	} else if (sechdr->sh_type == SHT_REL) {
+		relx_size = sizeof(Elf_Rel);
+		fromsec += strlen(".rel");
+	} else {
+		error("%s: [%s.ko] not relocation section\n", fromsec, modname);
+		return;
+	}
+
 	/* if from section (name) is know good then skip it */
 	if (match(fromsec, section_white_list))
 		return;
 
-	for (rela = start; rela < stop; rela++) {
-		if (get_relx_sym(elf, sechdr, rela, &r, &sym))
+	for (relx = start; relx < stop; relx = (void *)relx + relx_size) {
+		if (get_relx_sym(elf, sechdr, relx, &r, &sym))
 			continue;
 
 		switch (elf->hdr->e_machine) {
 		case EM_RISCV:
-			if (!strcmp("__ex_table", fromsec) &&
+			if (sechdr->sh_type == SHT_RELA &&
+			    !strcmp("__ex_table", fromsec) &&
 			    ELF_R_TYPE(r.r_info) == R_RISCV_SUB32)
 				continue;
 			break;
 		}
 
-		if (is_second_extable_reloc(start, rela, fromsec))
-			find_extable_entry_size(fromsec, &r);
-		check_section_mismatch(modname, elf, &r, sym, fromsec);
-	}
-}
-
-static void section_rel(const char *modname, struct elf_info *elf,
-			Elf_Shdr *sechdr)
-{
-	Elf_Sym *sym;
-	Elf_Rel *rel;
-	Elf_Rela r;
-	const char *fromsec;
-
-	Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
-	Elf_Rel *stop  = (void *)start + sechdr->sh_size;
-
-	fromsec = sech_name(elf, sechdr);
-	fromsec += strlen(".rel");
-	/* if from section (name) is know good then skip it */
-	if (match(fromsec, section_white_list))
-		return;
-
-	for (rel = start; rel < stop; rel++) {
-		if (get_relx_sym(elf, sechdr, (Elf_Rela *)rel, &r, &sym)
-			continue;
-
-		if (is_second_extable_reloc(start, rel, fromsec))
+		if (is_second_extable_reloc(start, relx, fromsec))
 			find_extable_entry_size(fromsec, &r);
 		check_section_mismatch(modname, elf, &r, sym, fromsec);
 	}
@@ -1877,10 +1863,9 @@ static void check_sec_ref(const char *modname, struct elf_info *elf)
 	for (i = 0; i < elf->num_sections; i++) {
 		check_section(modname, elf, &elf->sechdrs[i]);
 		/* We want to process only relocation sections and not .init */
-		if (sechdrs[i].sh_type == SHT_RELA)
-			section_rela(modname, elf, &elf->sechdrs[i]);
-		else if (sechdrs[i].sh_type == SHT_REL)
-			section_rel(modname, elf, &elf->sechdrs[i]);
+		if (sechdrs[i].sh_type == SHT_RELA ||
+		    sechdrs[i].sh_type == SHT_REL)
+			section_relx(modname, elf, &elf->sechdrs[i]);
 	}
 }
 
-- 
2.25.1

