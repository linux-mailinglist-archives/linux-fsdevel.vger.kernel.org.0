Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833125E7E1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiIWPUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIWPU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:20:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B5EE1090
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:20:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a8so751147lff.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Zow8yFZS7DL+sQi+dFI8ktR+CVObD/Cj7M/2zMgZrcE=;
        b=OwesCIlz00EUn7DRsMx0DjzCHBk8S/+Xi2g5fPxGQhSRVaCPRjRDdaU3EoxDGBycWF
         WjeJOwauK+2vsuvUb0vjkRCZ4RMivueV3nfN+bQNkdWetxD6j+QKSjPsuee2Tp2n38Jz
         /iJsK25fqBHvk1flzzUqT6xcaD2Kcry+CP91ebbpRaH+7JaO7k+DDGbA80azTpePJHUo
         C9mi6Q2+k5+aqh7plurR6pEpUr9EvDPbLxCLDRinQNGibIiinnoVBg84EnbuaBKnPpUT
         cKT++hkuZ7OScqK5B4U9F14Zu14fLK/+p4hCg8Uwqh1UdA/pssHQoaFSPvqyG9cck4Rn
         GTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zow8yFZS7DL+sQi+dFI8ktR+CVObD/Cj7M/2zMgZrcE=;
        b=A9JqqLfgZK+lCEeFOB/k5MQ6SiNL+I2dNmizW1NmdedRPDw71CPp3m/eGxIhIncPXN
         R8gEvor05sAtxWayP3OpBZaNKDCuHyaFEv6Yui6ZsZFjeBbL7R3RlBDLl03oO+bBnLc6
         aS66xprFmVmvqnOF/VVozE9WSzjIYSuLug1lbhK3/pT508HRqGEYMyvBauVYES5XnBnq
         8oBdPyI/Y18dLMKuS9l8h6hGCOKUiJNAqjcE5V/hplggKMc8H93uaY5fBe+w5BVXreB8
         4GIY7rnsf0PyXYFJheA/tT4xpNaKJZdjdWZkt+rmkrufFDIjc/gdKBeQHS2lF7UfKyml
         WSUg==
X-Gm-Message-State: ACrzQf0L/8rbLqZp/qJP+CwDc+Z1LDcJ1yHCfiWPO/SgfgKoSiaeRMJU
        eoYdJiRlLBORfmJig7su5uc0plQDsupqeWgyJWTJLg==
X-Google-Smtp-Source: AMsMyM78W2SpygRyWA6BwLCi+G+Q9AwHIlqubh16dKOB9mvu+zIZ03puXTWepUQ7h9eMZBQnICvUmLJxtqa9A8Z7/3M=
X-Received: by 2002:a05:6512:3612:b0:499:aea7:8bed with SMTP id
 f18-20020a056512361200b00499aea78bedmr3269322lfs.26.1663946423216; Fri, 23
 Sep 2022 08:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
In-Reply-To: <Yyi+l3+p9lbBAC4M@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 23 Sep 2022 16:19:46 +0100
Message-ID: <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
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

Hi,

On Mon, Sep 19, 2022 at 8:10 PM Sean Christopherson <seanjc@google.com> wro=
te:
>
> +Will, Marc and Fuad (apologies if I missed other pKVM folks)
>
> On Mon, Sep 19, 2022, David Hildenbrand wrote:
> > On 15.09.22 16:29, Chao Peng wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > >
> > > KVM can use memfd-provided memory for guest memory. For normal usersp=
ace
> > > accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
> > > virtual address space and then tells KVM to use the virtual address t=
o
> > > setup the mapping in the secondary page table (e.g. EPT).
> > >
> > > With confidential computing technologies like Intel TDX, the
> > > memfd-provided memory may be encrypted with special key for special
> > > software domain (e.g. KVM guest) and is not expected to be directly
> > > accessed by userspace. Precisely, userspace access to such encrypted
> > > memory may lead to host crash so it should be prevented.
> >
> > Initially my thaught was that this whole inaccessible thing is TDX spec=
ific
> > and there is no need to force that on other mechanisms. That's why I
> > suggested to not expose this to user space but handle the notifier
> > requirements internally.
> >
> > IIUC now, protected KVM has similar demands. Either access (read/write)=
 of
> > guest RAM would result in a fault and possibly crash the hypervisor (at
> > least not the whole machine IIUC).
>
> Yep.  The missing piece for pKVM is the ability to convert from shared to=
 private
> while preserving the contents, e.g. to hand off a large buffer (hundreds =
of MiB)
> for processing in the protected VM.  Thoughts on this at the bottom.

Just wanted to mention that for pKVM (arm64), this wouldn't crash the
hypervisor. A userspace access would crash the userspace process since
the hypervisor would inject a fault back. Because of that making it
inaccessible from userspace is good to have, but not really vital for
pKVM. What is important for pKVM is that the guest private memory is
not GUP'able by the host. This is because if it were, it might be
possible for a malicious userspace process (e.g., a malicious vmm) to
trick the host kernel into accessing guest private memory in a context
where it isn=E2=80=99t prepared to handle the fault injected by the
hypervisor. This of course might crash the host.

> > > This patch introduces userspace inaccessible memfd (created with
> > > MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> > > ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> > > in-kernel interface so KVM can directly interact with core-mm without
> > > the need to map the memory into KVM userspace.
> >
> > With secretmem we decided to not add such "concept switch" flags and in=
stead
> > use a dedicated syscall.
> >
>
> I have no personal preference whatsoever between a flag and a dedicated s=
yscall,
> but a dedicated syscall does seem like it would give the kernel a bit mor=
e
> flexibility.
>
> > What about memfd_inaccessible()? Especially, sealing and hugetlb are no=
t
> > even supported and it might take a while to support either.
>
> Don't know about sealing, but hugetlb support for "inaccessible" memory n=
eeds to
> come sooner than later.  "inaccessible" in quotes because we might want t=
o choose
> a less binary name, e.g. "restricted"?.
>
> Regarding pKVM's use case, with the shim approach I believe this can be d=
one by
> allowing userspace mmap() the "hidden" memfd, but with a ton of restricti=
ons
> piled on top.
>
> My first thought was to make the uAPI a set of KVM ioctls so that KVM cou=
ld tightly
> tightly control usage without taking on too much complexity in the kernel=
, but
> working through things, routing the behavior through the shim itself migh=
t not be
> all that horrific.
>
> IIRC, we discarded the idea of allowing userspace to map the "private" fd=
 because
> things got too complex, but with the shim it doesn't seem _that_ bad.
>
> E.g. on the memfd side:
>
>   1. The entire memfd must be mapped, and at most one mapping is allowed,=
 i.e.
>      mapping is all or nothing.
>
>   2. Acquiring a reference via get_pfn() is disallowed if there's a mappi=
ng for
>      the restricted memfd.
>
>   3. Add notifier hooks to allow downstream users to further restrict thi=
ngs.
>
>   4. Disallow splitting VMAs, e.g. to force userspace to munmap() everyth=
ing in
>      one shot.
>
>   5. Require that there are no outstanding references at munmap().  Or if=
 this
>      can't be guaranteed by userspace, maybe add some way for userspace t=
o wait
>      until it's ok to convert to private?  E.g. so that get_pfn() doesn't=
 need
>      to do an expensive check every time.
>
>   static int memfd_restricted_mmap(struct file *file, struct vm_area_stru=
ct *vma)
>   {
>         if (vma->vm_pgoff)
>                 return -EINVAL;
>
>         if ((vma->vm_end - vma->vm_start) !=3D <file size>)
>                 return -EINVAL;
>
>         mutex_lock(&data->lock);
>
>         if (data->has_mapping) {
>                 r =3D -EINVAL;
>                 goto err;
>         }
>         list_for_each_entry(notifier, &data->notifiers, list) {
>                 r =3D notifier->ops->mmap_start(notifier, ...);
>                 if (r)
>                         goto abort;
>         }
>
>         notifier->ops->mmap_end(notifier, ...);
>         mutex_unlock(&data->lock);
>         return 0;
>
>   abort:
>         list_for_each_entry_continue_reverse(notifier &data->notifiers, l=
ist)
>                 notifier->ops->mmap_abort(notifier, ...);
>   err:
>         mutex_unlock(&data->lock);
>         return r;
>   }
>
>   static void memfd_restricted_close(struct vm_area_struct *vma)
>   {
>         mutex_lock(...);
>
>         /*
>          * Destroy the memfd and disable all future accesses if there are
>          * outstanding refcounts (or other unsatisfied restrictions?).
>          */
>         if (<outstanding references> || ???)
>                 memfd_restricted_destroy(...);
>         else
>                 data->has_mapping =3D false;
>
>         mutex_unlock(...);
>   }
>
>   static int memfd_restricted_may_split(struct vm_area_struct *area, unsi=
gned long addr)
>   {
>         return -EINVAL;
>   }
>
>   static int memfd_restricted_mapping_mremap(struct vm_area_struct *new_v=
ma)
>   {
>         return -EINVAL;
>   }
>
> Then on the KVM side, its mmap_start() + mmap_end() sequence would:
>
>   1. Not be supported for TDX or SEV-SNP because they don't allow adding =
non-zero
>      memory into the guest (after pre-boot phase).
>
>   2. Be mutually exclusive with shared<=3D>private conversions, and is al=
lowed if
>      and only if the entire gfn range of the associated memslot is shared=
.

In general I think that this would work with pKVM. However, limiting
private<->shared conversions to the granularity of a whole memslot
might be difficult to handle in pKVM, since the guest doesn't have the
concept of memslots. For example, in pKVM right now, when a guest
shares back its restricted DMA pool with the host it does so at the
page-level. pKVM would also need a way to make an fd accessible again
when shared back, which I think isn't possible with this patch.

You were initially considering a KVM ioctl for mapping, which might be
better suited for this since KVM knows which pages are shared and
which ones are private. So routing things through KVM might simplify
things and allow it to enforce all the necessary restrictions (e.g.,
private memory cannot be mapped). What do you think?

Thanks,
/fuad
