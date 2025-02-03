Return-Path: <linux-fsdevel+bounces-40566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0246A2542B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4983161127
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136561FBCAD;
	Mon,  3 Feb 2025 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Msunbk40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DC78F5D;
	Mon,  3 Feb 2025 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570553; cv=none; b=TnPN1/zCNw5hPHAf9cGJLqztxPU3u+7MHZ3o5b38Vl4lecEGWagr0Vnagbsw82H3Tts6Wox3LW0MDtzWZuKKwCt1YpgPaUVkCXsFh/6mb0gzMbwLQezyLb7kh2NxVXLHPYJ6GctJg0icqhDIshzSqgTYBnPdV1W6GrLXz2fzXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570553; c=relaxed/simple;
	bh=mjJkCqwk1WqWxuLu0BgfdANNFd5gCR4A8HpbqdNYGvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3SF1NYLQOC8Vbgc94YvWLgTKXl92t+aKsj+0aW62sYvOPtoc7ACS0LnkV4eS1xDX5r1V4kbXsPGXpnAm259QIYI4XzQP3Q2ykNa4E4zLCrPJDfNxVeuM145PHoYiLUYtq1zraIyJDTUOqslGxcBMUV4YD+CUItnrLR71QTdDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Msunbk40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EDCC4CEE2;
	Mon,  3 Feb 2025 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738570552;
	bh=mjJkCqwk1WqWxuLu0BgfdANNFd5gCR4A8HpbqdNYGvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Msunbk40aaABEbyOg8lvujb8fVBdf02nTqsld0rGl/8SxCOUvaIFAu9JBxH2hKqOK
	 tbVvq/ETrJKNZtCQ7XXeWp8n/g7wtD1RPUGGeNN3pnmmDqf3ns1v7RgBD05G7qvpW6
	 oC3LwZdAeuCjqSOioUhWpDAHhD32+TyFwDpHFz1Y=
Date: Mon, 3 Feb 2025 09:14:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com, dakr@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] debugfs: add fsd's methods initialization
Message-ID: <2025020345-breath-comma-4097@gregkh>
References: <679f72f6.050a0220.48cbc.000d.GAE@google.com>
 <tencent_8D66623CFF36BA96EE36FE4B7474B1778509@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8D66623CFF36BA96EE36FE4B7474B1778509@qq.com>

On Mon, Feb 03, 2025 at 11:27:56AM +0800, Edward Adam Davis wrote:
> syzbot reported a uninit-value in full_proxy_unlocked_ioctl. [1]
> 
> The newly created fsd does not initialize methods, and increases the
> initialization of methods for fsd.
> 
> [1]
> BUG: KMSAN: uninit-value in full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
>  full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
>  x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 41a0ecc0997c ("debugfs: get rid of dynamically allocation proxy_ops")
> Reported-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8928e473a91452caca2f
> Tested-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/debugfs/file.c | 1 +
>  1 file changed, 1 insertion(+)

Is this still an issue on 6.14-rc1, specifically after commit
57b314752ec0 ("debugfs: Fix the missing initializations in
__debugfs_file_get()")?

thanks,

greg k-h

