Return-Path: <linux-fsdevel+bounces-13672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6C872C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 03:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB9D1F23F6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693E8801;
	Wed,  6 Mar 2024 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="AMAVbE6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA3D518
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691482; cv=none; b=oSlgFoYLlJUSGnOkXyI/7T3YLDg+CETtIAZPfAzCw/ohTaggrgFS5pWWHsqBGXqWgDsaIdFsfXB1+RG737jPdaXaaVVCTs+yOwXJ08vJOj89nGY8bZxcTWsWY2G1XCTnnEMFnWOqONOH37087uLgf6PE0RYRuFZ959jIdtd5lp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691482; c=relaxed/simple;
	bh=ex9yI/pATjFLqiXKqAc0OXyvWqnhyVUaU8mzdNPhoO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnUf7J/SxRUeW5tdaOScCPbobo9ye2N0ShH18mKV5V1QRysvO7BrF5jrNuCax1n1ZnU2kRc5VXQyam6eyHka59YskNfudsT/PkuFDXjlQvo6lMwv1MXalj3GjM1NS0NS/NncJ4Vl90TojxKkGMHoXyhveiYnbkG4/Uctnx4fEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=AMAVbE6i; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Received: from nebulosa.vulpes.eutheria.net (71-212-26-68.tukw.qwest.net [71.212.26.68])
	by endrift.com (Postfix) with ESMTPSA id 8E1C4A2BF;
	Tue,  5 Mar 2024 18:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1709690925; bh=ex9yI/pATjFLqiXKqAc0OXyvWqnhyVUaU8mzdNPhoO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMAVbE6igr4H1AXM69uzkxFbB1triy9uAskTPd36AtHQJvgb9Jc9Qjc14KoZ8/QAy
	 EFT8h7j9XbCgUuXA5jjdJYlvJ6R5laKiBCQRcKD/0zggBE9HOXVleWkOHydaMeAzAS
	 pb3vPDCUkNL1rTUF8opLorKcEh/udfpj96PnbKI7Gs7MULweUD33MQFWuz0X5E5l6F
	 nq1lq0A2jn/4TOlQoQsBF7xX3P5hyyW0AjTibUBoW9nAl3KHZyGzKQ4uhbX3IqAuzU
	 mODjdrFQd8Z/kaVGhTqcOzvtVQ+Gt0KuDxkLtA+6FTTn9J2pIVDMsRhKR1N+rmkzhY
	 ETkCy52rac80A==
From: Vicki Pfau <vi@endrift.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 3/3] fanotify: Fix misspelling of "writable"
Date: Tue,  5 Mar 2024 18:08:28 -0800
Message-ID: <20240306020831.1404033-3-vi@endrift.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306020831.1404033-1-vi@endrift.com>
References: <20240306020831.1404033-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several file system notification system headers have "writable" misspelled as
"writtable" in the comments. This patch fixes it in the fanotify header.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 include/uapi/linux/fanotify.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index cd14c94e9a1e..a37de58ca571 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -8,8 +8,8 @@
 #define FAN_ACCESS		0x00000001	/* File was accessed */
 #define FAN_MODIFY		0x00000002	/* File was modified */
 #define FAN_ATTRIB		0x00000004	/* Metadata changed */
-#define FAN_CLOSE_WRITE		0x00000008	/* Writtable file closed */
-#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
+#define FAN_CLOSE_WRITE		0x00000008	/* Writable file closed */
+#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
 #define FAN_OPEN		0x00000020	/* File was opened */
 #define FAN_MOVED_FROM		0x00000040	/* File was moved from X */
 #define FAN_MOVED_TO		0x00000080	/* File was moved to Y */
-- 
2.44.0


