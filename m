Return-Path: <linux-fsdevel+bounces-76826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC8oJ9HximnUOwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:52:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BEC1186A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C6230382AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26933A9E5;
	Tue, 10 Feb 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="S/JcyK9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC541CEAC2;
	Tue, 10 Feb 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713512; cv=none; b=nqHqYaLFh+LdBsvkbw7P84K0oAG1vYVtMy2jD/mCeznudvH0Kc8XzQPHBzzjlE4jqmGvLiZsjGpN3MGoyYPNgPfRGZNj1+LxL6QIOs0eREKqr7vda+0adgkN68KvgumcuaWAPBPC101NS4W0h0NuZypyH2T//97vGS/408PwH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713512; c=relaxed/simple;
	bh=jUmzlUvpRVPETx1Een0BqdGJbJWKuBnHYqqpzFew6OA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I4lQuHKSDTGtVg67nd8k2N37S/wpz2jeC9AVPQSPuM46qTQTvnv2GLbZIh8p++9Tbyqzd2sNhpPyuOdIGaE3IjLwGB/DdKSRv+3Xr9D3Pl1FPUFLctmhd4vyFzRlaJHZnirvftIPeMhVGGmKbPhhOI/LftNOD5sz3slneht6Sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=S/JcyK9m; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from fedora.fritz.box (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 33428E05E7;
	Tue, 10 Feb 2026 09:46:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1770713178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XuB+feR7aFASXPsyj4Ni7Jv4+aXhrYaTAXe+CNzrmI0=;
	b=S/JcyK9m6o2jqbjDbEDjvJuj94A6iUTaCpxNBXZJXAljIhoGFzqqQxzaKYosG6D9I6owBg
	5ENQ4Kh2Gz1tiVsf3XvIVhIIWdrIoux+IB2+RdSawU4JuNI5iQHh1UCCKrI0Np+oaac5f3
	ozwlH9vBK8ETP6pxiSaaORo8t7kcuSDTPttq/Nxbv3AS7ZgTnxEqro1vP77sFms8vxT689
	dWWY/7dN2Jcu5lWshnWhDUOK8AqM+lODB66QwZ3Lc9CrHVlS8thMMw+Y+cRdP87/ZQcK7s
	dyYDAWj1xXsruhfrW5UB7B94zzIG5D44YOc0jkJkKkCJAdz+zmVtHqkxbSxXGw==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: Horst Birthelmer <horst@birthelmer.com>
Subject: [PATCH v5 0/3] fuse: compound commands
Date: Tue, 10 Feb 2026 09:46:15 +0100
Message-Id: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OQQ6CMBAF0KuQrq1pO6WAK+9hXFA6lS4E0gLRE
 O5uITHKgujyT2be/IkE9A4DOSUT8Ti64NomhvSQkKoumxtSZ2ImgomUCwHUDgFp1d67dmhMoEM
 Xeo/lnVZ5qiVCocEAidedR+seq3y5xly70Lf+uT4a+TL9bY6cMprp0qBSUMhMn41pjnGRLOIo/
 lREVJjNtJQpjzVxq8BbUYyzfF+BqOSmKjhqC5lkW0V+K8W+IpcuBnQuSqmUsh9lnucXzTdcy44
 BAAA=
X-Change-ID: 20251223-fuse-compounds-upstream-c85b4e39b3d3
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770713177; l=3043;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=jUmzlUvpRVPETx1Een0BqdGJbJWKuBnHYqqpzFew6OA=;
 b=tQGwdzz+82HMPd+EfygK7ygkrnX+zRFuKdIaJvJD+fTh4yhZaxqfdjengUDzYe4BEqsFCQkLo
 xjWfhfZFc9TAHe34FsLaYxVnMbUYVuZcpC0d4kVMNt/flsmRzcq6ah/
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[birthelmer.com,none];
	R_DKIM_ALLOW(-0.20)[birthelmer.com:s=uddkim-202310];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,ddn.com,gmail.com,igalia.com];
	TAGGED_FROM(0.00)[bounces-76826-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[birthelmer.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.com:dkim,ddn.com:mid,ddn.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05BEC1186A3
X-Rspamd-Action: no action

In the discussion about open+getattr here [1] Bernd and Miklos talked
about the need for a compound command in fuse that could send multiple
commands to a fuse server.
    
Here's a propsal for exactly that compound command with an example
(the mentioned open+getattr).
    
The pull request for libfuse is here [2]
That pull request contains a patch for handling compounds 
and a patch for passthrough_hp that demonstrates multiple ways of
handling a compound. Either calling the helper in libfuse to decode and 
execute every request sequencially or decoding and handling it in the
fuse server itself.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
[2] https://github.com/libfuse/libfuse/pull/1418

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
Changes in v5:
- introduced the flag FUSE_COMPOUND_SEPARABLE as discussed here
- simplify result parsing and streamline the code
- simplify the result and error handling for open+getattr
- fixed a couple of issues pointed out by Joanne
- Link to v4: https://lore.kernel.org/r/20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com

Changes in v4:
- removed RFC 
- removed the unnecessary 'parsed' variable in fuse_compound_req, since
  we parse the result only once
- reordered the patches about the helper functions to fill in the fuse
  args for open and getattr calls
- Link to v3: https://lore.kernel.org/r/20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com

Changes in v3:
- simplified the data handling for compound commands
- remove the validating functionality, since it was only a helper for
  development
- remove fuse_compound_request() and use fuse_simple_request()
- add helper functions for creating args for open and attr
- use the newly createn helper functions for arg creation for open and
  getattr
- Link to v2: https://lore.kernel.org/r/20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com

Changes in v2:
- fixed issues with error handling in the compounds as well as in the
  open+getattr
- Link to v1: https://lore.kernel.org/r/20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com

---
Horst Birthelmer (3):
      fuse: add compound command to combine multiple requests
      fuse: create helper functions for filling in fuse args for open and getattr
      fuse: add an implementation of open+getattr

 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 224 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c             |  26 ++++--
 fs/fuse/file.c            | 137 +++++++++++++++++++++++-----
 fs/fuse/fuse_i.h          |  24 ++++-
 fs/fuse/inode.c           |   6 ++
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |  40 +++++++++
 8 files changed, 426 insertions(+), 35 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20251223-fuse-compounds-upstream-c85b4e39b3d3

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>


