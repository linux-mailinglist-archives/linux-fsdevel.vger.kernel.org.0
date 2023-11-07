Return-Path: <linux-fsdevel+bounces-2216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F387E3F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F411C20AB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1AE30CE5;
	Tue,  7 Nov 2023 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un6EMDAB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939B2FE22
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 12:54:51 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576146191
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 04:54:48 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d060aa2a4so38561956d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 04:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699361687; x=1699966487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuFbqjfsVCp34XchBGKV0CWjcihho4T2q4FA5kjS7eU=;
        b=Un6EMDABv8osp1SzeUde9l3uSm1+LK4uI3/Wu+cFXyVNMIZ0rMR/5y2WqYz4ljDei6
         +UstRklWEF315C2RRPERQYquxJILvOtavMpOMBrD9ZCSJ3kQUhQTpUQwGYNsKlKFV0Au
         9pDAFk4IyHTnT/i1e73IyiDfD5vNhZdZuY4rhCmkL8fsbbKEtuE2zqRBlSj+26h995MX
         cTYnsTzPvhxmwqkUDQXtHHDHN0RvpgVHyXtyt0AzZjgVgEAWnZfyez76Z8CSRihgpf2t
         id7TSCEyy1BVRHpWMH0os1JdBe+OFN7EUOdHo5pQT5H3VHK4OH1mJP2VKGwrTYPh03be
         asyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699361687; x=1699966487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuFbqjfsVCp34XchBGKV0CWjcihho4T2q4FA5kjS7eU=;
        b=MOVSw5va8UEfuP3Clx5Wi+QVgHsS9tA3FOUZAaBevDWNnq95+WiH1zIsXOunlvK5Li
         4APR7mTfBv0P8JorGU3nTNMz58EWB5BOHMM9sF17mvdicJ98mB+uM5SHeTOs42HnXTPR
         NlObVm3m4akej1tUKnSgCE9lI7YpD+yd2sMlrEigubEtRjw4b9pgNbsYirAR1t1cv9Qg
         Oj8K9XpYpI7vnq3UeOIoLEh8Twksb/RAg+FC35Wss2bCh046Llxc8mP8Xf1OGPwTcyup
         Gu94K4XSvZaRdSh24NNYURyLN2RSV5uxkym6ZVWiUdLfgrrN0jP3LLEu3IEBlZ3W2Ur4
         nmxA==
X-Gm-Message-State: AOJu0YxVEFKvnu4KUVgdzLZYef+sYih9hO85DmyF+255eVVVVwZwQ+HO
	tXclBy4B5uzcMKe8QDhqD2sIrqqnocezUnqkqq9zlA==
X-Google-Smtp-Source: AGHT+IHS9JUkEkC/BybEMf4UmdGXo/DmXLNK4bOT/jrKIAqRMkLyM4gXD6uMK1OzLS09666PL8dXekXtndn5vIwFZqQ=
X-Received: by 2002:a05:6214:260c:b0:66f:bb36:9a51 with SMTP id
 gu12-20020a056214260c00b0066fbb369a51mr33614248qvb.36.1699361687221; Tue, 07
 Nov 2023 04:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-31-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-31-pbonzini@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 7 Nov 2023 12:54:10 +0000
Message-ID: <CA+EHjTyZoLLv1nRfCEY4nHrbHadphn37jw3OPS17x1dAm_YUxA@mail.gmail.com>
Subject: Re: [PATCH 30/34] KVM: selftests: Add KVM_SET_USER_MEMORY_REGION2 helper
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Anish Moorthy <amoorthy@google.com>, 
	David Matlack <dmatlack@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Maciej Szmigiero <mail@maciej.szmigiero.name>, 
	David Hildenbrand <david@redhat.com>, Quentin Perret <qperret@google.com>, 
	Michael Roth <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Add helpers to invoke KVM_SET_USER_MEMORY_REGION2 directly so that tests
> can validate of features that are unique to "version 2" of "set user
> memory region", e.g. do negative testing on gmem_fd and gmem_offset.
>
> Provide a raw version as well as an assert-success version to reduce
> the amount of boilerplate code need for basic usage.
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-33-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  .../selftests/kvm/include/kvm_util_base.h     |  7 +++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/=
testing/selftests/kvm/include/kvm_util_base.h
> index 157508c071f3..8ec122f5fcc8 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -522,6 +522,13 @@ void vm_set_user_memory_region(struct kvm_vm *vm, ui=
nt32_t slot, uint32_t flags,
>                                uint64_t gpa, uint64_t size, void *hva);
>  int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32=
_t flags,
>                                 uint64_t gpa, uint64_t size, void *hva);
> +void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32=
_t flags,
> +                               uint64_t gpa, uint64_t size, void *hva,
> +                               uint32_t guest_memfd, uint64_t guest_memf=
d_offset);
> +int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint3=
2_t flags,
> +                                uint64_t gpa, uint64_t size, void *hva,
> +                                uint32_t guest_memfd, uint64_t guest_mem=
fd_offset);
> +
>  void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         enum vm_mem_backing_src_type src_type,
>         uint64_t guest_paddr, uint32_t slot, uint64_t npages,
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index 1c74310f1d44..d05d95cc3693 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -873,6 +873,35 @@ void vm_set_user_memory_region(struct kvm_vm *vm, ui=
nt32_t slot, uint32_t flags,
>                     errno, strerror(errno));
>  }
>
> +int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint3=
2_t flags,
> +                                uint64_t gpa, uint64_t size, void *hva,
> +                                uint32_t guest_memfd, uint64_t guest_mem=
fd_offset)
> +{
> +       struct kvm_userspace_memory_region2 region =3D {
> +               .slot =3D slot,
> +               .flags =3D flags,
> +               .guest_phys_addr =3D gpa,
> +               .memory_size =3D size,
> +               .userspace_addr =3D (uintptr_t)hva,
> +               .guest_memfd =3D guest_memfd,
> +               .guest_memfd_offset =3D guest_memfd_offset,
> +       };
> +
> +       return ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION2, &region);
> +}
> +
> +void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32=
_t flags,
> +                               uint64_t gpa, uint64_t size, void *hva,
> +                               uint32_t guest_memfd, uint64_t guest_memf=
d_offset)
> +{
> +       int ret =3D __vm_set_user_memory_region2(vm, slot, flags, gpa, si=
ze, hva,
> +                                              guest_memfd, guest_memfd_o=
ffset);
> +
> +       TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno =3D =
%d (%s)",
> +                   errno, strerror(errno));
> +}
> +
> +
>  /* FIXME: This thing needs to be ripped apart and rewritten. */
>  void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type=
,
>                 uint64_t guest_paddr, uint32_t slot, uint64_t npages,
> --
> 2.39.1
>
>

