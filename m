Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478CF644342
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiLFMkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiLFMkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:40:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6656E21E37
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 04:39:56 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x28so6102843lfn.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Dec 2022 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkayvQxZ2rk9ec8hNslzxK4Nie/20auCP0G0iWhyrZs=;
        b=S+aQUPWyvEU7pQOrmjsupSO1plGpPZHmCrpDPXpUSTGxP8r2xptH2cm3cZRVZfs+9J
         DxCyHLltg/MSPn2ncA+UPYq3TsKVd+f57YgACI97libEl3PRCQNwoY3v2MFrszH5YEei
         z7uPfLA1YoEhKxjzGHdHQTjOjTTvBQ7kV6y4gLcOv0DWxJGFirtugALgcJkBFGAyMA7l
         SeObJjJKnMhXmE66Dh9p/f+apK2Na9ZVRJLR/S0ivbn5uvX9vthPvtF11w/n8tIJXDNB
         LMaXjRcMP9nUTmek4Ev2ZtmF8UxAK8swbhlQuy3vKSc63exxMyOZcEzB6FzR57zhWsLM
         bRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkayvQxZ2rk9ec8hNslzxK4Nie/20auCP0G0iWhyrZs=;
        b=VXCez1QiOXGFOfs4JmyV2JKLTyshPMeHLIcOfX93M4wWkwTUHa+j9cDtixyQpDWNog
         qAJ78FPjgWuhJE0Iclc8yQaRtfD7JOcJuJtXLmiWe+wKoplxWfcbQs29wbxoFluGy/N+
         iqvMRXkmR77y+ESB8dYXCXudJMhVRCHfusAF81kIFp/fCJLAO024Qx5RfcX4Ubsf1XQD
         knsdcwQFGeLAgsA8GFOWH7f0DppvKm26NJfOUi9HInjHQ0m4drH/0gB83Ka2aEwf+zd/
         CJanAk419f13AMV1/+IhQb191i8HRjXYMUhVqBQiQOwBRYj5KlOh/YaXvAqhzwe4nmve
         AWPw==
X-Gm-Message-State: ANoB5pkOFHAEVDLLrwwqxwKUEDhkg1J8RBIpqlLVr8s7+j4ZbNOAoyKC
        plKFx6jtHgwR3NwO/lnQHM4eNP369vMAq+trKSOiGA==
X-Google-Smtp-Source: AA0mqf4TKl8GsrHiNPESi1DZOZqTZy0aDbR18Esul0WgamiFPqxDQYgJc4G41OG4L664mtan8pbuTueTvM8GvEw28w8=
X-Received: by 2002:ac2:4316:0:b0:4b5:d8e:c12 with SMTP id l22-20020ac24316000000b004b50d8e0c12mr14370423lfh.665.1670330394310;
 Tue, 06 Dec 2022 04:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com> <CA+EHjTyuQSa9YKkGd1OqtEzobuf6Bcghwiz00aaL15ikz7J2Vw@mail.gmail.com>
 <20221206115356.GA1216605@chaop.bj.intel.com>
In-Reply-To: <20221206115356.GA1216605@chaop.bj.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 6 Dec 2022 12:39:18 +0000
Message-ID: <CA+EHjTyczU4b8c2_X39+qLW96V-spaYtAMp=OCFubMr8VAccww@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

On Tue, Dec 6, 2022 at 11:58 AM Chao Peng <chao.p.peng@linux.intel.com> wro=
te:
>
> On Mon, Dec 05, 2022 at 09:03:11AM +0000, Fuad Tabba wrote:
> > Hi Chao,
> >
> > On Fri, Dec 2, 2022 at 6:18 AM Chao Peng <chao.p.peng@linux.intel.com> =
wrote:
> > >
> > > In memory encryption usage, guest memory may be encrypted with specia=
l
> > > key and can be accessed only by the guest itself. We call such memory
> > > private memory. It's valueless and sometimes can cause problem to all=
ow
> > > userspace to access guest private memory. This new KVM memslot extens=
ion
> > > allows guest private memory being provided through a restrictedmem
> > > backed file descriptor(fd) and userspace is restricted to access the
> > > bookmarked memory in the fd.
> > >
> > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds t=
wo
> > > additional KVM memslot fields restricted_fd/restricted_offset to allo=
w
> > > userspace to instruct KVM to provide guest memory through restricted_=
fd.
> > > 'guest_phys_addr' is mapped at the restricted_offset of restricted_fd
> > > and the size is 'memory_size'.
> > >
> > > The extended memslot can still have the userspace_addr(hva). When use=
, a
> > > single memslot can maintain both private memory through restricted_fd
> > > and shared memory through userspace_addr. Whether the private or shar=
ed
> > > part is visible to guest is maintained by other KVM code.
> > >
> > > A restrictedmem_notifier field is also added to the memslot structure=
 to
> > > allow the restricted_fd's backing store to notify KVM the memory chan=
ge,
> > > KVM then can invalidate its page table entries or handle memory error=
s.
> > >
> > > Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is add=
ed
> > > and right now it is selected on X86_64 only.
> > >
> > > To make future maintenance easy, internally use a binary compatible
> > > alias struct kvm_user_mem_region to handle both the normal and the
> > > '_ext' variants.
> > >
> > > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > Reviewed-by: Fuad Tabba <tabba@google.com>
> > > Tested-by: Fuad Tabba <tabba@google.com>
> >
> > V9 of this patch [*] had KVM_CAP_PRIVATE_MEM, but it's not in this
> > patch series anymore. Any reason you removed it, or is it just an
> > omission?
>
> We had some discussion in v9 [1] to add generic memory attributes ioctls
> and KVM_CAP_PRIVATE_MEM can be implemented as a new
> KVM_MEMORY_ATTRIBUTE_PRIVATE flag via KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES=
()
> ioctl [2]. The api doc has been updated:
>
> +- KVM_MEM_PRIVATE, if KVM_MEMORY_ATTRIBUTE_PRIVATE is supported (see
> +  KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES ioctl) =E2=80=A6
>
>
> [1] https://lore.kernel.org/linux-mm/Y2WB48kD0J4VGynX@google.com/
> [2]
> https://lore.kernel.org/linux-mm/20221202061347.1070246-3-chao.p.peng@lin=
ux.intel.com/

I see. I just retested it with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES,
and my Reviewed/Tested-by still apply.

Cheers,
/fuad

>
> Thanks,
> Chao
> >
> > [*] https://lore.kernel.org/linux-mm/20221025151344.3784230-3-chao.p.pe=
ng@linux.intel.com/
> >
> > Thanks,
> > /fuad
> >
> > > ---
> > >  Documentation/virt/kvm/api.rst | 40 ++++++++++++++++++++++-----
> > >  arch/x86/kvm/Kconfig           |  2 ++
> > >  arch/x86/kvm/x86.c             |  2 +-
> > >  include/linux/kvm_host.h       |  8 ++++--
> > >  include/uapi/linux/kvm.h       | 28 +++++++++++++++++++
> > >  virt/kvm/Kconfig               |  3 +++
> > >  virt/kvm/kvm_main.c            | 49 ++++++++++++++++++++++++++++----=
--
> > >  7 files changed, 114 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/=
api.rst
> > > index bb2f709c0900..99352170c130 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -1319,7 +1319,7 @@ yet and must be cleared on entry.
> > >  :Capability: KVM_CAP_USER_MEMORY
> > >  :Architectures: all
> > >  :Type: vm ioctl
> > > -:Parameters: struct kvm_userspace_memory_region (in)
> > > +:Parameters: struct kvm_userspace_memory_region(_ext) (in)
> > >  :Returns: 0 on success, -1 on error
> > >
> > >  ::
> > > @@ -1332,9 +1332,18 @@ yet and must be cleared on entry.
> > >         __u64 userspace_addr; /* start of the userspace allocated mem=
ory */
> > >    };
> > >
> > > +  struct kvm_userspace_memory_region_ext {
> > > +       struct kvm_userspace_memory_region region;
> > > +       __u64 restricted_offset;
> > > +       __u32 restricted_fd;
> > > +       __u32 pad1;
> > > +       __u64 pad2[14];
> > > +  };
> > > +
> > >    /* for kvm_memory_region::flags */
> > >    #define KVM_MEM_LOG_DIRTY_PAGES      (1UL << 0)
> > >    #define KVM_MEM_READONLY     (1UL << 1)
> > > +  #define KVM_MEM_PRIVATE              (1UL << 2)
> > >
> > >  This ioctl allows the user to create, modify or delete a guest physi=
cal
> > >  memory slot.  Bits 0-15 of "slot" specify the slot id and this value
> > > @@ -1365,12 +1374,29 @@ It is recommended that the lower 21 bits of g=
uest_phys_addr and userspace_addr
> > >  be identical.  This allows large pages in the guest to be backed by =
large
> > >  pages in the host.
> > >
> > > -The flags field supports two flags: KVM_MEM_LOG_DIRTY_PAGES and
> > > -KVM_MEM_READONLY.  The former can be set to instruct KVM to keep tra=
ck of
> > > -writes to memory within the slot.  See KVM_GET_DIRTY_LOG ioctl to kn=
ow how to
> > > -use it.  The latter can be set, if KVM_CAP_READONLY_MEM capability a=
llows it,
> > > -to make a new slot read-only.  In this case, writes to this memory w=
ill be
> > > -posted to userspace as KVM_EXIT_MMIO exits.
> > > +kvm_userspace_memory_region_ext struct includes all fields of
> > > +kvm_userspace_memory_region struct, while also adds additional field=
s for some
> > > +other features. See below description of flags field for more inform=
ation.
> > > +It's recommended to use kvm_userspace_memory_region_ext in new users=
pace code.
> > > +
> > > +The flags field supports following flags:
> > > +
> > > +- KVM_MEM_LOG_DIRTY_PAGES to instruct KVM to keep track of writes to=
 memory
> > > +  within the slot. For more details, see KVM_GET_DIRTY_LOG ioctl.
> > > +
> > > +- KVM_MEM_READONLY, if KVM_CAP_READONLY_MEM allows, to make a new sl=
ot
> > > +  read-only. In this case, writes to this memory will be posted to u=
serspace as
> > > +  KVM_EXIT_MMIO exits.
> > > +
> > > +- KVM_MEM_PRIVATE, if KVM_MEMORY_ATTRIBUTE_PRIVATE is supported (see
> > > +  KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES ioctl), to indicate a new slot=
 has private
> > > +  memory backed by a file descriptor(fd) and userspace access to the=
 fd may be
> > > +  restricted. Userspace should use restricted_fd/restricted_offset i=
n the
> > > +  kvm_userspace_memory_region_ext to instruct KVM to provide private=
 memory
> > > +  to guest. Userspace should guarantee not to map the same host phys=
ical address
> > > +  indicated by restricted_fd/restricted_offset to different guest ph=
ysical
> > > +  addresses within multiple memslots. Failed to do this may result u=
ndefined
> > > +  behavior.
> > >
> > >  When the KVM_CAP_SYNC_MMU capability is available, changes in the ba=
cking of
> > >  the memory region are automatically reflected into the guest.  For e=
xample, an
> > > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > > index a8e379a3afee..690cb21010e7 100644
> > > --- a/arch/x86/kvm/Kconfig
> > > +++ b/arch/x86/kvm/Kconfig
> > > @@ -50,6 +50,8 @@ config KVM
> > >         select INTERVAL_TREE
> > >         select HAVE_KVM_PM_NOTIFIER if PM
> > >         select HAVE_KVM_MEMORY_ATTRIBUTES
> > > +       select HAVE_KVM_RESTRICTED_MEM if X86_64
> > > +       select RESTRICTEDMEM if HAVE_KVM_RESTRICTED_MEM
> > >         help
> > >           Support hosting fully virtualized guest machines using hard=
ware
> > >           virtualization extensions.  You will need a fairly recent
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 7f850dfb4086..9a07380f8d3c 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -12224,7 +12224,7 @@ void __user * __x86_set_memory_region(struct =
kvm *kvm, int id, gpa_t gpa,
> > >         }
> > >
> > >         for (i =3D 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> > > -               struct kvm_userspace_memory_region m;
> > > +               struct kvm_user_mem_region m;
> > >
> > >                 m.slot =3D id | (i << 16);
> > >                 m.flags =3D 0;
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index a784e2b06625..02347e386ea2 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -44,6 +44,7 @@
> > >
> > >  #include <asm/kvm_host.h>
> > >  #include <linux/kvm_dirty_ring.h>
> > > +#include <linux/restrictedmem.h>
> > >
> > >  #ifndef KVM_MAX_VCPU_IDS
> > >  #define KVM_MAX_VCPU_IDS KVM_MAX_VCPUS
> > > @@ -585,6 +586,9 @@ struct kvm_memory_slot {
> > >         u32 flags;
> > >         short id;
> > >         u16 as_id;
> > > +       struct file *restricted_file;
> > > +       loff_t restricted_offset;
> > > +       struct restrictedmem_notifier notifier;
> > >  };
> > >
> > >  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_mem=
ory_slot *slot)
> > > @@ -1123,9 +1127,9 @@ enum kvm_mr_change {
> > >  };
> > >
> > >  int kvm_set_memory_region(struct kvm *kvm,
> > > -                         const struct kvm_userspace_memory_region *m=
em);
> > > +                         const struct kvm_user_mem_region *mem);
> > >  int __kvm_set_memory_region(struct kvm *kvm,
> > > -                           const struct kvm_userspace_memory_region =
*mem);
> > > +                           const struct kvm_user_mem_region *mem);
> > >  void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *=
slot);
> > >  void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
> > >  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > index 5d0941acb5bb..13bff963b8b0 100644
> > > --- a/include/uapi/linux/kvm.h
> > > +++ b/include/uapi/linux/kvm.h
> > > @@ -103,6 +103,33 @@ struct kvm_userspace_memory_region {
> > >         __u64 userspace_addr; /* start of the userspace allocated mem=
ory */
> > >  };
> > >
> > > +struct kvm_userspace_memory_region_ext {
> > > +       struct kvm_userspace_memory_region region;
> > > +       __u64 restricted_offset;
> > > +       __u32 restricted_fd;
> > > +       __u32 pad1;
> > > +       __u64 pad2[14];
> > > +};
> > > +
> > > +#ifdef __KERNEL__
> > > +/*
> > > + * kvm_user_mem_region is a kernel-only alias of kvm_userspace_memor=
y_region_ext
> > > + * that "unpacks" kvm_userspace_memory_region so that KVM can direct=
ly access
> > > + * all fields from the top-level "extended" region.
> > > + */
> > > +struct kvm_user_mem_region {
> > > +       __u32 slot;
> > > +       __u32 flags;
> > > +       __u64 guest_phys_addr;
> > > +       __u64 memory_size;
> > > +       __u64 userspace_addr;
> > > +       __u64 restricted_offset;
> > > +       __u32 restricted_fd;
> > > +       __u32 pad1;
> > > +       __u64 pad2[14];
> > > +};
> > > +#endif
> > > +
> > >  /*
> > >   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for us=
erspace,
> > >   * other bits are reserved for kvm internal use which are defined in
> > > @@ -110,6 +137,7 @@ struct kvm_userspace_memory_region {
> > >   */
> > >  #define KVM_MEM_LOG_DIRTY_PAGES        (1UL << 0)
> > >  #define KVM_MEM_READONLY       (1UL << 1)
> > > +#define KVM_MEM_PRIVATE                (1UL << 2)
> > >
> > >  /* for KVM_IRQ_LINE */
> > >  struct kvm_irq_level {
> > > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> > > index effdea5dd4f0..d605545d6dd1 100644
> > > --- a/virt/kvm/Kconfig
> > > +++ b/virt/kvm/Kconfig
> > > @@ -89,3 +89,6 @@ config KVM_XFER_TO_GUEST_WORK
> > >
> > >  config HAVE_KVM_PM_NOTIFIER
> > >         bool
> > > +
> > > +config HAVE_KVM_RESTRICTED_MEM
> > > +       bool
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 7f0f5e9f2406..b882eb2c76a2 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -1532,7 +1532,7 @@ static void kvm_replace_memslot(struct kvm *kvm=
,
> > >         }
> > >  }
> > >
> > > -static int check_memory_region_flags(const struct kvm_userspace_memo=
ry_region *mem)
> > > +static int check_memory_region_flags(const struct kvm_user_mem_regio=
n *mem)
> > >  {
> > >         u32 valid_flags =3D KVM_MEM_LOG_DIRTY_PAGES;
> > >
> > > @@ -1934,7 +1934,7 @@ static bool kvm_check_memslot_overlap(struct kv=
m_memslots *slots, int id,
> > >   * Must be called holding kvm->slots_lock for write.
> > >   */
> > >  int __kvm_set_memory_region(struct kvm *kvm,
> > > -                           const struct kvm_userspace_memory_region =
*mem)
> > > +                           const struct kvm_user_mem_region *mem)
> > >  {
> > >         struct kvm_memory_slot *old, *new;
> > >         struct kvm_memslots *slots;
> > > @@ -2038,7 +2038,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> > >  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> > >
> > >  int kvm_set_memory_region(struct kvm *kvm,
> > > -                         const struct kvm_userspace_memory_region *m=
em)
> > > +                         const struct kvm_user_mem_region *mem)
> > >  {
> > >         int r;
> > >
> > > @@ -2050,7 +2050,7 @@ int kvm_set_memory_region(struct kvm *kvm,
> > >  EXPORT_SYMBOL_GPL(kvm_set_memory_region);
> > >
> > >  static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> > > -                                         struct kvm_userspace_memory=
_region *mem)
> > > +                                         struct kvm_user_mem_region =
*mem)
> > >  {
> > >         if ((u16)mem->slot >=3D KVM_USER_MEM_SLOTS)
> > >                 return -EINVAL;
> > > @@ -4698,6 +4698,33 @@ static int kvm_vm_ioctl_get_stats_fd(struct kv=
m *kvm)
> > >         return fd;
> > >  }
> > >
> > > +#define SANITY_CHECK_MEM_REGION_FIELD(field)                        =
           \
> > > +do {                                                                =
           \
> > > +       BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=3D=
             \
> > > +                    offsetof(struct kvm_userspace_memory_region, fie=
ld));      \
> > > +       BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) =
!=3D         \
> > > +                    sizeof_field(struct kvm_userspace_memory_region,=
 field));  \
> > > +} while (0)
> > > +
> > > +#define SANITY_CHECK_MEM_REGION_EXT_FIELD(field)                    =
                   \
> > > +do {                                                                =
                   \
> > > +       BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=3D=
                     \
> > > +                    offsetof(struct kvm_userspace_memory_region_ext,=
 field));          \
> > > +       BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) =
!=3D                 \
> > > +                    sizeof_field(struct kvm_userspace_memory_region_=
ext, field));      \
> > > +} while (0)
> > > +
> > > +static void kvm_sanity_check_user_mem_region_alias(void)
> > > +{
> > > +       SANITY_CHECK_MEM_REGION_FIELD(slot);
> > > +       SANITY_CHECK_MEM_REGION_FIELD(flags);
> > > +       SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> > > +       SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> > > +       SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
> > > +       SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_offset);
> > > +       SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_fd);
> > > +}
> > > +
> > >  static long kvm_vm_ioctl(struct file *filp,
> > >                            unsigned int ioctl, unsigned long arg)
> > >  {
> > > @@ -4721,14 +4748,20 @@ static long kvm_vm_ioctl(struct file *filp,
> > >                 break;
> > >         }
> > >         case KVM_SET_USER_MEMORY_REGION: {
> > > -               struct kvm_userspace_memory_region kvm_userspace_mem;
> > > +               struct kvm_user_mem_region mem;
> > > +               unsigned long size =3D sizeof(struct kvm_userspace_me=
mory_region);
> > > +
> > > +               kvm_sanity_check_user_mem_region_alias();
> > >
> > >                 r =3D -EFAULT;
> > > -               if (copy_from_user(&kvm_userspace_mem, argp,
> > > -                                               sizeof(kvm_userspace_=
mem)))
> > > +               if (copy_from_user(&mem, argp, size))
> > > +                       goto out;
> > > +
> > > +               r =3D -EINVAL;
> > > +               if (mem.flags & KVM_MEM_PRIVATE)
> > >                         goto out;
> > >
> > > -               r =3D kvm_vm_ioctl_set_memory_region(kvm, &kvm_usersp=
ace_mem);
> > > +               r =3D kvm_vm_ioctl_set_memory_region(kvm, &mem);
> > >                 break;
> > >         }
> > >         case KVM_GET_DIRTY_LOG: {
> > > --
> > > 2.25.1
> > >
