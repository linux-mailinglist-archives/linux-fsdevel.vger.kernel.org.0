Return-Path: <linux-fsdevel+bounces-945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76D7D3E1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8688B20E70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795442111F;
	Mon, 23 Oct 2023 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pp2TtSC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC90210EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 17:44:06 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73068127
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 10:44:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so3428141276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698083041; x=1698687841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cU12HkP0RcoPxa/ApLebctC4ZDsqUcbganQiww/yNQ=;
        b=Pp2TtSC0AGFoBvTe4mcdWwW6EXiXZAQZgvlKbormp2a6Ew8VnuaZKKxuLNgZ6KatfN
         wPyOtgyUfD6vYrgFrohokrOXX+qzhYAkmc1Wv4rOIpItmQUpo8GkPrgNyQC659zUbELM
         sWs6VoaDSjjYZ7VN8miTyRpl/nk9f+m1zdcUNJtusqeKPmInCxB7c4B4GfAGRSFq2TLJ
         y1Gk4B54pmyex6Etx+ClvTFmxc5bQyVaUpbe9Y9KPFVlIwLh/hc9Jqg+TL3PnoqaF+Px
         ZVIe0Xf7MAQeVJ/y2g1lnfXs6wcGettDaeTF3FaR9rRoDUAK4uG3EzKmqCvne8jYRlkM
         np3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083041; x=1698687841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cU12HkP0RcoPxa/ApLebctC4ZDsqUcbganQiww/yNQ=;
        b=iC/dWxcovl9psB+O0pENFvgwbYIapMuGNQD2e76evPylmXCvSO3MMc6uCnGgRzhArK
         PMICZpbVez2n0a048D0/iazdNggCS5Hpg4P3SXSHyvd4LfB2d+hiXI5RE7Nnphi2RFLn
         +JCM0/6rl12foXrfUaFVawakodo24Moz8cJyI6vbGE4ppBgGw3ucsvlzlKM51V31F2UJ
         X4NhhucfNiuOJQXDVJrC+70Gm5CK9I7mlC87QB8PIsulN/NrA2o49g4Vy+Mx3ZF/+UUA
         GxvRNGqgrUzKtRlVcKE1MAj5JNfNJBFS1nX8CkfC7T7u0XzxKElPgkENIXMzThTKiIm9
         dH6g==
X-Gm-Message-State: AOJu0Yw+/SFByxYI80sJdQKsmV8/PRmDyXfKYwg0oBFXy0k6k98vZGe4
	diO1UK39fPT0igG9ubuUFNimvtVggdSnELxn3OsNSQ==
X-Google-Smtp-Source: AGHT+IHlLQUBoVSYTfZG/7GbhYCYEW98PnPFD+pBfefX+8UFDQXNyGwB9kMgJ6jZtuFuZciKJRyQvvPygzWm/TIb/iE=
X-Received: by 2002:a05:6902:1183:b0:d9a:d8d0:376b with SMTP id
 m3-20020a056902118300b00d9ad8d0376bmr11029852ybu.26.1698083040960; Mon, 23
 Oct 2023 10:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <ZShsQzKvQDZW+rRM@x1n> <CAJuCfpEtaLs=nQK=oPHe9Nyq1UoqLk1pt2k-5ddDks3Ni2d+cw@mail.gmail.com>
 <ZTVVhkq8uNoQUlQx@x1n>
In-Reply-To: <ZTVVhkq8uNoQUlQx@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Oct 2023 10:43:49 -0700
Message-ID: <CAJuCfpEDEXHVNYRaPsD3GVbcbZ-NuH0n3Cz-V0MDMhiJG_Esrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 10:02=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Oct 19, 2023 at 02:24:06PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Oct 12, 2023 at 3:00=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Sun, Oct 08, 2023 at 11:42:27PM -0700, Suren Baghdasaryan wrote:
> > > > From: Andrea Arcangeli <aarcange@redhat.com>
> > > >
> > > > Implement the uABI of UFFDIO_MOVE ioctl.
> > > > UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the applicat=
ion
> > > > needs pages to be allocated [1]. However, with UFFDIO_MOVE, if page=
s are
> > > > available (in userspace) for recycling, as is usually the case in h=
eap
> > > > compaction algorithms, then we can avoid the page allocation and me=
mcpy
> > > > (done by UFFDIO_COPY). Also, since the pages are recycled in the
> > > > userspace, we avoid the need to release (via madvise) the pages bac=
k to
> > > > the kernel [2].
> > > > We see over 40% reduction (on a Google pixel 6 device) in the compa=
cting
> > > > thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_CO=
PY. This was
> > > > measured using a benchmark that emulates a heap compaction implemen=
tation
> > > > using userfaultfd (to allow concurrent accesses by application thre=
ads).
> > > > More details of the usecase are explained in [2].
> > > > Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> > > > touching them within the same vma. Today, it can only be done by mr=
emap,
> > > > however it forces splitting the vma.
> > > >
> > > > [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aa=
rcange@redhat.com/
> > > > [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5=
nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> > > >
> > > > Update for the ioctl_userfaultfd(2)  manpage:
> > > >
> > > >    UFFDIO_MOVE
> > > >        (Since Linux xxx)  Move a continuous memory chunk into the
> > > >        userfault registered range and optionally wake up the blocke=
d
> > > >        thread. The source and destination addresses and the number =
of
> > > >        bytes to move are specified by the src, dst, and len fields =
of
> > > >        the uffdio_move structure pointed to by argp:
> > > >
> > > >            struct uffdio_move {
> > > >                __u64 dst;    /* Destination of move */
> > > >                __u64 src;    /* Source of move */
> > > >                __u64 len;    /* Number of bytes to move */
> > > >                __u64 mode;   /* Flags controlling behavior of move =
*/
> > > >                __s64 move;   /* Number of bytes moved, or negated e=
rror */
> > > >            };
> > > >
> > > >        The following value may be bitwise ORed in mode to change th=
e
> > > >        behavior of the UFFDIO_MOVE operation:
> > > >
> > > >        UFFDIO_MOVE_MODE_DONTWAKE
> > > >               Do not wake up the thread that waits for page-fault
> > > >               resolution
> > > >
> > > >        UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
> > > >               Allow holes in the source virtual range that is being=
 moved.
> > > >               When not specified, the holes will result in ENOENT e=
rror.
> > > >               When specified, the holes will be accounted as succes=
sfully
> > > >               moved memory. This is mostly useful to move hugepage =
aligned
> > > >               virtual regions without knowing if there are transpar=
ent
> > > >               hugepages in the regions or not, but preventing the r=
isk of
> > > >               having to split the hugepage during the operation.
> > > >
> > > >        The move field is used by the kernel to return the number of
> > > >        bytes that was actually moved, or an error (a negated errno-
> > > >        style value).  If the value returned in move doesn't match t=
he
> > > >        value that was specified in len, the operation fails with th=
e
> > > >        error EAGAIN.  The move field is output-only; it is not read=
 by
> > > >        the UFFDIO_MOVE operation.
> > > >
> > > >        The operation may fail for various reasons. Usually, remappi=
ng of
> > > >        pages that are not exclusive to the given process fail; once=
 KSM
> > > >        might deduplicate pages or fork() COW-shares pages during fo=
rk()
> > > >        with child processes, they are no longer exclusive. Further,=
 the
> > > >        kernel might only perform lightweight checks for detecting w=
hether
> > > >        the pages are exclusive, and return -EBUSY in case that chec=
k fails.
> > > >        To make the operation more likely to succeed, KSM should be
> > > >        disabled, fork() should be avoided or MADV_DONTFORK should b=
e
> > > >        configured for the source VMA before fork().
> > > >
> > > >        This ioctl(2) operation returns 0 on success.  In this case,=
 the
> > > >        entire area was moved.  On error, -1 is returned and errno i=
s
> > > >        set to indicate the error.  Possible errors include:
> > > >
> > > >        EAGAIN The number of bytes moved (i.e., the value returned i=
n
> > > >               the move field) does not equal the value that was
> > > >               specified in the len field.
> > > >
> > > >        EINVAL Either dst or len was not a multiple of the system pa=
ge
> > > >               size, or the range specified by src and len or dst an=
d len
> > > >               was invalid.
> > > >
> > > >        EINVAL An invalid bit was specified in the mode field.
> > > >
> > > >        ENOENT
> > > >               The source virtual memory range has unmapped holes an=
d
> > > >               UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> > > >
> > > >        EEXIST
> > > >               The destination virtual memory range is fully or part=
ially
> > > >               mapped.
> > > >
> > > >        EBUSY
> > > >               The pages in the source virtual memory range are not
> > > >               exclusive to the process. The kernel might only perfo=
rm
> > > >               lightweight checks for detecting whether the pages ar=
e
> > > >               exclusive. To make the operation more likely to succe=
ed,
> > > >               KSM should be disabled, fork() should be avoided or
> > > >               MADV_DONTFORK should be configured for the source vir=
tual
> > > >               memory area before fork().
> > > >
> > > >        ENOMEM Allocating memory needed for the operation failed.
> > > >
> > > >        ESRCH
> > > >               The faulting process has exited at the time of a
> > >
> > > Nit pick comment for future man page: there's no faulting process in =
this
> > > context. Perhaps "target process"?
> >
> > Ack.
> >
> > >
> > > >               UFFDIO_MOVE operation.
> > > >
> > > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  Documentation/admin-guide/mm/userfaultfd.rst |   3 +
> > > >  fs/userfaultfd.c                             |  63 ++
> > > >  include/linux/rmap.h                         |   5 +
> > > >  include/linux/userfaultfd_k.h                |  12 +
> > > >  include/uapi/linux/userfaultfd.h             |  29 +-
> > > >  mm/huge_memory.c                             | 138 +++++
> > > >  mm/khugepaged.c                              |   3 +
> > > >  mm/rmap.c                                    |   6 +
> > > >  mm/userfaultfd.c                             | 602 +++++++++++++++=
++++
> > > >  9 files changed, 860 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documen=
tation/admin-guide/mm/userfaultfd.rst
> > > > index 203e26da5f92..e5cc8848dcb3 100644
> > > > --- a/Documentation/admin-guide/mm/userfaultfd.rst
> > > > +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> > > > @@ -113,6 +113,9 @@ events, except page fault notifications, may be=
 generated:
> > > >    areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature ind=
icating
> > > >    support for shmem virtual memory areas.
> > > >
> > > > +- ``UFFD_FEATURE_MOVE`` indicates that the kernel supports moving =
an
> > > > +  existing page contents from userspace.
> > > > +
> > > >  The userland application should set the feature flags it intends t=
o use
> > > >  when invoking the ``UFFDIO_API`` ioctl, to request that those feat=
ures be
> > > >  enabled if supported.
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index a7c6ef764e63..ac52e0f99a69 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -2039,6 +2039,66 @@ static inline unsigned int uffd_ctx_features=
(__u64 user_features)
> > > >       return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED=
;
> > > >  }
> > > >
> > > > +static int userfaultfd_remap(struct userfaultfd_ctx *ctx,
> > > > +                          unsigned long arg)
> > >
> > > If we do want to rename from REMAP to MOVE, we'd better rename the
> > > functions too, as "remap" still exists all over the place..
> >
> > Ok. I thought that since the current implementation only remaps and
> > never copies it would be correct to keep "remap" in these internal
> > names and change that later if we support copying. But I'm fine with
> > renaming them now to avoid confusion. Will do.
>
> "move", not "copy", btw.
>
> Not a big deal, take your preference at each place; "remap" sometimes can
> read better, maybe.  Fundamentally, I think it's because both "remap" and
> "move" work in 99% cases.  That's also why I think either name would work
> here.

Ok, "move" it is. That will avoid unnecessary churn in the future if
we decide to implement the copy fallback.

>
> >
> >
> > >
> > > > +{
> > > > +     __s64 ret;
> > > > +     struct uffdio_move uffdio_move;
> > > > +     struct uffdio_move __user *user_uffdio_move;
> > > > +     struct userfaultfd_wake_range range;
> > > > +
> > > > +     user_uffdio_move =3D (struct uffdio_move __user *) arg;
> > > > +
> > > > +     ret =3D -EAGAIN;
> > > > +     if (atomic_read(&ctx->mmap_changing))
> > > > +             goto out;
> > >
> > > I didn't notice this before, but I think we need to re-check this aft=
er
> > > taking target mm's mmap read lock..
> >
> > Ack.
> >
> > >
> > > maybe we'd want to pass in ctx* into remap_pages(), more reasoning be=
low.
> >
> > Makes sense.
> >
> > >
> > > > +
> > > > +     ret =3D -EFAULT;
> > > > +     if (copy_from_user(&uffdio_move, user_uffdio_move,
> > > > +                        /* don't copy "remap" last field */
> > >
> > > s/remap/move/
> >
> > Ack.
> >
> > >
> > > > +                        sizeof(uffdio_move)-sizeof(__s64)))
> > > > +             goto out;
> > > > +
> > > > +     ret =3D validate_range(ctx->mm, uffdio_move.dst, uffdio_move.=
len);
> > > > +     if (ret)
> > > > +             goto out;
> > > > +
> > > > +     ret =3D validate_range(current->mm, uffdio_move.src, uffdio_m=
ove.len);
> > > > +     if (ret)
> > > > +             goto out;
> > > > +
> > > > +     ret =3D -EINVAL;
> > > > +     if (uffdio_move.mode & ~(UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES|
> > > > +                               UFFDIO_MOVE_MODE_DONTWAKE))
> > > > +             goto out;
> > > > +
> > > > +     if (mmget_not_zero(ctx->mm)) {
> > > > +             ret =3D remap_pages(ctx->mm, current->mm,
> > > > +                               uffdio_move.dst, uffdio_move.src,
> > > > +                               uffdio_move.len, uffdio_move.mode);
> > > > +             mmput(ctx->mm);
> > > > +     } else {
> > > > +             return -ESRCH;
> > > > +     }
> > > > +
> > > > +     if (unlikely(put_user(ret, &user_uffdio_move->move)))
> > > > +             return -EFAULT;
> > > > +     if (ret < 0)
> > > > +             goto out;
> > > > +
> > > > +     /* len =3D=3D 0 would wake all */
> > > > +     BUG_ON(!ret);
> > > > +     range.len =3D ret;
> > > > +     if (!(uffdio_move.mode & UFFDIO_MOVE_MODE_DONTWAKE)) {
> > > > +             range.start =3D uffdio_move.dst;
> > > > +             wake_userfault(ctx, &range);
> > > > +     }
> > > > +     ret =3D range.len =3D=3D uffdio_move.len ? 0 : -EAGAIN;
> > > > +
> > > > +out:
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  /*
> > > >   * userland asks for a certain API version and we return which bit=
s
> > > >   * and ioctl commands are implemented in this kernel for such API
> > > > @@ -2131,6 +2191,9 @@ static long userfaultfd_ioctl(struct file *fi=
le, unsigned cmd,
> > > >       case UFFDIO_ZEROPAGE:
> > > >               ret =3D userfaultfd_zeropage(ctx, arg);
> > > >               break;
> > > > +     case UFFDIO_MOVE:
> > > > +             ret =3D userfaultfd_remap(ctx, arg);
> > > > +             break;
> > > >       case UFFDIO_WRITEPROTECT:
> > > >               ret =3D userfaultfd_writeprotect(ctx, arg);
> > > >               break;
> > > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > > index b26fe858fd44..8034eda972e5 100644
> > > > --- a/include/linux/rmap.h
> > > > +++ b/include/linux/rmap.h
> > > > @@ -121,6 +121,11 @@ static inline void anon_vma_lock_write(struct =
anon_vma *anon_vma)
> > > >       down_write(&anon_vma->root->rwsem);
> > > >  }
> > > >
> > > > +static inline int anon_vma_trylock_write(struct anon_vma *anon_vma=
)
> > > > +{
> > > > +     return down_write_trylock(&anon_vma->root->rwsem);
> > > > +}
> > > > +
> > > >  static inline void anon_vma_unlock_write(struct anon_vma *anon_vma=
)
> > > >  {
> > > >       up_write(&anon_vma->root->rwsem);
> > > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaul=
tfd_k.h
> > > > index f2dc19f40d05..ce8d20b57e8c 100644
> > > > --- a/include/linux/userfaultfd_k.h
> > > > +++ b/include/linux/userfaultfd_k.h
> > > > @@ -93,6 +93,18 @@ extern int mwriteprotect_range(struct mm_struct =
*dst_mm,
> > > >  extern long uffd_wp_range(struct vm_area_struct *vma,
> > > >                         unsigned long start, unsigned long len, boo=
l enable_wp);
> > > >
> > > > +/* remap_pages */
> > > > +void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > +void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > > > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *sr=
c_mm,
> > > > +                 unsigned long dst_start, unsigned long src_start,
> > > > +                 unsigned long len, __u64 flags);
> > > > +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struc=
t *src_mm,
> > > > +                      pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pm=
dval,
> > > > +                      struct vm_area_struct *dst_vma,
> > > > +                      struct vm_area_struct *src_vma,
> > > > +                      unsigned long dst_addr, unsigned long src_ad=
dr);
> > > > +
> > > >  /* mm helpers */
> > > >  static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_=
struct *vma,
> > > >                                       struct vm_userfaultfd_ctx vm_=
ctx)
> > > > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/=
userfaultfd.h
> > > > index 0dbc81015018..2841e4ea8f2c 100644
> > > > --- a/include/uapi/linux/userfaultfd.h
> > > > +++ b/include/uapi/linux/userfaultfd.h
> > > > @@ -41,7 +41,8 @@
> > > >                          UFFD_FEATURE_WP_HUGETLBFS_SHMEM |    \
> > > >                          UFFD_FEATURE_WP_UNPOPULATED |        \
> > > >                          UFFD_FEATURE_POISON |                \
> > > > -                        UFFD_FEATURE_WP_ASYNC)
> > > > +                        UFFD_FEATURE_WP_ASYNC |              \
> > > > +                        UFFD_FEATURE_MOVE)
> > > >  #define UFFD_API_IOCTLS                              \
> > > >       ((__u64)1 << _UFFDIO_REGISTER |         \
> > > >        (__u64)1 << _UFFDIO_UNREGISTER |       \
> > > > @@ -50,6 +51,7 @@
> > > >       ((__u64)1 << _UFFDIO_WAKE |             \
> > > >        (__u64)1 << _UFFDIO_COPY |             \
> > > >        (__u64)1 << _UFFDIO_ZEROPAGE |         \
> > > > +      (__u64)1 << _UFFDIO_MOVE |             \
> > > >        (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > > >        (__u64)1 << _UFFDIO_CONTINUE |         \
> > > >        (__u64)1 << _UFFDIO_POISON)
> > > > @@ -73,6 +75,7 @@
> > > >  #define _UFFDIO_WAKE                 (0x02)
> > > >  #define _UFFDIO_COPY                 (0x03)
> > > >  #define _UFFDIO_ZEROPAGE             (0x04)
> > > > +#define _UFFDIO_MOVE                 (0x05)
> > > >  #define _UFFDIO_WRITEPROTECT         (0x06)
> > > >  #define _UFFDIO_CONTINUE             (0x07)
> > > >  #define _UFFDIO_POISON                       (0x08)
> > > > @@ -92,6 +95,8 @@
> > > >                                     struct uffdio_copy)
> > > >  #define UFFDIO_ZEROPAGE              _IOWR(UFFDIO, _UFFDIO_ZEROPAG=
E, \
> > > >                                     struct uffdio_zeropage)
> > > > +#define UFFDIO_MOVE          _IOWR(UFFDIO, _UFFDIO_MOVE,     \
> > > > +                                   struct uffdio_move)
> > > >  #define UFFDIO_WRITEPROTECT  _IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
> > > >                                     struct uffdio_writeprotect)
> > > >  #define UFFDIO_CONTINUE              _IOWR(UFFDIO, _UFFDIO_CONTINU=
E, \
> > > > @@ -222,6 +227,9 @@ struct uffdio_api {
> > > >        * asynchronous mode is supported in which the write fault is
> > > >        * automatically resolved and write-protection is un-set.
> > > >        * It implies UFFD_FEATURE_WP_UNPOPULATED.
> > > > +      *
> > > > +      * UFFD_FEATURE_MOVE indicates that the kernel supports movin=
g an
> > > > +      * existing page contents from userspace.
> > > >        */
> > > >  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP               (1<<0)
> > > >  #define UFFD_FEATURE_EVENT_FORK                      (1<<1)
> > > > @@ -239,6 +247,7 @@ struct uffdio_api {
> > > >  #define UFFD_FEATURE_WP_UNPOPULATED          (1<<13)
> > > >  #define UFFD_FEATURE_POISON                  (1<<14)
> > > >  #define UFFD_FEATURE_WP_ASYNC                        (1<<15)
> > > > +#define UFFD_FEATURE_MOVE                    (1<<16)
> > > >       __u64 features;
> > > >
> > > >       __u64 ioctls;
> > > > @@ -347,6 +356,24 @@ struct uffdio_poison {
> > > >       __s64 updated;
> > > >  };
> > > >
> > > > +struct uffdio_move {
> > > > +     __u64 dst;
> > > > +     __u64 src;
> > > > +     __u64 len;
> > > > +     /*
> > > > +      * Especially if used to atomically remove memory from the
> > > > +      * address space the wake on the dst range is not needed.
> > > > +      */
> > > > +#define UFFDIO_MOVE_MODE_DONTWAKE            ((__u64)1<<0)
> > > > +#define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES     ((__u64)1<<1)
> > > > +     __u64 mode;
> > > > +     /*
> > > > +      * "move" is written by the ioctl and must be at the end: the
> > > > +      * copy_from_user will not read the last 8 bytes.
> > > > +      */
> > > > +     __s64 move;
> > > > +};
> > > > +
> > > >  /*
> > > >   * Flags for the userfaultfd(2) system call itself.
> > > >   */
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 9656be95a542..6fac5c3d66e6 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2086,6 +2086,144 @@ int change_huge_pmd(struct mmu_gather *tlb,=
 struct vm_area_struct *vma,
> > > >       return ret;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_USERFAULTFD
> > > > +/*
> > > > + * The PT lock for src_pmd and the mmap_lock for reading are held =
by
> > > > + * the caller, but it must return after releasing the
> > > > + * page_table_lock. Just move the page from src_pmd to dst_pmd if =
possible.
> > > > + * Return zero if succeeded in moving the page, -EAGAIN if it need=
s to be
> > > > + * repeated by the caller, or other errors in case of failure.
> > > > + */
> > > > +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struc=
t *src_mm,
> > > > +                      pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pm=
dval,
> > > > +                      struct vm_area_struct *dst_vma,
> > > > +                      struct vm_area_struct *src_vma,
> > > > +                      unsigned long dst_addr, unsigned long src_ad=
dr)
> > > > +{
> > > > +     pmd_t _dst_pmd, src_pmdval;
> > > > +     struct page *src_page;
> > > > +     struct folio *src_folio;
> > > > +     struct anon_vma *src_anon_vma;
> > > > +     spinlock_t *src_ptl, *dst_ptl;
> > > > +     pgtable_t src_pgtable, dst_pgtable;
> > > > +     struct mmu_notifier_range range;
> > > > +     int err =3D 0;
> > > > +
> > > > +     src_pmdval =3D *src_pmd;
> > > > +     src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> > > > +
> > > > +     lockdep_assert_held(src_ptl);
> > > > +     mmap_assert_locked(src_mm);
> > > > +     mmap_assert_locked(dst_mm);
> > > > +
> > > > +     BUG_ON(!pmd_none(dst_pmdval));
> > > > +     BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> > > > +     BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> > > > +
> > > > +     if (!pmd_trans_huge(src_pmdval)) {
> > > > +             spin_unlock(src_ptl);
> > > > +             if (is_pmd_migration_entry(src_pmdval)) {
> > > > +                     pmd_migration_entry_wait(src_mm, &src_pmdval)=
;
> > > > +                     return -EAGAIN;
> > > > +             }
> > > > +             return -ENOENT;
> > > > +     }
> > > > +
> > > > +     src_page =3D pmd_page(src_pmdval);
> > > > +     if (unlikely(!PageAnonExclusive(src_page))) {
> > > > +             spin_unlock(src_ptl);
> > > > +             return -EBUSY;
> > > > +     }
> > > > +
> > > > +     src_folio =3D page_folio(src_page);
> > > > +     folio_get(src_folio);
> > > > +     spin_unlock(src_ptl);
> > > > +
> > > > +     /* preallocate dst_pgtable if needed */
> > > > +     if (dst_mm !=3D src_mm) {
> > > > +             dst_pgtable =3D pte_alloc_one(dst_mm);
> > > > +             if (unlikely(!dst_pgtable)) {
> > > > +                     err =3D -ENOMEM;
> > > > +                     goto put_folio;
> > > > +             }
> > > > +     } else {
> > > > +             dst_pgtable =3D NULL;
> > > > +     }
> > > > +
> > >
> > > IIUC Lokesh's comment applies here, we probably need the
> > > flush_cache_range(), not for x86 but for the other ones..
> > >
> > > cachetlb.rst:
> > >
> > >         Next, we have the cache flushing interfaces.  In general, whe=
n Linux
> > >         is changing an existing virtual-->physical mapping to a new v=
alue,
> > >         the sequence will be in one of the following forms::
> > >
> > >         1) flush_cache_mm(mm);
> > >            change_all_page_tables_of(mm);
> > >            flush_tlb_mm(mm);
> > >
> > >         2) flush_cache_range(vma, start, end);
> > >            change_range_of_page_tables(mm, start, end);
> > >            flush_tlb_range(vma, start, end);
> > >
> > >         3) flush_cache_page(vma, addr, pfn);
> > >            set_pte(pte_pointer, new_pte_val);
> > >            flush_tlb_page(vma, addr);
> >
> > Thanks for the reference. I guess that's to support VIVT caches?
>
> I'm not 100% sure VIVT the only case, but.. yeah flush anything to ram as
> long as things cached in va form would be required.

Ack.

>
> >
> > >
> > > > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, =
src_addr,
> > > > +                             src_addr + HPAGE_PMD_SIZE);
> > > > +     mmu_notifier_invalidate_range_start(&range);
> > > > +
> > > > +     folio_lock(src_folio);
> > > > +
> > > > +     /*
> > > > +      * split_huge_page walks the anon_vma chain without the page
> > > > +      * lock. Serialize against it with the anon_vma lock, the pag=
e
> > > > +      * lock is not enough.
> > > > +      */
> > > > +     src_anon_vma =3D folio_get_anon_vma(src_folio);
> > > > +     if (!src_anon_vma) {
> > > > +             err =3D -EAGAIN;
> > > > +             goto unlock_folio;
> > > > +     }
> > > > +     anon_vma_lock_write(src_anon_vma);
> > > > +
> > > > +     dst_ptl =3D pmd_lockptr(dst_mm, dst_pmd);
> > > > +     double_pt_lock(src_ptl, dst_ptl);
> > > > +     if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> > > > +                  !pmd_same(*dst_pmd, dst_pmdval))) {
> > > > +             double_pt_unlock(src_ptl, dst_ptl);
> > > > +             err =3D -EAGAIN;
> > > > +             goto put_anon_vma;
> > > > +     }
> > > > +     if (!PageAnonExclusive(&src_folio->page)) {
> > > > +             double_pt_unlock(src_ptl, dst_ptl);
> > > > +             err =3D -EBUSY;
> > > > +             goto put_anon_vma;
> > > > +     }
> > > > +
> > > > +     BUG_ON(!folio_test_head(src_folio));
> > > > +     BUG_ON(!folio_test_anon(src_folio));
> > > > +
> > > > +     folio_move_anon_rmap(src_folio, dst_vma);
> > > > +     WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_a=
ddr));
> > > > +
> > > > +     src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, src_p=
md);
> > > > +     _dst_pmd =3D mk_huge_pmd(&src_folio->page, dst_vma->vm_page_p=
rot);
> > > > +     _dst_pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma=
);
> > >
> > > Last time the conclusion is we leverage can_change_pmd_writable(), no=
?
> >
> > After your explanation that this works correctly for soft-dirty and
> > UFFD_WP I thought the only thing left to handle was the check for
> > VM_WRITE in both src_vma and dst_vma (which I added into
> > validate_remap_areas()). Maybe I misunderstood and if so, I can
> > replace the above PageAnonExclusive() with can_change_pmd_writable()
> > (note that we err out on VM_SHARED VMAs, so PageAnonExclusive() will
> > be included in that check).
>
> I think we still need PageAnonExclusive() because that's the first guard =
to
> decide whether the page can be moved over at all.
>
> What I meant is something like keeping that, then:
>
>         if (pmd_soft_dirty(src_pmdval))
>                 _dst_pmd =3D pmd_swp_mksoft_dirty(_dst_pmd);
>         if (pmd_uffd_wp(src_pmdval))
>                 _dst_pmd =3D pte_swp_mkuffd_wp(swp_pte);
>         if (can_change_pmd_writable(_dst_vma, addr, _dst_pmd))
>                 _dst_pmd =3D pmd_mkwrite(_dst_pmd, dst_vma);
>
> But I'm not really sure anyone can leverage that, especially after I just
> saw move_soft_dirty_pte(): mremap() treat everything dirty after movement=
.
> I don't think there's a clear definition of how we treat memory dirty aft=
er
> remap.
>
> Maybe we should follow what it does with mremap()?  Then your current cod=
e
> is fine.  Maybe that's the better start.

I think that was the original intention, basically treating remapping
as a write operation. Maybe I should add a comment here to make it
more clear?

>
> >
> > >
> > > > +     set_pmd_at(dst_mm, dst_addr, dst_pmd, _dst_pmd);
> > > > +
> > > > +     src_pgtable =3D pgtable_trans_huge_withdraw(src_mm, src_pmd);
> > > > +     if (dst_pgtable) {
> > > > +             pgtable_trans_huge_deposit(dst_mm, dst_pmd, dst_pgtab=
le);
> > > > +             pte_free(src_mm, src_pgtable);
> > > > +             dst_pgtable =3D NULL;
> > > > +
> > > > +             mm_inc_nr_ptes(dst_mm);
> > > > +             mm_dec_nr_ptes(src_mm);
> > > > +             add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> > > > +             add_mm_counter(src_mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > > > +     } else {
> > > > +             pgtable_trans_huge_deposit(dst_mm, dst_pmd, src_pgtab=
le);
> > > > +     }
> > > > +     double_pt_unlock(src_ptl, dst_ptl);
> > > > +
> > > > +put_anon_vma:
> > > > +     anon_vma_unlock_write(src_anon_vma);
> > > > +     put_anon_vma(src_anon_vma);
> > > > +unlock_folio:
> > > > +     /* unblock rmap walks */
> > > > +     folio_unlock(src_folio);
> > > > +     mmu_notifier_invalidate_range_end(&range);
> > > > +     if (dst_pgtable)
> > > > +             pte_free(dst_mm, dst_pgtable);
> > > > +put_folio:
> > > > +     folio_put(src_folio);
> > > > +
> > > > +     return err;
> > > > +}
> > > > +#endif /* CONFIG_USERFAULTFD */
> > > > +
> > > >  /*
> > > >   * Returns page table lock pointer if a given pmd maps a thp, NULL=
 otherwise.
> > > >   *
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index 2b5c0321d96b..0c1ee7172852 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -1136,6 +1136,9 @@ static int collapse_huge_page(struct mm_struc=
t *mm, unsigned long address,
> > > >        * Prevent all access to pagetables with the exception of
> > > >        * gup_fast later handled by the ptep_clear_flush and the VM
> > > >        * handled by the anon_vma lock + PG_lock.
> > > > +      *
> > > > +      * UFFDIO_MOVE is prevented to race as well thanks to the
> > > > +      * mmap_lock.
> > > >        */
> > > >       mmap_write_lock(mm);
> > > >       result =3D hugepage_vma_revalidate(mm, address, true, &vma, c=
c);
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index f9ddc50269d2..a5919cac9a08 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -490,6 +490,12 @@ void __init anon_vma_init(void)
> > > >   * page_remove_rmap() that the anon_vma pointer from page->mapping=
 is valid
> > > >   * if there is a mapcount, we can dereference the anon_vma after o=
bserving
> > > >   * those.
> > > > + *
> > > > + * NOTE: the caller should normally hold folio lock when calling t=
his.  If
> > > > + * not, the caller needs to double check the anon_vma didn't chang=
e after
> > > > + * taking the anon_vma lock for either read or write (UFFDIO_MOVE =
can modify it
> > > > + * concurrently without folio lock protection). See folio_lock_ano=
n_vma_read()
> > > > + * which has already covered that, and comment above remap_pages()=
.
> > > >   */
> > > >  struct anon_vma *folio_get_anon_vma(struct folio *folio)
> > > >  {
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 96d9eae5c7cc..45ce1a8b8ab9 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -842,3 +842,605 @@ int mwriteprotect_range(struct mm_struct *dst=
_mm, unsigned long start,
> > > >       mmap_read_unlock(dst_mm);
> > > >       return err;
> > > >  }
> > > > +
> > > > +
> > > > +void double_pt_lock(spinlock_t *ptl1,
> > > > +                 spinlock_t *ptl2)
> > > > +     __acquires(ptl1)
> > > > +     __acquires(ptl2)
> > > > +{
> > > > +     spinlock_t *ptl_tmp;
> > > > +
> > > > +     if (ptl1 > ptl2) {
> > > > +             /* exchange ptl1 and ptl2 */
> > > > +             ptl_tmp =3D ptl1;
> > > > +             ptl1 =3D ptl2;
> > > > +             ptl2 =3D ptl_tmp;
> > > > +     }
> > > > +     /* lock in virtual address order to avoid lock inversion */
> > > > +     spin_lock(ptl1);
> > > > +     if (ptl1 !=3D ptl2)
> > > > +             spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
> > > > +     else
> > > > +             __acquire(ptl2);
> > > > +}
> > > > +
> > > > +void double_pt_unlock(spinlock_t *ptl1,
> > > > +                   spinlock_t *ptl2)
> > > > +     __releases(ptl1)
> > > > +     __releases(ptl2)
> > > > +{
> > > > +     spin_unlock(ptl1);
> > > > +     if (ptl1 !=3D ptl2)
> > > > +             spin_unlock(ptl2);
> > > > +     else
> > > > +             __release(ptl2);
> > > > +}
> > > > +
> > > > +
> > > > +static int remap_present_pte(struct mm_struct *dst_mm, struct mm_s=
truct *src_mm,
> > > > +                          struct vm_area_struct *dst_vma,
> > > > +                          struct vm_area_struct *src_vma,
> > > > +                          unsigned long dst_addr, unsigned long sr=
c_addr,
> > > > +                          pte_t *dst_pte, pte_t *src_pte,
> > > > +                          pte_t orig_dst_pte, pte_t orig_src_pte,
> > > > +                          spinlock_t *dst_ptl, spinlock_t *src_ptl=
,
> > > > +                          struct folio *src_folio)
> > > > +{
> > > > +     double_pt_lock(dst_ptl, src_ptl);
> > > > +
> > > > +     if (!pte_same(*src_pte, orig_src_pte) ||
> > > > +         !pte_same(*dst_pte, orig_dst_pte)) {
> > > > +             double_pt_unlock(dst_ptl, src_ptl);
> > > > +             return -EAGAIN;
> > > > +     }
> > > > +     if (folio_test_large(src_folio) ||
> > > > +         !PageAnonExclusive(&src_folio->page)) {
> > > > +             double_pt_unlock(dst_ptl, src_ptl);
> > > > +             return -EBUSY;
> > > > +     }
> > > > +
> > > > +     BUG_ON(!folio_test_anon(src_folio));
> > > > +
> > > > +     folio_move_anon_rmap(src_folio, dst_vma);
> > > > +     WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_a=
ddr));
> > > > +
> > > > +     orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte)=
;
> > > > +     orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_pr=
ot);
> > > > +     orig_dst_pte =3D maybe_mkwrite(pte_mkdirty(orig_dst_pte), dst=
_vma);
> > >
> > > can_change_pte_writable()?
> >
> > Same as my previous comment. If that's still needed I'll replace the
> > above PageAnonExclusive() check with can_change_pte_writable().
>
> If no one else sees any problem, let's keep your current code, per my abo=
ve
> observations.. to match mremap(), also keep it simple.

Ack.

>
> One more thing I just remembered on memcg: only uncharge+charge may not
> work, I think the lruvec needs to be maintained as well, or memcg shrink
> can try to swap some irrelevant page at least, and memcg accounting can
> also go wrong.
>
> AFAICT, that means something like another pair of:
>
>         folio_isolate_lru() + folio_putback_lru()
>
> Besides the charge/uncharge.
>
> Yu Zhao should be familiar with that code, maybe you can double check wit=
h
> him before sending the new version.

Ok, I'll double check with Yu before sending cross-mm parts.

>
> I think this will belong to the separate patch to add cross-mm support, b=
ut
> please also double check even just in case there can be implication of
> single-mm that I missed.

Hmm. For single-mm we do not recharge memcgs. Why would we need to
isolate and put the pages back? Maybe I'm missing something... I'll
ask Yu in any case.

>
> Please also don't feel stressed over cross-mm support: at some point if y=
ou
> see that separate patch grows we can stop from there, listing all the
> cross-mm todos/investigations in the cover letter and start with single-m=
m.

Yes, I think this would be the best way forward (see my previous reply).

Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>

