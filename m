Return-Path: <linux-fsdevel+bounces-30342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA598A056
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BE2283814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B8E1917E7;
	Mon, 30 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JSmhmrWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5CE18FDAB;
	Mon, 30 Sep 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695307; cv=none; b=qhfjnS1Vzow6pUERPiiWwPMXBZABGttKOnJHMqOVw0sTbhMjbIgkvPGTxqujOHVH0BpMuv83BTaFAwhPEWTnX+MAzsQzu2sd2c9kcmzhpJOpeszo4NAFkQAEU6f8iatxcUfhEXR9LnKadWigiSFNmpNurwbeB+bDjQsHJDUEQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695307; c=relaxed/simple;
	bh=yr69Xt+oBFSxFfHWaYuaGHrNy9SgdK9fwESIzSXfPTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoAgo3/nuZkGlH5gsQkVV93kqVMXrBUzhuB7beFOZayXxAW5rba7Nnc0y2IX28fOSHsCCmIoFwTCJdtYo8GNw7K3tlOls7Xx7C7d8/shlnn3yM6j0J/kwd9tzpkeX+kmnjy45yikk7kvQeklGeLMPaTo8YqJHibDnY561eMYam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JSmhmrWO; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kwh8q1Ub6dpDycuiPQuN0DU5T3cLRGRT4zRLWwisCJE=;
  b=JSmhmrWOhGxp7Ap0wkpPv1i/0DTr292EhwEaconbaBVw8HuWE/rA2m17
   dxrDQrtNIungZrCIEe41yJaubnu+W7m+66QuDgR2sARL+8zQdWHFfBCRU
   9cAaywX5qeVIo4PIAyKrKYLV/IWJMSEMj6cqyheX/EcuqP1LqB59BiCRL
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956880"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/35] sysctl: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:55 +0200
Message-Id: <20240930112121.95324-10-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/sysctl.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..5c9202cb8f59 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1305,7 +1305,6 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
  * @write: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
- * @ppos: file position
  * @ppos: the current position in the file
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer


