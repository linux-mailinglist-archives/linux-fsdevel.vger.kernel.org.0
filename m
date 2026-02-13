Return-Path: <linux-fsdevel+bounces-77078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCjiFYvMjmkRFAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:02:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D174F1335F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96DE305BBB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C25C28136F;
	Fri, 13 Feb 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r0pBBPht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3223536B;
	Fri, 13 Feb 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966122; cv=none; b=UE/RHYS4ngfsf991LXXCafdZnJagcZd1Hnleu+qJ4qRM9UEUIVRAQLBIJnY8X0SPe6mqTOuddi6ALiJbRI/imyeeFa3c7QrnZXhjWEimR8ZqaVc2xiP14UHMSoQKrLpffgWEYv5hxs7u239krGbVPUctZ0E6FbmAWnH5tLxT/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966122; c=relaxed/simple;
	bh=ydS4jE/FuR90d2+OxmMK7Gc0AAs69afw83mKljgmL04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjxotQlOagVU7iVmMtDY8k71E5NLAWCqIvXwJNeY8JMPcdCs9Ax5Ko3u/KbfbN+JunFXTqd5CPkQKoQYwNyBVB64BxldmW6CtlXvGeGCh5zfoVid2pdy1S+9u6LICd2Fn+XNuH9jZVTI8mwgniElXvxyqzCD+P5wxR+HVWdXl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r0pBBPht; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770966121; x=1802502121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ydS4jE/FuR90d2+OxmMK7Gc0AAs69afw83mKljgmL04=;
  b=r0pBBPhtw/lCoSq7cNIMWA5ScAH6qgoej9BCeGyrioz273SjhxYfxakb
   z+eGY0hKmr63l691Shu1fu7ABhrc0fS6uLT3UY7SEsNRDNQ3gto9P3jQz
   UCmjFNrgLuJDWCvr8jCTijYlUWRjZYO7xlAuMSSdtNUbqWfo+Rg6BroSN
   BHnYEVBjuh121zeHBh+o4BT2WtxTOi/9RargroXsOkLVoR2YxcF8C85v+
   r4JWBHYcgK5EECFX0T+rht7hUb8p/AnjkNz9ykUJtHt3B5t8EabT/SGxI
   wV4uCbFtI/Qs20KWvV+8JBVAmmt9ja45l8M4jz8hyg7uqSP2Ducbns2BQ
   A==;
X-CSE-ConnectionGUID: OoYhvgbnSiq0VS9jJ6cseA==
X-CSE-MsgGUID: EOOOsnYfSuC5fOE2OVBAfg==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="137154150"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2026 15:01:54 +0800
IronPort-SDR: 698ecc62_seVu63iXk2RRIOU4oE8YAnQnh3l5dteF4aYAw7ZstxUH7Di
 3RLO6UEgrXSYut/f72dmbMKnlILcJ4nenrEO7ow==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 23:01:55 -0800
WDCIronportException: Internal
Received: from wdap-yooxex5p9f.ad.shared (HELO neo.wdc.com) ([10.224.28.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Feb 2026 23:01:52 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] fstests: simplify per-fs _fixed_by_kernel_commit
Date: Fri, 13 Feb 2026 08:01:46 +0100
Message-ID: <20260213070148.37518-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77078-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D174F1335F5
X-Rspamd-Action: no action

Hi Zorro,

Christoph asked in https://lore.kernel.org/r/20260210155123.GA3552@lst.de
to introduce a _fixed_by_fs_commit helper, that encapulates the
 if [ $FSTYP" = fs ] && _fixed_by_kernel_commit XXXXXX "blah"
pattern.

Here's my take on it. I also thought about adding more helpers like:
- _fixed_by_btrfs_commit
- _fixed_by_xfs_commit
- _fixed_by_ext4_commit
but not sure if this is going too far.

Johannes Thumshirn (2):
  fstests: add _fixed_by_fs_commit helper
  fstests: use _fixed_by_fs_commit where appropriate

 common/rc         |  9 +++++++++
 tests/generic/211 |  2 +-
 tests/generic/362 |  3 +--
 tests/generic/363 | 10 ++++------
 tests/generic/364 |  3 +--
 tests/generic/365 | 15 ++++++---------
 tests/generic/366 |  2 +-
 tests/generic/367 |  2 +-
 tests/generic/370 |  5 ++---
 tests/generic/471 |  2 +-
 tests/generic/562 |  3 +--
 tests/generic/623 |  2 +-
 tests/generic/631 |  3 +--
 tests/generic/646 |  2 +-
 tests/generic/649 |  2 +-
 tests/generic/650 |  2 +-
 tests/generic/695 |  2 +-
 tests/generic/700 |  2 +-
 tests/generic/701 |  2 +-
 tests/generic/702 |  2 +-
 tests/generic/703 |  3 +--
 tests/generic/704 |  2 +-
 tests/generic/706 |  3 +--
 tests/generic/707 |  2 +-
 tests/generic/708 |  3 +--
 tests/generic/733 | 10 ++--------
 tests/generic/736 |  2 +-
 tests/generic/738 |  2 +-
 tests/generic/741 |  2 +-
 tests/generic/742 |  3 +--
 tests/generic/748 |  2 +-
 tests/generic/755 |  2 +-
 tests/generic/757 |  2 +-
 tests/generic/761 |  2 +-
 tests/generic/763 |  2 +-
 tests/generic/764 |  2 +-
 tests/generic/766 |  8 +++-----
 tests/generic/771 |  2 +-
 tests/generic/779 |  2 +-
 tests/generic/782 |  2 +-
 tests/generic/784 |  2 +-
 tests/generic/785 |  2 +-
 42 files changed, 62 insertions(+), 75 deletions(-)

-- 
2.53.0


