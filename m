Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BCF6AFC6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 02:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCHBch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 20:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCHBcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:32:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486426E99;
        Tue,  7 Mar 2023 17:32:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so59933861edb.3;
        Tue, 07 Mar 2023 17:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678239150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wv48Gse23GWhV4FLS1xvq7CesexYNmHf7o1A7VPU4I=;
        b=HvK/f42Y5ig5MN8aX47N3PuVZvSPA1BhAXTgq6b6lKRV3NqmUH/ObA5gOi5V+CqApT
         nTteFKtmLGN8jNrOs6TqdkL3NuiT1Kz7PtVgJKiqoghNTsNQqEUcymiwVCiLTHUVGZT0
         GgeVZ8/4EGdJ46z7tgDYVHEEqK43hy90eDnLt61wWFeKsgLXFPTAaM25NaaZHgV0rRRg
         u5qiPbQVzjVVNyo9xJfkgbDKcW5/88FM89Y8BsAcpFhjCfdsKOOgIUWc1NuTfREuOCO9
         NJNTl2V8m7jrt44najZFbNkLCDEwCdL3C1iKx6duDu8aCaAAO95Zqc04qT9OmVIhMJsn
         i4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678239150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Wv48Gse23GWhV4FLS1xvq7CesexYNmHf7o1A7VPU4I=;
        b=V2oKngOFkyx8PKS2K7Fat9cZZugcIEdHYmK2Gjd0uegg33LHDZidPliV5QWJtjqqX/
         X2dwKD6F9gciwSwSu/SKWg6U/u2NIPNWp2R0zI5cce3iUWn15IJLUQZ8ZHs5XVeyavfi
         C4QJL/Yyvbyjhe0d9aWNX/1PDrBydHRaKMGGHadaUsc4J4s+coVDDdV80SoU/b15AltT
         3aPHd5gOCCC/0/8oUkjUbgXK3EzGkyLk7b73nVi50L9jBT4Px18nI0s+pqvpsg2zkL2z
         aBBZ0VDIzFjddyNqNFtiap7LaLPf8ExvhoWsUOYEq6wUZ51E1zs4yz+r7KSsyshavVLX
         XFgg==
X-Gm-Message-State: AO0yUKXlC9mqm0fyKYDEE8lHGbdI5vgoP9+fvRWHkgMj0L2ghU9NeuE+
        hne96LWYEaRR2QVMT64BWHixNpKDaC/T87lNHCw=
X-Google-Smtp-Source: AK7set9tlVLl+pNXDkJWR0/BfgTGqh/6bOnzUAAw53wzvgVE4mGyUQGzsX9ht3WJeYZ/lMkpWqINJ5xdHLd9HBpzY5c=
X-Received: by 2002:a17:906:2adb:b0:8de:c6a6:5134 with SMTP id
 m27-20020a1709062adb00b008dec6a65134mr7369382eje.15.1678239149687; Tue, 07
 Mar 2023 17:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20230228093206.821563-1-jolsa@kernel.org> <20230228093206.821563-10-jolsa@kernel.org>
In-Reply-To: <20230228093206.821563-10-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:32:17 -0800
Message-ID: <CAEf4BzbLz5q8NgREMEiOPumSBEhKMh0rDC=1ii8Muvm4Whg59w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 9/9] selftests/bpf: Add
 iter_task_vma_buildid test
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

On Tue, Feb 28, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Testing iterator access to build id in vma->vm_file->f_inode
> object by storing each binary with buildid into map and checking
> it against buildid retrieved in user space.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 78 +++++++++++++++++++
>  .../bpf/progs/bpf_iter_task_vma_buildid.c     | 60 ++++++++++++++
>  2 files changed, 138 insertions(+)
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
> +out:
> +       close(proc_maps_fd);
> +       close(iter_fd);
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
> index 000000000000..dc528a4783ec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_iter.h"
> +#include "err.h"
> +#include <bpf/bpf_helpers.h>
> +#include <string.h>
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
> +       struct seq_file *seq =3D ctx->meta->seq;
> +       struct task_struct *task =3D ctx->task;
> +       unsigned long file_key;
> +       struct inode *inode;
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
> +       inode =3D file->f_inode;
> +       if (IS_ERR_OR_NULL(inode->i_build_id)) {
> +               /* On error return empty build id. */
> +               __builtin_memset(&build_id.data, 0x0, sizeof(build_id.dat=
a));
> +               build_id.sz =3D 20;

let's replace `#define BUILD_ID_SIZE_MAX 20` in
include/linux/buildid.h with `enum { BUILD_ID_SIZE_MAX =3D 20 };`. This
will "expose" this constant into BTF and thus vmlinux.h, so we won't
have to hard-code anything. BPF users would be grateful as well.

No downsides of doing this.

> +       } else {
> +               __builtin_memcpy(&build_id, inode->i_build_id, sizeof(*in=
ode->i_build_id));
> +       }
> +
> +       bpf_map_update_elem(&files, &path, &build_id, 0);
> +       return 0;
> +}
> --
> 2.39.2
>
