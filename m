Return-Path: <linux-fsdevel+bounces-19031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFC78BF7A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653C0281BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA53F8EA;
	Wed,  8 May 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gz9oGuI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537F2C6B2;
	Wed,  8 May 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154622; cv=none; b=u0XlOrOuIuxcAtDgZ6zkCncRQjdDdlQEcVUp/yNqN3WGAecFtx9vZ+uqUZjvvGKw4uORBP0DHwEdlBaO75p3xVu6plc3d2XfjSEPHW4/DKrRoxrVaGSPU0baIqR6TGnt1bskpGgO7Pc6HYP/tqEFv7+tR9JCzbVefhdBBilM3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154622; c=relaxed/simple;
	bh=/PYr6SUMNBrkW6nqx2E1+VcSKjZX90qblFRZGrBVVpQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ij389LanVXZI5m7XwIjP8WZjiHSm1PW4nj4WWAShjSPD8l1PF32PSlm/Ewa98R+XFRygf+hN3rshtXsQH7VI0B4x4xJr1Fd9GYiT1EKRNHdVsdPSz9wRk9jULpjw8mMexS0RiNK4vlh6584tFNscluY4Bu2koQoEmvhHwVBdy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gz9oGuI1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715154615;
	bh=/PYr6SUMNBrkW6nqx2E1+VcSKjZX90qblFRZGrBVVpQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Gz9oGuI1yC8+sACIr5JJh9YjkCfiapVrZ7q7m8eBgtNre6tIH2qfj3Q4LagZnNqjL
	 fv7itXCXsp6yunBLbdDV4EBbnFaIHFEFj4PX7rAyF/fHGZKqkflOkGDOJOg43wxUUC
	 M+2lypCImE4e3cXJcxSO6vKfDDnq4Fj5PmAmCE2UgtsZ6HLJOsSPCr3+etJKB6D+DK
	 mducZ18pKQMJFEVAIQ9ZM7vVMJi30FKI6rEgAO3XStxP2525SlREL9IlxOMfl2fQ4Y
	 04TagZ4R3LnQiOPv7JavP92mjJzdGHBFfAOtyFCXcsgozlE6XGWGyo+RfahREpmUYr
	 XdGohaEJcwyHA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ABADA3782170;
	Wed,  8 May 2024 07:49:44 +0000 (UTC)
Message-ID: <f4cdb328-fafb-4197-8028-33e472b1a42f@collabora.com>
Date: Wed, 8 May 2024 12:50:09 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 4/5] selftests: Drop define _GNU_SOURCE
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Christian Brauner
 <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>, Seth Forshee
 <sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20240507214254.2787305-1-edliaw@google.com>
 <20240507214254.2787305-5-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240507214254.2787305-5-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/24 2:38 AM, Edward Liaw wrote:
> _GNU_SOURCE is provided by KHDR_INCLUDES, so it should be dropped to
> prevent _GNU_SOURCE redefined warnings.
> 
> Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/cachestat/test_cachestat.c            | 2 --
>  tools/testing/selftests/capabilities/test_execve.c            | 2 --
>  tools/testing/selftests/clone3/clone3.c                       | 2 --
>  .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 2 --
>  tools/testing/selftests/clone3/clone3_clear_sighand.c         | 2 --
>  tools/testing/selftests/clone3/clone3_selftests.h             | 1 -
>  tools/testing/selftests/clone3/clone3_set_tid.c               | 2 --
>  tools/testing/selftests/core/close_range_test.c               | 2 --
>  tools/testing/selftests/drivers/dma-buf/udmabuf.c             | 1 -
>  tools/testing/selftests/fchmodat2/fchmodat2_test.c            | 2 --
>  tools/testing/selftests/filesystems/binderfs/binderfs_test.c  | 2 --
>  tools/testing/selftests/filesystems/devpts_pts.c              | 1 -
>  tools/testing/selftests/filesystems/dnotify_test.c            | 1 -
>  tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c | 2 --
>  tools/testing/selftests/filesystems/eventfd/eventfd_test.c    | 2 --
>  tools/testing/selftests/filesystems/fat/rename_exchange.c     | 2 --
>  tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c   | 2 --
>  .../testing/selftests/filesystems/statmount/statmount_test.c  | 3 ---
>  tools/testing/selftests/futex/functional/futex_requeue_pi.c   | 3 ---
>  tools/testing/selftests/ipc/msgque.c                          | 1 -
>  tools/testing/selftests/kcmp/kcmp_test.c                      | 2 --
>  tools/testing/selftests/kvm/aarch64/arch_timer.c              | 2 --
>  tools/testing/selftests/kvm/aarch64/page_fault_test.c         | 1 -
>  tools/testing/selftests/kvm/aarch64/psci_test.c               | 3 ---
>  tools/testing/selftests/kvm/aarch64/vgic_init.c               | 1 -
>  tools/testing/selftests/kvm/arch_timer.c                      | 3 ---
>  tools/testing/selftests/kvm/demand_paging_test.c              | 3 ---
>  tools/testing/selftests/kvm/dirty_log_test.c                  | 3 ---
>  tools/testing/selftests/kvm/guest_memfd_test.c                | 2 --
>  tools/testing/selftests/kvm/hardware_disable_test.c           | 3 ---
>  tools/testing/selftests/kvm/include/userfaultfd_util.h        | 3 ---
>  tools/testing/selftests/kvm/kvm_binary_stats_test.c           | 2 --
>  tools/testing/selftests/kvm/kvm_create_max_vcpus.c            | 2 --
>  tools/testing/selftests/kvm/kvm_page_table_test.c             | 3 ---
>  tools/testing/selftests/kvm/lib/assert.c                      | 3 ---
>  tools/testing/selftests/kvm/lib/kvm_util.c                    | 2 --
>  tools/testing/selftests/kvm/lib/memstress.c                   | 2 --
>  tools/testing/selftests/kvm/lib/test_util.c                   | 2 --
>  tools/testing/selftests/kvm/lib/userfaultfd_util.c            | 3 ---
>  tools/testing/selftests/kvm/lib/x86_64/sev.c                  | 1 -
>  tools/testing/selftests/kvm/max_guest_memory_test.c           | 2 --
>  .../testing/selftests/kvm/memslot_modification_stress_test.c  | 3 ---
>  tools/testing/selftests/kvm/riscv/arch_timer.c                | 3 ---
>  tools/testing/selftests/kvm/rseq_test.c                       | 1 -
>  tools/testing/selftests/kvm/s390x/cmma_test.c                 | 2 --
>  tools/testing/selftests/kvm/s390x/sync_regs_test.c            | 2 --
>  tools/testing/selftests/kvm/set_memory_region_test.c          | 1 -
>  tools/testing/selftests/kvm/steal_time.c                      | 1 -
>  tools/testing/selftests/kvm/x86_64/amx_test.c                 | 2 --
>  .../selftests/kvm/x86_64/exit_on_emulation_failure_test.c     | 3 ---
>  tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c            | 2 --
>  tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c             | 2 --
>  tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c             | 1 -
>  tools/testing/selftests/kvm/x86_64/hyperv_ipi.c               | 2 --
>  tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c          | 1 -
>  tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c         | 2 --
>  tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c   | 2 --
>  tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c       | 3 ---
>  tools/testing/selftests/kvm/x86_64/platform_info_test.c       | 2 --
>  tools/testing/selftests/kvm/x86_64/pmu_counters_test.c        | 2 --
>  tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c    | 3 ---
>  .../selftests/kvm/x86_64/private_mem_conversions_test.c       | 1 -
>  tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c          | 1 -
>  tools/testing/selftests/kvm/x86_64/set_sregs_test.c           | 1 -
>  .../selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c  | 3 ---
>  tools/testing/selftests/kvm/x86_64/smm_test.c                 | 1 -
>  tools/testing/selftests/kvm/x86_64/state_test.c               | 1 -
>  tools/testing/selftests/kvm/x86_64/sync_regs_test.c           | 2 --
>  tools/testing/selftests/kvm/x86_64/ucna_injection_test.c      | 2 --
>  tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c  | 2 --
>  tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c       | 3 ---
>  tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c        | 1 -
>  .../testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c  | 1 -
>  tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c           | 2 --
>  tools/testing/selftests/kvm/x86_64/xapic_state_test.c         | 1 -
>  tools/testing/selftests/kvm/x86_64/xss_msr_test.c             | 2 --
>  tools/testing/selftests/landlock/base_test.c                  | 2 --
>  tools/testing/selftests/landlock/fs_test.c                    | 2 --
>  tools/testing/selftests/landlock/net_test.c                   | 2 --
>  tools/testing/selftests/landlock/ptrace_test.c                | 2 --
>  tools/testing/selftests/lsm/common.c                          | 2 --
>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c          | 2 --
>  tools/testing/selftests/lsm/lsm_list_modules_test.c           | 2 --
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c          | 2 --
>  tools/testing/selftests/membarrier/membarrier_test_impl.h     | 1 -
>  .../selftests/membarrier/membarrier_test_multi_thread.c       | 1 -
>  .../selftests/membarrier/membarrier_test_single_thread.c      | 1 -
>  tools/testing/selftests/memfd/common.c                        | 1 -
>  tools/testing/selftests/memfd/fuse_test.c                     | 2 --
>  tools/testing/selftests/memfd/memfd_test.c                    | 1 -
>  tools/testing/selftests/mm/cow.c                              | 1 -
>  tools/testing/selftests/mm/gup_longterm.c                     | 1 -
>  tools/testing/selftests/mm/hugepage-mmap.c                    | 1 -
>  tools/testing/selftests/mm/hugepage-mremap.c                  | 2 --
>  tools/testing/selftests/mm/hugetlb-madvise.c                  | 2 --
>  tools/testing/selftests/mm/hugetlb-read-hwpoison.c            | 2 --
>  tools/testing/selftests/mm/khugepaged.c                       | 1 -
>  tools/testing/selftests/mm/ksm_functional_tests.c             | 1 -
>  tools/testing/selftests/mm/madv_populate.c                    | 1 -
>  tools/testing/selftests/mm/map_populate.c                     | 2 --
>  tools/testing/selftests/mm/mdwe_test.c                        | 1 -
>  tools/testing/selftests/mm/memfd_secret.c                     | 2 --
>  tools/testing/selftests/mm/mlock2-tests.c                     | 1 -
>  tools/testing/selftests/mm/mrelease_test.c                    | 1 -
>  tools/testing/selftests/mm/mremap_dontunmap.c                 | 1 -
>  tools/testing/selftests/mm/mremap_test.c                      | 2 --
>  tools/testing/selftests/mm/pagemap_ioctl.c                    | 1 -
>  tools/testing/selftests/mm/pkey-helpers.h                     | 1 -
>  tools/testing/selftests/mm/protection_keys.c                  | 1 -
>  tools/testing/selftests/mm/split_huge_page_test.c             | 2 --
>  tools/testing/selftests/mm/thuge-gen.c                        | 2 --
>  tools/testing/selftests/mm/uffd-common.h                      | 1 -
>  tools/testing/selftests/mount_setattr/mount_setattr_test.c    | 1 -
>  .../move_mount_set_group/move_mount_set_group_test.c          | 1 -
>  tools/testing/selftests/net/af_unix/diag_uid.c                | 2 --
>  tools/testing/selftests/net/af_unix/scm_pidfd.c               | 1 -
>  tools/testing/selftests/net/af_unix/unix_connect.c            | 2 --
>  tools/testing/selftests/net/csum.c                            | 3 ---
>  tools/testing/selftests/net/gro.c                             | 3 ---
>  tools/testing/selftests/net/ip_defrag.c                       | 3 ---
>  tools/testing/selftests/net/ipsec.c                           | 3 ---
>  tools/testing/selftests/net/ipv6_flowlabel.c                  | 3 ---
>  tools/testing/selftests/net/ipv6_flowlabel_mgr.c              | 3 ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c             | 3 ---
>  tools/testing/selftests/net/mptcp/mptcp_inq.c                 | 3 ---
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.c             | 3 ---
>  tools/testing/selftests/net/msg_zerocopy.c                    | 3 ---
>  tools/testing/selftests/net/nettest.c                         | 2 --
>  tools/testing/selftests/net/psock_fanout.c                    | 3 ---
>  tools/testing/selftests/net/psock_snd.c                       | 3 ---
>  tools/testing/selftests/net/reuseport_addr_any.c              | 3 ---
>  tools/testing/selftests/net/reuseport_bpf_cpu.c               | 3 ---
>  tools/testing/selftests/net/reuseport_bpf_numa.c              | 3 ---
>  tools/testing/selftests/net/reuseport_dualstack.c             | 3 ---
>  tools/testing/selftests/net/so_incoming_cpu.c                 | 1 -
>  tools/testing/selftests/net/so_netns_cookie.c                 | 1 -
>  tools/testing/selftests/net/so_txtime.c                       | 3 ---
>  tools/testing/selftests/net/tap.c                             | 3 ---
>  tools/testing/selftests/net/tcp_fastopen_backup_key.c         | 1 -
>  tools/testing/selftests/net/tcp_inq.c                         | 2 --
>  tools/testing/selftests/net/tcp_mmap.c                        | 1 -
>  tools/testing/selftests/net/tls.c                             | 3 ---
>  tools/testing/selftests/net/toeplitz.c                        | 3 ---
>  tools/testing/selftests/net/tun.c                             | 3 ---
>  tools/testing/selftests/net/txring_overwrite.c                | 3 ---
>  tools/testing/selftests/net/txtimestamp.c                     | 3 ---
>  tools/testing/selftests/net/udpgso.c                          | 3 ---
>  tools/testing/selftests/net/udpgso_bench_rx.c                 | 3 ---
>  tools/testing/selftests/net/udpgso_bench_tx.c                 | 3 ---
>  tools/testing/selftests/perf_events/remove_on_exec.c          | 2 --
>  tools/testing/selftests/perf_events/sigtrap_threads.c         | 2 --
>  tools/testing/selftests/pid_namespace/regression_enomem.c     | 1 -
>  tools/testing/selftests/pidfd/pidfd.h                         | 1 -
>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c             | 2 --
>  tools/testing/selftests/pidfd/pidfd_getfd_test.c              | 2 --
>  tools/testing/selftests/pidfd/pidfd_open_test.c               | 2 --
>  tools/testing/selftests/pidfd/pidfd_poll_test.c               | 2 --
>  tools/testing/selftests/pidfd/pidfd_setns_test.c              | 2 --
>  tools/testing/selftests/pidfd/pidfd_test.c                    | 2 --
>  tools/testing/selftests/pidfd/pidfd_wait.c                    | 2 --
>  tools/testing/selftests/ptrace/get_set_sud.c                  | 1 -
>  tools/testing/selftests/ptrace/peeksiginfo.c                  | 1 -
>  tools/testing/selftests/rseq/basic_percpu_ops_test.c          | 1 -
>  tools/testing/selftests/rseq/basic_test.c                     | 2 --
>  tools/testing/selftests/rseq/param_test.c                     | 1 -
>  tools/testing/selftests/rseq/rseq.c                           | 2 --
>  tools/testing/selftests/seccomp/seccomp_benchmark.c           | 1 -
>  tools/testing/selftests/seccomp/seccomp_bpf.c                 | 2 --
>  tools/testing/selftests/user_events/abi_test.c                | 2 --
>  tools/testing/selftests/x86/amx.c                             | 2 --
>  tools/testing/selftests/x86/check_initial_reg_state.c         | 3 ---
>  tools/testing/selftests/x86/corrupt_xstate_header.c           | 3 ---
>  tools/testing/selftests/x86/entry_from_vm86.c                 | 3 ---
>  tools/testing/selftests/x86/fsgsbase.c                        | 2 --
>  tools/testing/selftests/x86/fsgsbase_restore.c                | 2 --
>  tools/testing/selftests/x86/ioperm.c                          | 2 --
>  tools/testing/selftests/x86/iopl.c                            | 2 --
>  tools/testing/selftests/x86/lam.c                             | 1 -
>  tools/testing/selftests/x86/ldt_gdt.c                         | 2 --
>  tools/testing/selftests/x86/mov_ss_trap.c                     | 2 --
>  tools/testing/selftests/x86/nx_stack.c                        | 2 --
>  tools/testing/selftests/x86/ptrace_syscall.c                  | 2 --
>  tools/testing/selftests/x86/sigaltstack.c                     | 2 --
>  tools/testing/selftests/x86/sigreturn.c                       | 3 ---
>  tools/testing/selftests/x86/single_step_syscall.c             | 3 ---
>  tools/testing/selftests/x86/syscall_arg_fault.c               | 3 ---
>  tools/testing/selftests/x86/syscall_numbering.c               | 3 ---
>  tools/testing/selftests/x86/sysret_rip.c                      | 3 ---
>  tools/testing/selftests/x86/sysret_ss_attrs.c                 | 3 ---
>  tools/testing/selftests/x86/test_FCMOV.c                      | 4 ----
>  tools/testing/selftests/x86/test_FCOMI.c                      | 4 ----
>  tools/testing/selftests/x86/test_FISTTP.c                     | 4 ----
>  tools/testing/selftests/x86/test_mremap_vdso.c                | 1 -
>  tools/testing/selftests/x86/test_shadow_stack.c               | 3 ---
>  tools/testing/selftests/x86/test_syscall_vdso.c               | 4 ----
>  tools/testing/selftests/x86/test_vsyscall.c                   | 3 ---
>  tools/testing/selftests/x86/unwind_vdso.c                     | 3 ---
>  tools/testing/selftests/x86/vdso_restorer.c                   | 3 ---
>  198 files changed, 405 deletions(-)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index b171fd53b004..c1a6ce7b0912 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdbool.h>
>  #include <linux/kernel.h>
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 7cde07a5df78..e3954b88c3ee 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <cap-ng.h>
>  #include <linux/capability.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 3c9bf0cd82a8..3c5e45dae617 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  /* Based on Christian Brauner's clone3() example */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <linux/types.h>
> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> index 31b56d625655..bb99ea20f7d5 100644
> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> @@ -7,8 +7,6 @@
>   */
>  
>  /* capabilities related code based on selftests/bpf/test_verifier.c */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <linux/types.h>
>  #include <linux/sched.h>
> diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> index 54a8b2445be9..50336d56db6b 100644
> --- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
> +++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> @@ -1,6 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <sched.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
> index 3d2663fe50ba..172e19d5515f 100644
> --- a/tools/testing/selftests/clone3/clone3_selftests.h
> +++ b/tools/testing/selftests/clone3/clone3_selftests.h
> @@ -3,7 +3,6 @@
>  #ifndef _CLONE3_SELFTESTS_H
>  #define _CLONE3_SELFTESTS_H
>  
> -#define _GNU_SOURCE
>  #include <sched.h>
>  #include <linux/sched.h>
>  #include <linux/types.h>
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> index ed785afb6077..8b5ed4484ee6 100644
> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -5,8 +5,6 @@
>   * These tests are assuming to be running in the host's
>   * PID namespace.
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <linux/types.h>
>  #include <linux/sched.h>
> diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
> index c59e4adb905d..1c2902bcc913 100644
> --- a/tools/testing/selftests/core/close_range_test.c
> +++ b/tools/testing/selftests/core/close_range_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/kernel.h>
> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> index c812080e304e..7c8dbab8ac44 100644
> --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #define __EXPORTED_HEADERS__
>  
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
> index e0319417124d..6b411859c2cd 100644
> --- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
> +++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -
> -#define _GNU_SOURCE
>  #include <fcntl.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 5f362c0fd890..fca693db1b09 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
> index b1fc9b916ace..73766447eeb0 100644
> --- a/tools/testing/selftests/filesystems/devpts_pts.c
> +++ b/tools/testing/selftests/filesystems/devpts_pts.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/filesystems/dnotify_test.c b/tools/testing/selftests/filesystems/dnotify_test.c
> index c0a9b2d3302d..05367a70b963 100644
> --- a/tools/testing/selftests/filesystems/dnotify_test.c
> +++ b/tools/testing/selftests/filesystems/dnotify_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE	/* needed to get the defines */
>  #include <fcntl.h>	/* in glibc 2.2 this has the needed
>  				   values defined */
>  #include <signal.h>
> diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
> index 65ede506305c..9bc2ddad7e92 100644
> --- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
> +++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <asm/unistd.h>
>  #include <linux/time_types.h>
>  #include <poll.h>
> diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> index f142a137526c..17935f42fbc9 100644
> --- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> +++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <asm/unistd.h>
> diff --git a/tools/testing/selftests/filesystems/fat/rename_exchange.c b/tools/testing/selftests/filesystems/fat/rename_exchange.c
> index e488ad354fce..56cf3ad8640d 100644
> --- a/tools/testing/selftests/filesystems/fat/rename_exchange.c
> +++ b/tools/testing/selftests/filesystems/fat/rename_exchange.c
> @@ -6,8 +6,6 @@
>   * Copyright 2022 Red Hat Inc.
>   * Author: Javier Martinez Canillas <javierm@redhat.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> index 759f86e7d263..b58a80bde95a 100644
> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <inttypes.h>
>  #include <unistd.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> index 3eafd7da58e2..d1cefd1b7d16 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -
> -#define _GNU_SOURCE
> -
>  #include <assert.h>
>  #include <stdint.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> index 7f3ca5c78df1..8e41f9fe784c 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> @@ -16,9 +16,6 @@
>   *      2009-Nov-6: futex test adaptation by Darren Hart <dvhart@linux.intel.com>
>   *
>   *****************************************************************************/
> -
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <limits.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> index 656c43c24044..291c81d59a9d 100644
> --- a/tools/testing/selftests/ipc/msgque.c
> +++ b/tools/testing/selftests/ipc/msgque.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
> index 25110c7c0b3e..885c9e943cee 100644
> --- a/tools/testing/selftests/kcmp/kcmp_test.c
> +++ b/tools/testing/selftests/kcmp/kcmp_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 4eaba83cdcf3..5369959e9fc2 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> -#define _GNU_SOURCE
> -
>  #include "arch_timer.h"
>  #include "delay.h"
>  #include "gic.h"
> diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> index 5972905275cf..79e99f47a9fe 100644
> --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> @@ -7,7 +7,6 @@
>   * hugetlbfs with a hole). It checks that the expected handling method is
>   * called (e.g., uffd faults with the right address and write/read flag).
>   */
> -#define _GNU_SOURCE
>  #include <linux/bitmap.h>
>  #include <fcntl.h>
>  #include <test_util.h>
> diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
> index 9b004905d1d3..1c8c6f0c1ca3 100644
> --- a/tools/testing/selftests/kvm/aarch64/psci_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
> @@ -10,9 +10,6 @@
>   *  - A test for KVM's handling of PSCI SYSTEM_SUSPEND and the associated
>   *    KVM_SYSTEM_EVENT_SUSPEND UAPI.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <linux/psci.h>
>  
>  #include "kvm_util.h"
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> index ca917c71ff60..b3b5fb0ff0a9 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2020, Red Hat, Inc.
>   */
> -#define _GNU_SOURCE
>  #include <linux/kernel.h>
>  #include <sys/syscall.h>
>  #include <asm/kvm.h>
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
> index ae1f1a6d8312..fcebd8d81ce4 100644
> --- a/tools/testing/selftests/kvm/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -19,9 +19,6 @@
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <pthread.h>
>  #include <linux/sizes.h>
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index bf3609f71854..0c4d3b6afbf8 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -6,9 +6,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2019, Google, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for pipe2 */
> -
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index eaad5b20854c..bf1ebc29f22a 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -4,9 +4,6 @@
>   *
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index 92eae206baa6..309fe84b84ad 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Author: Chao Peng <chao.p.peng@linux.intel.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> index decc521fc760..bce73bcb973c 100644
> --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -4,9 +4,6 @@
>   * kvm_arch_hardware_disable is called and it attempts to unregister the user
>   * return notifiers.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <fcntl.h>
>  #include <pthread.h>
>  #include <semaphore.h>
> diff --git a/tools/testing/selftests/kvm/include/userfaultfd_util.h b/tools/testing/selftests/kvm/include/userfaultfd_util.h
> index 877449c34592..a9d97c213584 100644
> --- a/tools/testing/selftests/kvm/include/userfaultfd_util.h
> +++ b/tools/testing/selftests/kvm/include/userfaultfd_util.h
> @@ -5,9 +5,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2019-2022 Google LLC
>   */
> -
> -#define _GNU_SOURCE /* for pipe2 */
> -
>  #include <inttypes.h>
>  #include <time.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> index 698c1cfa3111..f02355c3c4c2 100644
> --- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> +++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> @@ -6,8 +6,6 @@
>   *
>   * Test the fd-based interface for KVM statistics.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index b9e23265e4b3..c78f34699f73 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -6,8 +6,6 @@
>   *
>   * Test for KVM_CAP_MAX_VCPUS and KVM_CAP_MAX_VCPU_ID.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
> index e0ba97ac1c56..7759c685086b 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -8,9 +8,6 @@
>   * page size have been pre-allocated on your system, if you are planning to
>   * use hugepages to back the guest memory for testing.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <time.h>
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
> index 2bd25b191d15..b49690658c60 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -4,9 +4,6 @@
>   *
>   * Copyright (C) 2018, Google LLC.
>   */
> -
> -#define _GNU_SOURCE /* for getline(3) and strchrnul(3)*/
> -
>  #include "test_util.h"
>  
>  #include <execinfo.h>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index b2262b5fad9e..1eaf001d0ad4 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2018, Google LLC.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/lib/memstress.c b/tools/testing/selftests/kvm/lib/memstress.c
> index cf2c73971308..555e3932e529 100644
> --- a/tools/testing/selftests/kvm/lib/memstress.c
> +++ b/tools/testing/selftests/kvm/lib/memstress.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2020, Google LLC.
>   */
> -#define _GNU_SOURCE
> -
>  #include <inttypes.h>
>  #include <linux/bitmap.h>
>  
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 5a8f8becb129..8ed0b74ae837 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2020, Google LLC.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <assert.h>
> diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> index f4eef6eb2dc2..bd07568a5240 100644
> --- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> +++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> @@ -6,9 +6,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2019-2022 Google LLC
>   */
> -
> -#define _GNU_SOURCE /* for pipe2 */
> -
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index e248d3364b9c..e83809febae1 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <stdint.h>
>  #include <stdbool.h>
>  
> diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
> index 1a6da7389bf1..0b9678858b6d 100644
> --- a/tools/testing/selftests/kvm/max_guest_memory_test.c
> +++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> index 156361966612..05fcf902e067 100644
> --- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> +++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> @@ -6,9 +6,6 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   * Copyright (C) 2020, Google, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/syscall.h>
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index 0f9cabd99fd4..4b5004ef9c6b 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -7,9 +7,6 @@
>   *
>   * Copyright (c) 2024, Intel Corporation.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include "arch_timer.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 28f97fb52044..b3536400f9ac 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
> index 626a2b8a2037..84ba79c42ab1 100644
> --- a/tools/testing/selftests/kvm/s390x/cmma_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
> @@ -7,8 +7,6 @@
>   * Authors:
>   *  Nico Boehr <nrb@linux.ibm.com>
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> index 43fb25ddc3ec..53def355ccba 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -10,8 +10,6 @@
>   *
>   * Test expected behavior of the KVM_CAP_SYNC_REGS functionality.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index bd57d991e27d..214ff84f6fdb 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <pthread.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index bae0c5026f82..e9231387c589 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2020, Red Hat, Inc.
>   */
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <time.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index eae521f050e0..8e5713e36d4b 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -6,8 +6,6 @@
>   *
>   * Tests for amx #NM exception and save/restore.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
> index 6c2e5e0ceb1f..9c21b6bccc38 100644
> --- a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
> @@ -4,9 +4,6 @@
>   *
>   * Test for KVM_CAP_EXIT_ON_EMULATION_FAILURE.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "flds_emulation.h"
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c
> index df351ae17029..10b1b0ba374e 100644
> --- a/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2023, Google LLC.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> index 5c27efbf405e..4f5881d4ef66 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
> @@ -7,8 +7,6 @@
>   * This work is licensed under the terms of the GNU GPL, version 2.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> index 4c7257ecd2a6..4f3f3a9b038b 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> @@ -4,7 +4,6 @@
>   *
>   * Tests for Enlightened VMCS, including nested guest state.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> index f1617762c22f..8206f5ef42dd 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2022, Red Hat, Inc.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <pthread.h>
>  #include <inttypes.h>
>  
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> index c9b18707edc0..b987a3d79715 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> @@ -4,7 +4,6 @@
>   *
>   * Tests for Hyper-V extensions to SVM.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> index 05b56095cf76..077cd0ec3040 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2022, Red Hat, Inc.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <asm/barrier.h>
>  #include <pthread.h>
>  #include <inttypes.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
> index 3670331adf21..3eb0313ffa39 100644
> --- a/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> index 17bbb96fc4df..e7efb2b35f8b 100644
> --- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
> @@ -5,9 +5,6 @@
>   *
>   * Copyright (C) 2022, Google LLC.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <fcntl.h>
>  #include <stdint.h>
>  #include <time.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
> index 87011965dc41..2165b1ad8b38 100644
> --- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
> @@ -9,8 +9,6 @@
>   * Verifies expected behavior of controlling guest access to
>   * MSR_PLATFORM_INFO.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 26c85815f7e9..77f14138594e 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright (C) 2023, Tencent, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <x86intrin.h>
>  
>  #include "pmu.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> index 3c85d1ae9893..5ce53b8c46e0 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
> @@ -9,9 +9,6 @@
>   * Verifies the expected behavior of allow lists and deny lists for
>   * virtual PMU events.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "kvm_util.h"
>  #include "pmu.h"
>  #include "processor.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> index e0f642d2a3c4..82a8d88b5338 100644
> --- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2022, Google LLC.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <limits.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> index 366cf18600bc..d691d86e5bc3 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2020, Red Hat, Inc.
>   */
> -#define _GNU_SOURCE /* for program_invocation_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> index 3610981d9162..c021c0795a96 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
> @@ -10,7 +10,6 @@
>   * That bug allowed a user-mode program that called the KVM_SET_SREGS
>   * ioctl to put a VCPU's local APIC into an invalid state.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
> index 416207c38a17..362be40fc00d 100644
> --- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
> @@ -5,9 +5,6 @@
>   * Test that KVM emulates instructions in response to EPT violations when
>   * allow_smaller_maxphyaddr is enabled and guest.MAXPHYADDR < host.MAXPHYADDR.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
> -
>  #include "flds_emulation.h"
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
> index e18b86666e1f..55c88d664a94 100644
> --- a/tools/testing/selftests/kvm/x86_64/smm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
> @@ -4,7 +4,6 @@
>   *
>   * Tests for SMM.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
> index 88b58aab7207..1c756db329e5 100644
> --- a/tools/testing/selftests/kvm/x86_64/state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/state_test.c
> @@ -6,7 +6,6 @@
>   *
>   * Tests for vCPU state save/restore, including nested guest state.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> index adb5593daf48..8fa3948b0170 100644
> --- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
> @@ -8,8 +8,6 @@
>   * including requesting an invalid register set, updates to/from values
>   * in kvm_run.s.regs when kvm_valid_regs and kvm_dirty_regs are toggled.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> index dcbb3c29fb8e..abe71946941f 100644
> --- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
> @@ -17,8 +17,6 @@
>   * delivered into the guest or not.
>   *
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <pthread.h>
>  #include <inttypes.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> index f4f61a2d2464..53afbea4df88 100644
> --- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Tests for exiting into userspace on registered MSRs
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include "kvm_test_harness.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> index 977948fd52e6..fa512d033205 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> @@ -4,9 +4,6 @@
>   *
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_name */
> -
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <linux/bitmap.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> index ea0cb3cae0f7..3b93f262b797 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
> @@ -10,7 +10,6 @@
>   * and check it can be retrieved with KVM_GET_MSR, also test
>   * the invalid LBR formats are rejected.
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include <linux/bitmap.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> index affc32800158..00dd2ac07a61 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> @@ -9,7 +9,6 @@
>   * value instead of partially decayed timer value
>   *
>   */
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
> index 725c206ba0b9..c78e5f755116 100644
> --- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
> @@ -19,8 +19,6 @@
>   * Migration is a command line option. When used on non-numa machines will 
>   * exit with error. Test is still usefull on non-numa for testing IPIs.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <getopt.h>
>  #include <pthread.h>
>  #include <inttypes.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> index ab75b873a4ad..69849acd95b0 100644
> --- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
> index 167c97abff1b..f331a4e9bae3 100644
> --- a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Tests for the IA32_XSS MSR.
>   */
> -
> -#define _GNU_SOURCE /* for program_invocation_short_name */
>  #include <sys/ioctl.h>
>  
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index a6f89aaea77d..bdb3955a9452 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -5,8 +5,6 @@
>   * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
>   * Copyright © 2019-2020 ANSSI
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 9a6036fbf289..acec1c82c8b4 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -6,8 +6,6 @@
>   * Copyright © 2020 ANSSI
>   * Copyright © 2020-2022 Microsoft Corporation
>   */
> -
> -#define _GNU_SOURCE
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index f21cfbbc3638..eed040adcbac 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -5,8 +5,6 @@
>   * Copyright © 2022-2023 Huawei Tech. Co., Ltd.
>   * Copyright © 2023 Microsoft Corporation
>   */
> -
> -#define _GNU_SOURCE
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index a19db4d0b3bd..c831e6d03b02 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -5,8 +5,6 @@
>   * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
>   * Copyright © 2019-2020 ANSSI
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/landlock.h>
> diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
> index 9ad258912646..1b18aac570f1 100644
> --- a/tools/testing/selftests/lsm/common.c
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright © 2023 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <fcntl.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> index df215e4aa63f..7465bde3f922 100644
> --- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <fcntl.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> index 06d24d4679a6..a6b44e25c21f 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <string.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> index 66dec47e3ca3..110c6a07e74c 100644
> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> @@ -5,8 +5,6 @@
>   *
>   * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <linux/lsm.h>
>  #include <string.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
> index af89855adb7b..a8a60b6271a5 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
> +++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
> @@ -1,5 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#define _GNU_SOURCE
>  #include <linux/membarrier.h>
>  #include <syscall.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
> index a9cc17facfb3..b4651e2ade00 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <linux/membarrier.h>
>  #include <syscall.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
> index 4cdc8b1d124c..17ae5199b916 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <linux/membarrier.h>
>  #include <syscall.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
> index 8eb3d75f6e60..879d4f4c66fa 100644
> --- a/tools/testing/selftests/memfd/common.c
> +++ b/tools/testing/selftests/memfd/common.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #define __EXPORTED_HEADERS__
>  
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
> index 93798c8c5d54..15bc189bf831 100644
> --- a/tools/testing/selftests/memfd/fuse_test.c
> +++ b/tools/testing/selftests/memfd/fuse_test.c
> @@ -12,8 +12,6 @@
>   * the read() syscall with our memory-mapped memfd object as receive buffer to
>   * force the kernel to write into our memfd object.
>   */
> -
> -#define _GNU_SOURCE
>  #define __EXPORTED_HEADERS__
>  
>  #include <errno.h>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 18f585684e20..5172c27a8748 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #define __EXPORTED_HEADERS__
>  
>  #include <errno.h>
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 363bf5f801be..6f1a36d51f19 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -6,7 +6,6 @@
>   *
>   * Author(s): David Hildenbrand <david@redhat.com>
>   */
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index ad168d35b23b..3bfd5a630081 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -6,7 +6,6 @@
>   *
>   * Author(s): David Hildenbrand <david@redhat.com>
>   */
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/mm/hugepage-mmap.c b/tools/testing/selftests/mm/hugepage-mmap.c
> index 267eea2e0e0b..edb46888222f 100644
> --- a/tools/testing/selftests/mm/hugepage-mmap.c
> +++ b/tools/testing/selftests/mm/hugepage-mmap.c
> @@ -16,7 +16,6 @@
>   * range.
>   * Other architectures, such as ppc64, i386 or x86_64 are not so constrained.
>   */
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
> index c463d1c09c9b..8e22822bb754 100644
> --- a/tools/testing/selftests/mm/hugepage-mremap.c
> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> @@ -11,8 +11,6 @@
>   * To make sure the test triggers pmd sharing and goes through the 'unshare'
>   * path in the mremap code use 1GB (1024) or more.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index e74107185324..70c40c67bc5d 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -11,8 +11,6 @@
>   * filesystem.  Therefore, a hugetlbfs filesystem must be mounted on some
>   * directory.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> index ba6cc6f9cabc..6b8b41b4f754 100644
> --- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 829320a519e7..d18bf400dae6 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -1,4 +1,3 @@
> -#define _GNU_SOURCE
>  #include <ctype.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index d615767e396b..1deae905c42e 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -6,7 +6,6 @@
>   *
>   * Author(s): David Hildenbrand <david@redhat.com>
>   */
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index 17bcb07f19f3..d19ad13ffd7e 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -6,7 +6,6 @@
>   *
>   * Author(s): David Hildenbrand <david@redhat.com>
>   */
> -#define _GNU_SOURCE
>  #include <stdlib.h>
>  #include <string.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
> index 5c8a53869b1b..ff4d4079bd0e 100644
> --- a/tools/testing/selftests/mm/map_populate.c
> +++ b/tools/testing/selftests/mm/map_populate.c
> @@ -4,8 +4,6 @@
>   *
>   * MAP_POPULATE | MAP_PRIVATE should COW VMA pages.
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <sys/mman.h>
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index 1e01d3ddc11c..200bedcdc32e 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -7,7 +7,6 @@
>  #include <linux/mman.h>
>  #include <linux/prctl.h>
>  
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/auxv.h>
> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> index 9b298f6a04b3..750adede2816 100644
> --- a/tools/testing/selftests/mm/memfd_secret.c
> +++ b/tools/testing/selftests/mm/memfd_secret.c
> @@ -4,8 +4,6 @@
>   *
>   * Author: Mike Rapoport <rppt@linux.ibm.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <sys/uio.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> index 26f744188ad0..42574290d728 100644
> --- a/tools/testing/selftests/mm/mlock2-tests.c
> +++ b/tools/testing/selftests/mm/mlock2-tests.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <sys/mman.h>
>  #include <stdint.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
> index 100370a7111d..d78bf686e99f 100644
> --- a/tools/testing/selftests/mm/mrelease_test.c
> +++ b/tools/testing/selftests/mm/mrelease_test.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright 2022 Google LLC
>   */
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
> index 1d75084b9ca5..934fa6b441b2 100644
> --- a/tools/testing/selftests/mm/mremap_dontunmap.c
> +++ b/tools/testing/selftests/mm/mremap_dontunmap.c
> @@ -5,7 +5,6 @@
>   *
>   * Copyright 2020, Brian Geffon <bgeffon@google.com>
>   */
> -#define _GNU_SOURCE
>  #include <sys/mman.h>
>  #include <linux/mman.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index 2f8b991f78cb..e057154630e0 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -2,8 +2,6 @@
>  /*
>   * Copyright 2020 Google LLC
>   */
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index d59517ed3d48..2a18b5d276f0 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
> index 1af3156a9db8..37d6b01ce90a 100644
> --- a/tools/testing/selftests/mm/pkey-helpers.h
> +++ b/tools/testing/selftests/mm/pkey-helpers.h
> @@ -1,7 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _PKEYS_HELPER_H
>  #define _PKEYS_HELPER_H
> -#define _GNU_SOURCE
>  #include <string.h>
>  #include <stdarg.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
> index 48dc151f8fca..9f7de92caeda 100644
> --- a/tools/testing/selftests/mm/protection_keys.c
> +++ b/tools/testing/selftests/mm/protection_keys.c
> @@ -21,7 +21,6 @@
>   *	gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
>   *	gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
>   */
> -#define _GNU_SOURCE
>  #define __SANE_USERSPACE_TYPES__
>  #include <errno.h>
>  #include <linux/elf.h>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index d3c7f5fb3e7b..ae6ac950d7a1 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -3,8 +3,6 @@
>   * A test of splitting PMD THPs and PTE-mapped THPs from a specified virtual
>   * address range in a process via <debugfs>/split_huge_pages interface.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index ea7fd8fe2876..28a5c31bd791 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -12,8 +12,6 @@
>     ipcrm -m by hand, like this
>     sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
>     (warning this will remove all if someone else uses them) */
> -
> -#define _GNU_SOURCE 1
>  #include <sys/mman.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index cc5629c3d2aa..abb44319264a 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -7,7 +7,6 @@
>  #ifndef __UFFD_COMMON_H__
>  #define __UFFD_COMMON_H__
>  
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index c6a8c732b802..d894417134b6 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <sched.h>
>  #include <stdio.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> index bcf51d785a37..bd975670f61d 100644
> --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <sched.h>
>  #include <stdio.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
> index 79a3dd75590e..279d0c5f70d3 100644
> --- a/tools/testing/selftests/net/af_unix/diag_uid.c
> +++ b/tools/testing/selftests/net/af_unix/diag_uid.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright Amazon.com Inc. or its affiliates. */
> -
> -#define _GNU_SOURCE
>  #include <sched.h>
>  
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> index 7e534594167e..2986b8cd0418 100644
> --- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
> +++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
> -#define _GNU_SOURCE
>  #include <error.h>
>  #include <limits.h>
>  #include <stddef.h>
> diff --git a/tools/testing/selftests/net/af_unix/unix_connect.c b/tools/testing/selftests/net/af_unix/unix_connect.c
> index d799fd8f5c7c..34e816862cc7 100644
> --- a/tools/testing/selftests/net/af_unix/unix_connect.c
> +++ b/tools/testing/selftests/net/af_unix/unix_connect.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <sched.h>
>  
>  #include <stddef.h>
> diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
> index 90eb06fefa59..8262aa862331 100644
> --- a/tools/testing/selftests/net/csum.c
> +++ b/tools/testing/selftests/net/csum.c
> @@ -58,9 +58,6 @@
>   * different seed for each run (and logs this for reproducibility). It
>   * is advised to enable this for extra coverage in continuous testing.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <asm/byteorder.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 353e1e867fbb..f5d7032e6466 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -34,9 +34,6 @@
>   * flakiness is to be expected.
>   *
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/ip_defrag.c b/tools/testing/selftests/net/ip_defrag.c
> index f9ed749fd8c7..80c9e567a3d8 100644
> --- a/tools/testing/selftests/net/ip_defrag.c
> +++ b/tools/testing/selftests/net/ip_defrag.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
> index be4a30a0d02a..04aa06d26b09 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -3,9 +3,6 @@
>   * ipsec.c - Check xfrm on veth inside a net-ns.
>   * Copyright (c) 2018 Dmitry Safonov
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <asm/types.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/ipv6_flowlabel.c b/tools/testing/selftests/net/ipv6_flowlabel.c
> index 708a9822259d..b7e0c3c02e20 100644
> --- a/tools/testing/selftests/net/ipv6_flowlabel.c
> +++ b/tools/testing/selftests/net/ipv6_flowlabel.c
> @@ -1,8 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Test IPV6_FLOWINFO cmsg on send and recv */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <asm/byteorder.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
> index af95b48acea9..ebd219ba386e 100644
> --- a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
> +++ b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
> @@ -1,8 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Test IPV6_FLOWINFO_MGR */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <error.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index d2043ec3bf6d..ea93030ed3ec 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <limits.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
> index 218aac467321..c5bf873d76c2 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <assert.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index 926b0be87c99..7203ca9900e9 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <assert.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index bdc03a2097e8..9278bf585c80 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c
> @@ -24,9 +24,6 @@
>   * the kernel queues completions on the error queue for all zerocopy
>   * transfers.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <error.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
> index cd8a58097448..88e1d3b2ddf1 100644
> --- a/tools/testing/selftests/net/nettest.c
> +++ b/tools/testing/selftests/net/nettest.c
> @@ -3,8 +3,6 @@
>   *
>   * Copyright (c) 2013-2019 David Ahern <dsahern@gmail.com>. All rights reserved.
>   */
> -
> -#define _GNU_SOURCE
>  #include <features.h>
>  #include <sys/types.h>
>  #include <sys/ioctl.h>
> diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
> index 1a736f700be4..5b2d34440ae9 100644
> --- a/tools/testing/selftests/net/psock_fanout.c
> +++ b/tools/testing/selftests/net/psock_fanout.c
> @@ -26,9 +26,6 @@
>   * Todo:
>   * - functionality: PACKET_FANOUT_FLAG_DEFRAG
>   */
> -
> -#define _GNU_SOURCE		/* for sched_setaffinity */
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
> index edf1e6f80d41..2f29b513e18f 100644
> --- a/tools/testing/selftests/net/psock_snd.c
> +++ b/tools/testing/selftests/net/psock_snd.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/reuseport_addr_any.c b/tools/testing/selftests/net/reuseport_addr_any.c
> index b8475cb29be7..9ee6ece52865 100644
> --- a/tools/testing/selftests/net/reuseport_addr_any.c
> +++ b/tools/testing/selftests/net/reuseport_addr_any.c
> @@ -3,9 +3,6 @@
>  /* Test that sockets listening on a specific address are preferred
>   * over sockets listening on addr_any.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/reuseport_bpf_cpu.c b/tools/testing/selftests/net/reuseport_bpf_cpu.c
> index 2d646174729f..e93e38cfb2a8 100644
> --- a/tools/testing/selftests/net/reuseport_bpf_cpu.c
> +++ b/tools/testing/selftests/net/reuseport_bpf_cpu.c
> @@ -11,9 +11,6 @@
>   * This entire process is done for several different core id permutations
>   * and for each IPv4/IPv6 and TCP/UDP combination.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
> index c9ba36aa688e..502fdb9ce770 100644
> --- a/tools/testing/selftests/net/reuseport_bpf_numa.c
> +++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
> @@ -3,9 +3,6 @@
>   * Test functionality of BPF filters with SO_REUSEPORT. Same test as
>   * in reuseport_bpf_cpu, only as one socket per NUMA node.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/reuseport_dualstack.c b/tools/testing/selftests/net/reuseport_dualstack.c
> index fb7a59ed759e..d3c3d3f39f8f 100644
> --- a/tools/testing/selftests/net/reuseport_dualstack.c
> +++ b/tools/testing/selftests/net/reuseport_dualstack.c
> @@ -10,9 +10,6 @@
>   * This test creates these mixed AF_INET/AF_INET6 sockets and asserts the
>   * AF_INET preference for v4 packets.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/so_incoming_cpu.c b/tools/testing/selftests/net/so_incoming_cpu.c
> index e9fa14e10732..95bd0cdc3253 100644
> --- a/tools/testing/selftests/net/so_incoming_cpu.c
> +++ b/tools/testing/selftests/net/so_incoming_cpu.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright Amazon.com Inc. or its affiliates. */
> -#define _GNU_SOURCE
>  #include <sched.h>
>  
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/net/so_netns_cookie.c b/tools/testing/selftests/net/so_netns_cookie.c
> index b39e87e967cd..18532d564f79 100644
> --- a/tools/testing/selftests/net/so_netns_cookie.c
> +++ b/tools/testing/selftests/net/so_netns_cookie.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <sched.h>
>  #include <unistd.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
> index 8457b7ccbc09..011a24af9786 100644
> --- a/tools/testing/selftests/net/so_txtime.c
> +++ b/tools/testing/selftests/net/so_txtime.c
> @@ -9,9 +9,6 @@
>   * the expected stream. Sender will read transmit timestamps from the error
>   * queue. The streams can differ due to out-of-order delivery and drops.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <error.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
> index 247c3b3ac1c9..fa78b92d9740 100644
> --- a/tools/testing/selftests/net/tap.c
> +++ b/tools/testing/selftests/net/tap.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.c b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
> index c1cb0c75156a..d30f89bb944c 100644
> --- a/tools/testing/selftests/net/tcp_fastopen_backup_key.c
> +++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
> @@ -12,7 +12,6 @@
>   * there are no cases in which a cookie is not accepted by verifying
>   * that TcpExtTCPFastOpenPassiveFail remains 0.
>   */
> -#define _GNU_SOURCE
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/tcp_inq.c b/tools/testing/selftests/net/tcp_inq.c
> index bd6a9c7a3e8a..71ee145f151e 100644
> --- a/tools/testing/selftests/net/tcp_inq.c
> +++ b/tools/testing/selftests/net/tcp_inq.c
> @@ -5,8 +5,6 @@
>   *
>   * Simple example on how to use TCP_INQ and TCP_CM_INQ.
>   */
> -#define _GNU_SOURCE
> -
>  #include <error.h>
>  #include <netinet/in.h>
>  #include <netinet/tcp.h>
> diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
> index 4fcce5150850..72d5f1207ee0 100644
> --- a/tools/testing/selftests/net/tcp_mmap.c
> +++ b/tools/testing/selftests/net/tcp_mmap.c
> @@ -46,7 +46,6 @@
>   * received 32768 MB (99.9939 % mmap'ed) in 7.43764 s, 36.9577 Gbit
>   *   cpu usage user:0.035 sys:3.467, 106.873 usec per MB, 65530 c-switches
>   */
> -#define _GNU_SOURCE
>  #include <pthread.h>
>  #include <sys/types.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index f27a12d2a2c9..6dbad97d1d0a 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
> index 9ba03164d73a..e2d739892ce4 100644
> --- a/tools/testing/selftests/net/toeplitz.c
> +++ b/tools/testing/selftests/net/toeplitz.c
> @@ -20,9 +20,6 @@
>   * 5. Compute the cpu that RPS should select based on rx_hash and $rps_bitmap
>   * 6. Compare the cpus from 4 and 5
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index fa83918b62d1..a64dcfb242c1 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/net/txring_overwrite.c b/tools/testing/selftests/net/txring_overwrite.c
> index 7d9ea039450a..96972e0110a0 100644
> --- a/tools/testing/selftests/net/txring_overwrite.c
> +++ b/tools/testing/selftests/net/txring_overwrite.c
> @@ -4,9 +4,6 @@
>   * Verify that consecutive sends over packet tx_ring are mirrored
>   * with their original content intact.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <assert.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index ec60a16c9307..33dba9e90dea 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -16,9 +16,6 @@
>   * This test requires a dummy TCP server.
>   * A simple `nc6 [-u] -l -p $DESTPORT` will do
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <asm/types.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
> index 85b3baa3f7f3..9dc1026a033a 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <stddef.h>
>  #include <arpa/inet.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
> index 1cbadd267c96..999df1236320 100644
> --- a/tools/testing/selftests/net/udpgso_bench_rx.c
> +++ b/tools/testing/selftests/net/udpgso_bench_rx.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <error.h>
>  #include <errno.h>
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> index 477392715a9a..d7632993b354 100644
> --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> @@ -1,7 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
> -
>  #include <arpa/inet.h>
>  #include <errno.h>
>  #include <error.h>
> diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
> index 5814611a1dc7..ef4d923f4759 100644
> --- a/tools/testing/selftests/perf_events/remove_on_exec.c
> +++ b/tools/testing/selftests/perf_events/remove_on_exec.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2021, Google LLC.
>   */
>  
> -#define _GNU_SOURCE
> -
>  /* We need the latest siginfo from the kernel repo. */
>  #include <sys/types.h>
>  #include <asm/siginfo.h>
> diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
> index d1d8483ac628..14d1a3c8cb5c 100644
> --- a/tools/testing/selftests/perf_events/sigtrap_threads.c
> +++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
> @@ -5,8 +5,6 @@
>   * Copyright (C) 2021, Google LLC.
>   */
>  
> -#define _GNU_SOURCE
> -
>  /* We need the latest siginfo from the kernel repo. */
>  #include <sys/types.h>
>  #include <asm/siginfo.h>
> diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
> index 7d84097ad45c..54dc8f16d92a 100644
> --- a/tools/testing/selftests/pid_namespace/regression_enomem.c
> +++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
> @@ -1,4 +1,3 @@
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 88d6830ee004..e33177b1aa41 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -3,7 +3,6 @@
>  #ifndef __PIDFD_H
>  #define __PIDFD_H
>  
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> index 01cc37bf611c..67c9dc436c71 100644
> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <errno.h>
>  #include <fcntl.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> index cd51d547b751..b6a0e9b3d2f5 100644
> --- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
> index 8a59438ccc78..781a3931fb5a 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <inttypes.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> index 610811275357..a40fb27a78bb 100644
> --- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <linux/types.h>
>  #include <poll.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> index 6e2f2cd400ca..49d7a78cc4fe 100644
> --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index c081ae91313a..c3d52406b8fd 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -1,6 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/types.h>
> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
> index 0dcb8365ddc3..54beba0983f1 100644
> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
> @@ -1,6 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <linux/sched.h>
>  #include <linux/types.h>
> diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
> index 5297b10d25c3..054a78ebe8b5 100644
> --- a/tools/testing/selftests/ptrace/get_set_sud.c
> +++ b/tools/testing/selftests/ptrace/get_set_sud.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include "../kselftest_harness.h"
>  #include <stdio.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/ptrace/peeksiginfo.c b/tools/testing/selftests/ptrace/peeksiginfo.c
> index a6884f66dc01..1b7b77190f72 100644
> --- a/tools/testing/selftests/ptrace/peeksiginfo.c
> +++ b/tools/testing/selftests/ptrace/peeksiginfo.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <signal.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> index 2348d2c20d0a..5961c24ee1ae 100644
> --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: LGPL-2.1
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <pthread.h>
>  #include <sched.h>
> diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
> index 295eea16466f..1fed749b4bd7 100644
> --- a/tools/testing/selftests/rseq/basic_test.c
> +++ b/tools/testing/selftests/rseq/basic_test.c
> @@ -2,8 +2,6 @@
>  /*
>   * Basic test coverage for critical regions and rseq_current_cpu().
>   */
> -
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <sched.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
> index 2f37961240ca..48a55d94eb72 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: LGPL-2.1
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <linux/membarrier.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 96e812bdf8a4..88602889414c 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -14,8 +14,6 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>   * Lesser General Public License for more details.
>   */
> -
> -#define _GNU_SOURCE
>  #include <errno.h>
>  #include <sched.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> index b83099160fbc..3632a4890da9 100644
> --- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
> +++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> @@ -2,7 +2,6 @@
>   * Strictly speaking, this is not a test. But it can report during test
>   * runs so relative performace can be measured.
>   */
> -#define _GNU_SOURCE
>  #include <assert.h>
>  #include <err.h>
>  #include <limits.h>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 783ebce8c4de..972ccc12553e 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4,8 +4,6 @@
>   *
>   * Test code for seccomp bpf.
>   */
> -
> -#define _GNU_SOURCE
>  #include <sys/types.h>
>  
>  /*
> diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
> index 7288a05136ba..a1f156dbbd56 100644
> --- a/tools/testing/selftests/user_events/abi_test.c
> +++ b/tools/testing/selftests/user_events/abi_test.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
>   */
> -
> -#define _GNU_SOURCE
>  #include <sched.h>
>  
>  #include <errno.h>
> diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
> index d884fd69dd51..9441635fc452 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> -#define _GNU_SOURCE
>  #include <err.h>
>  #include <errno.h>
>  #include <pthread.h>
> diff --git a/tools/testing/selftests/x86/check_initial_reg_state.c b/tools/testing/selftests/x86/check_initial_reg_state.c
> index 3bc95f3ed585..0129cdae8abe 100644
> --- a/tools/testing/selftests/x86/check_initial_reg_state.c
> +++ b/tools/testing/selftests/x86/check_initial_reg_state.c
> @@ -3,9 +3,6 @@
>   * check_initial_reg_state.c - check that execve sets the correct state
>   * Copyright (c) 2014-2016 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  
>  unsigned long ax, bx, cx, dx, si, di, bp, sp, flags;
> diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
> index cf9ce8fbb656..d2c746149678 100644
> --- a/tools/testing/selftests/x86/corrupt_xstate_header.c
> +++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
> @@ -4,9 +4,6 @@
>   *
>   * Based on analysis and a test case from Thomas Gleixner.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
> index d1e919b0c1dc..9fa9d4a847ac 100644
> --- a/tools/testing/selftests/x86/entry_from_vm86.c
> +++ b/tools/testing/selftests/x86/entry_from_vm86.c
> @@ -5,9 +5,6 @@
>   *
>   * This exercises a few paths that need to special-case vm86 mode.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <assert.h>
>  #include <stdlib.h>
>  #include <sys/syscall.h>
> diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
> index 8c780cce941d..348134d2cefc 100644
> --- a/tools/testing/selftests/x86/fsgsbase.c
> +++ b/tools/testing/selftests/x86/fsgsbase.c
> @@ -3,8 +3,6 @@
>   * fsgsbase.c, an fsgsbase test
>   * Copyright (c) 2014-2016 Andy Lutomirski
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
> index 6fffadc51579..88dce47ab8e6 100644
> --- a/tools/testing/selftests/x86/fsgsbase_restore.c
> +++ b/tools/testing/selftests/x86/fsgsbase_restore.c
> @@ -12,8 +12,6 @@
>   *
>   * This is not part of fsgsbase.c, because that test is 64-bit only.
>   */
> -
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
> index 57ec5e99edb9..07b7c10f8d39 100644
> --- a/tools/testing/selftests/x86/ioperm.c
> +++ b/tools/testing/selftests/x86/ioperm.c
> @@ -3,8 +3,6 @@
>   * ioperm.c - Test case for ioperm(2)
>   * Copyright (c) 2015 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
>  #include <err.h>
>  #include <stdio.h>
>  #include <stdint.h>
> diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
> index 7e3e09c1abac..baa691154905 100644
> --- a/tools/testing/selftests/x86/iopl.c
> +++ b/tools/testing/selftests/x86/iopl.c
> @@ -3,8 +3,6 @@
>   * iopl.c - Test case for a Linux on Xen 64-bit bug
>   * Copyright (c) 2015 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
>  #include <err.h>
>  #include <stdio.h>
>  #include <stdint.h>
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index 215b8150b7cc..39edfd7f6037 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
> index 3a29346e1452..3b4237a85a12 100644
> --- a/tools/testing/selftests/x86/ldt_gdt.c
> +++ b/tools/testing/selftests/x86/ldt_gdt.c
> @@ -3,8 +3,6 @@
>   * ldt_gdt.c - Test cases for LDT and GDT access
>   * Copyright (c) 2015 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
>  #include <err.h>
>  #include <stdio.h>
>  #include <stdint.h>
> diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
> index cc3de6ff9fba..47ecc63220b7 100644
> --- a/tools/testing/selftests/x86/mov_ss_trap.c
> +++ b/tools/testing/selftests/x86/mov_ss_trap.c
> @@ -19,8 +19,6 @@
>   *
>   * This should mostly cover CVE-2018-1087 and CVE-2018-8897.
>   */
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <sys/ptrace.h>
>  #include <sys/types.h>
> diff --git a/tools/testing/selftests/x86/nx_stack.c b/tools/testing/selftests/x86/nx_stack.c
> index ea4a4e246879..97c5b34096cc 100644
> --- a/tools/testing/selftests/x86/nx_stack.c
> +++ b/tools/testing/selftests/x86/nx_stack.c
> @@ -23,8 +23,6 @@
>   * Regular stack is completely overwritten before testing.
>   * Test doesn't exit SIGSEGV handler after first fault at INT3.
>   */
> -#undef _GNU_SOURCE
> -#define _GNU_SOURCE
>  #undef NDEBUG
>  #include <assert.h>
>  #include <signal.h>
> diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
> index 12aaa063196e..bdc81c8bd1a7 100644
> --- a/tools/testing/selftests/x86/ptrace_syscall.c
> +++ b/tools/testing/selftests/x86/ptrace_syscall.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -
>  #include <sys/ptrace.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
> index f689af75e979..7f41c3a4268b 100644
> --- a/tools/testing/selftests/x86/sigaltstack.c
> +++ b/tools/testing/selftests/x86/sigaltstack.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -
> -#define _GNU_SOURCE
>  #include <signal.h>
>  #include <stdio.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
> index 5d7961a5f7f6..2054f729b2c2 100644
> --- a/tools/testing/selftests/x86/sigreturn.c
> +++ b/tools/testing/selftests/x86/sigreturn.c
> @@ -24,9 +24,6 @@
>   *
>   * Do not run on outdated, unpatched kernels at risk of nasty crashes.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <sys/time.h>
>  #include <time.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
> index 9a30f443e928..375f3b50a0b5 100644
> --- a/tools/testing/selftests/x86/single_step_syscall.c
> +++ b/tools/testing/selftests/x86/single_step_syscall.c
> @@ -9,9 +9,6 @@
>   * immediately issues #DB from CPL 0.  This requires special handling in
>   * the kernel.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <sys/time.h>
>  #include <time.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
> index 461fa41a4d02..10eee1bcd015 100644
> --- a/tools/testing/selftests/x86/syscall_arg_fault.c
> +++ b/tools/testing/selftests/x86/syscall_arg_fault.c
> @@ -3,9 +3,6 @@
>   * syscall_arg_fault.c - tests faults 32-bit fast syscall stack args
>   * Copyright (c) 2015 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
> index 991591718bb0..c72fc8aaa4d3 100644
> --- a/tools/testing/selftests/x86/syscall_numbering.c
> +++ b/tools/testing/selftests/x86/syscall_numbering.c
> @@ -5,9 +5,6 @@
>   *
>   * Copyright (c) 2018 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <stdbool.h>
> diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
> index 84d74be1d902..24bc219358a5 100644
> --- a/tools/testing/selftests/x86/sysret_rip.c
> +++ b/tools/testing/selftests/x86/sysret_rip.c
> @@ -3,9 +3,6 @@
>   * sigreturn.c - tests that x86 avoids Intel SYSRET pitfalls
>   * Copyright (c) 2014-2016 Andrew Lutomirski
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/x86/sysret_ss_attrs.c b/tools/testing/selftests/x86/sysret_ss_attrs.c
> index 5f3d4fca440f..f8b9e0b2a0c5 100644
> --- a/tools/testing/selftests/x86/sysret_ss_attrs.c
> +++ b/tools/testing/selftests/x86/sysret_ss_attrs.c
> @@ -7,9 +7,6 @@
>   * the hidden attributes set to an unusable state.  Make sure the kernel
>   * doesn't let this happen.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <stdio.h>
> diff --git a/tools/testing/selftests/x86/test_FCMOV.c b/tools/testing/selftests/x86/test_FCMOV.c
> index 6b5036fbb735..0c9431ba7d31 100644
> --- a/tools/testing/selftests/x86/test_FCMOV.c
> +++ b/tools/testing/selftests/x86/test_FCMOV.c
> @@ -1,8 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#undef _GNU_SOURCE
> -#define _GNU_SOURCE 1
> -#undef __USE_GNU
> -#define __USE_GNU 1
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/test_FCOMI.c b/tools/testing/selftests/x86/test_FCOMI.c
> index aec6692c6dcf..ba186665918d 100644
> --- a/tools/testing/selftests/x86/test_FCOMI.c
> +++ b/tools/testing/selftests/x86/test_FCOMI.c
> @@ -1,8 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#undef _GNU_SOURCE
> -#define _GNU_SOURCE 1
> -#undef __USE_GNU
> -#define __USE_GNU 1
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
> index 09789c0ce3e9..95580cdaaa32 100644
> --- a/tools/testing/selftests/x86/test_FISTTP.c
> +++ b/tools/testing/selftests/x86/test_FISTTP.c
> @@ -1,8 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#undef _GNU_SOURCE
> -#define _GNU_SOURCE 1
> -#undef __USE_GNU
> -#define __USE_GNU 1
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
> index f0d876d48277..a8bdba356682 100644
> --- a/tools/testing/selftests/x86/test_mremap_vdso.c
> +++ b/tools/testing/selftests/x86/test_mremap_vdso.c
> @@ -9,7 +9,6 @@
>   * Can be built statically:
>   * gcc -Os -Wall -static -m32 test_mremap_vdso.c
>   */
> -#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
> index 757e6527f67e..0ceca9064cec 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c
> @@ -7,9 +7,6 @@
>   * special glibc shadow stack support (longjmp(), swapcontext(), etc). Just
>   * stick to the basics and hope the compiler doesn't do anything strange.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <sys/syscall.h>
>  #include <asm/mman.h>
>  #include <sys/mman.h>
> diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/testing/selftests/x86/test_syscall_vdso.c
> index 8965c311bd65..5cd13279bba5 100644
> --- a/tools/testing/selftests/x86/test_syscall_vdso.c
> +++ b/tools/testing/selftests/x86/test_syscall_vdso.c
> @@ -8,10 +8,6 @@
>   * Can be built statically:
>   * gcc -Os -Wall -static -m32 test_syscall_vdso.c thunks_32.S
>   */
> -#undef _GNU_SOURCE
> -#define _GNU_SOURCE 1
> -#undef __USE_GNU
> -#define __USE_GNU 1
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 47cab972807c..cbf4e5012005 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -
> -#define _GNU_SOURCE
> -
>  #include <stdio.h>
>  #include <sys/time.h>
>  #include <time.h>
> diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
> index 4c311e1af4c7..754f5d4d425a 100644
> --- a/tools/testing/selftests/x86/unwind_vdso.c
> +++ b/tools/testing/selftests/x86/unwind_vdso.c
> @@ -5,9 +5,6 @@
>   *
>   * This tests __kernel_vsyscall's unwind info.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <features.h>
>  #include <stdio.h>
>  
> diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
> index fe99f2434155..8193de22a390 100644
> --- a/tools/testing/selftests/x86/vdso_restorer.c
> +++ b/tools/testing/selftests/x86/vdso_restorer.c
> @@ -10,9 +10,6 @@
>   * 64-bit userspace has never supported sa_restorer == NULL, so this is
>   * 32-bit only.
>   */
> -
> -#define _GNU_SOURCE
> -
>  #include <err.h>
>  #include <stdio.h>
>  #include <dlfcn.h>

-- 
BR,
Muhammad Usama Anjum

