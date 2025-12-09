Return-Path: <linux-fsdevel+bounces-71022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4ECB0B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 18:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBDD30F19E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B980832E68D;
	Tue,  9 Dec 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Psg4CKLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395032ABC3;
	Tue,  9 Dec 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300912; cv=none; b=eVrYze2QhhtAHKpC6wYBP2QKwLLw2/PaiSmlfWg1UoF1QPNXFo3bxFiu8ZEejGHsVOfDAXEz954AOXqXccgs8XK+K4wXOSjjp24PpW5l6GMgOWqtyLPANMXjJz/T9hi47o3/UX5VeO83vcj5sSNGobJetZdqEWNmf1Z8Ti3C630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300912; c=relaxed/simple;
	bh=6JzHwVMsw3oVBaLB929QEwdcMxFilfqVMX3zcgp6eKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F98BbZstw/BUnQwJ2Q7C9Yh/xOrXxfgvLXTT1PRS8oOSrvNXgWbruTf74F7F51R6UgaI49dJ0k9c2lVi8g9+wJx5BtJs1BNqO2m8d01t+BOGr3GK1ghAKER1w7++DlPStu++Ac9lV/0RGM5fatvcTisKk9RFhne4aPPsbya21CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Psg4CKLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73601C4CEFB;
	Tue,  9 Dec 2025 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765300911;
	bh=6JzHwVMsw3oVBaLB929QEwdcMxFilfqVMX3zcgp6eKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Psg4CKLAi9h/A9vrvljHnRqp9p5yz8B5YCapKgSBCEr6kmloaOVwmNaYxp96nI0Jm
	 E1pbyJ1ln1w7L+cwykG7ZYqv4qRzAcWJFrrDoVllnAKtP9kV9HNNc0yvVFDPPFwIkZ
	 zlIrgsKzfz9N31t7zC7ENkzXvNMPaNLtaoUlwGSCq0lbSmlyoP3LMxcO1rKyc+86dE
	 NNhWUd3A/NHLJln9jL7sW0vI/gKw88UtIG56vYvOYlGCOJt2PmPeBPQ+WVB8pAbtZB
	 YUlzouJwNa/r7jfn9C9CtIGicL5PvCAPTPMpQEpILvgU65s/m796Uhb97EubDbNHcQ
	 BLbAhrtl11WCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B591F3808200;
	Tue,  9 Dec 2025 17:18:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH kvm-next V11 0/7] Add NUMA mempolicy support
 for
 KVM guest-memfd
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176530072652.4018985.15391772848132749035.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:46 +0000
References: <20250827175247.83322-2-shivankg@amd.com>
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
To: Garg@codeaurora.org, Shivank <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com, vbabka@suse.cz,
 jgowans@amazon.com, mhocko@suse.com, jack@suse.cz, kvm@vger.kernel.org,
 dhavale@google.com, linux-btrfs@vger.kernel.org, aik@amd.com,
 papaluri@amd.com, kalyazin@amazon.com, peterx@redhat.com, linux-mm@kvack.org,
 clm@fb.com, ddutile@redhat.com, linux-kselftest@vger.kernel.org,
 shdhiman@amd.com, gshan@redhat.com, ying.huang@linux.alibaba.com,
 ira.weiny@intel.com, roypat@amazon.co.uk, matthew.brost@intel.com,
 linux-coco@lists.linux.dev, zbestahu@gmail.com, lorenzo.stoakes@oracle.com,
 linux-bcachefs@vger.kernel.org, apopple@nvidia.com, jmorris@namei.org,
 hch@infradead.org, chao.gao@intel.com, cgzones@googlemail.com,
 ziy@nvidia.com, rientjes@google.com, yuzhao@google.com, xiang@kernel.org,
 nikunj@amd.com, gourry@gourry.net, serge@hallyn.com, thomas.lendacky@amd.com,
 ashish.kalra@amd.com, chao.p.peng@intel.com, yan.y.zhao@intel.com,
 byungchul@sk.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
 michael.roth@amd.com, bfoster@redhat.com, bharata@amd.com,
 josef@toxicpanda.com, Liam.Howlett@oracle.com, ackerleytng@google.com,
 dsterba@suse.com, viro@zeniv.linux.org.uk, jefflexu@linux.alibaba.com,
 jaegeuk@kernel.org, dan.j.williams@intel.com, surenb@google.com,
 tabba@google.com, paul@paul-moore.com, joshua.hahnjy@gmail.com,
 brauner@kernel.org, quic_eberman@quicinc.com, rakie.kim@sk.com,
 pvorel@suse.cz, linux-erofs@lists.ozlabs.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 pankaj.gupta@amd.com, linux-security-module@vger.kernel.org,
 lihongbo22@huawei.com, amit@infradead.org, linux-fsdevel@vger.kernel.org,
 vannapurve@google.com, suzuki.poulose@arm.com, rppt@kernel.org,
 jgg@nvidia.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Sean Christopherson <seanjc@google.com>:

On Wed, 27 Aug 2025 17:52:41 +0000 you wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1] and can be applied
> directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
> Merge branch 'guest-memfd-mmap' into HEAD)
> 
> == Background ==
> KVM's guest-memfd memory backend currently lacks support for NUMA policy
> enforcement, causing guest memory allocations to be distributed across host
> nodes  according to kernel's default behavior, irrespective of any policy
> specified by the VMM. This limitation arises because conventional userspace
> NUMA control mechanisms like mbind(2) don't work since the memory isn't
> directly mapped to userspace when allocations occur.
> Fuad's work [1] provides the necessary mmap capability, and this series
> leverages it to enable mbind(2).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,kvm-next,V11,1/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,2/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
    https://git.kernel.org/jaegeuk/f2fs/c/16a542e22339
  - [f2fs-dev,kvm-next,V11,3/7] mm/mempolicy: Export memory policy symbols
    https://git.kernel.org/jaegeuk/f2fs/c/f634f10809ec
  - [f2fs-dev,kvm-next,V11,4/7] KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,5/7] KVM: guest_memfd: Add slab-allocated inode cache
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,6/7] KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
    (no matching commit)
  - [f2fs-dev,kvm-next,V11,7/7] KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



