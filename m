Return-Path: <linux-fsdevel+bounces-53448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76285AEF205
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557033B1C42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156E26C3B5;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGqLX9VY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23662237707;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360238; cv=none; b=SRQS2NyZCWHLtrfYujXmruZB1JRF7FHAXgl+eKPeQLBOR5O4SDUUWu5AT77deL2y2n7hKqtmxzcT3GP0N6Ghzac4tkfeNkGY/QfrHrrk0zI4RetGNVNUdK6j2Lv/burfoYe5snh92hcDcLlNmJcxm6SCreLhRYaUI7O7BTMW8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360238; c=relaxed/simple;
	bh=dP90U+P+CIJkX3PevzW9Eoc1cobYxd/SZNH6G2NvVvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pkdPKVpYNNhiVwjwhosOXhta6Np6nP8AzJLp4J5lubnEWnswUCV7kFC//rz9DKkE/6uWBKhY/2g1Zu5VN1kFg0P+Ds+bb9/oq3SMV0iyd5dU3YEgmbPBxLvsoVAMNh2gnvBRLxLJiACuKMfawZ/MbZYB8dMAbu7RmYlttzsDpq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGqLX9VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B89D5C4CEEB;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360237;
	bh=dP90U+P+CIJkX3PevzW9Eoc1cobYxd/SZNH6G2NvVvo=;
	h=From:Subject:Date:To:Cc:From;
	b=bGqLX9VYHiEQceo1jpTP0qNo7U221u/c6/SKV0j6ao5/kU5a/oiF+gN23CVN6WVq2
	 IHjLEU0e6qNvDGbsUJ0LtgflknNjSajIns+plR9/JOWCrTu6v/3TzEj2vyYzZbLUvo
	 //AKeBhd1Q/pEC/8sFpCmS816VSX+Mxf7WNw3CHjWCAGIUKDn7O+wipudGAX8gUayI
	 OukNQogwkg8iWUSWPXbndrdiL2qnYG/Rg/EWJKBZsDZhZdYKZMaYps9Xzvqz7RY+sR
	 PBMM3heuWCDnllKvWbEGkdrvW5B5ssHx1zHBIAxd7GZ92+h3D5cICG0g8kwGzdHtXm
	 Y7x7hldO7Tckg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A674CC83038;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/6] docs: Remove false positives from check-sysctl-docs
Date: Tue, 01 Jul 2025 10:56:41 +0200
Message-Id: <20250701-jag-sysctldoc-v1-0-936912553f58@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmiY2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwND3azEdN3iyuLkkpyU/GRdYyMLw+RUc4NUI4skJaCegqLUtMwKsHn
 RsbW1ABH4LJxfAAAA
X-Change-ID: 20250701-jag-sysctldoc-3281ce70e28b
To: Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=dP90U+P+CIJkX3PevzW9Eoc1cobYxd/SZNH6G2NvVvo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGhjot2AfezT7qOGdr19ioQfavdV9DUKox1i/
 DrrVSqP5eV72YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoY6LdAAoJELqXzVK3
 lkFP7WIL/2XyjWIY8MH+O6PwTq1+qzC/LvN6NJLzZEpEAkcsfEkSuJEeRjN7SgwiHNPvmYhiUKt
 n6IGsJDdCa6bXWpNAIpADHqebELpG/nst/oScGmdBE/6wiVc3DEDdAYgkvzusitb8OPA7WVRL6i
 JQ5fYy+QD9Tnvgzdhgc6JO401DOJan7piJVygliiqxUZLgtvtQtxpUQXxi098HxW1F7pRWxzOL9
 PPzNJfPBF5lyn6+dnp5jtZPSTUfCbo8rnurr0yY8bRGaJMZ6Qbl385ThjpgfhL+ADpr9ahQXRHh
 ot8CQ0u0Tw0eC+T7XpltJ468fh2+Gl2NKVr0iBhIxbIeslSYPVsjI6HKWIYrfWMnN1lgwTT9WPC
 MbHrjgSVjEpcMquHSN17VQHuiVufWJ2ofuAR37q83LTsJ3oFfl8VYycqNijRwoMb5/rrNyyZiLZ
 ctjNJcj/ssk3hnu2IISO3wadRSJ9EqQ6b0cAMNoIYm9uk9X3ag8f0IzApiyCpFrlc52ECB0gFI6
 Pk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Removed false positives from check-sysctl-docs where there where
ctl_tables that were implemented and had documentation but were being
marked as undocumented or unimplemented.

Besides adjusting the patterns in the check-sysctl-docs script, I also
corrected formatting in the kernel.rst and vm.rst doc files (no wording
changes!)

Please get back to me if you have any comment or suggestions
best

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (6):
      docs: nixify check-sysctl-docs
      docs: Use skiplist when checking sysctl admin-guide
      docs: Add awk section for ucount sysctl entries
      docs: Remove colon from ctltable title in vm.rst
      docs: Replace spaces with tabs in check-sysctl-docs
      docs: Downgrade arm64 & riscv from titles to comment

 Documentation/admin-guide/sysctl/kernel.rst |  32 +++--
 Documentation/admin-guide/sysctl/vm.rst     |   8 +-
 scripts/check-sysctl-docs                   | 184 +++++++++++++++-------------
 3 files changed, 120 insertions(+), 104 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250701-jag-sysctldoc-3281ce70e28b

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



