Return-Path: <linux-fsdevel+bounces-4710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498280296B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 01:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC901C2042E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C6B819
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="N6PZfp6/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Zb/hanz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F831D3
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 15:00:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3551D3200A5B;
	Sun,  3 Dec 2023 18:00:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Dec 2023 18:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701644445; x=1701730845; bh=s/475Q3xcJ88yisyQzsVoRK3U/OAb+/o9n9
	c6d4RqRU=; b=N6PZfp6/DZMcHHffE8C5akz8oR5UgYI70X5jZvl3TSZAP7EkV7L
	YoQAbgG4Tc9LQBXL2Do3YxLKhJg7zCjt3Zzeq5DcMBBN8i93qwiQDphvfoFv7e+S
	3kcnT2h6BeAHez8+rDyGuScMa8Pwe9jC8NWxQO6VwJ8gm96dYER6BwXDxvx+ihye
	Bnw9XLA1JgZWBHidjzMN0tOGdModTes96GDMCPx+USC5eM5SACNP4dRAjbxCDexS
	QNroDPJ5JgJiWtOkcsMAFz4qMoTFJaDRLds1JCK5iEuXraows7onvp9sSFdJmyGU
	cWQYhvtO5WKJhDu7NUDlnBwzSitau5Jw66A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701644445; x=1701730845; bh=s/475Q3xcJ88yisyQzsVoRK3U/OAb+/o9n9
	c6d4RqRU=; b=2Zb/hanzeaZOTjCy6Cfu+PsOJABiy8JQKpq9SwNHvtLfpeV0FHL
	hzvwdiZ4qlnN5TdFcsbnneyjZZyqAP6l9BjqQv21NnEemqLDIvf0l1IrgxCEXMON
	bbruCZMZliEVSM1Lf6OwjezofPYwF7uZphbexuCwbTHMZCYrF6W0zxfDCzlkWt7A
	yHSb9V+gGrD53ToDSqasv3PGnvBU3NU4l9b3o9gZGFkwGPagoY7yMGuvS88UT8pm
	e49pHHCtRItkMgAnMvoXN0pqm+UQWCi1nTeuc/xmo1vELZt0DzktWGVZkBS/2Bh6
	r8MEbLsgSDIkyOa8JfJwZAZlaa7JLnYDwzw==
X-ME-Sender: <xms:nAhtZSqZnPmb8F_4IWBN_mmu3afw1vrnD7Vk4Gc7IEFJTzmYNi-OHQ>
    <xme:nAhtZQoP9987Cnzg-SP_VkGAOEiGYVZux4-WbpUZeN2AA2F6R-2PlPsYLvkW0Re--
    X2s6SBF8ZZsYVC3>
X-ME-Received: <xmr:nAhtZXO7TNRJw8NWA8wO7WeDPkjeHgTXYAxaZSKvRb9uKm7NbPbzKlZvaxKP1YklS0wVWIStVjOspjuKHf8r71A7mbm1rQrNGmLGHexIdKQgB8FYcUQa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeev
    lefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:nAhtZR6O_CGrVTbJxcYADPlxnAvx_Tsdt8kVThYCFM3n8hzUN0J3fA>
    <xmx:nAhtZR47I6QtluUW36_saBvubnGCYRdSPZMs9y8QVN-e33nxboF6Qw>
    <xmx:nAhtZRi8q47Kf_FEa0EvLzx5Pj07GNwyjjhccRwYVvytznEmC3t3vw>
    <xmx:nQhtZeucamzbaBi6VGL4J4xFyZmqCDzD-P2XPcBlntFFd3k0gtsIiA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Dec 2023 18:00:43 -0500 (EST)
Message-ID: <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm>
Date: Mon, 4 Dec 2023 00:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Tyler Fanelli <tfanelli@redhat.com>, linux-fsdevel@vger.kernel.org,
 mszeredi@redhat.com, gmaglione@redhat.com, hreitz@redhat.com,
 Hao Xu <howeyxu@tencent.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
 <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,

On 12/3/23 12:20, Amir Goldstein wrote:
> On Sat, Dec 2, 2023 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Mon, Nov 6, 2023 at 4:08 PM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>> Hi Miklos,
>>>
>>> On 9/20/23 10:15, Miklos Szeredi wrote:
>>>> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> wrote:
>>>>>
>>>>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpose
>>>>> of allowing shared mmap of files opened/created with DIRECT_IO enabled.
>>>>> However, it leaves open the possibility of further relaxing the
>>>>> DIRECT_IO restrictions (and in-effect, the cache coherency guarantees of
>>>>> DIRECT_IO) in the future.
>>>>>
>>>>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
>>>>> only serves to allow shared mmap of DIRECT_IO files, while still
>>>>> bypassing the cache on regular reads and writes. The shared mmap is the
>>>>> only loosening of the cache policy that can take place with the flag.
>>>>> This removes some ambiguity and introduces a more stable flag to be used
>>>>> in FUSE_INIT. Furthermore, we can document that to allow shared mmap'ing
>>>>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>>>>>
>>>>> Tyler Fanelli (2):
>>>>>     fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>>>>>     docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
>>>>
>>>> Looks good.
>>>>
>>>> Applied, thanks.  Will send the PR during this merge window, since the
>>>> rename could break stuff if already released.
>>>
>>> I'm just porting back this feature to our internal fuse module and it
>>> looks these rename patches have been forgotten?
>>>
>>>
>>
>> Hi Miklos, Bernd,
>>
>> I was looking at the DIRECT_IO_ALLOW_MMAP code and specifically at
>> commit b5a2a3a0b776 ("fuse: write back dirty pages before direct write in
>> direct_io_relax mode") and I was wondering - isn't dirty pages writeback
>> needed *before* invalidate_inode_pages2() in fuse_file_mmap() for
>> direct_io_allow_mmap case?
>>
>> For FUSE_PASSTHROUGH, I am going to need to call fuse_vma_close()
>> for munmap of files also in direct-io mode [1], so I was considering installing
>> fuse_file_vm_ops for the FOPEN_DIRECT_IO case, same as caching case,
>> and regardless of direct_io_allow_mmap.
>>
>> I was asking myself if there was a good reason why fuse_page_mkwrite()/
>> fuse_wait_on_page_writeback()/fuse_vma_close()/write_inode_now()
>> should NOT be called for the FOPEN_DIRECT_IO case regardless of
>> direct_io_allow_mmap?
>>
> 
> Before trying to make changes to fuse_file_mmap() I tried to test
> DIRECT_IO_RELAX - I enabled it in libfuse and ran fstest with
> passthrough_hp --direct-io.
> 
> The test generic/095 - "Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice)
> on the same files" blew up hitting BUG_ON(fi->writectr < 0) in
> fuse_set_nowrite()
> 
> I am wondering how this code was tested?
> 
> I could not figure out the problem and how to fix it.
> Please suggest a fix and let me know which adjustments are needed
> if I want to use fuse_file_vm_ops for all mmap modes.

So fuse_set_nowrite() tests for inode_is_locked(), but that also 
succeeds for a shared lock. It gets late here (and I might miss 
something), but I think we have an issue with 
FOPEN_PARALLEL_DIRECT_WRITES. Assuming there would be plain O_DIRECT and 
mmap, the same issue might triggered? Hmm, well, so far plain O_DIRECT 
does not support FOPEN_PARALLEL_DIRECT_WRITES yet - the patches for that 
are still pending.


Will look into it in more detail in the morning.

Thanks,
Bernd

> 
> Thanks,
> Amir.
> 
> generic/095 5s ...  [10:53:05][   61.185656] kernel BUG at fs/fuse/dir.c:1756!
> [   61.186653] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   61.187447] CPU: 2 PID: 3599 Comm: fio Not tainted 6.6.0-xfstests #2025
> [   61.188461] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.15.0-1 04/01/2014
> [   61.189529] RIP: 0010:fuse_set_nowrite+0x47/0xdd
> [   61.190117] Code: 48 8b 87 e8 00 00 00 48 85 c0 75 02 0f 0b 48 8d
> af 38 06 00 00 48 89 fb 48 89 ef e8 e8 2b 8f 00 8b 83 28 05 00 00 85
> c0 79 02 <0f> 0b 05 00 00 00 80 48 89 ef 89 83 28 05 00 00 e8 86 30 8f
> 00 be
> [   61.192497] RSP: 0018:ffffc9000313fc98 EFLAGS: 00010282
> [   61.193109] RAX: 0000000080000001 RBX: ffff88800cfb21c0 RCX: ffffc9000313fc3c
> [   61.193937] RDX: 0000000000000003 RSI: ffffffff827ce6be RDI: ffffffff828a86cd
> [   61.194736] RBP: ffff88800cfb27f8 R08: 0000000e3ef2354a R09: 0000000000000000
> [   61.195509] R10: ffffffff82b74f20 R11: 0000000000000002 R12: ffff888009bf1f00
> [   61.196291] R13: ffffc9000313fe70 R14: 0000000000000002 R15: ffff88800cfb23f0
> [   61.197069] FS:  00007fa089f64740(0000) GS:ffff88807da00000(0000)
> knlGS:0000000000000000
> [   61.198024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   61.198701] CR2: 00007fa089f17fe0 CR3: 0000000009202001 CR4: 0000000000370ee0
> [   61.199817] Call Trace:
> [   61.200198]  <TASK>
> [   61.200486]  ? __die_body+0x1b/0x59
> [   61.200975]  ? die+0x35/0x4f
> [   61.201379]  ? do_trap+0x7c/0xff
> [   61.201828]  ? fuse_set_nowrite+0x47/0xdd
> [   61.202303]  ? do_error_trap+0xbe/0xeb
> [   61.202733]  ? fuse_set_nowrite+0x47/0xdd
> [   61.203196]  ? fuse_set_nowrite+0x47/0xdd
> [   61.203723]  ? exc_invalid_op+0x52/0x69
> [   61.204202]  ? fuse_set_nowrite+0x47/0xdd
> [   61.204720]  ? asm_exc_invalid_op+0x1a/0x20
> [   61.205204]  ? fuse_set_nowrite+0x47/0xdd
> [   61.205628]  ? fuse_set_nowrite+0x3d/0xdd
> [   61.206061]  ? do_raw_spin_unlock+0x88/0x8f
> [   61.206498]  ? _raw_spin_unlock+0x2d/0x43
> [   61.206915]  ? fuse_range_is_writeback+0x71/0x84
> [   61.207383]  fuse_sync_writes+0xf/0x19
> [   61.207857]  fuse_direct_io+0x167/0x5bd
> [   61.208375]  fuse_direct_write_iter+0xf0/0x146
> [   61.208990]  vfs_write+0x11d/0x1c4
> [   61.209458]  ksys_pwrite64+0x68/0x87
> [   61.209959]  do_syscall_64+0x6e/0x88
> 

