Return-Path: <linux-fsdevel+bounces-21185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C99900341
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B4E28677A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B06A198E73;
	Fri,  7 Jun 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="aT1r6suv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAB196C9C;
	Fri,  7 Jun 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762587; cv=none; b=ucJTWZNi2AzS4tN1NBDLlGXMTobIYIgs++QLSjwDwt2LbS2KCvRG6007RaVEHyPB0oN3w1FNVCMGJ/hKnZLC9AiHpHT1kogHueJFerGmljd6aDEkppyYUu7ifoM6AtS9llW0r2rhaus8+vQq5JUW4KEIl1QMo20SBqOKiHO/p7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762587; c=relaxed/simple;
	bh=JSCX7RvGYGCm4Gt9Lb/auQxZOXkDNo7HEW2q6MDF6cA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ4o33zrolHe/p4wfJMAcmDys8wVwYB2B3P/WKghVQswqOF8mMCbBl5hStNaLmhzzkzFUm1xyYx7/va4V1/UGBYdhs0vLV6P1CXiOOhY9neCHd6Ag6xudw7eQx2JQ4+KtvEvayoOEGFlCy+ALn0Td0cuYNSC0xHrr5hRal/GX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=aT1r6suv; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A69552117;
	Fri,  7 Jun 2024 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762110;
	bh=ItUueD9NFEUMthklqoi57QXeYkb5LTRd3/OWcQ0+j1c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aT1r6suv1YQ7IBfTqgJ85L69Qt3lCPBVsTzu8fLkiHW1XbadA47yNnXND9dEK8ERJ
	 y3pOs4/uH3QF/XgTqwFEV/svo7VavCzyGR8v0O9ZVNpadZZ++5mfw6A+Ej9rNnUEmc
	 v54C80Wxvw2Z/ubiWONTqWBpGPvGHffE43bpALM0=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:24 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 16/18] fs/ntfs3: Remove unused macros MAXIMUM_REPARSE_DATA_BUFFER_SIZE
Date: Fri, 7 Jun 2024 15:15:46 +0300
Message-ID: <20240607121548.18818-17-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

MAXIMUM_REPARSE_DATA_BUFFER_SIZE is not used in the code.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/ntfs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 1f2cdb0dbbe1..a5ca08db6dc5 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -999,9 +999,6 @@ struct REPARSE_POINT {
 
 static_assert(sizeof(struct REPARSE_POINT) == 0x18);
 
-/* Maximum allowed size of the reparse data. */
-#define MAXIMUM_REPARSE_DATA_BUFFER_SIZE	(16 * 1024)
-
 /*
  * The value of the following constant needs to satisfy the following
  * conditions:
-- 
2.34.1


