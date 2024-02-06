Return-Path: <linux-fsdevel+bounces-10454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED584B563
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895A61F21886
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585312F381;
	Tue,  6 Feb 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWD6FQPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBF6A322
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223004; cv=none; b=ZZA6VuAT0HVQaGjT98jiI0Dbu4plUs27sQbmOaTFSoEzmh6seQqPFJYwS4Pcxf1DW0Q7tbAsFZpbsaCK39dg7qj3PNdjVNg7mwVNcRlv8BEGZ7BMYk9cDFQhmxH0lYbprC6KgQvB6/FRG+sJO64UDPRQcWldysCWXjvFxYVKFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223004; c=relaxed/simple;
	bh=7lXaoll/6LnUnJH2kptlTT2YL4iSg+Aq+5q+HWkWb9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4xbH7N6YQP/CiRuA17YlHvRqDzqgYMhZwazKVc2BJToOe7QZMQlZ1Ftz7Za67McUE7u2DpT1hyYSxbjU178IO/DxkxtRUz8IToYrrAN6B/gvfftjD7jfylZLp2vWyxjeg7G9Uk1qyokBiKxHmBTgXw3yEy6xyHpdnAaj1Kitqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWD6FQPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D740C433C7;
	Tue,  6 Feb 2024 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707223004;
	bh=7lXaoll/6LnUnJH2kptlTT2YL4iSg+Aq+5q+HWkWb9M=;
	h=From:To:Cc:Subject:Date:From;
	b=YWD6FQPNETc4F2CSfia8C7KvoaXeDWk/8dDXmWLnpAQVY+65JZ5FYVELjouQreYFF
	 qRbctQpH4iwuDzmMgzoAsgPVLFGIdTjLncuIIX3QQD3jCGF7DhlDZrK8tHPCGl/d99
	 WsI8+utGv83OM2sJKGNS7hmTc0BukXKUkrw96E5nEUenm4ysC2QncV1wSG9Vm38wjt
	 17gPl+O4zuy3ta+HySxm6gLjbmzbtjX4Ovq37+6CqNfu5rMffcl0y+4F3MK0o4in4P
	 XGi1XDj4r6BNcK9BKE7n83cZSV0aur5QhvKhvJFCimKudJ1vOkIGzzVkiQTPyunIQx
	 KqtAMqQimaGsA==
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	aahringo@redhat.com
Subject: [PATCH RFC] MAINTAINERS: add Alex Aring as Reviewer for file locking code
Date: Tue,  6 Feb 2024 07:36:42 -0500
Message-ID: <20240206123642.28774-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alex helps co-maintain the DLM code and did some recent work to fix up
how lockd and GFS2 work together. Add him as a Reviewer for file locking
changes.

Acked-by: Alexander Aring <aahringo@redhat.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

Chuck, would you mind shepherding this into mainline?

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..1f999e4719e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8160,6 +8160,7 @@ F:	include/uapi/scsi/fc/
 FILE LOCKING (flock() and fcntl()/lockf())
 M:	Jeff Layton <jlayton@kernel.org>
 M:	Chuck Lever <chuck.lever@oracle.com>
+R:	Alexander Aring <alex.aring@gmail.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/fcntl.c
-- 
2.43.0


