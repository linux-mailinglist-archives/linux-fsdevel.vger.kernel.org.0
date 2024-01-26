Return-Path: <linux-fsdevel+bounces-9056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3717C83D9B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 12:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699531C23AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449341B81E;
	Fri, 26 Jan 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvLqJK7R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D771B7FC;
	Fri, 26 Jan 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270001; cv=none; b=VSEkK1B3fVnyUvLy2+5elnNu5D+YipH5H7Tdovg0uFYCdNW4qTG7GtYnWWtBQKCAOO2gh9uuOcqE2/XAJppvFem1Mjnz/gxhw5MJn/1Zyecu+C2Hym9Oie1IV02jt3Tix2YsGZOTOLsegGGl/zynUvZp0lUaiXYYmtUWI2V7vIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270001; c=relaxed/simple;
	bh=mYVNQgM6kMHDUeCkfyT25ST4WXu1tfC+Y8pHyYECgOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ne4Rra/FW7s7A3PyYs6kxIPosGVP7tpBK14+lV3kDAE4cv80cMykRhOxRC84XOefFqlF3EdjydYOuVNT7x6BEnZqYmNIBW7+wN9joGxkbist56fXYz4jCBC107DzG6XZ5o04uDS8hNwEE81adalSC6A3/MfSqY/h45gpCmPEdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvLqJK7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D9B1C433C7;
	Fri, 26 Jan 2024 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706270000;
	bh=mYVNQgM6kMHDUeCkfyT25ST4WXu1tfC+Y8pHyYECgOA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IvLqJK7RYbT7rcITRvd26yrHRTmlcglbqdImxlXPll0UJtEaPXB3/tXUh/VQ6H1zl
	 y3r+4QsUTJGA/CtnlDj312sA5MoyZnPHvIYD8N+PaAquDkc7zAsXeeT8uq6OYjEi9j
	 dUoJ5x2MN4Kh08kEhMufwCF1tA8vmh07sExgsDIEfc9OvWzhwOw9KhVZF8lKQTq9yt
	 H2ftONqVu2yZVvfDHSUcaueaxU7mRrcWIuC3Z2RhkXO58666NWbZiiIeATe3VN6+33
	 D5f/zYZOj8n1WXbIyM1iYwIYv5MS/JjaLJfED457ZuhSIyT1wYiU638BUld7IisOwk
	 admXsp66CW3pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D6C47DDF;
	Fri, 26 Jan 2024 11:53:19 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Jan 2024 12:53:10 +0100
Subject: [PATCH] MAINTAINERS: Update sysctl tree location
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-for-6-8-v1-1-9695cdd9f8ef@samsung.com>
X-B4-Tracking: v=1; b=H4sIACWds2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyMz3bT8Il0zXQtdC9PkVMPkZDMzA7MkJaDqgqLUtMwKsEnRsbW1ALV
 8bghZAAAA
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=HPzyLD05I4KtL5puu5ieEBvpSzlKvZSf692MeTRD/W8=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBls50uspKcXsj8qrMDVqGyepCioSHe3rOrcOGfm
 54ZYMwuEqyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZbOdLgAKCRC6l81St5ZB
 TwJaC/9FXc3g2NJntHWyQL3KlEAlSfdCC/EaHcjQAlqDr8E64qo5+KKNTkfTvqA8hhv6bcZxYbd
 ddwPPgQ9TMcbAF3QNFabMUOPO9jeFTHUCCBtYLLl8DPlddE8zG8rwi/mPRvZDYPSeDHSApz7c6u
 HapJQ7bvtI5u0r/3GbGERUx7v75w9BYuqmrybG/4PLjuq3HS/zHQpCq3FZiBLVWtDZHayPz2iyA
 N8n6QgtoomxtmXEaP9MnmzTVZxtqrSCu+18cNnCyxtjRRJewnEqYyZ+yDWBTcpoCd419g6atKAO
 kuk6b7vSuAHqakJYUYH7phreGRzQ7zxqVrC5b3vLAoAbrWkmeLV3hwOK4sK4NCyRKoGjezsNeU/
 zeUraXW23MJKbFxqqz1/E5cMQHgg4fEdSBfYfugMP/3u97vGitt0jLAgwW1a8HRH5mgsyjBl97R
 V7V6z0mA6qn4t/7k4RvH2NVm5I5n56sNFaOlYNzL0TFgA4ac4BQnrQsUZJjR1E9t6uMAw=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

To more efficiently co-maintain the sysctl subsystem a shared repository
has been created at https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git
and the sysctl-next branch that Luis Chamberlain (mcgrof@kernel.org) maintained at
https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
has moved to the shared sysctl-next branch located at
https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next.
This commit changes the sysctl tree in MAINTAINERS to reflect this change.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..adf69ab891e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17616,7 +17616,7 @@ M:	Joel Granados <j.granados@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git sysctl-next
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl-test.c

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240126-for-6-8-85ce1cc6606b

Best regards,
-- 
Joel Granados <j.granados@samsung.com>


