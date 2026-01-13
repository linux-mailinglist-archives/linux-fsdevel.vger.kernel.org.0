Return-Path: <linux-fsdevel+bounces-73363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D867D16394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B45C3027A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E61284896;
	Tue, 13 Jan 2026 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cff/cI6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C061C5F1B;
	Tue, 13 Jan 2026 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269107; cv=none; b=Fxc4ue9wP63Gooa4bM828N1Hxr+1RrEZLmoJ74bBYhTw0OxVYxPvnnwLQ0khdphlzr5ggGKbEz2jbnf2x0uteOaoN9deqwJ7sYl6d+Ar2VsNwClidH92uLXb7eXbV/VVifSKqfElwy8qbkkxoKegFGqj3yz2dZWx+siIzspU5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269107; c=relaxed/simple;
	bh=TAvbEnI/DvkXyMDso4H4FDdDNY6uhde78Ux+0q7rwz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dWTkRcfa0M8tfb1vSMsFIfVFp++bMsHJRDoO8HcbkQIVm5gvpLX8DRlwDRBfdeW35Xon5Hf7ku3EB702Q5kBDl6QMZ2bcmFCbg0dH1tuGzqZiNsVC3s1c7lWMROY31yJQxgs26pHiTlirfH5mAfzeS9Ls8lWY5EXj7XywvrYaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cff/cI6a; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DhTjBcdiZRUilQtgtS0QtmDGeyHuytznejgROAj6GY4=; b=cff/cI6aAel0HiFo8xzp+O64io
	ntA3jizviterNL+AZ/apokyp/becn/6qLDAXivX7BVIPXQSTmmasAhRlJPfZbFxbDtKIJIUtMUAgB
	QD/reVGWGmRTZwwhNzCl+/XyBj5sIsWK7YPHjAPusj3YwKnCoBzTZLJkph1g445zkbqk+U3QolIZk
	8hKnUUAPxzYcRJHUIbDfppdARRHeeKqZfcuTTdM4ZKsIEJD6Arjesibv1pOFZs/yrKj7zc2J/8T+f
	MfWHtGmG65fb4ZoA5ZOb1uztWu/+JTc5lANdLoiS95iIUCzJZxPakrNAv8KIBhOsb7J9AH+imPRdS
	EbRWlvhw==;
Received: from [179.118.187.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfTZJ-004eIK-Mp; Tue, 13 Jan 2026 02:51:37 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/4] exportfs: Some kernel-doc fixes
Date: Mon, 12 Jan 2026 22:51:23 -0300
Message-Id: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABulZWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Mj3ZL8vMps3bTi+NLSzBRdS3PjFNO0lLRkc7M0JaCegqLUtMwKsHn
 RsbW1AP0FXGtfAAAA
X-Change-ID: 20260112-tonyk-fs_uuid-973d5fdfc76f
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

This short series removes some duplicated documentation and address some
kernel-doc issues:

WARNING: ../include/linux/exportfs.h:289 struct member 'get_uuid' not described in 'export_operations'
WARNING: ../include/linux/exportfs.h:289 struct member 'map_blocks' not described in 'export_operations'
WARNING: ../include/linux/exportfs.h:289 struct member 'commit_blocks' not described in 'export_operations'
WARNING: ../include/linux/exportfs.h:289 struct member 'permission' not described in 'export_operations'
WARNING: ../include/linux/exportfs.h:289 struct member 'open' not described in 'export_operations'
WARNING: ../include/linux/exportfs.h:289 struct member 'flags' not described in 'export_operations'

---
André Almeida (4):
      exportfs: Fix kernel-doc output for get_name()
      exportfs: Mark struct export_operations functions at kernel-doc
      exportfs: Complete kernel-doc for struct export_operations
      docs: exportfs: Use source code struct documentation

 Documentation/filesystems/nfs/exporting.rst | 42 ++++-------------------------
 include/linux/exportfs.h                    | 33 ++++++++++++++++-------
 2 files changed, 28 insertions(+), 47 deletions(-)
---
base-commit: 9c7ef209cd0f7c1a92ed61eed3e835d6e4abc66c
change-id: 20260112-tonyk-fs_uuid-973d5fdfc76f

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


