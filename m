Return-Path: <linux-fsdevel+bounces-62146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5962B85A41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B3A1893041
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305330FC0F;
	Thu, 18 Sep 2025 15:29:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017C30DECA;
	Thu, 18 Sep 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209388; cv=none; b=WYq6KGHeiw8+Fr6IUeDir0CP34mWhD+5qQVhSn06o8SHUGC5cG+xivNKwFjfhs6TJ+h3N0mVb8MeApCdITR+8AH3yUNZuIrLvWEQLyfCJhduGGXHg88ORagUopM8jN74TDYNkWqxFIn+JQ/u5LdVaF+UQbkKUh9wjxNOc4L/FJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209388; c=relaxed/simple;
	bh=1E1TtPIzWv3UVjPPN5oafjjL60AY6+jP9kR4QCfSNnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvGhCB0dzmwbkI77atdqyqReCeWamBfqjA3tAz4g9JGvz47TSOUXF7kFb9qaxjyBgfsCtN0RT5EFFcvG0igUUb2IpMn1llfTor0uONxBC09z8nci0HSl6jMjCSKZXjRNF8gbpefQC6MHYMrcxRAy3RyqLHO75Z3hJqUOfuKP3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=fail smtp.mailfrom=freebox.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=freebox.fr
Received: from daria.iliad.local (unknown [213.36.7.13])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 179252003FC;
	Thu, 18 Sep 2025 17:28:31 +0200 (CEST)
From: Nicolas Schichan <nschichan@freebox.fr>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org,
	nschichan@freebox.fr
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Thu, 18 Sep 2025 17:28:30 +0200
Message-Id: <20250918152830.438554-1-nschichan@freebox.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.

This serie came a bit as a surprise, because even though the message
notifying of the initrd deprecation was added in July 2020, the message
was never displayed on our kernels.

When booting with root=/dev/ram0 in the kernel commandline,
handle_initrd() where the deprecation message resides is never called,
which is rather unfortunate (init/do_mounts_initrd.c):

	if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
		init_unlink("/initrd.image");
		handle_initrd(root_device_name); // shows the deprecation msg
		return true;
	}

It is likely we are not the alone booting with that particular
configuration, so other people are probably going to be surprised when
initrd support is removed, because they never saw the deprecation
message.

We do depend on initrd support a lot on our embedded platforms (more
than a million devices with a yearlyish upgrade to the latest
kernel). If it eventually becomes removed this is going to impact us.

We use an initrd squashfs4 image, because coming from a time where
embedded flash devices were fragile, we avoid having the root
filesystem directly mounted (even when read only) on the flash
block/mtd device, and have the bootloader load the root filesystem as
an initrd.

We use a squashfs4 because we can mount it and keep it compressed. The
kernel would decompress data on demand in the page cache, and evict it
as needed.

Regards,

-- 
Nicolas Schichan

