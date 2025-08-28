Return-Path: <linux-fsdevel+bounces-59514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB0B3A6CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDFFA01F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113EE32A3C9;
	Thu, 28 Aug 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Y4FiiP6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB92153E1;
	Thu, 28 Aug 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399541; cv=pass; b=aeS6gzs8vrZE2iAEI2Q16mix3kNOPGH9BqKbMgqQKnC7imSR9TxYpFFRW6khuerH+gePxg0DhKGO6V88YKkFAJ4dxjj0EmJwEz/wRiH5v8dbcMqnLEdsia0Tt8f0Cib6Sza3PHjfRr0sYslE381WqEz59nGi/02detMOl8ovl7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399541; c=relaxed/simple;
	bh=3hNbbGnIIeUh0Xq169DwWUhdfjIjNlud6e1OOq1hvgI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PWgE3pON5w4H+b8se7eZeSTdmshE5niv6Uh8UBYh4kJFh2zdORKtgpYhL0Zx3WBRn/TXqXa4oPGKZ6r1SVMD1okkg7tnvwdgVyOyvyMxuY99srGHdi+Tkqdn69gR0s/nru1oZeb8brcwS22gm5G8myWI+jtY6ugeedo3b65joA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Y4FiiP6c; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756399492; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nt9ujwIF+j5OMdtPq+mji6OStcJSTF2iSyhtPMWQLKVocY9TKH5Z4Dv9y8yrtcLm1OmhXdFLQPMOddurirkrT3MfKwB9MeCMw9GxvBs7CFhG5euz448+LvYOVLFRVzsobzWaNiDh3yZdg2/OD9ILDKRzf2H9/Vaiml5j+doSn5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756399492; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xrVBUXkzvzBF2rrjO9ftLnAnNRA3Pzir4wCQwPuO9Io=; 
	b=jGxafguVxA+sATZFmmv3LQgo/TI9Q39ykgTeMka0t41ZbDM2rcswWp0WKlJ+FSJms4aULM6yduwIZEv+Bg8Y1d2dftReHuJzZrdlI6ln0buPYW3yTXNXkz4nBFGMpok4Zn8Dz4Av1K1gnPTrV3Kl4hKr9b6wxLgesp4W1SPBTmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756399492;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xrVBUXkzvzBF2rrjO9ftLnAnNRA3Pzir4wCQwPuO9Io=;
	b=Y4FiiP6cHnEt9IL9qbZh8sOiJdC4tI4m0yKvUPOai5R5sg0SSKhFCQ7JgFGVUJif
	4wszl7sc/FyT08qi4yXkKTchq+1pf/KfWD9K6r6tWtvvmPXLO6XgJBqwax8hzBTOLJt
	nb3upuBHJ43WvuyEDRKePGvm0A0etm2tUe7wdyRs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756399491637732.1699248320573; Thu, 28 Aug 2025 09:44:51 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 28 Aug 2025 09:44:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:44:51 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>
Cc: "Byron Stanoszek" <gandalf@winds.org>, "Christoph Hellwig" <hch@lst.de>,
	"gregkh" <gregkh@linuxfoundation.org>,
	"julian.stecklina" <julian.stecklina@cyberus-technology.de>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"rafael" <rafael@kernel.org>,
	"torvalds" <torvalds@linux-foundation.org>,
	"viro" <viro@zeniv.linux.org.uk>,
	=?UTF-8?Q?=22Thomas_Wei=C3=9Fschuh=22?= <thomas.weissschuh@linutronix.de>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <198f1915a27.10415eef562419.6441525173245870022@zohomail.com>
In-Reply-To: <81788d65-968a-4225-ba1b-8ede4deb0f61@linux.alibaba.com>
References: <20250321050114.GC1831@lst.de>
 <20250825182713.2469206-1-safinaskar@zohomail.com>
 <20250826075910.GA22903@lst.de>
 <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
 <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
 <198ead62fff.fc7d206346787.2754614060206901867@zohomail.com>
 <d820951e-f5df-4ddb-a657-5f0cc7c3493a@linux.alibaba.com> <81788d65-968a-4225-ba1b-8ede4deb0f61@linux.alibaba.com>
Subject: Re: [PATCH] initrd: support erofs as initrd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122752d06e396f7e7865dd3a0d050000c5060cc9522ec008e81a4b38c4e66a6265240f58d73be4b200:zu0801122755eab974bb7b668fad6bb8710000346584e788a9fcab2204fd423ce27651cec1e91681ae3b5138:rf0801122b8c3ec6ac4e79f50d268b6a9400009faf7565bbb4e40d3b4d2d258eca40d706241f9abce8de4dd8018c6976:ZohoMail

 ---- On Wed, 27 Aug 2025 13:58:02 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote --- 
 > The additional cpio extraction destroys bit-for-bit identical data
 > protection, or some other new verification approach is needed for
 > initramfs tmpfs.

Put erofs to initramfs and sign whole thing.

Also: initramfs's are concatenatable.
So, you can put erofs to cpio and sign the result.
And then concatenate that cpio with another cpio (with init).

Also, you can put erofs to cpio, then sign this thing, and then add init to kernel
built-in cpio (via INITRAMFS_SOURCE).

In fact, this built-in initramfs (INITRAMFS_SOURCE) is very powerful thing.
You can specify there arbitrary boot logic, and have that initramfs inside kernel
image.

You can even specify logic there for checking signature of erofs (not cpio, but erofs itself).

Also, if all these is still not helpful, then try to describe your use case in more details.
I still don't understand what is wrong with signing cpio, which contains erofs.
Yes, this will slightly complicate pipeline for building erofs. Now you will
have to put it to cpio and then sign that cpio. So what?

Also, if your users want to have their own init inside that erofs, then
you can just write trivial init, which calls their init.
And you can put that trivial init to cpio, which is build-in in kernel via INITRAMFS_SOURCE.

Also, when I hear "sign, signature, something something", then UKIs show up in my mind.
( https://uapi-group.org/specifications/specs/unified_kernel_image/ ).
Maybe they are somehow helpful? That page talks a lot about signatures, measuring into
TPM, etc. (Every time that page says "initrd", they mean initramfs, of course.)

-- 
Askar Safin
https://types.pl/@safinaskar


