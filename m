Return-Path: <linux-fsdevel+bounces-24999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B19479D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CA61C203BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE615666F;
	Mon,  5 Aug 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lgfonySh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593D13CFAB
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853801; cv=none; b=QzTfkFBfk+iSGzp2SF7Wc9AL9e1JEZe93Hxq3maugsJVvdo1dhvEmEv15wCBBnX0bRTK/1A8aDT4paPEVD4//+btJo4DztiVojWd7vhqnGGZaQIlsuswW+bqB/mxBmU9olQhw4wcMtn6CBpo6JHi7PQPhffeG1HdDEj9++2IHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853801; c=relaxed/simple;
	bh=O2djrrekEMcBpJ8Uq8DwT92ZLKhfQ6p7aCZTrhhfM0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlWQ1xBiz/3BLpb1srX806OGkhpIKnYOH9pt2aEAATYt/cDoZADnx1x5FmMlYwI2cDqiuhgniPXDqUDFiVNJvytjoRtNc1oD9f0plSizByUtGWiTQCTAsE9FyavlWMrY3O2iY/vfPQ9K+QOtMG4KVDKm6J9DDDRtpKQ0yi3No3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lgfonySh; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id auyPsh8Id6NRTauyQsprzR; Mon, 05 Aug 2024 12:29:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722853795;
	bh=IPDMSYiJB4iN0nD73gIhr+VwzoVNFs4/Aaat5q255/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lgfonyShjQB2kO7Js8N5oGHIs7MaACaYIyKYlYwuf0VELB2GxLZZBGeC6Z9/7g0Mr
	 L1vnjfNqH9XRJs1mG2TrqfHQRfBWLRhKEI4lml3+NVUq5xnzcZfEkuW/Q8nTMPb3Zk
	 MX5VB3NuQy+ynVnc6ixeyrFiCdHEY06Ezt6N2DZbjFa2XnNEJDA94SvegpQ2XXTLkA
	 neOLzWe/XSUsEhU0wKY9hbtWKaPFtdWYwp8grAzKDgymIkdFXqHbb2rnJovSZfaLmC
	 krrLp2l+53btaaq4xkyB4BG2D0mcPzuAmbXP8yF3YnSTdEkuiUrlhn5xJx9084IdDI
	 bAuZyp6SMO/Gw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Aug 2024 12:29:55 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: willy@infradead.org,
	srinivas.kandagatla@linaro.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/3] ida: Remove the ida_simple_xxx() API
Date: Mon,  5 Aug 2024 12:29:46 +0200
Message-ID: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the final steps to remove the ida_simple_xxx() API.

Patch 1 updates the test suite. This is the last users of the API.

Patch 2 removes the old API.

Patch 3 is just a minor clean-up that still speak about the old API.

Christophe JAILLET (3):
  idr test suite: Remove usage of the deprecated ida_simple_xx() API
  ida: Remove the ida_simple_xxx() API
  nvmem: Update a comment related to struct nvmem_config

 include/linux/idr.h                 |  8 --------
 include/linux/nvmem-provider.h      |  2 +-
 tools/testing/radix-tree/idr-test.c | 16 +++++++---------
 3 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.45.2


