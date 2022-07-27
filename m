Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D4583170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbiG0SGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiG0SG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:06:29 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F27743D7
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 10:10:33 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D66EE3F130
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658941831;
        bh=MwbKTIqeQ2TTy8ePNbXBDPk1jZx92UHbKiiI/PaCj6g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vUEizXPH6F6Ph8M6VK549GJIbDDAr9NlH6GfFEBSIpxSP2GI2OflSoApd/atDs9Gi
         sAHjl2KixQ8cyQ8ggUIF4FHOl3uncFxB3hzRrkkO0xjADVXrHzaTC6uj6rENLnotkq
         smo/fzWwOnXa2aLO0B14Y/XgJIf7qeDUYymdIVdRFPqF++8hcU/uba7xR//iKT35ak
         Y8IcLUdZYz+s1fqJ+7ZOrxfHW+35+RkTGIiYc4ufqKVvFqpUcYs3em3uLPBp3vRo3W
         QmvxMDdzAt8je2jwD5HrhjAa7nYX2uEkSXUNPhPd2k8JMixz9y6yAANof05T4JPKUF
         wif86LGxGs+zg==
Received: by mail-oi1-f198.google.com with SMTP id 3-20020aca2803000000b0033b0bc7b4a5so830474oix.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jul 2022 10:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwbKTIqeQ2TTy8ePNbXBDPk1jZx92UHbKiiI/PaCj6g=;
        b=BLtSEOXB5g0ZVjHRUhay+QlMo4GW/3m0u/lgi2IpyIW9Ng0SpdP108QdincULSXPU4
         ndmiffvLFiJ4w54UJDIGnjqQKYE0S/LtNNP9zXIyGlotbJEQq51pMfAJakK6MEfx7JI/
         4O+BFLVV5Ycj8VaCc5coUTFsO3wx3wPtNeKD0cbWw7VTA2gdGcjoOMs1YxCafOA47t2a
         fRFTYsbFF90wVVuufUnOX8SaN7+35AooiTrv0oMaZF+DKoY1OS1/YlqJfgxRfeLFRSvE
         +pO/khI5XnLPwDi+DBU1Tw3Bkvjjt7jP7JgN8h9dFyP4Wtc+CMZyFrHrxm8TCQM0kHnP
         cryw==
X-Gm-Message-State: AJIora8htN3ZHrr0EoHhSvL8fgSprY6PHFHEu1uDeeHAAVl2paCQU3h5
        MktBnrTi2nHJE/RfwyuGq1A9ywfw9ny+CJU2z+9K3U8ymxzYB6u1vxk0GzfaPs7sWEjTRFnqGJR
        S5Xz4HuGhl2RUmWWtYaTLeX7R0CgQIxhysPCR/b+WsX5LhguM9Xim78hsSVw=
X-Received: by 2002:a05:6870:f2a9:b0:f2:c0bc:411d with SMTP id u41-20020a056870f2a900b000f2c0bc411dmr2737768oap.239.1658941830719;
        Wed, 27 Jul 2022 10:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBKZhLdkbcpF/TatWlbNU7aYa3ip9lhe72pmXXNtN2IB53IwzoKcN7+r9ei2CnBpFXQD7d/DMa6iQKKEY3MnM=
X-Received: by 2002:a05:6870:f2a9:b0:f2:c0bc:411d with SMTP id
 u41-20020a056870f2a900b000f2c0bc411dmr2737745oap.239.1658941830466; Wed, 27
 Jul 2022 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com> <20220722022416.137548-3-mfo@canonical.com>
 <CAK7LNARTN55RE18vXjMuAUO37kMeawBD4G=UcS6_j7U0asCZEA@mail.gmail.com>
In-Reply-To: <CAK7LNARTN55RE18vXjMuAUO37kMeawBD4G=UcS6_j7U0asCZEA@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 27 Jul 2022 14:10:18 -0300
Message-ID: <CAO9xwp2GpYHSNnvoXze=ye3OZoOxuoBv40BS+rv4UCdV=O_oHg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] modpost: deduplicate section_rel[a]()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 26, 2022 at 6:20 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 11:24 AM Mauricio Faria de Oliveira
> <mfo@canonical.com> wrote:
> >
> > Now both functions are almost identical, and we can again generalize
> > the relocation types Elf_Rela/Elf_Rel with Elf_Rela, and handle some
> > differences with conditionals on section header type (SHT_RELA/REL).
> >
> > The important bit is to make sure the loop increment uses the right
> > size for pointer arithmethic.
> >
> > The original reason for split functions to make program logic easier
> > to follow; commit 5b24c0715fc4 ("kbuild: code refactoring in modpost").
> >
> > Hopefully these 2 commits may help improving that, without an impact
> > in understanding the code due to generalization of relocation types.
> >
> > Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> > ---
> >  scripts/mod/modpost.c | 61 ++++++++++++++++---------------------------
> >  1 file changed, 23 insertions(+), 38 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 4c1038dccae0..d1ed67fa290b 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1794,63 +1794,49 @@ static int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
> >         return 0;
> >  }
> >
> > -static void section_rela(const char *modname, struct elf_info *elf,
> > +/* The caller must ensure sechdr->sh_type == SHT_RELA or SHT_REL. */
> > +static void section_relx(const char *modname, struct elf_info *elf,
> >                          Elf_Shdr *sechdr)
> >  {
> >         Elf_Sym  *sym;
> > -       Elf_Rela *rela;
> > +       Elf_Rela *relx; /* access .r_addend in SHT_RELA _only_! */
> >         Elf_Rela r;
> > +       size_t relx_size;
> >         const char *fromsec;
> >
> >         Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
> >         Elf_Rela *stop  = (void *)start + sechdr->sh_size;
> >
> >         fromsec = sech_name(elf, sechdr);
> > -       fromsec += strlen(".rela");
> > +       if (sechdr->sh_type == SHT_RELA) {
> > +               relx_size = sizeof(Elf_Rela);
> > +               fromsec += strlen(".rela");
> > +       } else if (sechdr->sh_type == SHT_REL) {
> > +               relx_size = sizeof(Elf_Rel);
> > +               fromsec += strlen(".rel");
> > +       } else {
> > +               error("%s: [%s.ko] not relocation section\n", fromsec, modname);
>
>
> Nit.
>
> modname already contains the suffix  ".o".
>
> For vmlinux, the error message will print like this:
> [vmlinux.o.ko]

Oops, I missed the '.o' suffix difference between modname and mod->name.

If it's OK, I just removed '.ko' as it's simpler than plumbing 'mod' in
(i.e., for  "[%s%s]" with mod->name, mod->is_vmlinux ? "" : ".ko" ).

And just noting for myself/other readers:

Similar calls in do_sysctl_{entry,table}() with '.ko' are OK because their
modname is mod->name (without '.o' suffix), and shouldn't run for vmlinux,
just modules (MODULE_SYSCTL_TABLE is defined if MODULE is defined).

Thanks!


>
>
>
>
>
> > +               return;
> > +       }
> > +
> >         /* if from section (name) is know good then skip it */
> >         if (match(fromsec, section_white_list))
> >                 return;
> >
> > -       for (rela = start; rela < stop; rela++) {
> > -               if (get_relx_sym(elf, sechdr, rela, &r, &sym))
> > +       for (relx = start; relx < stop; relx = (void *)relx + relx_size) {
> > +               if (get_relx_sym(elf, sechdr, relx, &r, &sym))
> >                         continue;
> >
> >                 switch (elf->hdr->e_machine) {
> >                 case EM_RISCV:
> > -                       if (!strcmp("__ex_table", fromsec) &&
> > +                       if (sechdr->sh_type == SHT_RELA &&
> > +                           !strcmp("__ex_table", fromsec) &&
> >                             ELF_R_TYPE(r.r_info) == R_RISCV_SUB32)
> >                                 continue;
> >                         break;
> >                 }
> >
> > -               if (is_second_extable_reloc(start, rela, fromsec))
> > -                       find_extable_entry_size(fromsec, &r);
> > -               check_section_mismatch(modname, elf, &r, sym, fromsec);
> > -       }
> > -}
> > -
> > -static void section_rel(const char *modname, struct elf_info *elf,
> > -                       Elf_Shdr *sechdr)
> > -{
> > -       Elf_Sym *sym;
> > -       Elf_Rel *rel;
> > -       Elf_Rela r;
> > -       const char *fromsec;
> > -
> > -       Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
> > -       Elf_Rel *stop  = (void *)start + sechdr->sh_size;
> > -
> > -       fromsec = sech_name(elf, sechdr);
> > -       fromsec += strlen(".rel");
> > -       /* if from section (name) is know good then skip it */
> > -       if (match(fromsec, section_white_list))
> > -               return;
> > -
> > -       for (rel = start; rel < stop; rel++) {
> > -               if (get_relx_sym(elf, sechdr, (Elf_Rela *)rel, &r, &sym)
> > -                       continue;
> > -
> > -               if (is_second_extable_reloc(start, rel, fromsec))
> > +               if (is_second_extable_reloc(start, relx, fromsec))
> >                         find_extable_entry_size(fromsec, &r);
> >                 check_section_mismatch(modname, elf, &r, sym, fromsec);
> >         }
> > @@ -1877,10 +1863,9 @@ static void check_sec_ref(const char *modname, struct elf_info *elf)
> >         for (i = 0; i < elf->num_sections; i++) {
> >                 check_section(modname, elf, &elf->sechdrs[i]);
> >                 /* We want to process only relocation sections and not .init */
> > -               if (sechdrs[i].sh_type == SHT_RELA)
> > -                       section_rela(modname, elf, &elf->sechdrs[i]);
> > -               else if (sechdrs[i].sh_type == SHT_REL)
> > -                       section_rel(modname, elf, &elf->sechdrs[i]);
> > +               if (sechdrs[i].sh_type == SHT_RELA ||
> > +                   sechdrs[i].sh_type == SHT_REL)
> > +                       section_relx(modname, elf, &elf->sechdrs[i]);
> >         }
> >  }
> >
> > --
> > 2.25.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Mauricio Faria de Oliveira
