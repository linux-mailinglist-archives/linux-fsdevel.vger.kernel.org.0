Return-Path: <linux-fsdevel+bounces-78838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mED5AJP7o2lPTgUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 09:40:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6271CEE15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492F33019F21
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C54B32FA3D;
	Sun,  1 Mar 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ek2T8Bcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F32A932;
	Sun,  1 Mar 2026 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354440; cv=none; b=XrlozgNUrCaGsitugOjVRAv47OoOXAA9++RXQ1qY9gl4/hZYp2mOEmu3UkihTVHSV1g2mA21HOGsQ8C9alfTqLsjAdB4dIYzvsJb9wFy6jqE5eimqnkBgCwWSDOP2HsfLplkpdaXsH2ZISjqStNiMUuRF0bPvN2pnbri83K8+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354440; c=relaxed/simple;
	bh=QXC4GGpRUNa98ffrfmxlM4QdE5cMsb5xA4dsxoNHgcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnXoQu4WSI0+uKhbB3gnX1MB3VTViezG2Ax0GX8GAonev0WvbSqU4A8Dv6YHEUYN6AjUbhBF9Pa9PntX2Ug5MgnPsZo330RNXJfkwAvzE0rjTZar61OVyttuspvlyXw+dQ7HWBGmgaUJGrE1/EA5iNayEzIF4pO0CukZ6bNKswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ek2T8Bcf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PFp2jwYoJiwmHoZgumraJXdJLAau7/xpL1zGznQ0p4A=; b=Ek2T8Bcf0qd2IcGD9c6aEKkby4
	MTj0F3QPFeWyISNPdDba/GT+KXGhATS+MRWMJDtbKDOZUGWeVn4aqpEK6a/KrxsrGNBubTPYoz5rV
	EmIW4IwFaXlV5yeZHkTi8GK1TdT6nnirTEYrBHgSZiPGJLLOLJXpLCuYD9BUgQm9gJsMd+9xVeHIy
	hNVaRNpTIT/FL/5aI03iSGX/pmjRM9QikrkQSHJwSYg5VYVQQ4RSBUYciXUYgBD5liS1u2oHF2ne/
	Y+b/wvZIngs2LkbhAZ25GcpvouP7gViTXSE3qF1S4zST2POzC2VlAtvXNomN7D9xdkgTRFnmZA4wH
	L03qxFDQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1vwcLm-00DVlM-Lo; Sun, 01 Mar 2026 08:40:31 +0000
Date: Sun, 1 Mar 2026 10:40:28 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	debian-loongarch@lists.debian.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aaP6atFYpVqulTO1@zeha.at>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
X-Debian-User: zeha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78838-lists,linux-fsdevel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeha@debian.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zeha.at:mid]
X-Rspamd-Queue-Id: 4A6271CEE15
X-Rspamd-Action: no action

Hi Sumanth, looong64 porters,

* Karel Zak <kzak@redhat.com> [260226 14:53]:
>The util-linux release v2.42-rc1 is now available at
>  http://www.kernel.org/pub/linux/utils/util-linux/v2.42/
[..]
>lsmem:
>    - display global memmap on memory parameter (by Sumanth Korikkar)

It appears the test for this is run on looong64 and fails there (failing the
entire build), at least in the Debian build infra.
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=loong64&ver=2.42%7Erc1-1&stamp=1772312955&raw=0

See below for log output excerpts.

Thanks,
Chris


log snippets:

================= O/E diff ===================
--- /build/reproducible-path/util-linux-2.42~rc1/tests/output/lsmem/lsmem-s390-zvm-6g	2026-02-28 21:08:31.577617951 +0000
+++ /build/reproducible-path/util-linux-2.42~rc1/tests/expected/lsmem/lsmem-s390-zvm-6g	2026-02-18 11:33:47.804188659 +0000
@@ -17,6 +17,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -27,6 +28,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -40,6 +42,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -73,6 +76,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -216,6 +220,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -237,6 +242,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -256,3 +262,4 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
==============================================

...

--- /build/reproducible-path/util-linux-2.42~rc1/tests/expected/lsmem/lsmem-x86_64-16g	2026-02-18 11:33:47.804978102 +0000
+++ /build/reproducible-path/util-linux-2.42~rc1/tests/output/lsmem/lsmem-x86_64-16g	2026-02-28 21:08:31.887234145 +0000
@@ -37,7 +37,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -49,7 +48,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -61,7 +59,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -199,7 +196,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -523,7 +519,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -563,7 +558,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -603,4 +597,3 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
}}}-diff

  FAILED (lsmem/lsmem-x86_64-16g)
========= script: /build/reproducible-path/util-linux-2.42~rc1/tests/ts/lsmem/lsmem =================


