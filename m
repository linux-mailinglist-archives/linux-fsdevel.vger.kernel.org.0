Return-Path: <linux-fsdevel+bounces-34662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044BC9C74BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3971F21498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379013D2B2;
	Wed, 13 Nov 2024 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTw+RixM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58233208A7;
	Wed, 13 Nov 2024 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509348; cv=none; b=daJIPCXS+hdRPdV0Arz58BCjRiXtR2sUKn7SqyBGamoxMKXl4KCohOKlz6w/8j9oWtwr4Wa8/1B3lTU4Ogilzjkjm4oEbW40jSkdoi4ejmHA4pp4JiVOxAF9EU3+tMn/Iz7Q6tKF3UpuMRMQ0vhwq275MYRPgk5AXANiN/zGOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509348; c=relaxed/simple;
	bh=XO/moQFwA/UzdpVLbdaRbzcRuBess2uvYfNKaZYVfdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J/b+uOfpqsqUpMuP2yZygUkcCmvXD9MQPl54JS2fYQMGCT7TM4c+58zDbpZYWnVD6Qsmm3gOLOAPXTRp8P0Ih1laVXXHHyjxJvxUEdnlq805ZMZm49Hd0KsqqA2m1as4vHjrc0Ml7vFx4xGDysI9pmyCDIcyN9avDCnCaAVLzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTw+RixM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C22C4CEC3;
	Wed, 13 Nov 2024 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731509347;
	bh=XO/moQFwA/UzdpVLbdaRbzcRuBess2uvYfNKaZYVfdY=;
	h=From:Date:Subject:To:Cc:From;
	b=LTw+RixMS/Q8U0v4+D695I95J0UnhqM7ZWZYqCNLefWWlidcHlUfz1YnnMgLTyGRI
	 t5atiIEw9xnMTsYdKMkaQoY5Hsr7LIGVfkXFkTLjQ9dQdXrCL/y1ixgFVVU3KojY8L
	 32/bbEsnfBucA3AkKJWh23dvJQCzBjuloTGIx8Nk4F76knXgSy6xTPzLF4kgb6VfFE
	 CL8omS2/N5/yTvYFdgoSX1/HdrTZ+Lx9k/Z7+xYO5X5s5ILgNX20/+ZBEPoqx9N5eS
	 9hypGw3OpsfE5djvw/TS7D2DwbllcWgQBsWnViKu6fqKTBbrM6E6lr4T30JAnbncQI
	 G1g+RDQDpTHRA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 13 Nov 2024 09:49:02 -0500
Subject: [PATCH manpages] listmount.2: fix verbiage about continuing the
 iteration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-main-v1-1-a6b738d56e55@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF28NGcC/x3MQQqAIBBA0avErBMadVFdJVpMNtkstFCIQLx70
 vLB5xfInIQzzF2BxI9kuWID9h24k6JnJXsz6EFbRDQqkESFk6aNnTF2ZGjpnfiQ998sECje5Bv
 WWj9Md7clYAAAAA==
X-Change-ID: 20241113-main-192abec3348e
To: Alejandro Colomar <alx@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XO/moQFwA/UzdpVLbdaRbzcRuBess2uvYfNKaZYVfdY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnNLxjnBEjLVAgOhJ6jKw4qUoTHgU8sb4TIyA+x
 EjU6dFhF6WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzS8YwAKCRAADmhBGVaC
 Fc0hD/0Tzi3skgPCxeo58Yy1zXEqBMUQW4B6P90she9vBVdXA6Wluqs+WNnR8i66HTKqwwFZEES
 sZj2iHZNcB1YV/Ota76Onz+FBLFgEDQDsNF3NW/RK0Bve02vJnJ1+6jo2ZRnwRV91O+/QMCey1t
 eX/vl/MuPo/9zrwnNdShVxhTPlPxcsd9EnKwciRtI2HXVfgThe7+sO3fPvTshsRgGLpVllcAQRD
 h8a2fQuERQ5/612qSGOABes201dyRG6ukwg8P599RPKmjHPjhOKajDqy08S6gVSS20oB0zp/fMX
 G15pyahwE6WAKlz9GHlsFFXIVbtlRrKwho2LozLL/XY/B0+OwdPbgDiBJSQaAhcgXbZY4bouiwI
 tjFe6d1lPgzoxtveAsZ5mXbSmL0t10tU7Thw4krTyhVKwNy6eOYS7DZRT4woPNDH0boj4EDZQNK
 OuCoDf8TsjRtYggY/0Em/GDxVbDVzgUblEIcx4JP76Ib+OPG5JTG3mTdPVLACnZWm/KEbEDd5Tw
 nOKJcB4SfxDNqAXbDxR9GQE/EJ/gUKhv/VVlGds4rYUBXQTlnB/AAYmDpXcBuYk6pG5ur7To3UM
 m3KNyBuXoDVKjciIYeCtxLAnUacxPpz/ZsBvfpkukWwgRt28DrIq/Ch84K6PnUsustnzu1UfzZO
 CCznEb/d8kXSB7w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The "+1" is wrong, since the kernel already increments the last_id. Fix
the manpage verbiage.

Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man/man2/listmount.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man2/listmount.2 b/man/man2/listmount.2
index 717581b85e12dc172b7c478b4608665e9da74933..00ac6a60c0cfead5c462fcac44e61647d841ffe5 100644
--- a/man/man2/listmount.2
+++ b/man/man2/listmount.2
@@ -67,7 +67,7 @@ is used to tell the kernel what mount ID to start the list from.
 This is useful if multiple calls to
 .BR listmount (2)
 are required.
-This can be set to the last mount ID returned + 1 in order to
+This can be set to the last mount ID returned in order to
 resume from a previous spot in the list.
 .SH RETURN VALUE
 On success, the number of entries filled into

---
base-commit: df69651a5c1abb61bd0d7ba0791f65f427923f75
change-id: 20241113-main-192abec3348e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


