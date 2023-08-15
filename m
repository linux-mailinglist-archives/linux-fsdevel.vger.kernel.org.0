Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4818577D3E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjHOUE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbjHOUD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:03:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8611BDC
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 13:03:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d669fcad15cso5239103276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692129833; x=1692734633;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdgiQF5eHDQGC93K0blyfdFyGr+2XYdNo+ZKSbJ8j6I=;
        b=tMP747PnrWIY3S2IgIlpTGvys1qcp7gvhf2tEkTincr/WVeeoLtSV4nAqvShetKLlE
         L1iZ2gBuYmK67h8Uw9IKCA2gN3qOM0GGC3XehHtQr0jMkW0ZJ/fXrRn6EfVMRIVGETms
         zlDBmwUShl2Q3VsZCRyHfSqWCKWeTFGcKSG1iAXT03s7rjvYB7wm+4XZLwdERLEqJnHl
         s+OEqS8CHaugxEaHqjEM4nmoUN0SaAqSQyAqE5Qleml+ks20SUEByr18WbK2nerA03bM
         m/EmYRW9TIB8/DRpffNeX6d54vgVpq23mcljzKseBhsuD7QuMUsIfvRucPdmyp9uk8JZ
         laEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692129833; x=1692734633;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdgiQF5eHDQGC93K0blyfdFyGr+2XYdNo+ZKSbJ8j6I=;
        b=ExuD/5DF6uxmJhXSFMpbGBSsxHS8I9iqNiMgX68sNqiKG/+bQg480U3E065wo7uilf
         zHf0RSDzomFKgGRq/pSaRCKAgtInAIVws6kSt8F3N7SStIoZOo85TnzRSXMtPArGUAW/
         D0o6tZTDDI4J0SH+p2DR+UZFINOUsx03H0BonxY2y2KnCeIsCdVxoM7veOJNWMbngrT/
         KQa2LBGnkOVXV7ubKDkOrpnRUeey8fQ7TTRxW2y2R31b6b7eIFZZqzyipNzMi6iOAaKI
         dVa7ToEDAIIJklRAkNQ8Xyje/OFDa9NVrCAu8Q4+JUJ2HSlTJuk3a7jB3wsTxMml/RSN
         +lQA==
X-Gm-Message-State: AOJu0YzDzDbqcCf6gLMLe2Oe5UGdeISxKzilOUHeNstHEp78Av6+RR4+
        2Cxq57l+iqWfH5Gm9LmdTdHt87JbPjI=
X-Google-Smtp-Source: AGHT+IF8PVKZ3/Mllt1qn4YqGQbrszG6AYhXRKKw5U6+m8LONIq9kWubfU+atsLqR25KKJSwV9mEz+vM5vc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:565:b0:d18:73fc:40af with SMTP id
 a5-20020a056902056500b00d1873fc40afmr176842ybt.5.1692129833519; Tue, 15 Aug
 2023 13:03:53 -0700 (PDT)
Date:   Tue, 15 Aug 2023 13:03:51 -0700
In-Reply-To: <diqzh6p02lk4.fsf@ackerleytng-ctop.c.googlers.com>
Mime-Version: 1.0
References: <ZNKv9ul2I7A4V7IF@google.com> <diqzh6p02lk4.fsf@ackerleytng-ctop.c.googlers.com>
Message-ID: <ZNvaJ3igvcvTZ/8k@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        chenhuacai@kernel.org, mpe@ellerman.id.au, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
>=20
> >> I feel that memslots form a natural way of managing usage of the gmem
> >> file. When a memslot is created, it is using the file; hence we take a
> >> refcount on the gmem file, and as memslots are removed, we drop
> >> refcounts on the gmem file.
> >
> > Yes and no.  It's definitely more natural *if* the goal is to allow gue=
st_memfd
> > memory to exist without being attached to a VM.  But I'm not at all con=
vinced
> > that we want to allow that, or that it has desirable properties.  With =
TDX and
> > SNP in particuarly, I'm pretty sure that allowing memory to outlive the=
 VM is
> > very underisable (more below).
> >
>=20
> This is a little confusing, with the file/inode split in gmem where the
> physical memory/data is attached to the inode and the file represents
> the VM's view of that memory, won't the memory outlive the VM?

Doh, I overloaded the term "VM".  By "VM" I meant the virtual machine as a =
"thing"
the rest of the world sees and interacts with, not the original "struct kvm=
" object.

Because yes, you're absolutely correct that the memory will outlive "struct=
 kvm",
but it won't outlive the virtual machine, and specifically won't outlive th=
e
ASID (SNP) / HKID (TDX) to which it's bound.

> This [1] POC was built based on that premise, that the gmem inode can be
> linked to another file and handed off to another VM, to facilitate
> intra-host migration, where the point is to save the work of rebuilding
> the VM's memory in the destination VM.
>=20
> With this, the bindings don't outlive the VM, but the data/memory
> does. I think this split design you proposed is really nice.
>=20
> >> The KVM pointer is shared among all the bindings in gmem=E2=80=99s xar=
ray, and we can
> >> enforce that a gmem file is used only with one VM:
> >>
> >> + When binding a memslot to the file, if a kvm pointer exists, it must
> >>   be the same kvm as the one in this binding
> >> + When the binding to the last memslot is removed from a file, NULL th=
e
> >>   kvm pointer.
> >
> > Nullifying the KVM pointer isn't sufficient, because without additional=
 actions
> > userspace could extract data from a VM by deleting its memslots and the=
n binding
> > the guest_memfd to an attacker controlled VM.  Or more likely with TDX =
and SNP,
> > induce badness by coercing KVM into mapping memory into a guest with th=
e wrong
> > ASID/HKID.
> >
> > I can think of three ways to handle that:
> >
> >   (a) prevent a different VM from *ever* binding to the gmem instance
> >   (b) free/zero physical pages when unbinding
> >   (c) free/zero when binding to a different VM
> >
> > Option (a) is easy, but that pretty much defeats the purpose of decopul=
ing
> > guest_memfd from a VM.
> >
> > Option (b) isn't hard to implement, but it screws up the lifecycle of t=
he memory,
> > e.g. would require memory when a memslot is deleted.  That isn't necess=
arily a
> > deal-breaker, but it runs counter to how KVM memlots currently operate.=
  Memslots
> > are basically just weird page tables, e.g. deleting a memslot doesn't h=
ave any
> > impact on the underlying data in memory.  TDX throws a wrench in this a=
s removing
> > a page from the Secure EPT is effectively destructive to the data (can'=
t be mapped
> > back in to the VM without zeroing the data), but IMO that's an oddity w=
ith TDX and
> > not necessarily something we want to carry over to other VM types.
> >
> > There would also be performance implications (probably a non-issue in p=
ractice),
> > and weirdness if/when we get to sharing, linking and/or mmap()ing gmem.=
  E.g. what
> > should happen if the last memslot (binding) is deleted, but there outst=
anding userspace
> > mappings?
> >
> > Option (c) is better from a lifecycle perspective, but it adds its own =
flavor of
> > complexity, e.g. the performant way to reclaim TDX memory requires the =
TDMR
> > (effectively the VM pointer), and so a deferred relcaim doesn't really =
work for
> > TDX.  And I'm pretty sure it *can't* work for SNP, because RMP entries =
must not
> > outlive the VM; KVM can't reuse an ASID if there are pages assigned to =
that ASID
> > in the RMP, i.e. until all memory belonging to the VM has been fully fr=
eed.
> >
>=20
> If we are on the same page that the memory should outlive the VM but not
> the bindings, then associating the gmem inode to a new VM should be a
> feature and not a bug.
>=20
> What do we want to defend against here?
>=20
> (a) Malicious host VMM
>=20
> For a malicious host VMM to read guest memory (with TDX and SNP), it can
> create a new VM with the same HKID/ASID as the victim VM, rebind the
> gmem inode to a VM crafted with an image that dumps the memory.
>=20
> I believe it is not possible for userspace to arbitrarily select a
> matching HKID unless userspace uses the intra-host migration ioctls, but =
if the
> migration ioctl is used, then EPTs are migrated and the memory dumper VM
> can't successfully run a different image from the victim VM. If the
> dumper VM needs to run the same image as the victim VM, then it would be
> a successful migration rather than an attack. (Perhaps we need to clean
> up some #MCs here but that can be a separate patch).

From a guest security perspective, throw TDX and SNP out the window.  As fa=
r as
the design of guest_memfd is concerned, I truly do not care what security p=
roperties
they provide, I only care about whether or not KVM's support for TDX and SN=
P is
clean, robust, and functionally correct.

Note, I'm not saying I don't care about TDX/SNP.  What I'm saying is that I=
 don't
want to design something that is beneficial only to what is currently a ver=
y
niche class of VMs that require specific flavors of hardware.

> (b) Malicious host kernel
>=20
> A malicious host kernel can allow a malicious host VMM to re-use a HKID
> for the dumper VM, but this isn't something a better gmem design can
> defend against.

Yep, completely out-of-scope.

> (c) Attacks using gmem for software-protected VMs
>=20
> Attacks using gmem for software-protected VMs are possible since there
> is no real encryption with HKID/ASID (yet?). The selftest for [1]
> actually uses this lack of encryption to test that the destination VM
> can read the source VM's memory after the migration. In the POC [1], as
> long as both destination VM knows where in the inode's memory to read,
> it can read what it wants to.
=20
Encryption is not required to protect guest memory from less privileged sof=
tware.
The selftests don't rely on lack of encryption, they rely on KVM incorporat=
ing
host userspace into the TCB.

Just because this RFC doesn't remove the VMM from the TCB for SW-protected =
VMS,
doesn't mean we _can't_ remove the VMM from the TCB.  pKVM has already show=
n that
such an implementation is possible.  We didn't tackle pKVM-like support in =
the
initial implementation because it's non-trivial, doesn't yet have a concret=
e use
case to fund/drive development, and would have significantly delayed suppor=
t for
the use cases people do actually care about.

There are certainly benefits from memory being encrypted, but it's neither =
a
requirement nor a panacea, as proven by the never ending stream of speculat=
ive
execution attacks.
=20
> This is a problem for software-protected VMs, but I feel that it is also =
a
> separate issue from gmem's design.

No, I don't want guest_memfd to be just be a vehicle for SNP/TDX VMs.  Havi=
ng line
of sight to removing host userspace from the TCB is absolutely a must have =
for me,
and having line of sight to improving KVM's security posture for "regular" =
VMs is
even more of a must have.  If guest_memfd doesn't provide us a very direct =
path to
(eventually) achieving those goals, then IMO it's a failure.

Which leads me to:

(d) Buggy components

Today, for all intents and purposes, guest memory *must* be mapped writable=
 in
the VMM, which means it is all too easy for a benign-but-buggy host compone=
nt to
corrupt guest memory.  There are ways to mitigate potential problems, e.g. =
by
developing userspace to adhere to the principle of least privilege inasmuch=
 as
possible, but such mitigations would be far less robust than what can be ac=
hieved
via guest_memfd, and practically speaking I don't see us (Google, but also =
KVM in
general) making progress on deprivileging userspace without forcing the iss=
ue.

> >> Could binding gmem files not on creation, but at memslot configuration
> >> time be sufficient and simpler?
> >
> > After working through the flows, I think binding on-demand would simpli=
fy the
> > refcounting (stating the obvious), but complicate the lifecycle of the =
memory as
> > well as the contract between KVM and userspace,
>=20
> If we are on the same page that the memory should outlive the VM but not
> the bindings, does it still complicate the lifecycle of the memory and
> the userspace/KVM contract? Could it just be a different contract?

Not entirely sure I understand what you're asking.  Does this question go a=
way
with my clarification about struct kvm vs. virtual machine?

> > and would break the separation of
> > concerns between the inode (physical memory / data) and file (VM's view=
 / mappings).
>=20
> Binding on-demand is orthogonal to the separation of concerns between
> inode and file, because it can be built regardless of whether we do the
> gmem file/inode split.
>=20
> + This flip-the-refcounting POC is built with the file/inode split and
> + In [2] (the delayed binding approach to solve intra-host migration), I
>   also tried flipping the refcounting, and that without the gmem
>   file/inode split. (Refcounting in [2] is buggy because the file can't
>   take a refcount on KVM, but it would work without taking that refcount)
>=20
> [1] https://lore.kernel.org/lkml/cover.1691446946.git.ackerleytng@google.=
com/T/
> [2] https://github.com/googleprodkernel/linux-cc/commit/dd5ac5e53f14a1ef9=
915c9c1e4cc1006a40b49df
