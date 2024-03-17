Return-Path: <linux-fsdevel+bounces-14633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBAB87DEDD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E9A2813CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790D61B949;
	Sun, 17 Mar 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL2ghk4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE61CD11;
	Sun, 17 Mar 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693480; cv=none; b=VdaA+1ch09Kp9LBD+3aQ7G8MJ+aASxA5L3sQiGEYW5mrGX7U7g0QyRL+6x0ICLLqX+6xWInWhBZjPqgGRvLCTnAhgMkbmwceG7Oye5CtaayR9uj4CHUGSI72zTdTUljd55ALZCQ8KD+HOnIWPeLkj9Wgh3kT8M1f4+hXhdZ/taI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693480; c=relaxed/simple;
	bh=5TMuct5iysN+++jCX0ghHaVBGM32xVUZYZTaz/c5VEQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppOv9fL488tI0DuyFKcZNfFvYfasUntDJQXS5dGQtUDTeUpXBPTmYh4HPx5i/WDHP89d9g/goyhAC98i8oucAmNuQhVrF7rgY5It2Olb1HikFYvLm9ijQhbWhjfsBUc8tVRMlayxcdQzW8I4oLyIUkWFuYsmc/eOuE3JzLnGZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL2ghk4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65680C433C7;
	Sun, 17 Mar 2024 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693480;
	bh=5TMuct5iysN+++jCX0ghHaVBGM32xVUZYZTaz/c5VEQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pL2ghk4c1HNbKLsiTvFVDvUt9uFkqMzG2NjGgWGdW8oYc+UksJ0S/0wYsH+sG14M+
	 NbRpcRMC9SIGAtftEm777rnoISqLFspjlx8GdvOr27ehy4Vu9wa9MhYwOXcymLvEDv
	 RjV0hwUZMh2UmPfHbdbvf4OUGyDW1Pyzy+JuT6/7vm1jxm9LL6U7pOQxh9k1OsiNpu
	 JBvxlveYViBShy8qe7g2dNXSurBTvOQOdOLCnwf2Fg7d3TRqlt566S79kWDsIz+7Kl
	 frLA057xbQeCfgGFy0Z2+rIG2vrFT3HVYE6R1pzwKUxKTGv/gJlkF2mSWetvIKMx/3
	 OxkPWFxvxu3Qw==
Date: Sun, 17 Mar 2024 09:37:59 -0700
Subject: [PATCH 16/20] man: document attr_modify command
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: "Darrick J. Wong" <djwong@djwong.org>, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171069247896.2685643.7638335950847568851.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@djwong.org>

Add some documentation for the new attr_modify command.  I'm not sure
all what this this supposed to do, but there needs to be /something/ to
satisfy the documentation tests.

Signed-off-by: Darrick J. Wong <djwong@djwong.org>
---
 man/man8/xfs_db.8 |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)


diff --git a/man/man8/xfs_db.8 b/man/man8/xfs_db.8
index a7f6d55e..d4651eb4 100644
--- a/man/man8/xfs_db.8
+++ b/man/man8/xfs_db.8
@@ -184,6 +184,40 @@ Displays the length, free block count, per-AG reservation size, and per-AG
 reservation usage for a given AG.
 If no argument is given, display information for all AGs.
 .TP
+.BI "attr_modify [\-r|\-u|\-s|\-f] [\-o n] [\-v n] [\-m n] name value
+Modifies an extended attribute on the current file with the given name.
+
+If the
+.B name
+is a string that can be converted into an integer value, it will be.
+.RS 1.0i
+.TP 0.4i
+.B \-r
+Sets the attribute in the root namespace.
+Only one namespace option can be specified.
+.TP
+.B \-u
+Sets the attribute in the user namespace.
+Only one namespace option can be specified.
+.TP
+.B \-s
+Sets the attribute in the secure namespace.
+Only one namespace option can be specified.
+.TP
+.B \-f
+Sets the attribute in the verity namespace.
+Only one namespace option can be specified.
+.TP
+.B \-m
+Length of the attr name.
+.TP
+.B \-o
+Offset into the attr value to place the new contents.
+.TP
+.B \-v
+Length of the attr value.
+.RE
+.TP
 .BI "attr_remove [\-r|\-u|\-s] [\-n] " name
 Remove the specified extended attribute from the current file.
 .RS 1.0i


