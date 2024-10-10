Return-Path: <linux-fsdevel+bounces-31644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 497519995A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770B81C22398
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B311E47A4;
	Thu, 10 Oct 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3DxVA6TQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D61BCA0A;
	Thu, 10 Oct 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602028; cv=none; b=TkQRyIbA2/Fzx4ucjzvjqiBq0txz/ypCmI+9z8BImGQH/YuTSwU7UmkpShSJRtUvZDkY92hx28YRHITg9N8vm7FUayCVW7vASPyrXVpS9eww9FvURBSBSsAyvHQBcpN9DzknMhI/YscF5kM33n0+o14vFdV7AuECo0K4neosGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602028; c=relaxed/simple;
	bh=ngdjVouWe+PLztzhxjJW6C3uAAPMwiae6xIS+yHMikA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZ2lmQVhS4zdWyv73MOKgRxoUVhv4WJvQw+sc6TvoUYlsQWThIh9hXGHSZt+j9M4Drnxg7kqUdwV4pr97zeA+g8BjHhf1nQDLhLfsuW08ciUK8RyHcbpIOr3j+5aqQt7wP0itO2ivK4dz9cFPHPtp+H8Zmpvt/4FyCRIBQ+qzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3DxVA6TQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Q12Tn3+ECMtW5503eMsGcm6IOyPdQSf8RLHIMjGO7+o=; b=3DxVA6TQyu/lGTYkhYk9E6U7ii
	KntF3BwI1ADdIgtBKbi4s9Adl+F5FqqKP9Z4T8fl8qucVzAo71C8JlFso3ssIRxBE6aRxNFNEnk57
	PAawSy4JwL9znRirWNjQGzJfI5mIlS+FM1cfdq3tgyaHvPXkTgiBW0zq9lYfFQ9/u6YueCx1kHE4u
	Pddb2aWJZZAZZrzjLagZb85os8eY1/fVbRwS7ymJDgIxJhQbw4husdL8MFikEvG230CLKlGIEH21J
	B0uQd34O/a0t2kk5nGMBblHtmRqQ81WfaBVwEVYOBYCF8lS8k+uaMcIxrQMHPs94I72Ol+yl2m/mv
	SHaiWM+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sz2Lp-0000000Edba-23U1;
	Thu, 10 Oct 2024 23:13:45 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: keescook@chromium.org,
	j.granados@samsung.com
Cc: patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: remove me from sysctl
Date: Thu, 10 Oct 2024 16:13:44 -0700
Message-ID: <20241010231344.3488817-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Joel has been doing a great job at sysctl maintenance, and I've tried
to use my time to help with other efforts, so just remove myself
from sysctl maintenance list.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1058f02e613..6a0749db1060 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18618,7 +18618,6 @@ F:	include/linux/proc_fs.h
 F:	tools/testing/selftests/proc/
 
 PROC SYSCTL
-M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <kees@kernel.org>
 M:	Joel Granados <joel.granados@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.43.0


