Return-Path: <linux-fsdevel+bounces-43418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73AAA566C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623283B21F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409B21771E;
	Fri,  7 Mar 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="q8mcuh8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404120C49E;
	Fri,  7 Mar 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346989; cv=none; b=QIOhBXbHosj/TSE809siDWij0QhvZimKCyc0/b0Q86hnz5e3WoI8uLv6P6eTzCjsa8XMhD2i4ETzyyyqvPC0dzQ5HSYdSh4y3T13cAMu3LhuhojyOPD087t8xgpXLmn7dUXNEGtPt1opL5QB5lcUjoRflXkGtABj3d/kTyYm5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346989; c=relaxed/simple;
	bh=WkCxgnFYvFujFRMpZOJasVbjW5B9RnepoADsBQ+01hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iavuStV2h6KMim3Ix5KFL1LRPBSAZOChH1JobH1frIw7VgmrFVhRVXLjTkNDp2TlYCt+sBddVI0ZWs4c+bwi5mmxHN26zgEoOF44FWcGR5D2Ynihw04JWZvnjlCvVmP4ROG0DNy+4msxft3DkMNzSapi/CtmSBkZYcEJoO+acGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=q8mcuh8p; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 3854C447C6;
	Fri,  7 Mar 2025 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1741346440; bh=WkCxgnFYvFujFRMpZOJasVbjW5B9RnepoADsBQ+01hw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=q8mcuh8pkZlvAP3cXTIfj9IrDH3WpsylC0KiGdFLtoGoBpo2tRFcVZFn/GjFeLeed
	 xUp5izj+iMo7THXQX4CAwe6NoQgAI4grm48wrNVWKcG6mLIb/ShunVu2BNNSgSLLpd
	 AVZ0xcj6sEVzyjKWO9OyKjueNcezZmCySRpJJ6lIpMu/ikvNKsWB2X0K7UGNP8a3ca
	 pOSrSePk9KH2nS9X5gkGz4fILSwpW2vemT8MGMyFEtXuRXqIAa1BlMaj1ftye4fXEZ
	 poJQIQ5LVbwufSkZEun3tP44gxRIMyng9ErW+hPuYJY5YVo9BjM6R63Q0B9bdJOX90
	 f6jNogm148Jfg==
Message-ID: <239cbc8a-9886-4ebc-865c-762bb807276c@marcan.st>
Date: Fri, 7 Mar 2025 20:20:37 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bcachefs?] general protection fault in proc_sys_compare
To: syzbot <syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com>,
 broonie@kernel.org, joel.granados@kernel.org, kees@kernel.org,
 kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/03/07 11:45, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b91872c56940 Merge tag 'dmaengine-fix-6.14' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1485e8b7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
> dashboard link: https://syzkaller.appspot.com/bug?extid=4364ec1693041cad20de
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d55a8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4b855669df70/disk-b91872c5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e44f3c546271/vmlinux-b91872c5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b106e670346a/bzImage-b91872c5.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/68b26fa478ee/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 579cd64b9df8a60284ec3422be919c362de40e41
> Author: Hector Martin <marcan@marcan.st>
> Date:   Sat Feb 8 00:54:35 2025 +0000
> 
>     ASoC: tas2770: Fix volume scale
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14aa03a8580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16aa03a8580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12aa03a8580000
[...]

This is a bad bisect. Not sure what the appropriate syzbot action is in
this case.

- Hector


