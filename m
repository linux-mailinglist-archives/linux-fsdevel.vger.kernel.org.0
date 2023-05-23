Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9233470E444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjEWR76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjEWR7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:59:49 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161DB13E
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:59:42 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-623802d9bfdso56183776d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684864781; x=1687456781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00YNi4Cu7qALK7ZrE5+b3vbAtwriNVrLEo9f8Doh2Cg=;
        b=XK9WQE+qexCqRZ0FDIoJQ7d+N+HRkZwHaHYZhFGQQbQbSNcl0hlwtFeZEKbJkyONJc
         kwZaf5eUSDPwXz9paBCTr+GV4EvYGs/TS9XbXiMc43GAX4Y6ZOmCx9IGwPGZa4Q4HPPI
         GxSVFSfuL1V+BkuvA8H/svHj5aAXf/UevD4TtKveDcsvSr9gMQoC/ZcE5VfF5Gi6+Qa4
         i64JSyTTKKISD1fyz9nWHaXUpfQtsTUFEg038V0P5+JJrC03eypdufGMpoo35ir9wnVw
         ZX1dDiULB2JyV+vBYrFK3wZIvrWRnoHfHAUvZ6JW8ScHnUNrEemBGfurDgW7GlPbV+zS
         L+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684864781; x=1687456781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00YNi4Cu7qALK7ZrE5+b3vbAtwriNVrLEo9f8Doh2Cg=;
        b=TR3m7gMoFkpJo2ccDvx+YWXmCNtC9Rm59pI1KGBAuRYRRtdXEnqdYrcXMuUVTuziZm
         4Dn47YgZQnGxaz9oy5AnrHvr2BxzaEyr+tyXOrGIDg5gYNNGKJsYS0ofTp2m3Kg7koLo
         SXCyEctMips4ih8SMcSMkAITtAew0K3khJgZJHUyMhUAULIF3hhGXBrLuNP32ozUVg1W
         h2XNMY3rT0RI7KDzMZW8OFLp4hJuZux+hcF8syQG32/iDFE05aJDChwhwQqe9k+p+Ntj
         egM6JqHRi55UPjYWD5b3DkmwVNfP0Py8kDLXyKodt/E4HGkqP5S6vuMP0zlhqAWuG+Xo
         lKgw==
X-Gm-Message-State: AC+VfDymhfJJ11SX021X7J2uwKNczhXzYGOtchlYTA/7hLF7nxgfA1FQ
        FQJhJ9syFJ9ZmrxO1Mr2ENd6OonUeUHAT65hMBQyLg==
X-Google-Smtp-Source: ACHHUZ4Nv8x86rr9l/ohMFat+iBcBygRbKiiC6l/gOvLEN61ygVOQv1Ay/qDZ66B/YCydqw3RtZS0p6/wjBwLrEVCdY=
X-Received: by 2002:a05:6214:27e9:b0:56f:796e:c3a5 with SMTP id
 jt9-20020a05621427e900b0056f796ec3a5mr21564373qvb.4.1684864781187; Tue, 23
 May 2023 10:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com> <ZGz3LeRyghnv4wwZ@x1n>
In-Reply-To: <ZGz3LeRyghnv4wwZ@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 23 May 2023 10:59:05 -0700
Message-ID: <CAJHvVcjh6hOrZyr1t92v07+PVNVJH-BnPDs+ZSUWsLVjpLEuHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 10:26=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, May 11, 2023 at 11:24:24AM -0700, Axel Rasmussen wrote:
> > The basic idea here is to "simulate" memory poisoning for VMs. A VM
> > running on some host might encounter a memory error, after which some
> > page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> > once poisoned, pages can never become "un-poisoned". So, when we live
> > migrate the VM, we need to preserve the poisoned status of these pages.
> >
> > When live migrating, we try to get the guest running on its new host as
> > quickly as possible. So, we start it running before all memory has been
> > copied, and before we're certain which pages should be poisoned or not.
> >
> > So the basic way to use this new feature is:
> >
> > - On the new host, the guest's memory is registered with userfaultfd, i=
n
> >   either MISSING or MINOR mode (doesn't really matter for this purpose)=
.
> > - On any first access, we get a userfaultfd event. At this point we can
> >   communicate with the old host to find out if the page was poisoned.
> > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marke=
r
>
> [as used to suggest..] maybe UFFDIO_POISON sounds better.
>
> >   so any future accesses will SIGBUS. Because the pte is now "present",
> >   future accesses won't generate more userfaultfd events, they'll just
> >   SIGBUS directly.
> >
> > UFFDIO_SIGBUS does not handle unmapping previously-present PTEs. This
> > isn't needed, because during live migration we want to intercept
> > all accesses with userfaultfd (not just writes, so WP mode isn't useful
> > for this). So whether minor or missing mode is being used (or both), th=
e
> > PTE won't be present in any case, so handling that case isn't needed.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c                 | 63 ++++++++++++++++++++++++++++++++
> >  include/linux/swapops.h          |  3 +-
> >  include/linux/userfaultfd_k.h    |  4 ++
> >  include/uapi/linux/userfaultfd.h | 25 +++++++++++--
> >  mm/memory.c                      |  4 ++
> >  mm/userfaultfd.c                 | 62 ++++++++++++++++++++++++++++++-
> >  6 files changed, 156 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 0fd96d6e39ce..edc2928dae2b 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1966,6 +1966,66 @@ static int userfaultfd_continue(struct userfault=
fd_ctx *ctx, unsigned long arg)
> >       return ret;
> >  }
> >
> > +static inline int userfaultfd_sigbus(struct userfaultfd_ctx *ctx, unsi=
gned long arg)
> > +{
> > +     __s64 ret;
> > +     struct uffdio_sigbus uffdio_sigbus;
> > +     struct uffdio_sigbus __user *user_uffdio_sigbus;
> > +     struct userfaultfd_wake_range range;
> > +
> > +     user_uffdio_sigbus =3D (struct uffdio_sigbus __user *)arg;
> > +
> > +     ret =3D -EAGAIN;
> > +     if (atomic_read(&ctx->mmap_changing))
> > +             goto out;
> > +
> > +     ret =3D -EFAULT;
> > +     if (copy_from_user(&uffdio_sigbus, user_uffdio_sigbus,
> > +                        /* don't copy the output fields */
> > +                        sizeof(uffdio_sigbus) - (sizeof(__s64))))
> > +             goto out;
> > +
> > +     ret =3D validate_range(ctx->mm, uffdio_sigbus.range.start,
> > +                          uffdio_sigbus.range.len);
> > +     if (ret)
> > +             goto out;
> > +
> > +     ret =3D -EINVAL;
> > +     /* double check for wraparound just in case. */
> > +     if (uffdio_sigbus.range.start + uffdio_sigbus.range.len <=3D
> > +         uffdio_sigbus.range.start) {
> > +             goto out;
> > +     }
> > +     if (uffdio_sigbus.mode & ~UFFDIO_SIGBUS_MODE_DONTWAKE)
> > +             goto out;
> > +
> > +     if (mmget_not_zero(ctx->mm)) {
> > +             ret =3D mfill_atomic_sigbus(ctx->mm, uffdio_sigbus.range.=
start,
> > +                                       uffdio_sigbus.range.len,
> > +                                       &ctx->mmap_changing, 0);
> > +             mmput(ctx->mm);
> > +     } else {
> > +             return -ESRCH;
> > +     }
> > +
> > +     if (unlikely(put_user(ret, &user_uffdio_sigbus->updated)))
> > +             return -EFAULT;
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     /* len =3D=3D 0 would wake all */
> > +     BUG_ON(!ret);
> > +     range.len =3D ret;
> > +     if (!(uffdio_sigbus.mode & UFFDIO_SIGBUS_MODE_DONTWAKE)) {
> > +             range.start =3D uffdio_sigbus.range.start;
> > +             wake_userfault(ctx, &range);
> > +     }
> > +     ret =3D range.len =3D=3D uffdio_sigbus.range.len ? 0 : -EAGAIN;
> > +
> > +out:
> > +     return ret;
> > +}
> > +
> >  static inline unsigned int uffd_ctx_features(__u64 user_features)
> >  {
> >       /*
> > @@ -2067,6 +2127,9 @@ static long userfaultfd_ioctl(struct file *file, =
unsigned cmd,
> >       case UFFDIO_CONTINUE:
> >               ret =3D userfaultfd_continue(ctx, arg);
> >               break;
> > +     case UFFDIO_SIGBUS:
> > +             ret =3D userfaultfd_sigbus(ctx, arg);
> > +             break;
> >       }
> >       return ret;
> >  }
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index 3a451b7afcb3..fa778a0ae730 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -405,7 +405,8 @@ typedef unsigned long pte_marker;
> >
> >  #define  PTE_MARKER_UFFD_WP                  BIT(0)
> >  #define  PTE_MARKER_SWAPIN_ERROR             BIT(1)
> > -#define  PTE_MARKER_MASK                     (BIT(2) - 1)
> > +#define  PTE_MARKER_UFFD_SIGBUS                      BIT(2)
> > +#define  PTE_MARKER_MASK                     (BIT(3) - 1)
>
> [as used to suggest..] I'd consider reusing SWAPIN_ERROR directly.
>
> Actually.. I think maybe we should have 1 patch changing SWAPIN_ERROR fro=
m
> VM_FAULT_SIGBUS to VM_FAULT_HWPOISON.
>
> Let's imagine a VM having anonymous page backing and got a swapin error
> when faulted on one of the guest page.  Instead of crashing the hyperviso=
r
> with sigbus we should probably make it a MCE injected into the guest too,
> because there's no page corrupt in bare metal in this specific case,
> however to the guest it's the same as having one page corrupted just like=
 a
> real MCE.

This is a great idea, you're right that injecting an MCE into the
guest is exactly the end goal, and it seems like VM_FAULT_HWPOISON
will "just work". Also the name UFFDIO_POISON resolves any confusion
with UFFD_FEATURE_SIGBUS, so that's a nice side benefit.

I'll make this change in v2, thanks for the idea Peter!

>
> >
> >  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> >  {
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index d78b01524349..6de1084939c5 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -46,6 +46,7 @@ enum mfill_atomic_mode {
> >       MFILL_ATOMIC_COPY,
> >       MFILL_ATOMIC_ZEROPAGE,
> >       MFILL_ATOMIC_CONTINUE,
> > +     MFILL_ATOMIC_SIGBUS,
> >       NR_MFILL_ATOMIC_MODES,
> >  };
> >
> > @@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct=
 *dst_mm,
> >  extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigne=
d long dst_start,
> >                                    unsigned long len, atomic_t *mmap_ch=
anging,
> >                                    uffd_flags_t flags);
> > +extern ssize_t mfill_atomic_sigbus(struct mm_struct *dst_mm, unsigned =
long start,
> > +                                unsigned long len, atomic_t *mmap_chan=
ging,
> > +                                uffd_flags_t flags);
> >  extern int mwriteprotect_range(struct mm_struct *dst_mm,
> >                              unsigned long start, unsigned long len,
> >                              bool enable_wp, atomic_t *mmap_changing);
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/user=
faultfd.h
> > index 66dd4cd277bd..616e33d3db97 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -39,7 +39,8 @@
> >                          UFFD_FEATURE_MINOR_SHMEM |           \
> >                          UFFD_FEATURE_EXACT_ADDRESS |         \
> >                          UFFD_FEATURE_WP_HUGETLBFS_SHMEM |    \
> > -                        UFFD_FEATURE_WP_UNPOPULATED)
> > +                        UFFD_FEATURE_WP_UNPOPULATED |        \
> > +                        UFFD_FEATURE_SIGBUS_IOCTL)
> >  #define UFFD_API_IOCTLS                              \
> >       ((__u64)1 << _UFFDIO_REGISTER |         \
> >        (__u64)1 << _UFFDIO_UNREGISTER |       \
> > @@ -49,12 +50,14 @@
> >        (__u64)1 << _UFFDIO_COPY |             \
> >        (__u64)1 << _UFFDIO_ZEROPAGE |         \
> >        (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> > -      (__u64)1 << _UFFDIO_CONTINUE)
> > +      (__u64)1 << _UFFDIO_CONTINUE |         \
> > +      (__u64)1 << _UFFDIO_SIGBUS)
> >  #define UFFD_API_RANGE_IOCTLS_BASIC          \
> >       ((__u64)1 << _UFFDIO_WAKE |             \
> >        (__u64)1 << _UFFDIO_COPY |             \
> > +      (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> >        (__u64)1 << _UFFDIO_CONTINUE |         \
> > -      (__u64)1 << _UFFDIO_WRITEPROTECT)
> > +      (__u64)1 << _UFFDIO_SIGBUS)
> >
> >  /*
> >   * Valid ioctl command number range with this API is from 0x00 to
> > @@ -71,6 +74,7 @@
> >  #define _UFFDIO_ZEROPAGE             (0x04)
> >  #define _UFFDIO_WRITEPROTECT         (0x06)
> >  #define _UFFDIO_CONTINUE             (0x07)
> > +#define _UFFDIO_SIGBUS                       (0x08)
> >  #define _UFFDIO_API                  (0x3F)
> >
> >  /* userfaultfd ioctl ids */
> > @@ -91,6 +95,8 @@
> >                                     struct uffdio_writeprotect)
> >  #define UFFDIO_CONTINUE              _IOWR(UFFDIO, _UFFDIO_CONTINUE, \
> >                                     struct uffdio_continue)
> > +#define UFFDIO_SIGBUS                _IOWR(UFFDIO, _UFFDIO_SIGBUS, \
> > +                                   struct uffdio_sigbus)
> >
> >  /* read() structure */
> >  struct uffd_msg {
> > @@ -225,6 +231,7 @@ struct uffdio_api {
> >  #define UFFD_FEATURE_EXACT_ADDRESS           (1<<11)
> >  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM              (1<<12)
> >  #define UFFD_FEATURE_WP_UNPOPULATED          (1<<13)
> > +#define UFFD_FEATURE_SIGBUS_IOCTL            (1<<14)
> >       __u64 features;
> >
> >       __u64 ioctls;
> > @@ -321,6 +328,18 @@ struct uffdio_continue {
> >       __s64 mapped;
> >  };
> >
> > +struct uffdio_sigbus {
> > +     struct uffdio_range range;
> > +#define UFFDIO_SIGBUS_MODE_DONTWAKE          ((__u64)1<<0)
> > +     __u64 mode;
> > +
> > +     /*
> > +      * Fields below here are written by the ioctl and must be at the =
end:
> > +      * the copy_from_user will not read past here.
> > +      */
> > +     __s64 updated;
> > +};
> > +
> >  /*
> >   * Flags for the userfaultfd(2) system call itself.
> >   */
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f69fbc251198..e4b4207c2590 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3675,6 +3675,10 @@ static vm_fault_t handle_pte_marker(struct vm_fa=
ult *vmf)
> >       if (WARN_ON_ONCE(!marker))
> >               return VM_FAULT_SIGBUS;
> >
> > +     /* SIGBUS explicitly requested for this PTE. */
> > +     if (marker & PTE_MARKER_UFFD_SIGBUS)
> > +             return VM_FAULT_SIGBUS;
> > +
> >       /* Higher priority than uffd-wp when data corrupted */
> >       if (marker & PTE_MARKER_SWAPIN_ERROR)
> >               return VM_FAULT_SIGBUS;
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index e97a0b4889fc..933587eebd5d 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -278,6 +278,51 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pm=
d,
> >       goto out;
> >  }
> >
> > +/* Handles UFFDIO_SIGBUS for all non-hugetlb VMAs. */
> > +static int mfill_atomic_pte_sigbus(pmd_t *dst_pmd,
> > +                                struct vm_area_struct *dst_vma,
> > +                                unsigned long dst_addr,
> > +                                uffd_flags_t flags)
> > +{
> > +     int ret;
> > +     struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > +     pte_t _dst_pte, *dst_pte;
> > +     spinlock_t *ptl;
> > +
> > +     _dst_pte =3D make_pte_marker(PTE_MARKER_UFFD_SIGBUS);
> > +     dst_pte =3D pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> > +
> > +     if (vma_is_shmem(dst_vma)) {
> > +             struct inode *inode;
> > +             pgoff_t offset, max_off;
> > +
> > +             /* serialize against truncate with the page table lock */
> > +             inode =3D dst_vma->vm_file->f_inode;
> > +             offset =3D linear_page_index(dst_vma, dst_addr);
> > +             max_off =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> > +             ret =3D -EFAULT;
> > +             if (unlikely(offset >=3D max_off))
> > +                     goto out_unlock;
> > +     }
> > +
> > +     ret =3D -EEXIST;
> > +     /*
> > +      * For now, we don't handle unmapping pages, so only support fill=
ing in
> > +      * none PTEs, or replacing PTE markers.
> > +      */
> > +     if (!pte_none_mostly(*dst_pte))
> > +             goto out_unlock;
> > +
> > +     set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> > +
> > +     /* No need to invalidate - it was non-present before */
> > +     update_mmu_cache(dst_vma, dst_addr, dst_pte);
> > +     ret =3D 0;
> > +out_unlock:
> > +     pte_unmap_unlock(dst_pte, ptl);
> > +     return ret;
> > +}
> > +
> >  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address=
)
> >  {
> >       pgd_t *pgd;
> > @@ -328,8 +373,12 @@ static __always_inline ssize_t mfill_atomic_hugetl=
b(
> >        * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
> >        * by THP.  Since we can not reliably insert a zero page, this
> >        * feature is not supported.
> > +      *
> > +      * PTE marker handling for hugetlb is a bit special, so for now
> > +      * UFFDIO_SIGBUS is not supported.
>
> Can you be more specific on this?
>
> What's the plan when HGM will be merged?  Is it possible that all memory
> just support this always so we only need 1 feature flag?

We'll want hugetlbfs support for this operation too, but it's only
really useful (at least for our use case) after HGM is merged. But,
there's no strong reason not to just implement both all at once - I'll
extend v2 to also work properly with hugetlbfs. Probably it isn't too
hard, I just need to do a bit more reading of how swap markers are
handled in hugetlbfs.


>
> >        */
> > -     if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > +     if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
> > +         uffd_flags_mode_is(flags, MFILL_ATOMIC_SIGBUS)) {
> >               mmap_read_unlock(dst_mm);
> >               return -EINVAL;
> >       }
> > @@ -473,6 +522,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd=
_t *dst_pmd,
> >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> >               return mfill_atomic_pte_continue(dst_pmd, dst_vma,
> >                                                dst_addr, flags);
> > +     } else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_SIGBUS)) {
> > +             return mfill_atomic_pte_sigbus(dst_pmd, dst_vma,
> > +                                            dst_addr, flags);
> >       }
> >
> >       /*
> > @@ -694,6 +746,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *ds=
t_mm, unsigned long start,
> >                           uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTI=
NUE));
> >  }
> >
> > +ssize_t mfill_atomic_sigbus(struct mm_struct *dst_mm, unsigned long st=
art,
> > +                         unsigned long len, atomic_t *mmap_changing,
> > +                         uffd_flags_t flags)
> > +{
> > +     return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> > +                         uffd_flags_set_mode(flags, MFILL_ATOMIC_SIGBU=
S));
> > +}
> > +
> >  long uffd_wp_range(struct vm_area_struct *dst_vma,
> >                  unsigned long start, unsigned long len, bool enable_wp=
)
> >  {
> > --
> > 2.40.1.606.ga4b1b128d6-goog
> >
>
> --
> Peter Xu
>
