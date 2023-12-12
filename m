Return-Path: <linux-fsdevel+bounces-5615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113C80E338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 05:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B51C21AB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA6C2EE;
	Tue, 12 Dec 2023 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmoKe4wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322DC12B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 04:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A127C433C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 04:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702354324;
	bh=FzYJkX4QBI+ZrjVDQpXCUN0tHIAhsz+wZ/vtOd78kuU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=pmoKe4wjLbU01nfhn2ZVu07KQcFrLC7ymwl90yym7EK8DCr44cnos/BgiGnSMf3LB
	 o6reQsMS1A6BbcuHpfthwNQ5bouX/g6OoqXGaSJHwd7t+RqS0qiu9480jK6ooOw1xi
	 n+UTFiTaz1k9GbE15sPRDodCZ3bvo6PjmvHHVkc4bxGoJIF3vOYL7oyltg9KZ6vENw
	 UmHosVUtnSdgGOjgvchZveCX0RovnLcIe+aKsC5ZX6ol1qwnXl2R14Y6Bo45TtiPPe
	 kNouY0bzjpGwp4biHeW1Ig35TW1KiSPYMduoZ9WGCqUT+zm1GMCvLRjdkpcpAN26K4
	 3m2u00TkvJrsg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1eb39505ba4so3169065fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 20:12:04 -0800 (PST)
X-Gm-Message-State: AOJu0YxZH7HsN862Q7Gi9YDH8udF3gauoYzd7IRwPdHhq0/S7/PcYtda
	8DPg1XDwI6tz8oNu1ftjkEmdSzsjHgAMGI4Fsks=
X-Google-Smtp-Source: AGHT+IEzLdWG352fSSJu/YN8KKluw1bros9k0a7sSSRjScYQw0SV6MLw7zhEN7BWqQLKKsyo5wVO0phDCPqOxHTu0Xg=
X-Received: by 2002:a05:6870:9a06:b0:1fb:75b:99a9 with SMTP id
 fo6-20020a0568709a0600b001fb075b99a9mr6703323oab.88.1702354323512; Mon, 11
 Dec 2023 20:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5dc6:0:b0:507:5de0:116e with HTTP; Mon, 11 Dec 2023
 20:12:02 -0800 (PST)
In-Reply-To: <PUZPR04MB63167EF34D0B46A4D418A86C8185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63167EF34D0B46A4D418A86C8185A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 Dec 2023 13:12:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8HieJNdF7poscX0gR0_EBCVW+aACW6bBBCVXKiaORq5w@mail.gmail.com>
Message-ID: <CAKYAXd8HieJNdF7poscX0gR0_EBCVW+aACW6bBBCVXKiaORq5w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] exfat: get file size from DataLength
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>, "cpgs@samsung.com" <cpgs@samsung.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

2023-12-05 19:16 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> From the exFAT specification, the file size should get from 'DataLength'
> of Stream Extension Directory Entry, not 'ValidDataLength'.
>
> Without this patch set, 'DataLength' is always same with 'ValidDataLength'
> and get file size from 'ValidDataLength'. If the file is created by other
> exFAT implementation and 'DataLength' is different from 'ValidDataLength',
> this exFAT implementation will not be compatible.
Have you ever run xfstests against v6 version ?
The page allocation failure problem in my test happen below.
What is your test result?

[ 3029.994963] run fstests generic/476 at 2023-12-12 09:39:35
[12514.707396] perf: interrupt took too long (2501 > 2500), lowering
kernel.perf_event_max_sample_rate to 79750
[13670.913452] fsstress: page allocation failure: order:0,
mode:0x40808(GFP_NOWAIT|__GFP_COMP|__GFP_MOVABLE),
nodemask=(null),cpuset=/,mems_allowed=0
[13670.913470] CPU: 0 PID: 297913 Comm: fsstress Tainted: G
OE      6.7.0-rc4 #1
[13670.913474] Hardware name: Dell Inc. Precision Tower 3620/0MWYPT,
BIOS 2.13.1 06/14/2019
[13670.913476] Call Trace:
[13670.913482]  <TASK>
[13670.913486]  dump_stack_lvl+0x48/0x70
[13670.913492]  dump_stack+0x10/0x20
[13670.913495]  warn_alloc+0x138/0x1b0
[13670.913501]  __alloc_pages+0x116b/0x1200
[13670.913504]  ? blk_mq_sched_try_merge+0x1be/0x1d0
[13670.913511]  ? policy_nodemask+0x10f/0x150
[13670.913516]  alloc_pages_mpol+0x91/0x220
[13670.913518]  ? filemap_get_entry+0xf3/0x180
[13670.913523]  alloc_pages+0x5e/0xd0
[13670.913525]  folio_alloc+0x18/0x50
[13670.913527]  filemap_alloc_folio+0xf5/0x100
[13670.913530]  __filemap_get_folio+0x112/0x2f0
[13670.913534]  __getblk_slow+0xba/0x250
[13670.913539]  __breadahead+0x8f/0xc0
[13670.913544]  exfat_get_dentry+0x155/0x1d0 [exfat]
[13670.913553]  ? _raw_spin_lock_irqsave+0x28/0x60
[13670.913557]  exfat_find_dir_entry+0x17b/0x740 [exfat]
[13670.913566]  ? __exfat_resolve_path+0x102/0x160 [exfat]
[13670.913574]  exfat_find+0xdd/0x340 [exfat]
[13670.913580]  ? update_load_avg+0x82/0x7d0
[13670.913584]  ? update_cfs_group+0xab/0xc0
[13670.913586]  ? psi_group_change+0x237/0x4e0
[13670.913590]  ? _raw_spin_unlock+0x19/0x40
[13670.913593]  ? raw_spin_rq_unlock+0x10/0x40
[13670.913598]  ? debug_smp_processor_id+0x17/0x20
[13670.913600]  ? mod_objcg_state+0xd0/0x350
[13670.913604]  ? memcg_slab_post_alloc_hook+0x195/0x230
[13670.913609]  ? kmem_cache_alloc_lru+0x1ca/0x3e0
[13670.913611]  ? __d_alloc+0x2e/0x200
[13670.913616]  exfat_lookup+0x55/0x200 [exfat]
[13670.913622]  ? preempt_count_add+0x54/0xc0
[13670.913626]  ? d_alloc_parallel+0x318/0x470
[13670.913628]  ? generic_permission+0x38/0x220
[13670.913632]  path_openat+0x588/0x1150
[13670.913637]  do_filp_open+0xb2/0x160
[13670.913643]  ? _raw_spin_unlock+0x19/0x40
[13670.913645]  ? alloc_fd+0xa9/0x190
[13670.913649]  do_sys_openat2+0x9b/0xd0
[13670.913653]  __x64_sys_creat+0x4b/0x70
[13670.913656]  do_syscall_64+0x5c/0xe0
[13670.913659]  ? __fput+0x16c/0x2f0
[13670.913661]  ? kmem_cache_free+0x190/0x3a0
[13670.913663]  ? percpu_counter_add_batch+0x35/0xb0
[13670.913666]  ? debug_smp_processor_id+0x17/0x20
[13670.913668]  ? fpregs_assert_state_consistent+0x2a/0x50
[13670.913672]  ? exit_to_user_mode_prepare+0x49/0x1a0
[13670.913675]  ? syscall_exit_to_user_mode+0x34/0x50
[13670.913677]  ? do_syscall_64+0x6b/0xe0
[13670.913679]  ? do_syscall_64+0x6b/0xe0
[13670.913682]  ? __x64_sys_write+0x19/0x20
[13670.913684]  ? do_syscall_64+0x6b/0xe0
[13670.913686]  ? sysvec_apic_timer_interrupt+0x66/0xd0
[13670.913689]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

>
> Changes for v6:
>   - Fix build warning of printk() on 32-bit system.
>   - Fix read/write judgment in exfat_direct_IO().
>   - Remove update ei->valid_size in exfat_file_zeroed_range().
>
> Changes for v5:
>   - do not call exfat_map_new_buffer() if iblock + max_blocks < valid_blks.
>   - Reorganized the logic of exfat_get_block(), both writing and reading
> use
>     block index judgment.
>   - Remove unnecessary code moves.
>   - Reduce sync in exfat_file_write_iter()
>
> Changes for v4:
>   - Rebase for linux-6.7-rc1
>   - Use block_write_begin() instead of cont_write_begin() in
> exfat_write_begin()
>   - In exfat_cont_expand(), use ei->i_size_ondisk instead of i_size_read()
> to
>     get the number of clusters of the file.
>
> Changes for v3:
>   - Rebase to linux-6.6
>   - Move update ->valid_size from exfat_file_write_iter() to
> exfat_write_end()
>   - Use block_write_begin() instead of exfat_write_begin() in
> exfat_file_zeroed_range()
>   - Remove exfat_expand_and_zero()
>
> Changes for v2:
>   - Fix race when checking i_size on direct i/o read
>
> Yuezhang Mo (2):
>   exfat: change to get file size from DataLength
>   exfat: do not zero the extended part
>
> Yuezhang Mo (2):
>   exfat: change to get file size from DataLength
>   exfat: do not zero the extended part
>
>  fs/exfat/exfat_fs.h |   2 +
>  fs/exfat/file.c     | 193 +++++++++++++++++++++++++++++++++++++++-----
>  fs/exfat/inode.c    | 136 +++++++++++++++++++++++++++----
>  fs/exfat/namei.c    |   6 ++
>  4 files changed, 299 insertions(+), 38 deletions(-)
>
> --
> 2.25.1
>

