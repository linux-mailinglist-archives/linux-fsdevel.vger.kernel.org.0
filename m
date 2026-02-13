Return-Path: <linux-fsdevel+bounces-77079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B0cInbMjmkRFAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:02:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B51335ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B56153027804
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB0286D60;
	Fri, 13 Feb 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TaHzIaUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843A2727F3;
	Fri, 13 Feb 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966123; cv=none; b=XUel0W+r7y5ZziD3WhYAIvpQ8MFKDgAmBCkYmrQUT9jZWkafQ1C7gzQdtgEuTbIRnWCO8zGTy1KNYOdfqtyxlU+PfP5ANY2e5xQsN24asf7LfL6PADZshN7SNq0XRsh4K1yDUH9UMl6l4LkTYQ+sE+QMWLwHWJ3+450EkswK5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966123; c=relaxed/simple;
	bh=iSIy7NAJPrjEdPcd4UeTXpoTl9zgTJT/95A9CezpxzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0w6lzjPpmpG2ZRHQsCs018l69wNee4+3647YbpRGsP+M/rOqqddENfscbA1LrL21NhnkPnoCxiHywL7gHrJ5A5e/GkyfYe9fFG70bJY4BsNHiKKdnGpLClKW+Y3VMh0CAaX2nbf85U4tYBVhoTGoNj0i4GGHrdvb5LM2o9S4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TaHzIaUe; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770966122; x=1802502122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSIy7NAJPrjEdPcd4UeTXpoTl9zgTJT/95A9CezpxzI=;
  b=TaHzIaUeUwBgMd2fghYkWLMUkn3JcPIavoWHS5KYh5jZCPB+8KqA7Qqm
   U+4A2Mll36jIHojBeF971rir28JrJKZvOzzf2/5fdfCAJiOVkNd1yb5Qd
   b88kd+i6/OlUkkR1dJ2q2ntN8P4Jk9sBFp8Duz4YAuq4KEM8IWoKa3TCq
   dJVbzgkVvX6H+8jhCBJ3yYA1wV87k595jmbUwkpVKu9Mf/HQaHSV8OX+h
   XXNibB4J022Ia2c43SACOiHPY6zfdP4fyzgksHvejC/VC6FBEiQGeQaJs
   iuQLWa8Abj2jPPECGl1On2hKRTFD97wjQ0GsCsrvVptXX31xSImMTNaEf
   w==;
X-CSE-ConnectionGUID: OeL2+lq9ReqKfwiKzoV6Iw==
X-CSE-MsgGUID: y4Nec5deRqyR6Eq+HUb93g==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="137154152"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2026 15:01:56 +0800
IronPort-SDR: 698ecc64_+RgUFSjR3mJ3TgRdCF5/pk9zZ6MNitzjRdx4gfYCDYrUaaO
 cOvpCOWQgRAL20IjfVkVyk0xwqYogSYoIePbQiw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 23:01:57 -0800
WDCIronportException: Internal
Received: from wdap-yooxex5p9f.ad.shared (HELO neo.wdc.com) ([10.224.28.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Feb 2026 23:01:54 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] fstests: add _fixed_by_fs_commit helper
Date: Fri, 13 Feb 2026 08:01:47 +0100
Message-ID: <20260213070148.37518-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213070148.37518-1-johannes.thumshirn@wdc.com>
References: <20260213070148.37518-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77079-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B5B51335ED
X-Rspamd-Action: no action

Add a new helper `_fixed_by_fs_commit` eliminating the
 if [ $FSTYP = fs ] && _fixed_by_kernel_commit XXXX YYYY
pattern.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index c3cdc220a29b..7adc53045be0 100644
--- a/common/rc
+++ b/common/rc
@@ -1898,6 +1898,15 @@ _fixed_by_kernel_commit()
 	_fixed_by_git_commit kernel $*
 }
 
+_fixed_by_fs_commit()
+{
+	local fstyp=$1
+	shift
+
+	[ "$fstyp" = "$FSTYP" ] && \
+		_fixed_by_kernel_commit $*
+}
+
 # Compare with _fixed_by_* helpers, this helper is used for test cases
 # are not regression tests, e.g. functional tests or maintainer tests,
 # this helper suggests git commits that should be applied to source trees
-- 
2.53.0


