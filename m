Return-Path: <linux-fsdevel+bounces-23732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3046931F78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 05:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ACE1C20CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 03:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E917BD2;
	Tue, 16 Jul 2024 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XAyX7KV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E536E15E9B;
	Tue, 16 Jul 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101902; cv=none; b=uzvls3S+7wSS1VkOxU0N4kgKeL/cNx9vEIfTD0R0I+UC9qPvKOY1sJ8W/wW086y7vRA9iVdI5xQrtk4c/KZPMnPsM8+zCD6izIRiEv2HN9VPYPRfUeR1ykz8fYZWvG9DULRe2h7ke/9ilcIAaumNhb2P8A5OxTtemlFdywOW59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101902; c=relaxed/simple;
	bh=X7dB+6L4gT8OzKV1n2/NLDUILsHO+pspKg+lYdn1bRg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oqU3snBhhulJnXxvb7oeR7LDtwD+EsiACa7vNRluCIx0hwq/agJv88d4W2u6muEjq3gXRaAqiu93XE9YhfKU6ueIC8j0tzqh5cPLVSxIWa24yLfgzng3RAcioMxys+FggrNHO1mrpQQVN9jFZj2ywfQfqByz58hQyUgMt+pSSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XAyX7KV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C24AC116B1;
	Tue, 16 Jul 2024 03:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721101901;
	bh=X7dB+6L4gT8OzKV1n2/NLDUILsHO+pspKg+lYdn1bRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XAyX7KV3tlQo67bwjyViZhx49oCRLY7zjDGv8iHoFFh9SFZiMPuHDTQe/nIJF0Y2o
	 e+1rZQuAuMnAcGWutUfJU0UnK5OBrZNIYQ0L8dq7MQA2LE7y/my+8wZI96AqX4sDzx
	 EBYYvNC2Yet+PdyAgUjNFY1jV3aCbuzOsUDC3TLU=
Date: Mon, 15 Jul 2024 20:51:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com>
Cc: aleksandr.mikhalitsyn@canonical.com, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [mm?] BUG: sleeping function called from invalid
 context in vma_alloc_folio_noprof
Message-Id: <20240715205140.c260410215836e753a44b5e9@linux-foundation.org>
In-Reply-To: <00000000000069b4ee061d5334e4@google.com>
References: <00000000000069b4ee061d5334e4@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 18:24:19 -0700 syzbot <syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ba9149980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3e82ae343b26b4d2335
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144c4b66980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163c28f6980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz
> 
> The issue was bisected to:
> 
> commit ca567df74a28a9fb368c6b2d93e864113f73f5c2
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Sun Jun 7 20:47:08 2020 +0000
> 
>     nsfs: add pid translation ioctls
> 

yup, thanks.  Breaking out of the switch statement while holding
rcu_read_lock().


