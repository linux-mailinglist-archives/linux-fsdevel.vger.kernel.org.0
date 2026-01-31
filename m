Return-Path: <linux-fsdevel+bounces-75993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHVfOFXufWn7UQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 12:58:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A416C1BEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 12:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222483017C09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA76329E5E;
	Sat, 31 Jan 2026 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="6CRqRTt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736A29B777
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769860663; cv=none; b=BS4LvfX9tvyDFn6TnU6VYhplpj5y0ffS3JIqziamE7dZ0MSCIuSRvVaxkv6oQRnqkcHd+u/BDkkrf6k8yDfFv/ZzRo0sjpdtvGcvEItEe7GtfhGDz8GiZCSqFl9Z+YxfRS/imOh4cvY1z7Ba9g9ybzgW4L0pujw2/5nTzOlsWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769860663; c=relaxed/simple;
	bh=H6ECki5O3pXMqdXiWe0qzuuFqpXf61vksDRDY7+WwFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=krLnCCPsW4KyI5WqNs6QvHvbyYY5Xm568wcjnlTl76kObsAy6TepU/iaseqyw54SI2jIkL3r8H8PqiJ7jdxk5PDhc3l4y6vMM/+lFxbqhbbC/+ghiXc7jC3MyQwBcy2T0FroAUFkLCJLRcC/M8oMcTcokodobKHZuOexUEcsP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=6CRqRTt0; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1769860649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qYchFagW0mMfqnpLJClYSFGt4E/R7I0QuD0kPdX9A2c=;
	b=6CRqRTt0kVuO+gUAjTC7uyZE4n1z6/ecLIhWetLp8fHcFN6kBK8TfHjNJcF/LIa1sr4va0
	fHg1uogFGU3btx5cpxDRUUCDxVdybG3xmmDERKGwDEBfGcBKTpAP8JjHi3Rnc56wMxGuRV
	CFKYw+bO/gcYuQoHkqaCr0nXYGCKc7s=
From: =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Date: Sat, 31 Jan 2026 12:57:26 +0100
Subject: [PATCH v2] docs: filesystems: ensure proc pid substitutable is
 complete
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260131-ksm_stat-v2-1-a8fea12d604e@wiredspace.de>
X-B4-Tracking: v=1; b=H4sIACXufWkC/23MQQrCMBCF4auUWRtJ0jKKK+8hRYZmtIPYlkyIS
 sndjV27/B+PbwXlKKxwalaInEVlnmr4XQPDSNOdjYTa4K1H61prHvq8aqJkuuC6FhFbywT1vkS
 +yXujLn3tUTTN8bPJ2f3WP0h2xhlCIhvocAyM55dEDrrQwPvA0JdSvr5aX/ukAAAA
X-Change-ID: 20260130-ksm_stat-4d14366630ea
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wiredspace.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wiredspace.de:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75993-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[wiredspace.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[witcher@wiredspace.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seibold.net:email,wiredspace.de:email,wiredspace.de:dkim,wiredspace.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 8A416C1BEA
X-Rspamd-Action: no action

The entry in proc.rst for 3.14 is missing the closing ">" of the "pid"
field for the ksm_stat file. Add this for both the table of contents and
the actual header for the "ksm_stat" file.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
---
Changes in v2:
- Also adjust title underline to match the new length
- Link to v1: https://lore.kernel.org/r/20260130-ksm_stat-v1-1-a6aa0da78de6@wiredspace.de
---
 Documentation/filesystems/proc.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 8256e857e2d7..b0c0d1b45b99 100644
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
@@ -2289,8 +2289,8 @@ The number of open files for the process is stored in 'size' member
 of stat() output for /proc/<pid>/fd for fast access.
 -------------------------------------------------------
 
-3.14 /proc/<pid/ksm_stat - Information about the process's ksm status
----------------------------------------------------------------------
+3.14 /proc/<pid>/ksm_stat - Information about the process's ksm status
+----------------------------------------------------------------------
 When CONFIG_KSM is enabled, each process has this file which displays
 the information of ksm merging status.
 

---
base-commit: 6b8edfcd661b569f077cc1ea1f7463ec38547779
change-id: 20260130-ksm_stat-4d14366630ea

Best regards,
-- 
Thomas Böhler <witcher@wiredspace.de>


