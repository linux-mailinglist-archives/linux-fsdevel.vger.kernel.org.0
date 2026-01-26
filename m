Return-Path: <linux-fsdevel+bounces-75502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABO3HLumd2lrjwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:39:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D971F8B924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8BC13044A55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75D34D4EC;
	Mon, 26 Jan 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b="OMNd3/7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722934D4DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449119; cv=pass; b=NCmgsdW5eRUn8NeSKAuFQt1iLdIaWmSAuQCBVHsI6ooN1ypjz56+i3kKbtqmEt0Sqctl0BI9LCU5TX4NpEUj7hD3tqO7lgSCch9c/GfqYdz2Bh5iIxAwt9UuDTGHV1YdZKoY4jFPKP1LBEpdKWongZO0Hfs7HkKSsJlLCJVGlxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449119; c=relaxed/simple;
	bh=uJJ/Ym9eCKvD/y1t4Fjhl4NlIw9gQ9YMBTKX/JXOyUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=td0m+JOeotFFWOqEo1R8iqrpYghfTelzukb0i8du83hx6PW+L9rZSoYObFYlDLlsrI9NioTgm5FvUPnVyBqB2sCT1qzZwuvszOL1DLpS9BBVs1tpx8oEbdJjt1gEUwExTtm0bdLhaT8pr2mLFMkN4ogNb1WTn/kpUPqrH8LJt1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b=OMNd3/7Q; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65832eb9723so8741511a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 09:38:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769449116; cv=none;
        d=google.com; s=arc-20240605;
        b=HiSXpuxW8u7s7KZsNIwbZkU2uLdMT6KcgbLEINayxTwry1aglvmOVQr4fXDUI5ryLF
         lRts4JoJB3Strp2I69HIOcbQWqvtDVI74SVN141+FqhK4i0ejeBP3yqbNWu9aHpS1MAA
         kbt1AXH+rIz6C+MgVItPoJsAemjfHo1vnr/cvKUNjiQTG+P6ycFhfLPZ0H2nxq3rDZLp
         F4Bu4sQHNHaqSxs5A3NVrcyBrXqxUcEwlZzYwI30kTXzqpxSSCmBJbowXZEHJJVJMoGu
         avFuY8otqhfB8BUbhDZg0Aju5ESuu9Ef6Y72eKWiruCPOFlJGJXDRw3xWixfDTRROeSf
         TqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJJ/Ym9eCKvD/y1t4Fjhl4NlIw9gQ9YMBTKX/JXOyUs=;
        fh=12/n5VlSwSJ2pKXjR2enkShEtbU0v9oJPeChLyaFxyY=;
        b=U5jKvJGjL6DnhmwQfXeD/HWM+R6nb9xVczwNhFI82tZlnYr3/eIOA55gOhSeytKrI3
         ZOM4G2jl65LiUBZB0UtK6KZT3VXrfAfG/aRZor5kJdAYcMSKdySRnPnj6KlOOak/iaYQ
         12mRXs9M5c0c+beqQ+zgG4zFUNG4/WnROKbedmOwCdIv4ZkGoQv5+8zCasiT1ok2lTPP
         taPIfXjJBIMadlVbCmKk7d1hpVbHqEsUUnxJeG/XHd+kkbOlf2ToHaTkRJqw6ed/PHQm
         EjmzaPpu17/NC+bWmhVN4qoDp0CpKgVbogVTYaPVDlVwGTZfPxvI2GFyCLZef5e/CHkO
         Ydjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20230601.gappssmtp.com; s=20230601; t=1769449116; x=1770053916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJJ/Ym9eCKvD/y1t4Fjhl4NlIw9gQ9YMBTKX/JXOyUs=;
        b=OMNd3/7QXVReviOIsXuPVHvqrFqBCUwKAfUtdL2yeDFhaHRNTR7zW5/NkgAE1tIXB8
         KpFVUlO50bEtp82qtbyl7OTs1Y+Ka6TqjSILABV+RmmBHlP2TPIi5MAjBof4HIzm1Cdi
         XgHvG5xEUNSU0/S2ON6gFUo3DGiqTyZRMgzBqFFPLdxs/RCSwS0Ok73RxQ2YnI0FfI/B
         jnx6NVMoxhUfikv9vC4pajCs6XrPdlneS8wSJ0XsvpUVXWaXmVq90szo9orUuSun+qIl
         v1vsKoGPMNHVEYAFEnoRx2tEjO+Ys8cvAuU+loxAl1RBRYBYXzWnH+UnJqwjILesTXR2
         MxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449116; x=1770053916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJJ/Ym9eCKvD/y1t4Fjhl4NlIw9gQ9YMBTKX/JXOyUs=;
        b=nKTM4ZW7GwdFYpi1JVZgw2H9fVa9paRV3ce9VA/nP2jb90ulRlULsxBJCgiWA04lap
         OsWHx2tYaanTyJwMtIn8ZstbBAOjTZr6DMC9OcFpRlhPF6+Cf/Rcbu/QdN1C7Fwq8HNX
         LW5OXvkZKLYIZomMig09AYYRgQkBl7rB5fIHWAvuG9P7ZBQWA1/qmxh0oKONIR/SG3WB
         7Re3AbMajwoM5UHK3ejIYOuP10J31B71qzIcGGT51XyU0eqBHIBYhyr7fBvYf45BrOXK
         oPSReyy794OkqsWhdpAZunPFVRapl4TLI/ktWo+f+wDVfKHrlzNrZK/kgDUlP/i+FrrP
         8jrA==
X-Gm-Message-State: AOJu0Yyh2WdDJ0tbjqtXP+LcQAx75QfMEQClHBsOStlKdycl7OOp9eP2
	0aWY1L4oPk0FfBwdqzcLZW73L7Fe8yPwzaqHJripa0V0ERYObb7yE4fKpWxSQoFyvU8dYKDP2ar
	wpQ8VhIZdahK77R5QelrahKo6jmWZNGnbnfyzebhRkw==
X-Gm-Gg: AZuq6aLoZZEyUhMzJs6JZvl0AogBGUdI870pIuCfJAr2ErhvHVWphPjl8/952LH3+0y
	R+SqMwEwlvhbbKPobB+zdwyIU77tT8f73vGDmvnJFavWf7zReeuFh6WFD2b4Ey2UlbaFsXZI1av
	N5KUEnw7IvWm0FTJ2l/EpCVdDpO2lHx5+tyF95nA7DPx3q0EH2LweQYw05lBluNzuGJUvJtZxkB
	cpcO5lQIAk6+mBkBRDYvc3puoT7VfMUjFnpObdG6BJizpnwo4vAIuY4i8AzVwtlVuRgaheMyYHT
	SgCGgjbUL7Pq0bzSAosarsDOTnspVr9aq2tqrW5ioM2IVTv/y7AF0Us7wyiWLSmtkqIpCHk=
X-Received: by 2002:a05:6402:1d52:b0:64d:2920:ef29 with SMTP id
 4fb4d7f45d1cf-6587068c28emr3719386a12.2.1769449115464; Mon, 26 Jan 2026
 09:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
 <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com>
In-Reply-To: <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com>
From: Cong Wang <cwang@multikernel.io>
Date: Mon, 26 Jan 2026 09:38:23 -0800
X-Gm-Features: AZwV_QhpVEKU-S5SmNvwbMciDELXM0ojc9983ZSSAnvoDVGnZMOTDLWTBpv_HG0
Message-ID: <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75502-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[multikernel-io.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D971F8B924
X-Rspamd-Action: no action

Hi Xiang,

On Sun, Jan 25, 2026 at 8:04=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Cong,
>
> On 2026/1/25 01:10, Cong Wang wrote:
> > Hello,
> >
> > I would like to introduce DAXFS, a simple read-only filesystem
> > designed to operate directly on shared physical memory via the DAX
> > (Direct Access).
> >
> > Unlike ramfs or tmpfs, which operate within the kernel=E2=80=99s page c=
ache
> > and result in fragmented, per-instance memory allocation, DAXFS
> > provides a mechanism for zero-copy reads from contiguous memory
> > regions. It bypasses the traditional block I/O stack, buffer heads,
> > and page cache entirely.
> >
> > Key Features
> > - Zero-Copy Efficiency: File reads resolve to direct memory loads,
> > eliminating page cache duplication and CPU-driven copies.
> > - True Physical Sharing: By mapping a contiguous physical address or a
> > dma-buf, multiple kernel instances or containers can share the same
> > physical pages.
> > - Hardware Integration: Supports mounting memory exported by GPUs,
> > FPGAs, or CXL devices via the dma-buf API.
> > - Simplicity: Uses a self-contained, read-only image format with no
> > runtime allocation or complex device management.
> >
> > Primary Use Cases
> > - Multikernel Environments: Sharing a common Docker image across
> > independent kernel instances via shared memory.
> > - CXL Memory Pooling: Accessing read-only data across multiple hosts
> > without network I/O.
> > - Container Rootfs Sharing: Using a single DAXFS base image for
> > multiple containers (via OverlayFS) to save physical RAM.
> > - Accelerator Data: Zero-copy access to model weights or lookup tables
> > stored in device memory.
>
> Actually, EROFS DAX is already used for this way for various users,
> including all the usage above.
>
> Could you explain why EROFS doesn't suit for your use cases?

EROFS does not support direct physical memory operations. As you
mentioned, it relies on other layers like ramdax to function in these
scenarios.

I have looked into ramdax, and it does not seem suitable for
multikernel use case. Specifically, the ending 128K is shared across
multiple kernels, which would cause significant issues. For reference:

87 dimm->label_area =3D memremap(start + size - LABEL_AREA_SIZE,
88 LABEL_AREA_SIZE, MEMREMAP_WB);
...
154 static int ramdax_set_config_data(struct nvdimm *nvdimm, int buf_len,
155 struct nd_cmd_set_config_hdr *cmd)
156 {
157 struct ramdax_dimm *dimm =3D nvdimm_provider_data(nvdimm);
158
159 if (sizeof(*cmd) > buf_len)
160 return -EINVAL;
161 if (struct_size(cmd, in_buf, cmd->in_length) > buf_len)
162 return -EINVAL;
163 if (size_add(cmd->in_offset, cmd->in_length) > LABEL_AREA_SIZE)
164 return -EINVAL;
165
166 memcpy(dimm->label_area + cmd->in_offset, cmd->in_buf, cmd->in_length);
167
168 return 0;
169 }

Not to mention other cases like GPU/SmartNIC etc..

If you are interested in adding multikernel support to EROFS, here is
the codebase you could start with:
https://github.com/multikernel/linux. PR is always welcome.

Thanks,
Cong Wang

