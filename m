Return-Path: <linux-fsdevel+bounces-75948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKUjIHrNfGlHOwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:25:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE7BC00C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EFDB3003356
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E64338925;
	Fri, 30 Jan 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="ltOEIFlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E07221F20
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786741; cv=none; b=QmXz2Xu3D55QTTGIKpC24/xGBiI7CS7HLujWwNB0Afc6oqmCTcqhU3kWZRqS9McX22swbJ6DHSBm89OGOsH9nTb6AU/AVyZ3rNl9kted7Oei/upavH7Cl6kuU+GxarS85k7cqtUOAY/6qtCFj5D6GWhnlrTV5+Tc7h8Ycwx/SY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786741; c=relaxed/simple;
	bh=SyMj/yR9F0xv3KH/aGBm0oBYdP5Wv3wP9gmWPrk7UvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KARzsT3RPhBlXwsPzolDuzKTcDeSeW0/V2UsRDENHIm+uAWD6gviV7o7fFdrFszTMtYpnOs5Dh7MgAY23KaByrLQsBXDCs9PwbBicCoW3vrY1lI7o4Vseis8THY/SHHSK6v2nN3Z8URgFRADQOPC7YT6AvOHeL34DBw5Sg2HlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=ltOEIFlE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1769786727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IklL95PHT+w3sFQXSNf8gYPa46yCOGUlpAY0wy5v2IY=;
	b=ltOEIFlEi23fx/S8hmKbv9+r76vkJxWTgVHPG1scsMrTvK9fkyowc6u1dgmfy0q4bF5ypz
	4EHhpAJkIc3Wd6kpW7MuF9/kii95rQL/TpHzojeh9BL9pWzYuX/uAdInNtCNsi8YZQYVc1
	7YHvLkSjSxkzTAQMQZc2UAM2cR1Izwo=
From: =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Date: Fri, 30 Jan 2026 16:25:07 +0100
Subject: [PATCH] docs: filesystems: ensure proc pid substitutable is
 complete
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260130-ksm_stat-v1-1-a6aa0da78de6@wiredspace.de>
X-B4-Tracking: v=1; b=H4sIAFLNfGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ2MD3ezi3PjiksQSXZMUQxNjMzMzY4PURCWg8oKi1LTMCrBR0bG1tQC
 1RPy3WgAAAA==
X-Change-ID: 20260130-ksm_stat-4d14366630ea
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wiredspace.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[wiredspace.de:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75948-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[wiredspace.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[witcher@wiredspace.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AAE7BC00C
X-Rspamd-Action: no action

The entry in proc.rst for 3.14 is missing the closing ">" of the "pid"
field for the ksm_stat file. Add this for both the table of contents and
the actual header for the "ksm_stat" file.

Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
---
 Documentation/filesystems/proc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..346816b02bac 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -48,7 +48,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
   3.13  /proc/<pid>/fd - List of symlinks to open files
-  3.14  /proc/<pid/ksm_stat - Information about the process's ksm status.
+  3.14  /proc/<pid>/ksm_stat - Information about the process's ksm status.
 
   4	Configuring procfs
   4.1	Mount options
@@ -2289,7 +2289,7 @@ The number of open files for the process is stored in 'size' member
 of stat() output for /proc/<pid>/fd for fast access.
 -------------------------------------------------------
 
-3.14 /proc/<pid/ksm_stat - Information about the process's ksm status
+3.14 /proc/<pid>/ksm_stat - Information about the process's ksm status
 ---------------------------------------------------------------------
 When CONFIG_KSM is enabled, each process has this file which displays
 the information of ksm merging status.

---
base-commit: 6b8edfcd661b569f077cc1ea1f7463ec38547779
change-id: 20260130-ksm_stat-4d14366630ea

Best regards,
-- 
Thomas Böhler <witcher@wiredspace.de>


