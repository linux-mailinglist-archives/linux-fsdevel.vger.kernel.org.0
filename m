Return-Path: <linux-fsdevel+bounces-75354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC55NPP9dGk7/wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:14:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191B7E41E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9623D3011846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5BE238C15;
	Sat, 24 Jan 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b="g146gg8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CB21D3D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769274669; cv=pass; b=jNpgNc4noScEAQoL/FPj//N+i0ABTnBf2Jy/D7LOET7qcYVOyHHMSXXaQfr0OMfWmYmzloX+mFiywsK/qAISA/aC+xcPOqwVMK922Mfv6johgiODrzSxpulZZ37V6db1OahxlIl+WmvQejXI02hMfgT6kAZTdOQf3h2zfQg2vCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769274669; c=relaxed/simple;
	bh=0guLFI3yNYL4nKgjJyirG/A5FgTwEs1RA0pP7qKHPeA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F4HyCWgBCuQSDoJPvOab1AHXijtEO9Zvi+mEP1Sut9guBUymt3fgN+CRPhoX6NRnyGa72Y/Uc6cQs/dzADCCImAl5e+xAzcB0Uxf//waoqDTia0QI9MBnLsYHM8awU0WfogQv+zi50NvV2YXSMMYiX3oDgerK8b42hbZrIE79CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b=g146gg8K; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so4934444a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 09:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769274666; cv=none;
        d=google.com; s=arc-20240605;
        b=J4Na5oLl1mX04KnMaqJ7T8ep6ytWzODwABEEkjLB6rST/bgfJeCrxhuf8Uw7ZehbYU
         ZuyhQGk2Lof1ELVqORCwMoUOZtop1bvt2hUXrIUZcNX7roya1DOOCmRBAVjupblTSE9W
         zpeyeO/de+exHfAsNjyTYH3HnkXV/5ZltTiUP9uG/xo5PcIC01Aj11sayh28XgjGlUh9
         jruAH3ZtZ0I49hhhWrgZ9v9PYADCAmS6fPA0PJNAdKZp+6YO4quGDSySPY9tinWjFcVK
         41DPKqKVMZWlc8HVS1JixZ5jJruLyKWG21pRBjrZwt5YWRLU2Y6koJP9usQVKl8Kej0y
         5cNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=0guLFI3yNYL4nKgjJyirG/A5FgTwEs1RA0pP7qKHPeA=;
        fh=MLId9pOXgLsGejWIe5OSUP3up7R+QF02o5p2FupE2+g=;
        b=SL20ZyqWkYBF8IsKvQF7Ig/lFZ080JVHi2ASwv7H54TUBU6f2QQgnJYIovF/pTdH/M
         EaOKosV6RdjR8fM7S1aqQZsl4euVOBrjVH2sXFTfX2lg6DT4KeJ/lj7gA62SKP1BPdBh
         ad97PzHmyCa3DzFZ24ergThOkHtagqBW+mcXKCSzIqeDhnOMBiXoxAlrppzNTwBvbmMH
         1RKubnK2IiCHnQ/JbQfZmOXsLyEiKy9gMNlaOdDoIqPBEc+MKHbXmrMeb5WQeSDs3v53
         fM3aJ5lyd51kEKAkNZEx5IqmlXcwosrLbWYRUyNXEVjl7caZlCSD4ELMzq5iU0BgZwXN
         WXdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20230601.gappssmtp.com; s=20230601; t=1769274666; x=1769879466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0guLFI3yNYL4nKgjJyirG/A5FgTwEs1RA0pP7qKHPeA=;
        b=g146gg8KabMhMk9E9spY/dHYwQKhytYZXa0SWrkpsLI8O4NnubAgV8UsNOmpCwTZD/
         c/Dzg2Ri7zzy8BTdTGQU0Yb4ROzhY+sTLrkvG2Yu1/UtzC8CatsuqjhA2uEhpszsN05U
         ViZ9/KqszjAYCYBuYJFHYQb5DvZZr2oao4oZlTXlYiaJf35fcvvphFmOyO8NUPh/DzFZ
         e2K7sOGU6qa2AXEeC3J/wCA/8ypag1ioxUU3Z1HhfEqb3g081/uYLcQPUIU9m5aO3QjF
         Th5tkI52ZSkG3ruGJA/XEC+xJIk9tz1vaIRnbsoEJa7On5+rLywtwAbI8CHybIrRXJJT
         hl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769274666; x=1769879466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0guLFI3yNYL4nKgjJyirG/A5FgTwEs1RA0pP7qKHPeA=;
        b=lQNTXzHmzbOh9qVwhFLBPxGd7v4psJiB3xtV9Kh3WDfjc/+g6BH3QsGYIq2Hr8x4uh
         +mpsIamHgGNrsDiqTKuKnx2GS8Rz34n/HY0HsjBgd4k/1Yp9VhZcCjiHW/O9peqF4XPM
         bwc6tkKQG0w+dDRyP/+PiOWGqOpk3eTcAamtVnO2xMpIaxulzu7QjS9PJtB+qez6gmbu
         9GIcxYPBC3XvZaAzSH66AuxAbCQgpFxI8q/LPIvFNGht5+UDQMShoMrZ3Aa8I0PpUElk
         7KMUDxbtn4s3ANnomwQH9T+zcbuevPvhDo1uWXzLSyyEXBZYS2vbBqyP0j4/a+gjnUkP
         jLLg==
X-Gm-Message-State: AOJu0YzI2FckbvVM4cuTe3mcnIPgJK6/CEr6mxtZHCYjnK+vl7yXSlld
	C+VjyNcbGxX2J3WXojyi7AV9iWb5yC3No2K8WFisMOlCcEI0ghPGRrajmochr/FdvVXoqzbqRwV
	k9h/6ElY25qQXwhvkmwMotX2HHAZt5Opg6yKtlODeH+rZ1zcSxmF93MIySA==
X-Gm-Gg: AZuq6aJrkj6U2X21api1qASlPd0AY7VeMyw1+Sf0pB5fj15hxNw6ecyKw1MaTdNe9iG
	l5pEbtM1FqkoI0J1gYljLLn9/3d6o96EvTIE3L8GG2+Ni+pT3USqq5wBTqsD915/ZyPnJ1AFhy0
	gk9s0e3NZ8TcxyC86yRYsMiIHuFtVaFhHdCTuqPFNdF0XxcpqlHh+I0ceML1wjrsAj4IzIMgSFT
	ifxwBJIC12z1ed86/7W7o3J7Ke08fthMoFq1bPCV+CmG4zlClmich55IdS/X/06hD9TFLEixQQq
	KLYc7VN/GdYIHN+0NlI/zCV9at3B6j0zex5yAEV9+Rqj1pEP2K64kl/wSmbu
X-Received: by 2002:a05:6402:398a:b0:64b:7ab2:9f83 with SMTP id
 4fb4d7f45d1cf-658487ca05dmr3259820a12.31.1769274665372; Sat, 24 Jan 2026
 09:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cong Wang <cwang@multikernel.io>
Date: Sat, 24 Jan 2026 09:10:54 -0800
X-Gm-Features: AZwV_Qhxdx5zMF1zGxFZZ1OazCcKy7yeZniyqbTBOvVt-ZdammtaNoM6DOBMeLM
Message-ID: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
Subject: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for shared memory
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75354-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[multikernel.io];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[multikernel-io.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,multikernel-io.20230601.gappssmtp.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3191B7E41E
X-Rspamd-Action: no action

Hello,

I would like to introduce DAXFS, a simple read-only filesystem
designed to operate directly on shared physical memory via the DAX
(Direct Access).

Unlike ramfs or tmpfs, which operate within the kernel=E2=80=99s page cache
and result in fragmented, per-instance memory allocation, DAXFS
provides a mechanism for zero-copy reads from contiguous memory
regions. It bypasses the traditional block I/O stack, buffer heads,
and page cache entirely.

Key Features
- Zero-Copy Efficiency: File reads resolve to direct memory loads,
eliminating page cache duplication and CPU-driven copies.
- True Physical Sharing: By mapping a contiguous physical address or a
dma-buf, multiple kernel instances or containers can share the same
physical pages.
- Hardware Integration: Supports mounting memory exported by GPUs,
FPGAs, or CXL devices via the dma-buf API.
- Simplicity: Uses a self-contained, read-only image format with no
runtime allocation or complex device management.

Primary Use Cases
- Multikernel Environments: Sharing a common Docker image across
independent kernel instances via shared memory.
- CXL Memory Pooling: Accessing read-only data across multiple hosts
without network I/O.
- Container Rootfs Sharing: Using a single DAXFS base image for
multiple containers (via OverlayFS) to save physical RAM.
- Accelerator Data: Zero-copy access to model weights or lookup tables
stored in device memory.

The source includes a kernel module and a mkdaxfs user-space tool for
image creation, it is available here:
https://github.com/multikernel/daxfs

I am looking forward to your feedback on the architecture and its
potential integration to the upstream Linux kernel.

Best regards,
Cong Wang

