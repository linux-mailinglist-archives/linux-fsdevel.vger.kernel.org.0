Return-Path: <linux-fsdevel+bounces-40526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B6A246DE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 03:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC453A535B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 02:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115F3F9C5;
	Sat,  1 Feb 2025 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="B0Lf1TXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9C4A3E;
	Sat,  1 Feb 2025 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738377827; cv=pass; b=oSKizHumFc3QSviOhA7Q46oWeyVa+orylwKzdtSYBJC8dXWben3Ib1Thsyv4ZPz5oJUTC0pT7oOTxyhzV1PvXpfbOkT5bil0rrIXaR/ghxNthrfmi/LegT9krW6FycN0UygRWh/S6hm/R88wGnvR6tvqnSfDa1PwZFMYfps6hQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738377827; c=relaxed/simple;
	bh=GMODuOBsrY8WRZETQm+HiDn/En2Bjw4oMn91H/iV5Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaWZ9OrsmH3+Z2dtDOOUvo5BsMhwmk1YdMkBMMuC6Fkp5zPCUrtzuExLoC6KGMUmC5Sx0Lti17beg4FcsTiCCkQYvxLOuH5ST0NnDJCBC9ZBn6YKyVHWv4ociObCi8TfprFbb932Ipt2swbncK9h+owDwZBmoARMv2NqQ7kO6QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=B0Lf1TXS; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1738377811; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b5haWb3rfP9MtHsZDsxCRhmY0rmME6UspJZw5yL0xBdS3ozwIURxuexg1RUNnM0ysq6B14w2th4lZgC9EodMAptqoxw1XowhMjlYX5mzjwTymThCj5xDuPJpR4GdO1fGkEYiGcviYcrT8AAQTQ2OsbzpirWcrQMX6tENpPB6gmE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738377811; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GMODuOBsrY8WRZETQm+HiDn/En2Bjw4oMn91H/iV5Ps=; 
	b=d8Q+2ukXLNwhoU+m3jc9qeS40sU5NaVO3cSHK5Mt+W8jhrY70g15dXKO3tStKl4PxMi1K5qkRXP8uR/AUY0+dg7+zS884CZknQZQj4gcKBP3i+QRWnbn2/ZJNIUVY05n62WBeyIyr8BP5qQU9xuXe+p4kXvut63EbDBQ5PRyk9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738377811;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=GMODuOBsrY8WRZETQm+HiDn/En2Bjw4oMn91H/iV5Ps=;
	b=B0Lf1TXSr1ZGr2OsQnfUutgdKUFqrxjLovaVdJGHMQjojea5yIVkVM16EIl3YW59
	wmnJtwE3ZLErKD4ZvPVCu6J3617ziiLWdjOJBidsbKdvJLMviCHEa0xe51q4JBpwuOi
	yOyPT6mW4fWEYiboYFhEwX1itl/V7g87XxstGeHQ=
Received: by mx.zohomail.com with SMTPS id 1738377807804961.3242472563459;
	Fri, 31 Jan 2025 18:43:27 -0800 (PST)
From: Askar Safin <safinaskar@zohomail.com>
To: dhowells@redhat.com
Cc: christian.brauner@ubuntu.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/5] Add manpage for open_tree(2)
Date: Sat,  1 Feb 2025 05:43:22 +0300
Message-Id: <20250201024322.2625842-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
References: <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122cdfcf9964647958ede0c52b01000061f855f066d959016a5a9aeb8d8ac2b562924eac93f82f7b468f258658b7:zu08011227011cd5f454f9342e9cc22f83000071cfc7e82987801c0e0d46333920226891152fe82319cbf0e8:rf0801122cc48feaafdeec6066e041face0000a5192a6b5cad411612f1c958ba862b41a8b386fa55172d65916ee7856e38:ZohoMail
X-ZohoMailClient: External

David Howells, ping! You still didn't add all these manpages.

https://lore.kernel.org/linux-man/159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk/

