Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9726BDB9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCPWZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCPWZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:25:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D827496;
        Thu, 16 Mar 2023 15:24:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so13494239edb.6;
        Thu, 16 Mar 2023 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679005395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGSZyqKLu9g/b6ltq5HPmqtNV6Ck97PehH5tW5q6yKw=;
        b=B0dxVLRnRXXZLCRxo8NJ6aibdCmCMWnolan9GswsTXDfMVrnVbHzijuwJA5Oi3tqIW
         6nT/pGnodEEpPaISyehOV3sVMBLax489zKxPrI3dM6woBo1X+YdOH/PQQQvjDwK1qdG7
         F52pX+eaq3Nhxs3nGoaNYF5ev9lf/ePdg+QqTY+6K4OKpCQt/72D0ARsRbGStDkTPRMU
         pE0thi+jNmFnmqHi5VjTMyGywxWf/yIiPpJMevfY2U/RmAkNHkKe7UDU/pLdnaDUCtDY
         9t38RGsLVvbDKoDB7Qdot+dSAVv0wQDHS1RWr64j0i3KPc4XVhN6nQ4Ag413WI1n+4Yu
         BAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGSZyqKLu9g/b6ltq5HPmqtNV6Ck97PehH5tW5q6yKw=;
        b=G4Qqr+iJas9PbBlGkF1Q+IfU5cxxiwBb+FNuGrBHEgLbaDJeJt7/tWJLvjWnTMuld8
         zs6ADYlBLCaL2BpwGKor1+ENB2Hx41ysyP2mbvVGXtnyWtjbN+oNcgBe76DTLEn5mRwP
         XBh+JV6dIGFS7b5IwydxD8GviCIJd9P5MhwG7NEjkReDd02WKdJnYq/O85lJE1b5uMfL
         7VN/uVCb4qlrQHoW4oFH6ncKNVLE6ruNwDB/uqg7Tf/h8D5XhGpzg8rP/s+PcbhpQ4Kr
         AXbdFPiA2H9pOB+wBTIU1WuAevhc2BUWCrrdQW9+L64Q6xYJh7HNGcl16523fIKIXWJ3
         vf7w==
X-Gm-Message-State: AO0yUKWuOxFaUTq4Nrc4MKtOz7xsHLegDYMnBaYUyGGW2C++4xYFx5/G
        6YqO0+2BtECxz2yBfm1LyN0ONZw5whitdAL9J18=
X-Google-Smtp-Source: AK7set9fHlBx26S7LOhx6lweHap9xCD5lSyQMnsugPB/PzOCM0OOWwhWygZ6QWBEabhw6FIPFUESOayFrEwergf47Io=
X-Received: by 2002:a17:906:2b09:b0:931:ce20:db96 with SMTP id
 a9-20020a1709062b0900b00931ce20db96mr35719ejg.5.1679005394787; Thu, 16 Mar
 2023 15:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-6-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-6-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:23:03 -0700
Message-ID: <CAEf4BzZpXK0_k0Z8BmAB1-Edpc_BZYsu5wt9XVEJ4ryAxDYewA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 5/9] selftests/bpf: Add read_buildid function
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
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
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

On Thu, Mar 16, 2023 at 10:03=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding read_build_id function that parses out build id from
> specified binary.
>
> It will replace extract_build_id and also be used in following
> changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 86 +++++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h |  5 ++
>  2 files changed, 91 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 934bf28fc888..72b38a41f574 100644
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
>  #define TRACEFS_PIPE   "/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE   "/sys/kernel/debug/tracing/trace_pipe"
> @@ -234,3 +237,86 @@ ssize_t get_rel_offset(uintptr_t addr)
>         fclose(f);
>         return -EINVAL;
>  }
> +
> +static int
> +parse_build_id_buf(const void *note_start, Elf32_Word note_size,
> +                  char *build_id)

nit: single line

should we pass buffer size instead of assuming at least BPF_BUILD_ID_SIZE b=
elow?

> +{
> +       Elf32_Word note_offs =3D 0, new_offs;
> +
> +       while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> +               Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_off=
s);
> +
> +               if (nhdr->n_type =3D=3D 3 && nhdr->n_namesz =3D=3D sizeof=
("GNU") &&
> +                   !strcmp((char *)(nhdr + 1), "GNU") && nhdr->n_descsz =
> 0 &&
> +                   nhdr->n_descsz <=3D BPF_BUILD_ID_SIZE) {
> +                       memcpy(build_id, note_start + note_offs +
> +                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r), nhdr->n_descsz);
> +                       memset(build_id + nhdr->n_descsz, 0, BPF_BUILD_ID=
_SIZE - nhdr->n_descsz);
> +                       return (int) nhdr->n_descsz;
> +               }
> +
> +               new_offs =3D note_offs + sizeof(Elf32_Nhdr) +
> +                          ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descs=
z, 4);
> +               if (new_offs >=3D note_size)
> +                       break;

while condition() above would handle this, so this check appears not necess=
ary?

so just assign note_offs directly?


> +               note_offs =3D new_offs;
> +       }
> +
> +       return -EINVAL;

nit: -ENOENT or -ESRCH?

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

ELF_C_READ_MMAP ?

> +       if (!elf)
> +               goto out;
> +       if (elf_kind(elf) !=3D ELF_K_ELF)
> +               goto out;
> +       if (gelf_getehdr(elf, &ehdr) =3D=3D NULL)

nit: !gelf_getehdr()

> +               goto out;
> +       if (ehdr.e_ident[EI_CLASS] !=3D ELFCLASS64)
> +               goto out;

does this have to be 64-bit specific?... you are using gelf stuff, you
can be bitness-agnostic here

> +
> +       for (i =3D 0; i < ehdr.e_phnum; i++) {
> +               GElf_Phdr mem, *phdr;
> +               char *data;
> +
> +               phdr =3D gelf_getphdr(elf, i, &mem);
> +               if (!phdr)
> +                       goto out;
> +               if (phdr->p_type !=3D PT_NOTE)
> +                       continue;

I don't know where ELF + build ID spec is (if at all), but it seems to
always be in the ".note.gnu.build-id" section, so should we check the
name here?


> +               data =3D elf_rawfile(elf, &max);
> +               if (!data)
> +                       goto out;
> +               if (phdr->p_offset >=3D max || (phdr->p_offset + phdr->p_=
memsz >=3D max))

`phdr->p_offset + phdr->p_memsz =3D=3D max` would be fine, no?

> +                       goto out;
> +               err =3D parse_build_id_buf(data + phdr->p_offset, phdr->p=
_memsz, build_id);
> +               if (err > 0)
> +                       goto out;
> +               err =3D -EINVAL;
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
> index 53efde0e2998..bc3b92057033 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -4,6 +4,9 @@
>
>  #include <bpf/libbpf.h>
>
> +#define __ALIGN_MASK(x, mask)  (((x)+(mask))&~(mask))
> +#define ALIGN(x, a)            __ALIGN_MASK(x, (typeof(x))(a)-1)
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
