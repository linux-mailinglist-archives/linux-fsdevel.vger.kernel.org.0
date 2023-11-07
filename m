Return-Path: <linux-fsdevel+bounces-2217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF747E3FA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9065F1C20B90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36842EB11;
	Tue,  7 Nov 2023 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+Aqvpji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465292DF91
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 13:07:58 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9DB47AE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 05:07:55 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6ce322b62aeso3472852a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699362475; x=1699967275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VRoxoxM3bk/ddMYA7RkVxhIt7sN32CxDfhJasXbdTQ=;
        b=d+AqvpjiFbFAWRV9cRJNKM3v3+qxl1cKA38dut0JjiA4ZbvMBxHGiFdgjCsutproHH
         6HnqdEbNqk0h/X0h52BLPSv3pILQ6OucibhTiP7uDR3GnEkBHBWQnf9hG6p0JVzcviQC
         aY9Ojx2Mztp6zUpbe5e9YEeKDWtdBIkSNLBThIGCKPJKRlP48841vRZ5iB4Uj0BdizKf
         M9PGkCSbajupx+ldPomAqseDO/W0+69X4hr3QQdNE9Onj+F79btBCLki3H9VRTSSO7co
         Zz9FQYfrvqEiG2x5YPNAv5Ud1E/XsNf4yucjlAKenbi1kIrzw8HR08VQVCqGalDrGrq+
         ZbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362475; x=1699967275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VRoxoxM3bk/ddMYA7RkVxhIt7sN32CxDfhJasXbdTQ=;
        b=vCrQym0dJZm2xMoogJsrtzAoi3SfKl/8+Sk6067aOdd5aSCptI+fdJ86F8GHdm6I2J
         Y33fCtg7j54NMjnY7+rsrmFEb3rBXl6zae6HKPRX0p3/h8LHSLZycSwVZygrO5xoiIIG
         fPO7u4/nTosXLgvzuonrPqY+zqlWOhVL055K8UduzWVs1iwl6B3Zkvsd09ZFgOL8l2s6
         orW8gwtI5zCSrhdSbvYdVXjv6/RJwJaqauC1p0ICWnwH2EyTgHJxa9iEB6hcGdJjCDCD
         +0DcFG2Wd8dRPEmhQHpGijh8N30DoZoRSCptuz51U1RbDsDVDYwX3ci8NFJ9xxOfPWZj
         ALoA==
X-Gm-Message-State: AOJu0YxGMVG+9jIZn799FtY6FH2rvLAGmi/Kv99iRw5LsNBnVf6miio2
	mou1h1Mw9jum0xLuULpE+ORsx4eigE6PHtNvQRYcmA==
X-Google-Smtp-Source: AGHT+IEc/OoLKiW5UzIza8k0AJcg/cvGrUiQc/SGatsr9amhK5Gck/VoGoIGcZKiRYhIoVxvQmPBVV/w9nNgSokWHaw=
X-Received: by 2002:a05:6871:3227:b0:1ef:ace4:f360 with SMTP id
 mo39-20020a056871322700b001eface4f360mr2023903oac.17.1699362474620; Tue, 07
 Nov 2023 05:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-33-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-33-pbonzini@redhat.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 7 Nov 2023 13:07:18 +0000
Message-ID: <CA+EHjTxMK2G3WSQsjPA5zn94+a91HsoaWXx8tz1TTGuq1tVZ5Q@mail.gmail.com>
Subject: Re: [PATCH 32/34] KVM: selftests: Add basic selftest for guest_memfd()
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

Hi,

On Sun, Nov 5, 2023 at 4:35=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Add a selftest to verify the basic functionality of guest_memfd():
>
> + file descriptor created with the guest_memfd() ioctl does not allow
>   read/write/mmap operations
> + file size and block size as returned from fstat are as expected
> + fallocate on the fd checks that offset/length on
>   fallocate(FALLOC_FL_PUNCH_HOLE) should be page aligned
> + invalid inputs (misaligned size, invalid flags) are rejected
> + file size and inode are unique (the innocuous-sounding
>   anon_inode_getfile() backs all files with a single inode...)
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-35-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../testing/selftests/kvm/guest_memfd_test.c  | 206 ++++++++++++++++++
>  2 files changed, 207 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index ecdea5e7afa8..fd3b30a4ca7b 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -134,6 +134,7 @@ TEST_GEN_PROGS_x86_64 +=3D access_tracking_perf_test
>  TEST_GEN_PROGS_x86_64 +=3D demand_paging_test
>  TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
>  TEST_GEN_PROGS_x86_64 +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_x86_64 +=3D guest_memfd_test
>  TEST_GEN_PROGS_x86_64 +=3D guest_print_test
>  TEST_GEN_PROGS_x86_64 +=3D hardware_disable_test
>  TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> new file mode 100644
> index 000000000000..ea0ae7e25330
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright Intel Corporation, 2023
> + *
> + * Author: Chao Peng <chao.p.peng@linux.intel.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include "test_util.h"
> +#include "kvm_util_base.h"
> +#include <linux/bitmap.h>
> +#include <linux/falloc.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <fcntl.h>

The include ordering should be fixed. Otherwise,

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> +
> +static void test_file_read_write(int fd)
> +{
> +       char buf[64];
> +
> +       TEST_ASSERT(read(fd, buf, sizeof(buf)) < 0,
> +                   "read on a guest_mem fd should fail");
> +       TEST_ASSERT(write(fd, buf, sizeof(buf)) < 0,
> +                   "write on a guest_mem fd should fail");
> +       TEST_ASSERT(pread(fd, buf, sizeof(buf), 0) < 0,
> +                   "pread on a guest_mem fd should fail");
> +       TEST_ASSERT(pwrite(fd, buf, sizeof(buf), 0) < 0,
> +                   "pwrite on a guest_mem fd should fail");
> +}
> +
> +static void test_mmap(int fd, size_t page_size)
> +{
> +       char *mem;
> +
> +       mem =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,=
 fd, 0);
> +       TEST_ASSERT_EQ(mem, MAP_FAILED);
> +}
> +
> +static void test_file_size(int fd, size_t page_size, size_t total_size)
> +{
> +       struct stat sb;
> +       int ret;
> +
> +       ret =3D fstat(fd, &sb);
> +       TEST_ASSERT(!ret, "fstat should succeed");
> +       TEST_ASSERT_EQ(sb.st_size, total_size);
> +       TEST_ASSERT_EQ(sb.st_blksize, page_size);
> +}
> +
> +static void test_fallocate(int fd, size_t page_size, size_t total_size)
> +{
> +       int ret;
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, total_size);
> +       TEST_ASSERT(!ret, "fallocate with aligned offset and size should =
succeed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       page_size - 1, page_size);
> +       TEST_ASSERT(ret, "fallocate with unaligned offset should fail");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, page_size)=
;
> +       TEST_ASSERT(ret, "fallocate beginning at total_size should fail")=
;
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size=
, page_size);
> +       TEST_ASSERT(ret, "fallocate beginning after total_size should fai=
l");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       total_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) at total_size should suc=
ceed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       total_size + page_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) after total_size should =
succeed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       page_size, page_size - 1);
> +       TEST_ASSERT(ret, "fallocate with unaligned size should fail");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       page_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) with aligned offset and =
size should succeed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate to restore punched hole should succe=
ed");
> +}
> +
> +static void test_invalid_punch_hole(int fd, size_t page_size, size_t tot=
al_size)
> +{
> +       struct {
> +               off_t offset;
> +               off_t len;
> +       } testcases[] =3D {
> +               {0, 1},
> +               {0, page_size - 1},
> +               {0, page_size + 1},
> +
> +               {1, 1},
> +               {1, page_size - 1},
> +               {1, page_size},
> +               {1, page_size + 1},
> +
> +               {page_size, 1},
> +               {page_size, page_size - 1},
> +               {page_size, page_size + 1},
> +       };
> +       int ret, i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(testcases); i++) {
> +               ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUN=
CH_HOLE,
> +                               testcases[i].offset, testcases[i].len);
> +               TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINVAL,
> +                           "PUNCH_HOLE with !PAGE_SIZE offset (%lx) and/=
or length (%lx) should fail",
> +                           testcases[i].offset, testcases[i].len);
> +       }
> +}
> +
> +static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
> +{
> +       size_t page_size =3D getpagesize();
> +       uint64_t flag;
> +       size_t size;
> +       int fd;
> +
> +       for (size =3D 1; size < page_size; size++) {
> +               fd =3D __vm_create_guest_memfd(vm, size, 0);
> +               TEST_ASSERT(fd =3D=3D -1 && errno =3D=3D EINVAL,
> +                           "guest_memfd() with non-page-aligned page siz=
e '0x%lx' should fail with EINVAL",
> +                           size);
> +       }
> +
> +       for (flag =3D 1; flag; flag <<=3D 1) {
> +               uint64_t bit;
> +
> +               fd =3D __vm_create_guest_memfd(vm, page_size, flag);
> +               TEST_ASSERT(fd =3D=3D -1 && errno =3D=3D EINVAL,
> +                           "guest_memfd() with flag '0x%lx' should fail =
with EINVAL",
> +                           flag);
> +
> +               for_each_set_bit(bit, &valid_flags, 64) {
> +                       fd =3D __vm_create_guest_memfd(vm, page_size, fla=
g | BIT_ULL(bit));
> +                       TEST_ASSERT(fd =3D=3D -1 && errno =3D=3D EINVAL,
> +                                   "guest_memfd() with flags '0x%llx' sh=
ould fail with EINVAL",
> +                                   flag | BIT_ULL(bit));
> +               }
> +       }
> +}
> +
> +static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
> +{
> +       int fd1, fd2, ret;
> +       struct stat st1, st2;
> +
> +       fd1 =3D __vm_create_guest_memfd(vm, 4096, 0);
> +       TEST_ASSERT(fd1 !=3D -1, "memfd creation should succeed");
> +
> +       ret =3D fstat(fd1, &st1);
> +       TEST_ASSERT(ret !=3D -1, "memfd fstat should succeed");
> +       TEST_ASSERT(st1.st_size =3D=3D 4096, "memfd st_size should match =
requested size");
> +
> +       fd2 =3D __vm_create_guest_memfd(vm, 8192, 0);
> +       TEST_ASSERT(fd2 !=3D -1, "memfd creation should succeed");
> +
> +       ret =3D fstat(fd2, &st2);
> +       TEST_ASSERT(ret !=3D -1, "memfd fstat should succeed");
> +       TEST_ASSERT(st2.st_size =3D=3D 8192, "second memfd st_size should=
 match requested size");
> +
> +       ret =3D fstat(fd1, &st1);
> +       TEST_ASSERT(ret !=3D -1, "memfd fstat should succeed");
> +       TEST_ASSERT(st1.st_size =3D=3D 4096, "first memfd st_size should =
still match requested size");
> +       TEST_ASSERT(st1.st_ino !=3D st2.st_ino, "different memfd should h=
ave different inode numbers");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       size_t page_size;
> +       size_t total_size;
> +       int fd;
> +       struct kvm_vm *vm;
> +
> +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
> +
> +       page_size =3D getpagesize();
> +       total_size =3D page_size * 4;
> +
> +       vm =3D vm_create_barebones();
> +
> +       test_create_guest_memfd_invalid(vm);
> +       test_create_guest_memfd_multiple(vm);
> +
> +       fd =3D vm_create_guest_memfd(vm, total_size, 0);
> +
> +       test_file_read_write(fd);
> +       test_mmap(fd, page_size);
> +       test_file_size(fd, page_size, total_size);
> +       test_fallocate(fd, page_size, total_size);
> +       test_invalid_punch_hole(fd, page_size, total_size);
> +
> +       close(fd);
> +}
> --
> 2.39.1
>
>

