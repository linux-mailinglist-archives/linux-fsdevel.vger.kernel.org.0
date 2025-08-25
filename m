Return-Path: <linux-fsdevel+bounces-59119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42366B349E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BF65E0723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C64D25949A;
	Mon, 25 Aug 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="NNWWQ24q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49C30AAD4;
	Mon, 25 Aug 2025 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145603; cv=pass; b=TFwMYfdvgjjUmp9L9lK5F4eXVbEkFzMUZtgwmUlRk6tj6r1Efw9F8MbpNca7c0UIAJQxH8Suew6exytSRP5VQwu7BqiAPguiI/JbPY8c8Wv6D4iX2BDtYzYtVA1/ztqQ5mhALVtQGPSUqrNnYrz1Q6cRvMVg7MECgl9oR/YAZpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145603; c=relaxed/simple;
	bh=nPs0JHxy9jORGCVpVU821NrMJMHbWeJkBDpV5dF9g1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQz1boNqS41IX5fhyI0S6Dq2u06zSVJ3UrL9xgTIr24Ziv0CYzeYev6vVlRppAeAtLEVNapdmGgZ4JBPVETuZh4agTFoeH3voNelcbS3LIm9apGH9lMRHQTkTSiuz6KTq/zAgcrICRyMQ9OCAYuJg2csANbIN3NDH177SGQ8pSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=NNWWQ24q; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145570; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FnvY7HnB1mcpJVIueHLexrh1W1v2hdqVhDjxCuBguwL8CZYgeZj5NAtdtkPCAPsArk7hEtTzb97iJ2I4YNLJi0u9OXOF+sgy9z5rOFaSLfw2r/MX5PONVljS2z4aBI+RFggMtU9qg6Wq8vN7XHuzsq3U6N1GFm+/OZaUNb+MId0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145570; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QqFttihhuIcg0x/jZsEOekyKe9krH3t1/C3t43F4S5s=; 
	b=HYBAf1X9dp7fIhn7vW7Vtzy2OihWeNScRr7uIAtd7ZI8EtqXwmzAW9eZEicEKofsp3RLDWiBT71BWn9NpZMQ9XX+HXoCdT0gnhtypO8XFpSfJlZlA9GgPlnLsebCfcgxQvKwvb3myEDZuzASdWqzWbE7oGHzqjd6Po7VswjaQjE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145570;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=QqFttihhuIcg0x/jZsEOekyKe9krH3t1/C3t43F4S5s=;
	b=NNWWQ24qjE8XNC0/mMLDx+B3nzoj4XX6O+ZXFe+yGyx8KkpxDF+Tl8XbFyvLcB16
	uMt1pxeXGrfBZAlxaIQszHutIifW1tLwbA6fFWIOyJbV00sq1ILRJQEkSZgwDkMpgWu
	5Nug2zjF5IYSjCay9aLd7b/Q5CuCUWUZml1TrDcA=
Received: by mx.zohomail.com with SMTPS id 1756145566336367.5887384375375;
	Mon, 25 Aug 2025 11:12:46 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	cyphar@cyphar.com,
	Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH v2 0/4] vfs: if RESOLVE_NO_XDEV passed to openat2, don't *trigger* automounts
Date: Mon, 25 Aug 2025 18:12:29 +0000
Message-ID: <20250825181233.2464822-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122704d5dcbaeeb079349d81243c0000733617fc22b2d41e3f07dc7f2e784f99e9b8bfbfb658a2388a:zu080112278931ff1f51fe7d90def37689000061921c521fe03869143442e6e860f6ff2881004666e6f391b4:rf0801122c6f0cf1153cb03c8a709787cc00006072a6b6288e39e398946e8029c3f686bae0623fd6e39ec0270ceb950c58:ZohoMail
X-ZohoMailClient: External

openat2 had a bug: if we pass RESOLVE_NO_XDEV, then openat2
doesn't traverse through automounts, but may still trigger them.
See this link for full bug report with reproducer:
https://lore.kernel.org/linux-fsdevel/20250817075252.4137628-1-safinaskar@zohomail.com/

This patchset fixes the bug.

RESOLVE_NO_XDEV logic hopefully becomes more clear:
now we immediately fail when we cross mountpoints.

I think 4th patch should go to -fixes and stable trees.

I split everything to very small commits to make
everything as bisectable as possible.

Minimal testing was performed. I tested that my original
reproducer doesn't reproduce anymore. And I did boot-test
with localmodconfig in qemu

I'm not very attached to this patchset. I. e. I will not be offended
if someone else will submit different fix for this bug.

v1: https://lore.kernel.org/linux-fsdevel/20250817171513.259291-1-safinaskar@zohomail.com/

v1 -> v2:
- Commit messages
- Comments
- Clarified that 4th patch should go to stable
- Whitespace

Askar Safin (4):
  namei: move cross-device check to traverse_mounts
  namei: remove LOOKUP_NO_XDEV check from handle_mounts
  namei: move cross-device check to __traverse_mounts
  openat2: don't trigger automounts with RESOLVE_NO_XDEV

 fs/namei.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.47.2


