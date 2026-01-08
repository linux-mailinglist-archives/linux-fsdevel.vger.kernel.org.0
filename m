Return-Path: <linux-fsdevel+bounces-72858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFFD0431B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88B8D30A3F30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F45500BF3;
	Thu,  8 Jan 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b="vDTTDRWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3281500BE9;
	Thu,  8 Jan 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882711; cv=none; b=qVLo8Ow3w5YfBkBkyzdJ2PH5fNdNuJX+M4HJVA0hQzzKsJOeehEodQlWu7LID2lzu7bp3yjcaK1lIcalJhiAxWDz7QBW4oDVDEK3UOTX0NY5V1FlIpZjeDxjpqU7/9l9PLQuMmX9PEjBkkDcdACzWqY0FjiiEDrUZo793ee3zZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882711; c=relaxed/simple;
	bh=GsXlnnfD/ARWqJs4ZJhEUczkVQITzAZ/JAwpXAGdqeU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nzkoD2a/NC9WsvNvipdXYdflhDJEDBhAeXujGOL2bd9fsKx0qeC1vx5o+mGohYBNZ1ityocy6D8cDqPG1F4fw4YaxwgvW5ImTZXdRfmRs4bp1tJn2KpZ9XrDqJtpEM00ZSSbQ566MhOdH896vByYSUKl416FjogA6ckn2cxIIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com; spf=pass smtp.mailfrom=birthelmer.com; dkim=pass (2048-bit key) header.d=birthelmer.com header.i=@birthelmer.com header.b=vDTTDRWd; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.com
Received: from [127.0.1.1] (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id F3F88E04D2;
	Thu,  8 Jan 2026 15:23:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birthelmer.com;
	s=uddkim-202310; t=1767882222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D4aWng9wh2Y6jaY23RUEufxAnJvOVDBOxwLX3GZyC00=;
	b=vDTTDRWdMa8n1G424L33yW7AVGZJkV5teQYHog6Z06G9fC03dOxJ63Fl4TmJQqLAEltm8H
	TsuFKYWDXqO01QHCUA08tu758SOgqTttwzrNVqIVyi5R8TdOJXjUUC1I0p8min397PLWsv
	DRBBqjWf4hH4LJCWTibgwmRgnlcF1VAvaOccVkgZpKF+KVveDZR19G0KNKtB0YNH5/jDa0
	wbcNHVL2j5786YwH6pmPSbL0WvJ9FeL7az0hSMS4aFnTek5DG/dLIgzoHTv5laM8uGaGf9
	5ipb07/TZdVAOaaKRM4uXrGtqLE/juQF9x7cQiBOYTkNAgSR3C5C4bb5Hznsag==
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.com
From: horst@birthelmer.com
Subject: [PATCH RFC v3 0/3] fuse: compound commands
Date: Thu, 08 Jan 2026 15:23:33 +0100
Message-Id: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOW9X2kC/43OvQ6CMBAH8FchN3uGfgDqZGLiA7gaB0oP6UBLW
 mg0hHe36eKo4/8+fncrBPKGApyKFTxFE4yzKYhdAd3Q2ieh0SkDL3nFOBfYL4Gwc+PkFqsDLlO
 YPbUjdodKSRJHJbSAtD156s0ry3e4XS/wSMXBhNn5d74WWW79hCPDEhvVaqprcZSNOmtt92kwi
 5H/qfCklH2jpKxY+pW+yrZtH1KQO5wHAQAA
X-Change-ID: 20251223-fuse-compounds-upstream-c85b4e39b3d3
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>, syzbot@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767882221; l=1925;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=GsXlnnfD/ARWqJs4ZJhEUczkVQITzAZ/JAwpXAGdqeU=;
 b=LHX8xgxtdLlUr15KAtz5CsIO6umsz6l531mr/EAAnLJ+n5w3cnbA6R7AZ3XNiooPWoBlNdrgv
 hW3rRYIRGsICUpcXfzu/2ISnOOxpZZX++f+94SbsnO5fj1P46yEHVbp
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

In the discussion about open+getattr here [1] Bernd and Miklos talked
about the need for a compound command in fuse that could send multiple
commands to a fuse server.
    
Here's a propsal for exactly that compound command with an example
(the mentioned open+getattr).
    
[1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
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
      fuse: add an implementation of open+getattr
      fuse: use the newly created helper functions

 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 276 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c             |   9 +-
 fs/fuse/file.c            | 152 +++++++++++++++++++++----
 fs/fuse/fuse_i.h          |  27 ++++-
 fs/fuse/inode.c           |   6 +
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |  37 +++++++
 8 files changed, 476 insertions(+), 35 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-fuse-compounds-upstream-c85b4e39b3d3

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>


