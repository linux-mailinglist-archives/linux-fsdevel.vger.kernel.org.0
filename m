Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D826BDBB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 23:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCPWc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPWcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:32:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A18618B3;
        Thu, 16 Mar 2023 15:31:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so13517705edb.9;
        Thu, 16 Mar 2023 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679005906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3zLWyHPVNxQpPGRXFL1+XihZgc7nxVWWTNMj/1mwl8=;
        b=oY2B7x8wnqsGwcCpIVExvWjMN6zqSVawA617kP+hKY8qwY8tMDxE1GTf8NJGN3DX2t
         D8qispaJSZ763gwsQBot30RSYleujJyrn6EMJcDdQhVNLZB5ndgFC3fDX7NqJI0MKEkD
         J8s7TDzRATJlrpel1+/VODW4xObjtY4IAmX7ZJ8irh6XGXQ4sbU7kmEPsMZiUCJmqPv+
         CGBp3skNfM4SMBYiR7tWOF7ydc/PY+ugz/zPhh3nd9Ch9yl8d+VFUlvWcLKa6BC5HW5B
         mSqJpLA81jn3LuMwNxMGrT+4TVqnHV2kYTI3X3dAkDdsLT3sdKgk7T60YXibQJFU8HeO
         M5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3zLWyHPVNxQpPGRXFL1+XihZgc7nxVWWTNMj/1mwl8=;
        b=Hzy5/+k8Kn3MHhrP1lOPe4IQrxfiDp0k6afXPr6TcUIEBdDEjov19zBY9RUpDh3iD+
         z/Qv7C11kt2Za3O3OgnngP2FEzhMI+yMDd7ql/IpSGndHbHFA747Ubql61EZmaXpswgo
         pMnaTOs+kZTkGOJuHXP42pssp3S9Eb1AhAHhYb/NRS5uIGJtMvzGlkPBW7kSm2JywN55
         JdX4a1TyTaUtM9+L7JB9DLzG8Aiq1cO4IScAGnXN0LX4zI7WFK4aGVvuDeCfv8XOH/57
         7i34Diwzd1g2HMd1Uw5QW8WrAIaTgIbsXcoR3tps3S5chRAdiZrMON/2dVMtWoIDjMwD
         aqbw==
X-Gm-Message-State: AO0yUKUSBA2qrA9FqEbCBXL1MCTRL67yMQC83YE4JPb0vCn/hEmXD7xQ
        ZtWtilh/jfubtjLL2WBc8ScgOAFgaeIFelXo6+w=
X-Google-Smtp-Source: AK7set8l5zfO9GJlRowCWeytxjenFzFoUcsMoAd0b6XFdlHAhpu9dFDxw0gQXlKT0FZyLzSjXj7kOq7I7J2m/70171I=
X-Received: by 2002:a17:906:8552:b0:8ab:b606:9728 with SMTP id
 h18-20020a170906855200b008abb6069728mr6191916ejy.5.1679005905761; Thu, 16 Mar
 2023 15:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230316170149.4106586-1-jolsa@kernel.org> <20230316170149.4106586-9-jolsa@kernel.org>
In-Reply-To: <20230316170149.4106586-9-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 15:31:33 -0700
Message-ID: <CAEf4BzYh-kxwNzBf8M1g2+kch=Sy0hgRGR0eoR+PTYmwncJB1g@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 8/9] selftests/bpf: Add iter_task_vma_buildid test
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
> Testing iterator access to build id in vma->vm_file object by storing
> each binary with build id into map and checking it against build id
> retrieved in user space.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 78 +++++++++++++++++++
>  .../bpf/progs/bpf_iter_task_vma_buildid.c     | 56 +++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_b=
uildid.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 1f02168103dd..c7dd89e7cad0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -33,6 +33,7 @@
>  #include "bpf_iter_bpf_link.skel.h"
>  #include "bpf_iter_ksym.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
> +#include "bpf_iter_task_vma_buildid.skel.h"
>
>  static int duration;
>
> @@ -1536,6 +1537,81 @@ static void test_task_vma_dead_task(void)
>         bpf_iter_task_vma__destroy(skel);
>  }
>
> +#define D_PATH_BUF_SIZE        1024
> +
> +struct build_id {
> +       u32 sz;
> +       char data[BPF_BUILD_ID_SIZE];
> +};
> +
> +static void test_task_vma_buildid(void)
> +{
> +       int err, iter_fd =3D -1, proc_maps_fd =3D -1, sz;
> +       struct bpf_iter_task_vma_buildid *skel;
> +       char key[D_PATH_BUF_SIZE], *prev_key;
> +       char build_id[BPF_BUILD_ID_SIZE];
> +       int len, files_fd, cnt =3D 0;
> +       struct build_id val;
> +       char c;
> +
> +       skel =3D bpf_iter_task_vma_buildid__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma_buildid__open_and_loa=
d"))
> +               return;
> +
> +       skel->links.proc_maps =3D bpf_program__attach_iter(
> +               skel->progs.proc_maps, NULL);
> +
> +       if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_it=
er")) {
> +               skel->links.proc_maps =3D NULL;
> +               goto out;
> +       }
> +
> +       iter_fd =3D bpf_iter_create(bpf_link__fd(skel->links.proc_maps));
> +       if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> +               goto out;
> +
> +       /* trigger the iterator, there's no output, just map */
> +       len =3D read(iter_fd, &c, 1);
> +       ASSERT_EQ(len, 0, "len_check");
> +
> +       files_fd =3D bpf_map__fd(skel->maps.files);
> +
> +       prev_key =3D NULL;
> +
> +       while (true) {
> +               err =3D bpf_map_get_next_key(files_fd, prev_key, &key);
> +               if (err) {
> +                       if (errno =3D=3D ENOENT)
> +                               err =3D 0;
> +                       break;
> +               }
> +               if (bpf_map_lookup_elem(files_fd, key, &val))
> +                       break;
> +               if (!ASSERT_LE(val.sz, BPF_BUILD_ID_SIZE, "buildid_size")=
)
> +                       break;
> +
> +               sz =3D read_build_id(key, build_id);
> +               /* If there's an error, the build id is not present or ma=
lformed, kernel
> +                * should see the same result and bpf program pushed zero=
 build id.
> +                */
> +               if (sz < 0) {
> +                       memset(build_id, 0x0, BPF_BUILD_ID_SIZE);
> +                       sz =3D BPF_BUILD_ID_SIZE;
> +               }
> +               ASSERT_EQ(val.sz, sz, "build_id_size");
> +               ASSERT_MEMEQ(val.data, build_id, sz, "build_id_data");
> +
> +               prev_key =3D key;
> +               cnt++;
> +       }
> +
> +       printf("checked %d files\n", cnt);

ASSERT_GT(cnt, 0, "file_cnt");

better than printf, and tests no results condition

> +out:
> +       close(proc_maps_fd);
> +       close(iter_fd);

`if (proc_maps_fd >=3D 0)` and `if (iter_fd >=3D 0)` are missing


> +       bpf_iter_task_vma_buildid__destroy(skel);
> +}
> +
>  void test_bpf_sockmap_map_iter_fd(void)
>  {
>         struct bpf_iter_sockmap *skel;
> @@ -1659,6 +1735,8 @@ void test_bpf_iter(void)
>                 test_task_vma();
>         if (test__start_subtest("task_vma_dead_task"))
>                 test_task_vma_dead_task();
> +       if (test__start_subtest("task_vma_buildid"))
> +               test_task_vma_buildid();
>         if (test__start_subtest("task_btf"))
>                 test_task_btf();
>         if (test__start_subtest("tcp4"))
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.=
c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> new file mode 100644
> index 000000000000..11a59c0f1aba
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_iter.h"
> +#include "err.h"
> +#include <bpf/bpf_helpers.h>
> +#include <string.h>

do you need <string.h> include? I don't think BPF-side is supposed to inclu=
de it

> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +#define VM_EXEC                0x00000004
> +#define D_PATH_BUF_SIZE        1024
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 10000);
> +       __type(key, char[D_PATH_BUF_SIZE]);
> +       __type(value, struct build_id);
> +} files SEC(".maps");
> +
> +static char path[D_PATH_BUF_SIZE];
> +static struct build_id build_id;
> +
> +SEC("iter/task_vma")
> +int proc_maps(struct bpf_iter__task_vma *ctx)
> +{
> +       struct vm_area_struct *vma =3D ctx->vma;
> +       struct task_struct *task =3D ctx->task;
> +       struct file *file;
> +
> +       if (task =3D=3D (void *)0 || vma =3D=3D (void *)0)
> +               return 0;
> +
> +       if (!(vma->vm_flags & VM_EXEC))
> +               return 0;
> +
> +       file =3D vma->vm_file;
> +       if (!file)
> +               return 0;
> +
> +       __builtin_memset(path, 0x0, D_PATH_BUF_SIZE);
> +       bpf_d_path(&file->f_path, (char *) &path, D_PATH_BUF_SIZE);
> +
> +       if (bpf_map_lookup_elem(&files, &path))
> +               return 0;
> +
> +       if (IS_ERR_OR_NULL(file->f_build_id)) {
> +               /* On error return empty build id. */
> +               __builtin_memset(&build_id.data, 0x0, sizeof(build_id.dat=
a));
> +               build_id.sz =3D BUILD_ID_SIZE_MAX;
> +       } else {
> +               __builtin_memcpy(&build_id, file->f_build_id, sizeof(*fil=
e->f_build_id));
> +       }
> +
> +       bpf_map_update_elem(&files, &path, &build_id, 0);
> +       return 0;
> +}
> --
> 2.39.2
>
