Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2D57D88D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 04:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiGVCY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiGVCYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:45 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF597D69
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:37 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC55E3F12B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456676;
        bh=hqasS2PjFohy8PE1VKCVY/VWJWfGA+Wsx6gjsloj5Nc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bfW3CIV6Ifd12tL2gp1Pykke8x+MrUiWqEVjj6hy0PZcH/AEKERz2bfrv9l8bBK8x
         wPc32ErXkzXdjwRIAhUf3UnKZLpWgl67rv5Go6ILn4su4ANl4OQayWgUHS3F9vReOu
         pHYZ2iaVBKOckmzjOfJ10k96wISdlnKaExWKXJv8i5zJhwvVYRr4mbcdIOcM1qSh20
         L+8Qf33UiY/clI3QwTvb+5XIOLojNh3PmgGyZaLtjBoPZUlZw6G16LzFUh+XKlZSWF
         JrrvqoDC3G70isrmu5wtPfLopq3//Utqq2RRz+7MO0L9MgWTQB9kkoPCKrpFoQPYYG
         aAYg5PWgIcCrw==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-10d7a610a64so1774212fac.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqasS2PjFohy8PE1VKCVY/VWJWfGA+Wsx6gjsloj5Nc=;
        b=iNPn/o5nWkiinvNOzqP3xKnJYutQVyrr8+0c9tH1BcyEpTyxUs2JWOfUCQem4iRtJf
         6W5uHDu8xN4nyGDrZCqtvP9fEVaEo/NN9LKmCSaLwXDKhQxz1yw4OxdfPR2vXXE+kCY6
         vwbVez+fEFI4oSG2WmWoasUz5oMXeokUbTGHG4NNPPBqWRr1Ddkor/T5K0YGB7eBrsUC
         YGRIX9D1T+QmS8HddQhnQGLZL1I4c+PyytUTzP07yh7NGKF/b9YO2KRblEudt4HWf56b
         uYkrz4KGQ7WpHuOJnHMg3CmDtV2puEPTcz1BJFFgpexU80qZIuVuRhrJJFXOWZX9cj8m
         j8AQ==
X-Gm-Message-State: AJIora+0NOzBr3D+qX0Uk1BBWCUAiFPj7AFUCeFJJaAP5kvoWXN5hGK/
        ddEAJaXb09i/Jva/+AkJ6qJP9IyoHTQddXlZWAU/5v1UGZj5xE8xNyUJTWwmvF5fKCaYHKdyc/m
        k36DtG1nW2ZTKwg/GjDU70zQ4DZyrFXno9SssQwLEJDw=
X-Received: by 2002:a05:6830:6517:b0:614:d582:77d7 with SMTP id cm23-20020a056830651700b00614d58277d7mr507273otb.323.1658456675938;
        Thu, 21 Jul 2022 19:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLS6QJ5eow90pKBFp4ctGLCUQ8MqGGb68x3HdZDh7OOZ9QuEHvw5tz1dmPFuwuWlLEdvLurA==
X-Received: by 2002:a05:6830:6517:b0:614:d582:77d7 with SMTP id cm23-20020a056830651700b00614d58277d7mr507263otb.323.1658456675607;
        Thu, 21 Jul 2022 19:24:35 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:35 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 4/6] module, modpost: introduce support for MODULE_SYSCTL_TABLE
Date:   Thu, 21 Jul 2022 23:24:14 -0300
Message-Id: <20220722022416.137548-5-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that 'struct ctl_table' is exposed to modpost/file2alias,
introduce MODULE_SYSCTL_TABLE to register some sysctl tables,
just like MODULE_DEVICE_TABLE for, eg, drivers PCI ID tables.

This adds a '__mod_sysctl__<name>_device_table' symbol in the
module that points to the array of 'struct ctl_table' entries.

This is identified and handled by file2alias, as other tables,
that emits MODULE_ALIAS("sysctl:<struct ctl_table.procname>")
statements for each entry.

That would be relatively simple for 'procname' as a char array
(eg, do_{rpmsg,i2c,spi}_entry()) but since it's a char pointer
an ELF relocation is used (it sets that pointer value to where
the string it should point to actually ends up).

...

It's probably not ideal to convert 'struct ctl_table.procname'
to a char array, as the max length it uses in some modules is
long, and all other users would pay the memory price of a one-
size-fits-all array size.

Also, some places set it to NULL, which requires special care
and changes (i.e., set/check the first byte is '\0').

Anyway, the resulting disadvantages in the general case aren't
worth the simplicity gain in this particular case.

...

So, add ELF relocation handling code, borrowing that function
we factored-out in modpost.c earlier.

The logic and details are commented in the source, but briefly:

0) modpost.c calls file2alias.c's handle_moddevtable()

1) handle_moddevtable()
1.1) matches a '__mod__sysctl__..._device_table' symbol
1.2) calls do_sysctl_table() for it (array of struct ctl_table)

2) do_sysctl_table()
2.1) finds the relocation section that _references_ the section
     that defines that symbol (ie, that holds the actual values
     of 'procname' char pointers to be replaced in that symbol).
2.2) calls do_sysctl_entry() for each entry in that table/array

3) do_sysctl_entry()
3.1) calls do_sysctl_section_relx() to scan a relocation section
     for the relocation entry that targets a particular procname
     pointer of this entry (struct ctl_table).
3.2) do_sysctl_section_relx() returns its source string pointer.
3.3) do_sysctl_entry() stores 'sysctl:<procname>' in the buffer.

4) do_sysctl_table() emits a 'MODULE_ALIAS()' statement with it.

...

This algorithm is likely iterating over the earlier relocation
entries many times as each 'struct ctl_table' entry starts the
loop over the relocation section again, but keep it simple now.

We could keep the relocation entry cursor pointer across calls,
and start over only when we can't find a relocation, I guess.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 include/linux/module.h   |   7 +++
 scripts/mod/file2alias.c | 111 +++++++++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c    |   4 +-
 scripts/mod/modpost.h    |   3 ++
 4 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 518296ea7f73..3010f687df19 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -247,6 +247,13 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 #define MODULE_DEVICE_TABLE(type, name)
 #endif
 
+#if defined(MODULE) && defined(CONFIG_PROC_SYSCTL)
+/* Creates an alias so file2alias.c can find sysctl "device" table. */
+#define MODULE_SYSCTL_TABLE(name) MODULE_DEVICE_TABLE(sysctl, name)
+#else /* !MODULE || !CONFIG_PROC_SYSCTL */
+#define MODULE_SYSCTL_TABLE(name)
+#endif
+
 /* Version of form [<epoch>:]<version>[-<extra-version>].
  * Or for CVS/RCS ID version, everything but the number is stripped.
  * <epoch>: A (small) unsigned integer which allows you to start versions
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index cbd6b0f48b4e..3bf9cb84c548 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1452,6 +1452,115 @@ static int do_dfl_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/*
+ * Scan the relocation section with section header index 'relx_shndx'
+ * for the relocation entry for target 'offset' and return a pointer
+ * to its source value (from another section/offset).
+ *
+ * The caller must ensure sechdr->sh_type == SHT_RELA or SHT_REL.
+ */
+static void *do_sysctl_section_relx(struct elf_info *info,
+				    unsigned int relx_shndx, int offset)
+{
+	/* Relocation section's header, and start/stop addresses. */
+	Elf_Shdr *sechdr = &info->sechdrs[relx_shndx];
+	Elf_Rela *start = (void *)info->hdr + sechdr->sh_offset;
+	Elf_Rela *stop  = (void *)start + sechdr->sh_size;
+
+	/* Relocation entry cursor and size in SHT_RELA or SHT_REL. */
+	Elf_Rela *relx; /* access .r_addend in SHT_RELA _only_! */
+	size_t relx_size;
+
+	if (sechdr->sh_type == SHT_RELA)
+		relx_size = sizeof(Elf_Rela);
+	else if (sechdr->sh_type == SHT_REL)
+		relx_size = sizeof(Elf_Rel);
+	else
+		return NULL;
+
+	for (relx = start; relx < stop; relx = (void *)relx + relx_size) {
+		/*
+		 * 'r' is the relocation entry, applied to the 'target offset'
+		 * in the 'target section' of this (relocation) section, with
+		 * the value from symbol 'sym' (in/at 'source section/offset').
+		 */
+		Elf_Rela r;
+		Elf_Sym *sym;
+		unsigned int sym_shndx;
+		int sym_offset;
+
+		if (get_relx_sym(info, sechdr, relx, &r, &sym))
+			continue;
+
+		/* Looking for this target offset. */
+		if (r.r_offset != offset)
+			continue;
+
+		/* Pointer to source section/offset (note: addend is needed). */
+		sym_shndx = get_secindex(info, sym);
+		sym_offset = sym->st_value;
+		return (void *)info->hdr + info->sechdrs[sym_shndx].sh_offset
+			+ sym_offset + r.r_addend;
+	}
+
+	return NULL;
+}
+
+/* Looks like: sysctl:S */
+static int do_sysctl_entry(const char *modname, int sym_entry_offset,
+			   char *alias, const char *symname,
+			   unsigned int relx_shndx, struct elf_info *info)
+{
+	/* Find the relocation entry for procname's offset and use its string */
+	int offset = sym_entry_offset + OFF_sysctl_device_id_procname;
+	const char *procname = do_sysctl_section_relx(info, relx_shndx, offset);
+
+	if (procname) {
+		sprintf(alias, "sysctl:%s", procname);
+		return 1;
+	}
+
+	error("%s: [%s.ko] cannot find relocation string.\n", symname, modname);
+	return 0;
+}
+
+static void do_sysctl_table(void *symval, unsigned long size,
+			    struct module *mod, const char *symname,
+			    Elf_Sym *sym, struct elf_info *info)
+{
+	unsigned long id_size = SIZE_sysctl_device_id;
+	unsigned int i, secindex, shndx;
+	char alias[ALIAS_SIZE];
+
+	device_id_check(mod->name, "sysctl", size, id_size, symval);
+	/* Leave last one: it's the terminator. */
+	size -= id_size;
+
+	/* Find relocation section that references the section w/ the symbol. */
+	shndx = sym->st_shndx;
+	for (secindex = 0; secindex < info->num_sections; secindex++) {
+		Elf_Shdr *shdr = &info->sechdrs[secindex];
+
+		if ((shdr->sh_type == SHT_REL || shdr->sh_type == SHT_RELA) &&
+		    (shdr->sh_flags & SHF_INFO_LINK) && shdr->sh_info == shndx)
+			break;
+	}
+
+	if (secindex == info->num_sections) {
+		error("%s: [%s.ko] cannot find relocation section.\n",
+		      symname, mod->name);
+		return;
+	}
+
+	/* The symbol is an array of struct ctl_table elements at offset 'i'. */
+	for (i = 0; i < size; i += id_size) {
+		if (do_sysctl_entry(mod->name, sym->st_value+i, alias, symname, secindex, info)) {
+			buf_printf(&mod->dev_table_buf,
+				   "MODULE_ALIAS(\"%s\");\n", alias);
+		}
+	}
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1585,6 +1694,8 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 		do_pnp_device_entry(symval, sym->st_size, mod);
 	else if (sym_is(name, namelen, "pnp_card"))
 		do_pnp_card_entries(symval, sym->st_size, mod);
+	if (sym_is(name, namelen, "sysctl"))
+		do_sysctl_table(symval, sym->st_size, mod, symname, sym, info);
 	else {
 		int i;
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d1ed67fa290b..e2df2fbb0909 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1735,8 +1735,8 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
  * w/ possible relocation addend 'r.r_addend').
  * - 'sym' is that symbol (a pointer to the symbol table + symbol table index).
  */
-static int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
-			Elf_Rela *out_r, Elf_Sym **out_sym)
+int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
+		 Elf_Rela *out_r, Elf_Sym **out_sym)
 {
 	Elf_Sym *sym;
 	Elf_Rela r;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 044bdfb894b7..cdb95c7e03a9 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -212,3 +212,6 @@ void modpost_log(enum loglevel loglevel, const char *fmt, ...);
 #define warn(fmt, args...)	modpost_log(LOG_WARN, fmt, ##args)
 #define error(fmt, args...)	modpost_log(LOG_ERROR, fmt, ##args)
 #define fatal(fmt, args...)	modpost_log(LOG_FATAL, fmt, ##args)
+
+int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
+			Elf_Rela *out_r, Elf_Sym **out_sym);
-- 
2.25.1

