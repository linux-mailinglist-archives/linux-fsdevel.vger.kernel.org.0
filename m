Return-Path: <linux-fsdevel+bounces-56868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C2B1CB5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD7618C5173
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED372BEFF4;
	Wed,  6 Aug 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="CIboG/jz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF32BEFE9;
	Wed,  6 Aug 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502348; cv=none; b=PyHoIT60GtP/G6YTZyxWdpr6/ppfuQu9w5UlCIrKmGq+8Y06Vn4tknPOHSyuAaEXqw1yJQp0su5WtcBT2cLmL76uPZQaCFBLQPwnjEBqvtLD6Oc+3WHvf6D4jfmjtoUaqT1HA9pDzlYWoDzutFnX3q5Xp7cqMPaBjlc9sg+15Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502348; c=relaxed/simple;
	bh=RDJQO007ERabTkgl/PrzfQjR8d5XxCqa8xKNU89DqCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRcNpa4hUBTn8/ksd0Amt1wp8zVCLJDNDvOXEGg4EIdKz+8wrbQByShXz7rfUDPtjwZWGO7Om+83eeE9V6830Q9DGXnPPMRoxPDPXfldKYixDdZ+Bi9HjI+zaO9APL5/pJ+nf2fnMwgnUTfmk7UGd5vOlqjBLYYrZj19MRV5Xm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=CIboG/jz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxyPg6DNWz9sqy;
	Wed,  6 Aug 2025 19:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBWNR74Nu1rSft9Gxex91tgUE5zJxVh5493aLPxeGcw=;
	b=CIboG/jz3nvHCTnsZUfUjATDr/Bru0eB8Fg5iLBYdSHPeQKIh5AxEkTSpEOnJR56hespM7
	ZBmwIDA6RrdlQx/AFb33vKvMB/KsncvUyQXwpUst9UGcYrO/6B35madSsOkAHbK06msbNw
	S9KbaqvDWohllx3akkuuYw3ILt2xsj7kr+XgzWNtkS++PXBX7yAwXQA9+OXrw3IKLW1QbT
	yTItwUiw72pNZn/5D/Xdz1+hXDiDIC6kQqIbuX7hSXXo3AZXcDMh3437QA7z1sBUuJrWo2
	m38jHvsas/vi2I1Ub+eM4Kv38PrRIBnrbL6GjJjaYOn3bYNgLCMTP5Uh+Px8+w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:43 +1000
Subject: [PATCH v2 09/11] mount_setattr.2: mirror opening sentence from
 fsopen(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-9-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=RDJQO007ERabTkgl/PrzfQjR8d5XxCqa8xKNU89DqCo=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntKeunVS6Ln/6/52aHV4XJx5duXCg3muL16maXC75
 gpUqVxo6ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATsXnH8D86V5SVd89uqY82
 K7K2S7yuN6gKXiTtVDHrVvYc17I3p7QY/ocFyeTqPf3itKVKkX3VpWox1olOIb9+B7yqc57kb64
 2kRsA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyPg6DNWz9sqy

All of the other new mount API docs have this lead-in sentence in order
to make this set of APIs feel a little bit more cohesive.  Despite being
a bit of a latecomer, mount_setattr(2) is definitely part of this family
of APIs and so deserves the same treatment.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index d44fafc93a20..b9afc21035b8 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -19,7 +19,11 @@ .SH SYNOPSIS
 .SH DESCRIPTION
 The
 .BR mount_setattr ()
-system call changes the mount properties of a mount or an entire mount tree.
+system call is part of the suite of file descriptor based mount facilities
+in Linux.
+.P
+.BR mount_setattr ()
+changes the mount properties of a mount or an entire mount tree.
 If
 .I path
 is relative,

-- 
2.50.1


