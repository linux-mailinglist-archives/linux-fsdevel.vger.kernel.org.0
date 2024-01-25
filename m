Return-Path: <linux-fsdevel+bounces-8978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A283C8E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59442B218B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94321468EC;
	Thu, 25 Jan 2024 16:46:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73176137C42;
	Thu, 25 Jan 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201171; cv=none; b=qBhU4UL2HTa7oyYogYYrxjI005A/0FwnRelTbwhESQvctXl84gXtLI+jco3QLjZiQaK2eK+JOZZJX/gacG6nk/5S8dlXXDVYxNYDc1NnaQt6NtjyzRosApgUXFMShchTWoO0DL2K4KxKnHmv1rkxN4JuiXD2Rf2kXpwaiSHsfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201171; c=relaxed/simple;
	bh=RYSkqFOQ01hFCkK6kdRl4zoorgEFa1qy6JwzzkzXoKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJjmxybI1hql6mlmqZ9vubcCnUuFM/lw7XLXqbZEuqqTSqj3K2sP+Nfzf5Iqr3a0ohjbbnk2RzwUv5GXZr1PBbVUkts9dQxmIqFMejhkiTwudtuoBBirIAe/FSX5iyAjEfP24Uw0pgDjfbbpxbjSxtTtAukW7dk0rEvbgkeBa8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908D41762;
	Thu, 25 Jan 2024 08:46:53 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DED3F5A1;
	Thu, 25 Jan 2024 08:46:03 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 35/35] HACK! arm64: dts: Add fake tag storage to fvp-base-revc.dts
Date: Thu, 25 Jan 2024 16:42:56 +0000
Message-Id: <20240125164256.4147-36-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Faking a tag storage region for FVP is useful for testing.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch, not intended to be merged.

 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 42 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 60472d65a355..e9f44420cb62 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -165,10 +165,30 @@ C1_L2: l2-cache1 {
 		};
 	};
 
-	memory@80000000 {
+	memory0: memory@80000000 {
 		device_type = "memory";
-		reg = <0x00000000 0x80000000 0 0x80000000>,
-		      <0x00000008 0x80000000 0 0x80000000>;
+		reg = <0x00 0x80000000 0x00 0x80000000>;
+		numa-node-id = <0x00>;
+	};
+
+	/* tags0 */
+	tags_memory0: memory@8f8000000 {
+		device_type = "memory";
+		reg = <0x08 0xf8000000 0x00 0x4000000>;
+		numa-node-id = <0x00>;
+	};
+
+	memory1: memory@880000000 {
+		device_type = "memory";
+		reg = <0x08 0x80000000 0x00 0x78000000>;
+		numa-node-id = <0x01>;
+	};
+
+	/* tags1 */
+	tags_memory1: memory@8fc00000 {
+		device_type = "memory";
+		reg = <0x08 0xfc000000 0x00 0x3c00000>;
+		numa-node-id = <0x01>;
 	};
 
 	reserved-memory {
@@ -183,6 +203,22 @@ vram: vram@18000000 {
 			reg = <0x00000000 0x18000000 0 0x00800000>;
 			no-map;
 		};
+
+		tags0: tag-storage@8f8000000 {
+			compatible = "arm,mte-tag-storage";
+			reg = <0x08 0xf8000000 0x00 0x4000000>;
+			block-size = <0x1000>;
+			tagged-memory = <&memory0>;
+			reusable;
+		};
+
+		tags1: tag-storage@8fc00000 {
+			compatible = "arm,mte-tag-storage";
+			reg = <0x08 0xfc000000 0x00 0x3c00000>;
+			block-size = <0x1000>;
+			tagged-memory = <&memory1>;
+			reusable;
+		};
 	};
 
 	gic: interrupt-controller@2f000000 {
-- 
2.43.0


