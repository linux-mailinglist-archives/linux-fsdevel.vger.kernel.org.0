Return-Path: <linux-fsdevel+bounces-45867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE9A7DF0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA2B3B012D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520E254841;
	Mon,  7 Apr 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1KQEh8R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12194253359;
	Mon,  7 Apr 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032125; cv=none; b=op3aPT3bM4UzYbsYkPtij5aDyOs+z1WUtxn2BXrKp7/Owe0pZkvWZb3PCKrBtWAF19eMm7fGgtD7s5C725Dttq5xK0xG9WkuyEZ8IdVIxcN1ggeCmdICtzsg0QI+qFjEc6ONYt6376Ah6MjoT5/VBGz+AfJneB6Ofs5skyuJgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032125; c=relaxed/simple;
	bh=JaSD1slroXG8EfiX5HR0eSyQaxOR5hoY6v6GGmonORU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esT8swZkv50fASjcgQa/+3NYuF4ZCF9KUK+LcXithCzLtATYdVxAGUmC9hVG8Mtv9jhzorPm6EJY8wgthtxZ7WVm+OMwQrl1wF+skTLLogSDn4Asm28miAf5X9DGIj27t4zPwo9dtDJQCUVojLsLdvAJqg4L/UbmzgmNrTerZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1KQEh8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E6AC4CEE7;
	Mon,  7 Apr 2025 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744032124;
	bh=JaSD1slroXG8EfiX5HR0eSyQaxOR5hoY6v6GGmonORU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1KQEh8RWl7GMy1SAP0XKZi/pgV8Cg6mxJVtZt8juDl3uknq8f0P7G5VKbmR5rKBv
	 hIXPGqp5mmGjqr+B9+f87Yg/8dSGqde5HvQnlkTpMo5+xhQk1sf/YvZvct53zt+9zn
	 WeP/+SV/ShRDtxj+7MaP+yoK/BI1ftms/po5VSJSLJIzDXtddagqWYqHwSLy9f3iBW
	 xfxrmr+waXw5Py4N1sC4qiaBC1G/u6av+rF9g2UcHiTy6ZU1Mirh3L4n/ISCQBxmF2
	 CWOWQX7e22rja/jYhZYZHLAGe62pTyF14Sn0LRGhu/iDIZik+TE+6G5GvqX+OAAwvA
	 L4znjFY5GEpBw==
Date: Mon, 7 Apr 2025 15:21:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, eperezma@redhat.com, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, benliang.zhao@mediatek.com, bin.zhang@mediatek.com
Subject: Re: [RESEND] virtiofs: add filesystem context source name check
Message-ID: <20250407-handgefertigt-duzen-d92bfc181937@brauner>
References: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>

On Mon, Apr 07, 2025 at 07:50:49PM +0800, Xiangsheng Hou wrote:
> In certain scenarios, for example, during fuzz testing, the source
> name may be NULL, which could lead to a kernel panic. Therefore, an
> extra check for the source name should be added.

Oha, that's not great and easily reproducible:

[13344.588906] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
[13344.602350] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[13344.610367] CPU: 8 UID: 0 PID: 1427 Comm: anon_inode_test Not tainted 6.15.0-rc1-gb96146cd957f #21 PREEMPT(undef)
[13344.617410] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown 2/2/2022
[13344.621368] RIP: 0010:strcmp+0x5b/0xb0
[13344.624462] Code: fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38 d0 7f 04 84 c0 75 50 48 89 f0 48 89 f2 0f b6 6b ff 4c 8d 66 01 48 c1 e8 03 83 e2 07 <42> 0f b6 04 28 38 d0 7f 04 84 c0 75 24 41 3a 6c 24 ff 74 ae 19 c0
[13344.635506] RSP: 0018:ffffc900050dfd28 EFLAGS: 00010246
[13344.638112] RAX: 0000000000000000 RBX: ffff8881918158a9 RCX: fffff52000a1bf86
[13344.640726] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881918158a8
[13344.643279] RBP: 0000000000000069 R08: 0000000000000000 R09: fffffbfff2aa7c82
[13344.646722] R10: ffffc900050dfd58 R11: 0000000000000000 R12: 0000000000000001
[13344.648844] R13: dffffc0000000000 R14: ffff8881e2110ce0 R15: dffffc0000000000
[13344.651382] FS:  00007f891cf53740(0000) GS:ffff88843fd42000(0000) knlGS:0000000000000000
[13344.654257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[13344.656296] CR2: 000055dfec6997d8 CR3: 00000001cbf21006 CR4: 0000000000770ef0
[13344.658863] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[13344.661325] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[13344.662722] PKRU: 55555554
[13344.663266] Call Trace:
[13344.663776]  <TASK>
[13344.664303]  virtio_fs_get_tree+0xc4/0x1060
[13344.665237]  ? rcu_is_watching+0x12/0xb0
[13344.666047]  ? cap_capable+0x170/0x320
[13344.666802]  vfs_get_tree+0x87/0x2f0
[13344.667540]  vfs_cmd_create+0xb2/0x240
[13344.668317]  __x64_sys_fsconfig+0x629/0x9f0
[13344.669143]  ? vfs_cmd_create+0x240/0x240
[13344.669956]  ? rcu_is_watching+0x12/0xb0
[13344.670738]  ? syscall_trace_enter+0x129/0x230
[13344.671617]  do_syscall_64+0x74/0x190
[13344.672354]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

This needs to be backported to all LTS kernels.

> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  fs/fuse/virtio_fs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 2c7b24cb67ad..53c2626e90e7 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1669,6 +1669,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	unsigned int virtqueue_size;
>  	int err = -EIO;
>  
> +	if (!fsc->source)
> +		return invalf(fsc, "No source specified");
> +
>  	/* This gets a reference on virtio_fs object. This ptr gets installed
>  	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
>  	 * to drop the reference to this object.
> -- 
> 2.46.0
> 

