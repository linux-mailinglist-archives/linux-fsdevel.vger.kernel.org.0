Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CC7B1FED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjI1OoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjI1OoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:44:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9E180
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 07:44:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c6193d6bb4so196855ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695912259; x=1696517059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qvi2mkKPCAws2hfkWmM7tfPaBJGsA62IYTCfBAyQTE=;
        b=mBlb0mORjrI8zgKBJUp/nqVn2IxlkdEoH0SsETqnqgwjX2FyS1Hbl2VGfiiqHPVSE0
         cDYApN5UNG0eneQkVtzNVfoMW9D124v6IpaAOf309tLIrWkRD4dsSNEUAhhwpKhABdj/
         AyJPhtYfMqnpUlTcbxrnXs2o01BP0X0cewnsfiCmcqGrNxpjogf4VX478lNN2vM2hSXU
         EmkB0PTagYZimJB8li5MA1/mdFE/35asF5uvGFpCiIt4wicmi+paLgns4GxtuNBD1o0B
         1a6M4N3P1mX1buyiCyyVXOoiT321pCeSkzZ/1JL6CsJuZIbVZL4WtULYvuN+855WSUoI
         L0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912259; x=1696517059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qvi2mkKPCAws2hfkWmM7tfPaBJGsA62IYTCfBAyQTE=;
        b=hDv/FUk+sYkdO1VEyBqx4zdUAQGrEpGRy9wWNyMb0q7nXnR3Koi+J2A7/qy3AEGSc8
         d/DZeClMokSPus+cuFcRduqvlSXpU5TMLokawBUFD76qKS9Pz9vwV0G4S4CVVl9N70mL
         ylxYwcdyytdKk4EmakZ8TFDmBFUUCP2Ux7nzKQoSTUHeb1lUrlkoRNHgRglC/Rpf7Akg
         nYYo03ZBQo0ZHkONdQW7HdPzVSvj9neb5RsDu/HqI1lHPBRRPnSt8SrSVCrXGYzmQ9ai
         RHXI3nKm/j6JnbqpwNkZAzYFq8M/6jHw3xtGkq0kVD44dvWHzrD+NvbGVie3kyePFGeh
         xEPQ==
X-Gm-Message-State: AOJu0YyQuA3rcQGZXBa9w7cCXcEufSfusQqg0MtZy+VBevVDvl7NN+li
        KJ+Y2mtLmrm6PSNetiKGErGaIH+i3ldtQkZCw1jPcQ==
X-Google-Smtp-Source: AGHT+IHNVH8eIpIeXF8BSMRijlmgWijQPUek08k5OnwkliBTC9hDO4zqY1E2fjrhmT60W3kssnGULoeyjCmg+QFWfww=
X-Received: by 2002:a17:902:e751:b0:1c6:112f:5ceb with SMTP id
 p17-20020a170902e75100b001c6112f5cebmr678306plf.25.1695912258487; Thu, 28 Sep
 2023 07:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
In-Reply-To: <20230928-themen-dilettanten-16bf329ab370@brauner>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Sep 2023 16:43:42 +0200
Message-ID: <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 4:05=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > So I spent a good chunk of time going through this patch.
>
> The main thing that makes me go "we shouldn't do this" is that KASAN
> isn't able to detect UAF issues as Jann pointed out so I'm getting
> really nervous about this.

(FWIW there is an in-progress patch to address this that I sent a few
weeks ago but that is not landed yet,
<https://lore.kernel.org/linux-mm/20230825211426.3798691-1-jannh@google.com=
/>.
So currently KASAN can only detect UAF in SLAB_TYPESAFE_BY_RCU slabs
when the slab allocator has given them back to the page allocator.)

> And Jann also pointed out some potential issues with
> __fget_files_rcu() as well...

The issue I see with the current __fget_files_rcu() is that the
"file->f_mode & mask" is no longer effective in its current position,
it would have to be moved down below the get_file_rcu() call.
That's a semantic difference between manually RCU-freeing and
SLAB_TYPESAFE_BY_RCU - we no longer have the guarantee that an object
can't be freed and reallocated within a single RCU grace period.
With the current patch, we could race like this:

```
static inline struct file *__fget_files_rcu(struct files_struct *files,
        unsigned int fd, fmode_t mask)
{
        for (;;) {
                struct file *file;
                struct fdtable *fdt =3D rcu_dereference_raw(files->fdt);
                struct file __rcu **fdentry;

                if (unlikely(fd >=3D fdt->max_fds))
                        return NULL;

                fdentry =3D fdt->fd + array_index_nospec(fd, fdt->max_fds);
                file =3D rcu_dereference_raw(*fdentry);
                if (unlikely(!file))
                        return NULL;

                if (unlikely(file->f_mode & mask))
                        return NULL;

                [in another thread:]
                [file is removed from fd table and freed]
                [file is reallocated as something like an O_PATH file,
                 which the check above would not permit]
                [reallocated file is inserted in the fd table in the
same position]

                /*
                 * Ok, we have a file pointer. However, because we do
                 * this all locklessly under RCU, we may be racing with
                 * that file being closed.
                 *
                 * Such a race can take two forms:
                 *
                 *  (a) the file ref already went down to zero,
                 *      and get_file_rcu() fails. Just try again:
                 */
                if (unlikely(!get_file_rcu(file))) [succeeds]
                        continue;

                /*
                 *  (b) the file table entry has changed under us.
                 *       Note that we don't need to re-check the 'fdt->fd'
                 *       pointer having changed, because it always goes
                 *       hand-in-hand with 'fdt'.
                 *
                 * If so, we need to put our ref and try again.
                 */
                [recheck succeeds because the new file was inserted in
the same position]
                if (unlikely(rcu_dereference_raw(files->fdt) !=3D fdt) ||
                    unlikely(rcu_dereference_raw(*fdentry) !=3D file)) {
                        fput(file);
                        continue;
                }

                /*
                 * Ok, we have a ref to the file, and checked that it
                 * still exists.
                 */
                [a file incompatible with the supplied mask is returned]
                return file;
        }
}
```

There are also some weird get_file_rcu() users in other places like
BPF's task_file_seq_get_next and in gfs2_glockfd_next_file that do
weird stuff without the recheck, especially gfs2_glockfd_next_file
even looks at the inodes of files without taking a reference (which
seems a little dodgy but maybe actually currently works because inodes
are also RCU-freed?). So I think you'd have to clean all of that up
before you can make this change.

Similar thing with get_mm_exe_file(), that relies on get_file_rcu()
success meaning that the file was not reallocated. And tid_fd_mode()
in procfs assumes that task_lookup_fd_rcu() returns a file* whose mode
can be inspected under RCU.

As Linus already mentioned, release_empty_file() is also broken now,
because it assumes that nobody will grab references to unopened files,
but actually that can now happen spuriously when a concurrent fget()
has called get_file_rcu() on a recycled file and not yet hit the
recheck fput(). Kinda like the thing with "struct page" where GUP can
randomly spuriously bump up the refcount of any page including ones
that are not mapped into userspace. So that would have to go through
the same fput() path as every other file freeing.

We also now rely on the "f_count" initialization in init_file()
happening after the point of no return, which is currently the case,
but that'd have to be documented to avoid someone adding a later
bailout in the future, and maybe could be clarified by actually moving
the count initialization after the bailout?

Heh, I grepped for `__rcu.*file`, and BPF has a thing in
kernel/bpf/verifier.c that seems to imply it would be safe for some
types of BPF programs to follow the mm->exe_file reference solely
protected by RCU, which already seems a little dodgy now but more
after this change:

```
/* RCU trusted: these fields are trusted in RCU CS and can be NULL */
BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
        struct file __rcu *exe_file;
};
```

(To be clear: This is not intended to be an exhaustive list.)


So I think conceptually this is something you can do but it would
require a bit of cleanup all around the kernel to make sure you really
just have one or two central functions that make use of the limited
RCU-ness of "struct file", and that nothing else relies on that or
makes assumptions about how non-zero refcounts move.
