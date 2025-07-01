Return-Path: <linux-fsdevel+bounces-53451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C8AEF207
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FB7442B21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0226CE27;
	Tue,  1 Jul 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNDFq16F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC422609F7;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360238; cv=none; b=ZVqgH2JvYmwr8Z9Bjjf+Idv8B/7Yld3TTIA88pdkPw3e088Ht7cHLamLRqg60Xu3K/spRUrURsodpTqfQGcEHKWJ3IyMmwImzfbp8xBMUfH5IQvIZHEtCYpNKtiNGN3nYNO0mtvyHQ4DaI78CGJOqmFavVar/cHSwjb9HDJ2eYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360238; c=relaxed/simple;
	bh=ePs3rKA84il3gm9cXFfVHZ3ucJrNb+nPVHECDo+XbZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwPdtwimcT5vZI/hQK1LHKDNg+vgbfZets8/1rmHJ4SZXY0wgIi4f8cqelctz+UHkvR7L7M1jyDqIL2AsREOsjhNb0lb0tpxjdXgIJvTFDW/JUdKyoMWYSQ3pAo1gMvNOSHxN+ec0VH8Wj3ywALd5gp7bJGCn1lT7cXHBIMiC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNDFq16F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E99F9C4CEF3;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360238;
	bh=ePs3rKA84il3gm9cXFfVHZ3ucJrNb+nPVHECDo+XbZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cNDFq16FletVTE+NfGeEhHIPc0QdYj0aOPGiETDNaNK3HOJpLXhe1IbKwg7zAtojZ
	 bEbfePcBN0H4PCuSTT5PNspKsbjMs/IUzEpt3ULUMLrS38S/0o90LyW3BhBumkd3j/
	 tasLlAynfjPQvjxQt67kIzLKz66eqJGJWOsaHRnINVZHle6w1JRESDgxDYvPVQUbvw
	 xm2lcv1B/K3ZHxx5B2jzh/U/nxw6YcVx2ZQ7q9TeeGZ4kx48zcb3zMhtJv9C1dcHLt
	 nxAmB13ArM44FGDNKUMvvjGJ5TUxTSQiYCWgMG9QcyPx4ooVkLLf6qvIVsNc8ywLC+
	 ZulIlbCC2n/zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0662C8303F;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 01 Jul 2025 10:56:45 +0200
Subject: [PATCH 4/6] docs: Remove colon from ctltable title in vm.rst
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-jag-sysctldoc-v1-4-936912553f58@kernel.org>
References: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
In-Reply-To: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
To: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ePs3rKA84il3gm9cXFfVHZ3ucJrNb+nPVHECDo+XbZs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGhjouoNu2I0ilCYWLHWWuG47LqYHwLaTWL3g
 OQqm4JJtVO3YokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoY6LqAAoJELqXzVK3
 lkFP7iMMAI3NMJR99dSUgXyOUtmWmrLaFiCA2eWJ02jhi9jyeDG8vcCXeXnRXVtb0tGHTMA6/01
 VoDeAh8fLOsUthbt3PfU7ZBmMfqEDJrF42hyug+KWNqNngAK9YKNsuQOVBluWaHhPzEdpH7DwMG
 B/qNvNttRWVTPsoVFh+tsNguiXU3J6zatmyEoi7zP5ycDkLu8nkL9AvzEaVilfn7R3R3kmGMTym
 IIv1bTqrHXE2mEomvaQ08a5PKPwQBva+ruTEnHxCxfu9TWRHqtwOkkqlsTMbFKykrny9P73idu5
 5o+VXozhMUzwUBfS9I52vZ5gVhI3ezempQe1X2em4K15yWlNdu0EcJhll7EL9XxbtdrUfvVDKq6
 6IJmwZFFGh5dE33oUaWUfw0/fdc5bjwIqKxreW4K+wPp71JHymE3zQ+9qxqA536z7fBJxOXQa7A
 6NI/7JELVvyktBH3O8bWA55sb1fL+wIsAb6cJYUZcMl8VvFCPUuRHPooslppSBftwnb57C6rLu+
 DU=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Removing them solves an issue where they were incorrectly considered as
not implemented by the check-sysctl-docs script

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9bef46151d53cd3130a4a14c8a66bfdc3a5561b4..4d71211fdad8d061ccdef57477ce3dca5c78741d 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -465,8 +465,8 @@ The minimum value is 1 (1/1 -> 100%). The value less than 1 completely
 disables protection of the pages.
 
 
-max_map_count:
-==============
+max_map_count
+=============
 
 This file contains the maximum number of memory map areas a process
 may have. Memory map areas are used as a side-effect of calling
@@ -495,8 +495,8 @@ memory allocations.
 The default value depends on CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT.
 
 
-memory_failure_early_kill:
-==========================
+memory_failure_early_kill
+=========================
 
 Control how to kill processes when uncorrected memory error (typically
 a 2bit error in a memory module) is detected in the background by hardware

-- 
2.47.2



