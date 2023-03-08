Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0896AFC37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 02:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCHBXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 20:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCHBXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:23:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99C1F5E1;
        Tue,  7 Mar 2023 17:23:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so59918309eda.1;
        Tue, 07 Mar 2023 17:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678238584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KskDoY551EmOHdJiRobDKDE+GFk+1yzE3Gg+RoSEyLY=;
        b=JkQ0bhqC4Am3GcwuI0OROo84uG8MtJapLie7+68UMHC5Os+sArhf+fMXrkFCEwU6ih
         z3CNo5ZBcJnEAEyOG50vquTJXubVuAGEqRAiR31KBRlocW8rqfEsPA4BnETM4Yh7xcAm
         YcKY/PFP7waSJx5BEx6c3DL89+jR12G/ty2oqNEFShnLxgaNCdxXu0tZH5LLqyra+MCT
         HJwIeOkqve/OxsgaKJwKzTCSC9eb6CRCnxh4jAJ/6l9LNpdjbC+gwWf0sVXvg2pW9aUk
         ozl55DldiDnJFtOtvrzhwLtnTEeybIg8Xv/RGwgIJyjv8wyNtfFqeb7kjyerqQ2I9QSO
         lycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KskDoY551EmOHdJiRobDKDE+GFk+1yzE3Gg+RoSEyLY=;
        b=XurVw3H66Gb/y6VXWowUv8/exrs/A9+c/hbmyGwBbO0KCAZkfPRg2HiC6IYERBAcAE
         AV127IHMCPu5+jNH2LPdTvMBz6bKat3xaqZ6xaZ952eNu6bcyQNv1gACrcTQeX+vhtu9
         HRlMD6Esjsb4Koxn/UbzVuTyQ6GA3iXHcMWX59IqNd0KEgvfx9arLi/XzwB3coO2LEsU
         4WTGRTr2AK+2HNcLN6fttBMJO1xjJFDC8k/dZ1lbZNnq76umcr7xcYdJFGro1VKNGJMN
         vPDUD9bOx/Jsl6PVhAxFo9xCqG37VEjJ7fxKerq7u2KuLiBzA87bCOiPIqSrEisXAGgB
         iMRQ==
X-Gm-Message-State: AO0yUKXzOpEEeKCzOmFhGeKfM7fWis0zOemY47PH89shuzzA92UE3anW
        0PE1qomW9EP0KLXIKcGEVz74jgqKIDmMGxvPErY=
X-Google-Smtp-Source: AK7set8UF2ElgsF28TDecwVtSd8IHMfsKKXYJQppk+w1+yzC8tJQLsFc92Ik1julFeaWkn6KOgvNREeU2jUpuJ0aQbY=
X-Received: by 2002:a17:907:33c1:b0:8b0:fbd5:2145 with SMTP id
 zk1-20020a17090733c100b008b0fbd52145mr8286182ejb.15.1678238583714; Tue, 07
 Mar 2023 17:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20230228093206.821563-1-jolsa@kernel.org> <20230228093206.821563-6-jolsa@kernel.org>
In-Reply-To: <20230228093206.821563-6-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:22:51 -0800
Message-ID: <CAEf4BzZsOvvPJRt69vj+YCAJ1DAXgLSD0E3rfoMOLo3c6mSKiQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 5/9] selftests/bpf: Add read_buildid function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:33=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding read_build_id function that parses out build id from
> specified binary.
>
> It will replace extract_build_id and also be used in following
> changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 98 +++++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h |  5 ++
>  2 files changed, 103 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 09a16a77bae4..c10e16626cd3 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -11,6 +11,9 @@
>  #include <linux/perf_event.h>
>  #include <sys/mman.h>
>  #include "trace_helpers.h"
> +#include <linux/limits.h>
> +#include <libelf.h>
> +#include <gelf.h>
>
>  #define DEBUGFS "/sys/kernel/debug/tracing/"
>
> @@ -230,3 +233,98 @@ ssize_t get_rel_offset(uintptr_t addr)
>         fclose(f);
>         return -EINVAL;
>  }
> +
> +static int
> +parse_build_id_buf(const void *note_start, Elf32_Word note_size,
> +                  char *build_id)
> +{
> +       Elf32_Word note_offs =3D 0, new_offs;
> +
> +       while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> +               Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_off=
s);
> +
> +               if (nhdr->n_type =3D=3D 3 &&
> +                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> +                   !strcmp((char *)(nhdr + 1), "GNU") &&
> +                   nhdr->n_descsz > 0 &&
> +                   nhdr->n_descsz <=3D BPF_BUILD_ID_SIZE) {
> +                       memcpy(build_id, note_start + note_offs +
> +                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r),
> +                              nhdr->n_descsz);
> +                       memset(build_id + nhdr->n_descsz, 0,
> +                              BPF_BUILD_ID_SIZE - nhdr->n_descsz);

I won't count :) but if something fits within 100 characters, please
keep it on single line

> +                       return (int) nhdr->n_descsz;
> +               }
> +
> +               new_offs =3D note_offs + sizeof(Elf32_Nhdr) +
> +                          ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descs=
z, 4);
> +
> +               if (new_offs >=3D note_size)
> +                       break;
> +               note_offs =3D new_offs;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +/* Reads binary from *path* file and returns it in the *build_id*
> + * which is expected to be at least BPF_BUILD_ID_SIZE bytes.
> + * Returns size of build id on success. On error the error value
> + * is returned.
> + */
> +int read_build_id(const char *path, char *build_id)
> +{
> +       int fd, err =3D -EINVAL;
> +       Elf *elf =3D NULL;
> +       GElf_Ehdr ehdr;
> +       size_t max, i;
> +
> +       fd =3D open(path, O_RDONLY | O_CLOEXEC);
> +       if (fd < 0)
> +               return -errno;
> +
> +       (void)elf_version(EV_CURRENT);
> +
> +       elf =3D elf_begin(fd, ELF_C_READ, NULL);
> +       if (!elf)
> +               goto out;
> +
> +       if (elf_kind(elf) !=3D ELF_K_ELF)
> +               goto out;
> +
> +       if (gelf_getehdr(elf, &ehdr) =3D=3D NULL)
> +               goto out;
> +
> +       if (ehdr.e_ident[EI_CLASS] !=3D ELFCLASS64)
> +               goto out;
> +
> +       for (i =3D 0; i < ehdr.e_phnum; i++) {
> +               GElf_Phdr mem, *phdr;
> +               char *data;
> +
> +               phdr =3D gelf_getphdr(elf, i, &mem);
> +               if (!phdr)
> +                       goto out;
> +
> +               if (phdr->p_type !=3D PT_NOTE)
> +                       continue;
> +
> +               data =3D elf_rawfile(elf, &max);
> +               if (!data)
> +                       goto out;
> +
> +               if (phdr->p_offset >=3D max ||
> +                  (phdr->p_offset + phdr->p_memsz >=3D max))
> +                       goto out;
> +
> +               err =3D parse_build_id_buf(data + phdr->p_offset, phdr->p=
_memsz, build_id);
> +               if (err > 0)
> +                       goto out;
> +       }
> +
> +out:
> +       if (elf)
> +               elf_end(elf);
> +       close(fd);
> +       return err;
> +}
> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/=
selftests/bpf/trace_helpers.h
> index 53efde0e2998..50b2cc498ba7 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -4,6 +4,9 @@
>
>  #include <bpf/libbpf.h>
>
> +#define ALIGN(x, a)            __ALIGN_MASK(x, (typeof(x))(a)-1)
> +#define __ALIGN_MASK(x, mask)  (((x)+(mask))&~(mask))

nit: I know these are macros, but why would you first use __ALIGN_MASK
and then #define it? swap them?


> +
>  struct ksym {
>         long addr;
>         char *name;
> @@ -23,4 +26,6 @@ void read_trace_pipe(void);
>  ssize_t get_uprobe_offset(const void *addr);
>  ssize_t get_rel_offset(uintptr_t addr);
>
> +int read_build_id(const char *path, char *build_id);
> +
>  #endif
> --
> 2.39.2
>
