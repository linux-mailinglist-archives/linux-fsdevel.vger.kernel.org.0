Return-Path: <linux-fsdevel+bounces-53449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47023AEF1FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F2E1BC4F21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA326CE08;
	Tue,  1 Jul 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhh46ATT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D3246784;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360238; cv=none; b=YZ3xh4X6m0LrpHRRmM/pZrH/goVoXCubu/9KiyrIc4cLc7SNgU9RbIxh34oECjxUWQsxG06OOrFBpwLJVM1rFfAO0XJgJV6/IcokSsR/06drNkBSxisjdmHYNSd1AuTrEsUKp7aoYmWzi6zs/z0GeorDSDHgMEzAYeFB29HU40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360238; c=relaxed/simple;
	bh=JVXQ/8IYf8XnXtTQdEVwyxaiGUvK4wO6JQSfGjOdsb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQ3ZxuQ+z35Hm28sQKXPzpm2lVB394lRBeZoYXrSHUmzxz4lGiB32f0b8mG4ya9ywakyiCSSCBxMxVAdUiapP0kPSJo5R4/GREWjXp6BGzX19csUXXPphlSLuQJc2xwGM7F+dr/BhEVhAL8lMWgpGw4Kr8ZoadXaa3YhA4XQ+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhh46ATT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C505DC4CEEF;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751360237;
	bh=JVXQ/8IYf8XnXtTQdEVwyxaiGUvK4wO6JQSfGjOdsb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bhh46ATTFHrOd+dIK3J5Xs6zGbIxEe7gp/qQk4eB+4fpy6WrEYEjulhJ0daQHb0Bq
	 twxIG/sXzV4+7jiuNKoA7YclwAmZ9VU9f0/KnUTtG4inNeq4V6OMnwLpdRAET4JByb
	 XDdEkugi7b31K0vsUQdVP0AP6vdmXidMjOsCissOzmbMZRH3vLWYfsgDZexy2LoMrI
	 4vppeF1Ky8I8tpNryZidhWTkAeFqtnJDhnF7R7gKYDqJqoAcXvLELdSKPHoiWXGZ6g
	 o3ZqRNoZCdck/DBYZT28OMhr2Or+n1fQYqNbmmiSvusL/6m599D5v+z10kkbgUjBWe
	 bwozHaDczCZ/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7245C8302F;
	Tue,  1 Jul 2025 08:57:17 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 01 Jul 2025 10:56:42 +0200
Subject: [PATCH 1/6] docs: nixify check-sysctl-docs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-jag-sysctldoc-v1-1-936912553f58@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=723;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=JVXQ/8IYf8XnXtTQdEVwyxaiGUvK4wO6JQSfGjOdsb8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGhjoukEx+FI2E8vSQQRccHuWoI9V1GcM0R7d
 fKbDkKzE3co9okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoY6LpAAoJELqXzVK3
 lkFPbHMMAI06sGLAcctT2iDoYoE/iAsxas2+g68NDcMNxpeiUDzAlcKHcqy19oUW60QUNafaHbw
 XhZBaJFUFsXTtDn7IOAEtmosQ/kIHVMmkDdzvhzzOAEBxgIWTKygd7/0t5wQ+AVlJaREhqw5M4k
 ejm9QMffJ6cxlQvwlZ/B50nBTPQVPnH/LNHpP/Hc/LjZ59SrTcoOq55h5ni+/Z9hzCunhpDaV2b
 mUb44PwZRk8xanfhibjwR1CUk/EBTRNgcIPgCL66a/+AwGbEhr+TcoXVWKr+sL1tcbKxm9UNk+C
 56u4lIMZNouNy3oiDq4qx0OvjtIbRxKlCjPW+tVvi2IAqFRwTDTYCLReBxc1vQzzpRhdzFxkbF+
 eOHc4TiPgzxYqgy8WZw9Xlmd7sUlsEbgHE0miDath+JJ2jj/dCL7uwnFAW4BsupMwMZLTgFqg5X
 inKmhL/NfdUjCpkf3EPkAPpGVrqsm0pawB6v1HzsAjdY2eJTtc64AkZv4GZzNc6nmBEVpC7UuY3
 30=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Use "#!/usr/bin/env -S gawk -f" instead of "#!/bin/gawk". Needed for
testing in nix environments as they only provide /usr/bin/env at the
standard location.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 scripts/check-sysctl-docs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 20274c63e7451a8722137e7077f4456f293f4e54..178dcf2888ffd21845e8464fc2595052c02ff4a3 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -1,4 +1,4 @@
-#!/usr/bin/gawk -f
+#!/usr/bin/env -S gawk -f
 # SPDX-License-Identifier: GPL-2.0
 
 # Script to check sysctl documentation against source files

-- 
2.47.2



