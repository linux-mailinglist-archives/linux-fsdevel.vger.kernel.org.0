Return-Path: <linux-fsdevel+bounces-66717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF893C2A841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD833B55C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2072D12EF;
	Mon,  3 Nov 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZEqPloh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5926560A
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157316; cv=none; b=MtEDkOsLbLFdDWe0PdbFdomKLxEgO9LkYFscXuAT53+Fs5KBoDE2Jol/RmdX6/5KbAe19co5Go+habYW9gkzM/3n9MP/gU/5p/WlGx1SqSXwFVWTaJoisFD/uvgw9nBmgB5TTeKtr/FKlN8Mb6sLtUzytgTDLKF8rOOBCzgMRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157316; c=relaxed/simple;
	bh=9vo0/jy+V/G2nGD+Fzu7IIaTEn50LfP0pfj1YF1EWqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eGfxw15ffAvh+1fzNmie2NjF6bdl84OjgNmSBsP1VeT0WxY48x9efD+uc7ign8oboP+Ke4o7MklatYq2ve2CNaS5wqEUpxYSdrreXWB2v8glxEk3lIRZ41UitveYjtiNr8CCEAVzZwIky4NdMfGbglitCmvgDifMdhF8YMx2Dbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZEqPloh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762157314; x=1793693314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9vo0/jy+V/G2nGD+Fzu7IIaTEn50LfP0pfj1YF1EWqI=;
  b=IZEqPlohmjkXsr9QZZ/uYTgIPBIkY1m/d5OakYj8Ehnx3tH8zyH7OwGk
   IMdMPfn4tAhSVcOfkOyYRr1h7djj1l1+GLg+cbLIiOIVqniLONpA31f9W
   ldsW4h51CmhfUrkwJdv0NKKHU/80NUtVKvzr0gp+QgRgvKxBd8Q2sfdeC
   L+3yJXwoNtdneKw2NZNMGwyJm9dAFTOWvIDzw0Vjy+RvgEQn2389I17YS
   N76xdQl2kJXC9w+CUiqY1KEHZagLv6jqZs9S8FMyLTAwATx/aMcu3v6DF
   JiPK23r3Vd21IW+CuwHqEB56Ho3mgs2uvtP3xpV1QtEd7e92Btj2Lyopa
   w==;
X-CSE-ConnectionGUID: bihPbc9XShOrhlfE/cbmbQ==
X-CSE-MsgGUID: 2tqN5ZccSZ6Ju+RNQCVABA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="63924017"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="63924017"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:08:34 -0800
X-CSE-ConnectionGUID: B3OpfaSES7ueps2anQo3aw==
X-CSE-MsgGUID: NQm5L/7iQZGmvfhnyZuZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="190898138"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Nov 2025 00:08:32 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] init: Replace simple_strtoul() with kstrtouint() in root_delay_setup()
Date: Mon,  3 Nov 2025 13:36:27 +0530
Message-Id: <20251103080627.1844645-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated simple_strtoul() with kstrtouint() for better error
handling and input validation. Return 0 on parsing failure to indicate
invalid parameter, maintaining existing behavior for valid inputs.

The simple_strtoul() function is deprecated in favor of kstrtoint()
family functions which provide better error handling and are recommended
for new code and replacements.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 init/do_mounts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 3c5fd993bc7e..3284226f7a2a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -120,7 +120,8 @@ static int __init fs_names_setup(char *str)
 static unsigned int __initdata root_delay;
 static int __init root_delay_setup(char *str)
 {
-	root_delay = simple_strtoul(str, NULL, 0);
+	if (kstrtouint(str, 0, &root_delay))
+		return 0;
 	return 1;
 }
 
-- 
2.34.1


