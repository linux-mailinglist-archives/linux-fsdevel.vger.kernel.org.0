Return-Path: <linux-fsdevel+bounces-29994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29125984B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576111C230AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222513BAEE;
	Tue, 24 Sep 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vQk6gcxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4E1B85F1;
	Tue, 24 Sep 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205846; cv=none; b=ZFKra+/JLkuRv4wcem+Cqv9y6vj4i0HEONEriBFV9S4f1EjdypI5eML4Zwbmrea1QQZnUWrQwaXKLODQKbDEFh9OZR1PxxHe5QCLVaW4Dc5chnnW0YWn15T2Ee2otNsMH9PCyMTFVfIC8MlYbCIEzO4MVySik67Y1AJ6BQNCP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205846; c=relaxed/simple;
	bh=NDG6ALr1R5N6nYXJ1mUALoq8v7Z6f/xPQjOScNhTEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gG3GBH9X6S/zdhJC8QOpWbxZA2JfIwJ0ncZYf77gil7wk9DL9/0115/+VGlOYUY2XS0zX6vsc4la4z5dyaLcrHIBRI+4t7xG0k98QmEFo++oWxFg3Zk5I/o+2u6WhShCDtHi2WYB18rTTQRqXdMYcGbBTdS9GX8XRnKhGdx/J0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vQk6gcxW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XCqXw0Vt4z9tjc;
	Tue, 24 Sep 2024 21:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1727205840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=17WJMeltX8R2P17eHC1mKHMp6fqbwE3q9+yXZvGUQ2g=;
	b=vQk6gcxW3DP8rDJl7tkU4Z1ma6xPXDGpAGqwngp8Xu7t693wOfnxXRmhpSjRM72BVX0SyP
	VkUx/foV1Xvi6q1+quo+lpfoXy9+5tU2reelB7gdI+0OX4f0EqRnzEgNxVMSWE17BK60w4
	aK2t3McrWYQ14D7Wc1JQHqEtnZXoOCvIHti1z86BAdF/lYIQ2i/SDKR1MTisyhMRj3dbtC
	VYIXltQFxqjGToLJPSVJ7M1mcbRTP59rS4begZ0avh7QRZWDBxRCzeeZjK7qzRmVkXsmaf
	KwEGRnalRYaAc/ms8hnIKpUJEIjaE+FqVMywx0QHlDwBJwPfdlYVsY8Y3EIuXQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kernel@pankajraghav.com,
	Christian Brauner <brauner@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/2] add block size > page size support to ramfs
Date: Tue, 24 Sep 2024 21:23:49 +0200
Message-ID: <20240924192351.74728-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Add block size > page size to ramfs as we support minimum folio order
allocation in the page cache. The changes are very minimal, and this is
also a nice way to stress test just the page cache changes for minimum
folio order.

I tested the changes from blocksize 4k to 2M with ltp's fsx on an x86
machine.

I ran a basic perf test with dd as follows:
$ mount ramfs -t ramfs -o blocksize=$bs /media/test/
$ dd if=/mnt/rand of="/media/test/rand" bs=2M count=2048

+------+----------+
|  bs  | BW(GB/s) |
+------+----------+
| 4k   |      1.7 |
| 8k   |      2.4 |
| 16k  |      3.2 |
| 32k  |      4.0 |
| 64k  |      4.5 |
| 128k |      4.8 |
| 256k |      5.3 |
| 512k |      5.5 |
| 1M   |      5.6 |
| 2M   |      5.6 |
+------+----------+

We get better performance for larger bs as we allocate larger folios
instead of multiple smaller folios when there is no memory fragmentation
and pressure.

Pankaj Raghav (2):
  ramfs: add blocksize mount option
  ramfs: enable block size > page size

 fs/ramfs/inode.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)


base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
-- 
2.44.1


