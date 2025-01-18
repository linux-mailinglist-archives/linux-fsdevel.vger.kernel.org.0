Return-Path: <linux-fsdevel+bounces-39589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D6FA15D3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ACB18884E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB5198E65;
	Sat, 18 Jan 2025 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nfUUXjid";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nfUUXjid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDB19067C;
	Sat, 18 Jan 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737208396; cv=none; b=XwTgjH21hGrPUS7GmncMdnWwC/GL9DlJovw1ehBjEE+NGRBV0iyKOaITyP9rcVbRz8w8ACscyvUvosN9tnt261lMmsnmgAHHNlE1oiHomRBdV9OIONZXttgw0xwCJ1P2J1KtpayBHzio3JP+b84ar6FN8IqBvcNI2keleyIUNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737208396; c=relaxed/simple;
	bh=4xuedTlTRdyuSybBq8oZvujcPhw1NKUNjrddZwKc/yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDbMwl2N+cOlA/x7plMybntz58M8dHzN2ydo/BdBbNz+oGJE3YeL4blsAV3r+z1uZ4hgjUO5JsXFFD4UMH6vzfK90zKEDBkfUFHaCaOrFgxUYancrjZUSgdsDmYe0kd086As2XqInfBsXUK/+N5De4v4UKxL7Od1lrE/yFOpZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nfUUXjid; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nfUUXjid; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737208394;
	bh=4xuedTlTRdyuSybBq8oZvujcPhw1NKUNjrddZwKc/yI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nfUUXjidVbsdn8+NM3qy99PmoiVwli+E6rNAE7NCv+Foo2S/UqPUXYHaEwow1q3e4
	 D7m3vR8RpwsZm4p0nMvAiQJF482rtoF5UpV6HU9NhQVi7C7CHIsFwVaViluW86InJM
	 82grT3TQYUrqP9ZmfGTGwCWPrk0TCDFNQIla8oFc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4B4FE128635D;
	Sat, 18 Jan 2025 08:53:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WGMuOgsNdTMf; Sat, 18 Jan 2025 08:53:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737208394;
	bh=4xuedTlTRdyuSybBq8oZvujcPhw1NKUNjrddZwKc/yI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nfUUXjidVbsdn8+NM3qy99PmoiVwli+E6rNAE7NCv+Foo2S/UqPUXYHaEwow1q3e4
	 D7m3vR8RpwsZm4p0nMvAiQJF482rtoF5UpV6HU9NhQVi7C7CHIsFwVaViluW86InJM
	 82grT3TQYUrqP9ZmfGTGwCWPrk0TCDFNQIla8oFc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 873701286343;
	Sat, 18 Jan 2025 08:53:13 -0500 (EST)
Message-ID: <1242f7acd71dfdabfd5507b2d439e2380343ca8a.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/6] convert efivarfs to manage object data correctly
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Jeremy Kerr
	 <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro
	 <viro@zeniv.linux.org.uk>
Date: Sat, 18 Jan 2025 08:53:11 -0500
In-Reply-To: <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXHy+D2GDANFyYJLOZj1fPmgoX+Ed6CRy3mSSCeutsO07w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-01-09 at 10:50 +0100, Ard Biesheuvel wrote:
> Are there any existing test suites that cover efivarfs that you could
> recommend?

The good news is there is actually an existing test suite.  I was
writing some for selftests/filesystems/efivarfs, but it turns out they
exist in selftests/efivarfs.  You can run them from the kernel source
tree (in a VM with your changes) as:

make -C tools/testing/selftests TARGETS=efivarfs run_tests

So I've merged all the testing I had here and started writing new ones.

The bad news is that writing new tests I've run across another corner
case in the efivarfs code: you can set the inode size to anything you
want (as root) which means you can take a real variable and get it to
mimic an uncommitted one (at least to stat):

# ls -l /sys/firmware/efi/efivars/PK-8be4df61-93ca-11d2-aa0d-00e098032b8c 
-rw-r--r-- 1 root root 841 Jan 18 13:40 /sys/firmware/efi/efivars/PK-8be4df61-93ca-11d2-aa0d-00e098032b8c
# chattr -i /sys/firmware/efi/efivars/PK-8be4df61-93ca-11d2-aa0d-00e098032b8c
# > /sys/firmware/efi/efivars/PK-8be4df61-93ca-11d2-aa0d-00e098032b8c
# ls -l /sys/firmware/efi/efivars/PK-8be4df61-93ca-11d2-aa0d-00e098032b8c
-rw-r--r-- 1 root root 0 Jan 18 13:40 /sys/firmware/efi/efivars/PK-8be4df61-93ca-11d2-aa0d-00e098032b8c

I'm not sure how much of a bug this is for the old code (only systemd
seems to check for zero size files), and it's only in the cache inode,
so if you cat the file you get the fully 841 bytes.  However, obviously
it becomes a huge problem with my new code because you can use the
truncate inode to actually delete the variable file (even thought the
variable is still there) so I need to add a fix for it to my series. 
I'll post it separately when I have it to see what you think.

Regards,

James


