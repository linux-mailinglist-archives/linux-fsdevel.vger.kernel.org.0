Return-Path: <linux-fsdevel+bounces-45097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F8A71C37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7507A337D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A71F5433;
	Wed, 26 Mar 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyS3UwKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2511F63DD;
	Wed, 26 Mar 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007744; cv=none; b=Le0/E0HzC/TFtzoNmCVyh2ZIQ1M9F4dD1cgdXMtHUq9MckSu7WqrF1t10vSEA+3gPKgF3bhgXmYMx8O3RvsMRvr/SSHxfFlM9GVIXYJPFdMZSMDzp5IaqIP+/S1YJTrLukQTrFzmK04dZ72uW5bZ+cT0EEX5AYL1axqkfj+VbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007744; c=relaxed/simple;
	bh=/j6PcOoWyDgRrb4mDoUwSYJNqXaS+qewMovhxAHvQ1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pXWvz6sc4i8TlOk1FF3l72bNjgcunqboMiQCFjHG8bbzKgzPkU1eRIW8Dv4y8Voj3hPrMMjWTlwzoN54pYKuLtJyBEkUMlDMHZDcF1uO098Eik3aLR+XLEPdLhlFskKzfJ95VM/88TGzXj2wxoCPWEz0JMWk4XkuEyaPJXdES1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyS3UwKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AF7C4CEE8;
	Wed, 26 Mar 2025 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743007744;
	bh=/j6PcOoWyDgRrb4mDoUwSYJNqXaS+qewMovhxAHvQ1Q=;
	h=From:Date:Subject:To:Cc:From;
	b=JyS3UwKK3WkGtk39qAWuY7N9POEno+elq8+Yn63ObrElD0PH/fWZWWgGKIAG64Psf
	 nwJMov2csx1azoWJ8WSDwB4w4eKxd+zoxgBe2KvFPIJpzgixDr2E9DoBBRVKJOqAWg
	 2TFDMDu7iWVWQmdSkPQ29vYEvlSIO7lugoJP0nKlpOfIrJDkKeQSpaDwjjVNUWRio4
	 oU8O6aOloQYP0kP1yygoP4kDARVAs60jiyLdtK3U+ftX07fJdzfBtA1npzcSUu1Ola
	 IhLFp8DNVg5hEffOYMU9HzGkBUyQuu126xwpH0jZ98wXW/vlSnCdzqq1rNf6DtYm+P
	 59gictiW/9nxg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 26 Mar 2025 17:45:30 +0100
Subject: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-configfs-maintainer-v1-1-b175189fa27b@kernel.org>
X-B4-Tracking: v=1; b=H4sIACkv5GcC/x2MQQqAIBAAvyJ7TjDTor4SHcRW20MaGhGIf086z
 GEOMwUyJsIMCyuQ8KFMMTTpOwb2MMEjp705SCG1GOTIbQyOvMv8NBTuBiY+oxJ2Etoop6GVV0J
 H739dt1o/1dN962UAAAA=
X-Change-ID: 20250326-configfs-maintainer-9e40c705a4f5
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=/j6PcOoWyDgRrb4mDoUwSYJNqXaS+qewMovhxAHvQ1Q=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBn5C87y6IUdxQ9EJ3NhSrjxdqXDgFE/kOR30jGs
 xF2EKadJSaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ+QvOwAKCRDhuBo+eShj
 dy8GD/oCrGI/gskZiZMr9Nuvx5Ycpzijn/pIDaqkH8RyHRLyWThcn3B/w2xOVGnBxbf7ahWesVE
 yOnnxX1FVr5yC1PHsPIXeWgnfLplYgtYNkvNkOBhB9kBxRchVvUO4l24g0iHNmCwl6khmebED8l
 +xh5otRCFy9WZ0G9l3xbVk3sVwXtKd77lWInSZ1ITCSrFpxA5G9GvIHsUIuqXmPA+by4qRo9tF9
 wLk6JNrDjB5RATDlHJ07QIbbFrEYLju/Il4rYwJvN7om5buz12agrBIP1GHo8hRdy3ZFInMHp+X
 E2b130MpYH14r5Hx6LajYj9u8i51e7voA1He0QkwKzJV5UZ9XKiyzcCEincMEiAYMy4yOoTDLXA
 UtdG4jZZweIHaJWMOdobXQH6Sx8TpvkCaB1f1Yv6o4pJ1LvfMYxAaqKCTuElyqoUYjgO7I2Z/kw
 zd6yaH5dCpFP5cqnRifmcm858vd2MOZ6ipcseZaEtYeZfEP/41RSLKPR5wJTpHnAewTBISoLjnK
 8sFnMh/iyzQp8iU2LIsWTbmRr3yT4pfB0tf++Q1XH8JrelqyCce+T9JNCZ0dgWINTIbS3cZLMjQ
 8KRlp7PPQ/CtrHDULtlkgkLF2GjnYme4HnAMrsNgf76cbpCp4TTJTVf+3CG4SBsVutK0qb2K906
 vHQZFE090OAxXeg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove Joel Becker as maintainer of configfs and add Andreas Hindborg as
maintainer and Breno Leitao as reviewer. Also update the tree URL.

Add an entry for Joel Becker to CREDITS.

Acked-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
As recommended in plenary session at LSF/MM plenary session on March 25 2025.
Joel is no longer active in the community.
---
 CREDITS     | 4 ++++
 MAINTAINERS | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index 53d11a46fd69..3ec620f7260b 100644
--- a/CREDITS
+++ b/CREDITS
@@ -317,6 +317,10 @@ S: Code 930.5, Goddard Space Flight Center
 S: Greenbelt, Maryland 20771
 S: USA
 
+N: Joel Becker
+E: jlbec@evilplan.org
+D: configfs
+
 N: Adam Belay
 E: ambx1@neo.rr.com
 D: Linux Plug and Play Support
diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e..ff62b2bff99a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5860,9 +5860,10 @@ S:	Maintained
 F:	Documentation/security/snp-tdx-threat-model.rst
 
 CONFIGFS
-M:	Joel Becker <jlbec@evilplan.org>
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	Breno Leitao <leitao@debian.org>
 S:	Supported
-T:	git git://git.infradead.org/users/hch/configfs.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git configfs-next
 F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	samples/configfs/

---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250326-configfs-maintainer-9e40c705a4f5

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



