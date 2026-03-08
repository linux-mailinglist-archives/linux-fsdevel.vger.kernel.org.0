Return-Path: <linux-fsdevel+bounces-79715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PebEJxxIrWmH0wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 10:57:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E022F41A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 10:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96555301474D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2736C0DF;
	Sun,  8 Mar 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="D+o9D8fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BA36C0AF
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772963860; cv=pass; b=Zc+Gqz0+X3Qkt0XGv7DuG+Q/xHJNBv2QxP6gVxhJNLcouTYf7gdDskl/6LZZzAcXocfUY7IcU4FUGDHf4eKojSYxjeMaYZrpp1LLcD572s4RRWGuUUe7i+C1QpOQxmItQt3+4ii0XGASP0Dhw0IX3yHG11MiMJzf1XHugTYly+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772963860; c=relaxed/simple;
	bh=pveo1jbABvf9O21ut4Px0fwZjIMaPEs533v+HloVQKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6UcgSk0jzmm8D/H8SBUGcyVm1oCT3y1HGCOwnRjP6KxXcZ24fvtCA3NUhT5gylAhpIh702U62uCe88a6LURsWD2MOgz3m7p42sfdVqIoLtzsTIZ0XdpaUvPRA8M199HsV/DVhZnL/CdZomiFWJSnFbYRZ9dNG0ppmc3LCJlJ1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=D+o9D8fn; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e0553b0so89716007b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 01:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772963858; cv=none;
        d=google.com; s=arc-20240605;
        b=XIWnutgVk2DvHnoBKDpQ/B84uScAcpkjk/KnpAzG4sxtjzwklzNJl8QcMUkbmElEpR
         j4oVG/KJkr7deremrgP3qBe1WqcR6rNGJ4CBBT/GVuNNhRefh4hba8EbxSXdvc25DF58
         HAx3jriaHhr7BIvN1ojQ7U0hvXmj1Vrd18s+rGfAf6KiIvI+ZaphTlI1M9lzf8AwTHb4
         F0ACXZKyJ0klXQxYkn+mLKA/1UocKQYarcFNyT3tIG0S4uEz0YDckTGl+tsSJJiyzKdk
         IoiKJdpZ5OGu5JNUf1Rsjp7twoIzhZtD0JLlMdGCRDH4b8IhdfAn6onmH+2j4IeMQmhc
         Bcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vXCC9wd6WJbv4Rkek0lOfebWInM67Hmdt26u86+GnkA=;
        fh=HNxowrGCudk9Pa2ZO0TRjut6IloU4JtSJPwwL1CWpfw=;
        b=dTHf7nMNsrbLFkM66a9b4tBCbVG0J+DXDTrQwxMOsgWYe8zjhxD2A6Q1/6u9+8R3W6
         bzBUY/wVZckKbxNShvi9lk+/qIHuIVH0eEJ1gqkww9yQoz5qLHYqnE0Qz+YIWGe/OfIF
         NOYKPnrNjpvcMF7ADFaUJJnDx15kedgpdVtWK3KIg5BMMbaYVkonjv1uOEpScYxSlKi3
         ADl1yd8L/gC5K3riHhFc6GW6DGD/Rb9WyfvZU5qrWk1yT62ljmluYfgqOwpPApEgyiNj
         SVQnkvpGy4e1nt7r85aaDVJby1Rd6pLLcw4U5idM3cw84ONjHmU5jFbOYk/eDoPv3GgS
         QRsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1772963858; x=1773568658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vXCC9wd6WJbv4Rkek0lOfebWInM67Hmdt26u86+GnkA=;
        b=D+o9D8fncxtFtN7EidB4eNuGgzgtTwjuAXILMSsPfPgzul5ysoKL/2ImmAIG6aWm2z
         6OJfNiYwnfgBA1Fxb6VhieWIWL5tELIRUsXxfrZXqzYAV6N0xgtg2t9NUDZD1g7gVINh
         LBmh9plxBUm77z1c48OxpAZNH7tV6QwixRTRXPwiVEwUhmk+Ktx5loHoehPJmw4Ka1mc
         xybB8a7S07H801K6MgmLVZIzB4tBP3Hu3lyH07O58QQ2J7yZmavwZyGULkSWKdTx5216
         PpJpDGQDhFDFbOEKvjZ/gBVpWnbYnEA1bobkrHXQfbTuy/sTrtis27vaYNjordXskrF3
         GATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772963858; x=1773568658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXCC9wd6WJbv4Rkek0lOfebWInM67Hmdt26u86+GnkA=;
        b=o1HQEyb+WinUojD9fYIIN1BiOTtfueutfp5zEBNtm3vsAeVuvCWaberFByssdjJbx6
         a2L2hOsrGHcYzYJKmAK2fjfCwwK2a7mOd6RaVGGsigw2SRgxvVyFBmisqTyTkkfi5H9/
         G64Y1se8VHhpU1NI8z7OyYRKxflfJZbejTstTiw14458xyO10BRxnhlb88p3Vh7NdAM5
         Ed9SbnBRmXx/uAnOXh4LpvWFk4VXHoj4XJpToz4XfgOG4xiXV6DFvAPdsoIB0mMHIu5Y
         M+TAL63SnjZn1x8bTH1PnMKkxoGQErLOAkqQW1R9gJ6WV+EUYMTMVDmqXY0mJyNU1s2z
         2gKg==
X-Gm-Message-State: AOJu0YzHSAk5L50U16nhAWbXxhVkE/aSI5pp6kNnrHFBSDEyFtaoHmhH
	/8x0XfJkvR95bLC9WxwJehu4aQltSJ+toQz3XCCaBR6g52tFBANJqsE+dr9daccW2wGWd3CYSZt
	1cBQO/Yn6MuPzU7+D2VeyT3Op6u6zn6fWAgV1CBabpw==
X-Gm-Gg: ATEYQzz0vrn4mhtCieJxlADOVQ6eY6PUuaBMhXeHXtJHW4J0EKRWpVE5WbocqmjWXCX
	XQwzbeoesw78+uOAH1Q0027wo5zm4Ec3S0h9RRnzE70Ie1IsqlMTNliGrT4n6Bkl4D7GXEnYXFP
	R3J8rIko7639xnu/aY4XCEkpdVLaRPykRVAz67sYRler5TsD5Xrv/vwEKjynsGYnT+dFW2AZ0Zp
	YsYF18+wi6QZYu8XXlVg50RqIDvWLVAPNate6LtvltCpmLuZBq+Nd6gkSlPWe5xkV1GKgUPdsaW
	CvM+P0KXzqpi4UO75YlDYNAqLYPC6du5vCisjRXRXA==
X-Received: by 2002:a05:690c:4b87:b0:798:6ee0:2a68 with SMTP id
 00721157ae682-798dd79a7f8mr70252727b3.64.1772963858401; Sun, 08 Mar 2026
 01:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304114727.384416-1-r@hev.cc>
In-Reply-To: <20260304114727.384416-1-r@hev.cc>
From: hev <r@hev.cc>
Date: Sun, 8 Mar 2026 17:57:27 +0800
X-Gm-Features: AaiRm52SpIZfNiOfmNNlgLYK3x_bGxvzWJa5vwCMHz9YODE09mjAuuMinHe2KyA
Message-ID: <CAHirt9hA=yw1NDS5zz0qkLEtczu1STZFBeq+soEF0GYhN8HTBw@mail.gmail.com>
Subject: Re: [PATCH v2] binfmt_elf: Align eligible read-only PT_LOAD segments
 to PMD_SIZE for THP
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0F7E022F41A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hev-cc.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[hev.cc];
	TAGGED_FROM(0.00)[bounces-79715-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hev-cc.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r@hev.cc,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

I ran a quick benchmark on x86_64 as well.

Machine: AMD Ryzen 9 7950X
Binutils: 2.46
GCC: 15.2.1 (built with -z,noseparate-code + --enable-host-pie)

Workload: building Linux v7.0-rc1 with x86_64_defconfig.

Without patch:

 * instructions:     8,246,133,611,932
 * cpu-cycles:       8,001,028,142,928
 * itlb-misses:      3,672,158,331
 * time elapsed:     64.66 s

With patch:

 * instructions:     8,246,025,137,750
 * cpu-cycles:       7,565,925,107,502
 * itlb-misses:      26,821,242
 * time elapsed:     61.97 s

Instructions are basically unchanged. iTLB misses drop from ~3.67B to
~26M (~99.27% reduction), which results in about a ~5.44% reduction in
cycles and ~4.18% shorter wall time for this workload.

Thanks,
Rui

