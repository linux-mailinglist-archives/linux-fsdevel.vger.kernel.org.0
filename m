Return-Path: <linux-fsdevel+bounces-24796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6D944DAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B36B23AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950371A4B39;
	Thu,  1 Aug 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Bx9fEMFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FA16DECD
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521263; cv=none; b=JbBr167NRE2XZPNNlESDyDPGUXmA7BbQYYluz/sMz51V6wSvEh9KOffZOPFAMu94IL7ZuI6udqlcn026iwwVJx/Q5Sv3gYASM0UqtNi9T6Cs+Nv50w6HeMMQRvj6jsUvInrZjrQBnXIi39UreVTX5CuupvAoBTc6kCggVtfb5QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521263; c=relaxed/simple;
	bh=XNHhHRpvgY/MqyKnsrIUaLqoMu3SwbPwhO/IWu1UhSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz9cw9DQZDNJ9u/+/Iyd0Zj7SE09w/aPvqDlHkRMzLUCLL7z26SOZdAmfjAnS8yio5O1zJszzEmUfuRfePY3QOEItzVa9HgaxK8rijg/BTTSHW5nVD8OBw1a8Mm7h9t64a6PHviKJXmdL9BvG2RFvUZ0g2F7W3wcpR5/n4T3jO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Bx9fEMFZ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-661d7e68e89so18176687b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2024 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722521261; x=1723126061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ySdl7cV1sMC+f6fyOoZuuvhfWYrH1jWG25mq2cl1h0I=;
        b=Bx9fEMFZVW1OnU4y4jE25+U5/FeDQnjwcHJ+OULK4lqR5SjGULm9nbCPt1l+Gph/4N
         d3oGggtqkxU1Q6NaEay/PFHuPeNOLivrTgPzltYfO09FWun/Fv5FjJ8ULomfZ9sKTgqX
         Y57GMItELHJSPtzUIFVS4NKPB10iRDpuIK1cjYc+OK1gT6oA3tuhg3KKfdDwSUp89iGs
         xKEO625UFp6u2xWvT6t9m4M6FnbeuoEhHXYzXyysoTLL6ATIL0HYli6PdGqtAV8CzVKk
         JFN7z/GKN87IiVd81FUFQLf0NKzHL85+ZQEMhZD4GauotYss1qhLaUeiMKQ9+lL0v5Cm
         Tbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722521261; x=1723126061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySdl7cV1sMC+f6fyOoZuuvhfWYrH1jWG25mq2cl1h0I=;
        b=NZhZ8P0p3QgFe2bDblzWPoW282DSUMjbzc+EJE3e1T43wemz91RGDq+oLmxOKMUP4d
         rkfGJExQRkAID3c2ZRy+3qbI3zQzbaBj1e+466Ct8aE9KUCMMVxQM0utaCzfFS5yqYz4
         TTJCO5qX8e+04dE/YacrHneN7o/V2S5gbCJbQZt0RnFXwzeWwHY2GaUXaBLA/Cn6CqO+
         qbFtDIBJl6+HZG9ibZC8pfY77YpnJxzpy8jUzVk/zu2oCv+/sRVPHpUi5PaXYhiRRMvB
         gA8KlI7xiBeXuvVqfyXZRwxuQy2S2PJO4h4od7/PMxAdeqxwCbkhjxky/W/J6ZZAmoTC
         6wFw==
X-Forwarded-Encrypted: i=1; AJvYcCUvlD/wI14h48zrL+0nl4CK2oTDgiIkLjLQ7aZq3gv+BMQqVAYH9vYyiwZFpLRQLe1d1+gEnbspsIEtfjxASUN1w8IFR+a9ZunI9md1Gg==
X-Gm-Message-State: AOJu0Yz6QTfcGoEFfEWURW/EEMs9Rnh72YLG0pMykGwWOqzwg0qgaqhQ
	sMDJxqSXfJ/7rBoW2TMBnoV3FRVh5iVBy/rNCf4xADOfI4KEH2SunCchLRVKwWc=
X-Google-Smtp-Source: AGHT+IFqO6la4nVOpFgnsMqcwdnRljSzCYeEa1I3zo/c1Q5/y+I5cm5d7JvT7/VkK7ye+J990oMgpQ==
X-Received: by 2002:a0d:c383:0:b0:64b:16ed:7c86 with SMTP id 00721157ae682-6895f12132cmr1193407b3.4.1722521260890;
        Thu, 01 Aug 2024 07:07:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab3d6csm33405877b3.110.2024.08.01.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:07:40 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:07:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Wojciech =?utf-8?Q?G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, kees@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fs: last check for exec credentials on NOEXEC
 mount
Message-ID: <20240801140739.GA4186762@perftesting>
References: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801120745.13318-1-wojciech.gladysz@infogain.com>

On Thu, Aug 01, 2024 at 02:07:45PM +0200, Wojciech Gładysz wrote:
> Test case: thread mounts NOEXEC fuse to a file being executed.
> WARN_ON_ONCE is triggered yielding panic for some config.
> Add a check to security_bprm_creds_for_exec(bprm).
> 

Need more detail here, a script or something to describe the series of events
that gets us here, I can't quite figure out how to do this.

> Stack trace:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2736 at fs/exec.c:933 do_open_execat+0x311/0x710 fs/exec.c:932
> Modules linked in:
> CPU: 0 PID: 2736 Comm: syz-executor384 Not tainted 5.10.0-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:do_open_execat+0x311/0x710 fs/exec.c:932
> Code: 89 de e8 02 b1 a1 ff 31 ff 89 de e8 f9 b0 a1 ff 45 84 ff 75 2e 45 85 ed 0f 8f ed 03 00 00 e8 56 ae a1 ff eb bd e8 4f ae a1 ff <0f> 0b 48 c7 c3 f3 ff ff ff 4c 89 f7 e8 9e cb fe ff 49 89 de e9 2d
> RSP: 0018:ffffc90008e07c20 EFLAGS: 00010293
> RAX: ffffffff82131ac6 RBX: 0000000000000004 RCX: ffff88801a6611c0
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffffc90008e07cf0 R08: ffffffff8213173f R09: ffffc90008e07aa0
> R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880115810e0
> R13: dffffc0000000000 R14: ffff88801122c040 R15: ffffc90008e07c60
> FS:  00007f9e283ce6c0(0000) GS:ffff888058a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9e2848600a CR3: 00000000139de000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  bprm_execve+0x60b/0x1c40 fs/exec.c:1939
>  do_execveat_common+0x5a6/0x770 fs/exec.c:2077
>  do_execve fs/exec.c:2147 [inline]
>  __do_sys_execve fs/exec.c:2223 [inline]
>  __se_sys_execve fs/exec.c:2218 [inline]
>  __x64_sys_execve+0x92/0xb0 fs/exec.c:2218
>  do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
>  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> RIP: 0033:0x7f9e2842f299
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9e283ce218 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> RAX: ffffffffffffffda RBX: 00007f9e284bd3f8 RCX: 00007f9e2842f299
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
> RBP: 00007f9e284bd3f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9e2848a134
> R13: 0030656c69662f2e R14: 00007ffc819a23d0 R15: 00007f9e28488130
> 
> Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
> ---
>  fs/exec.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a126e3d1cacb..0cc6a7d033a1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -953,8 +953,6 @@ EXPORT_SYMBOL(transfer_args_to_stack);
>   */
>  static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  {
> -	struct file *file;
> -	int err;
>  	struct open_flags open_exec_flags = {
>  		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>  		.acc_mode = MAY_EXEC,
> @@ -969,26 +967,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  	if (flags & AT_EMPTY_PATH)
>  		open_exec_flags.lookup_flags |= LOOKUP_EMPTY;
>  
> -	file = do_filp_open(fd, name, &open_exec_flags);
> -	if (IS_ERR(file))
> -		goto out;
> -
> -	/*
> -	 * may_open() has already checked for this, so it should be
> -	 * impossible to trip now. But we need to be extra cautious
> -	 * and check again at the very end too.
> -	 */
> -	err = -EACCES;
> -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> -			 path_noexec(&file->f_path)))
> -		goto exit;
> -

This still needs to be left here to catch any bad actors in the future.  Thanks,

Josef

