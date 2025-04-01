Return-Path: <linux-fsdevel+bounces-45452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D04A77DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8476F16533F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08885204C0D;
	Tue,  1 Apr 2025 14:29:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B9204C02;
	Tue,  1 Apr 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517749; cv=none; b=r75b3RBzPpzfltM5YrKw4SOy5EWlP608QBRsLK/26VRt3DQeawt0k8xVf4+7472nnXSxYSKWg+k08CVK0afU+zQhjpAMkb6LcKioVpTvVmac1oNubXZ/onJF45ixWrwio/OPqFf0siFdtguqRkYLzq5ujxBP0D07LwyLFR9w4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517749; c=relaxed/simple;
	bh=LdbTBtL0qcTKiPgcxxTcWGlDkqzL0yiVtxMBmI6883I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuGL8Y/RzKlmuyk/FJCeWmZr7h84GuBAl5vNq/9AXe/+lxijzOT3CiOP4cYK+vuASqpoKtRJiX3t/kktjnD3ArhoCkOpZOMYSjIm2NtivKvT5rkiWjdhcMsXLWegjYHK5EwbnTd4MGHLeYxQ3phh96Tnb2rr0kndPhMPXREkfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.42.36] (helo=plastiekpoot)
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1tzcbk-000000007rx-2Gbc;
	Tue, 01 Apr 2025 16:28:52 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1tzcbi-000000002rX-19mC;
	Tue, 01 Apr 2025 16:28:50 +0200
From: Jaco Kroon <jaco@uls.co.za>
To: bernd.schubert@fastmail.fm,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	joannelkoong@gmail.com
Cc: miklos@szeredi.hu,
	rdunlap@infradead.org,
	trapexit@spawn.link,
	david.laight.linux@gmail.com
Subject: fuse: increase readdir() buffer size [v4]
Date: Tue,  1 Apr 2025 16:18:15 +0200
Message-ID: <20250401142831.25699-1-jaco@uls.co.za>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314221701.12509-1-jaco@uls.co.za>
References: <20250314221701.12509-1-jaco@uls.co.za>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

This is the fourth revision of the patch, second revision if you only
look at the folio variants and not consider the previous ones using
pages (ie, against kernel 6.13 onwards).

Basic testing was once more completed without any errors noticed.

Kind regards,
Jaco


