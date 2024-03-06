Return-Path: <linux-fsdevel+bounces-13674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3F2872CA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 03:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6502881F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D08DDA5;
	Wed,  6 Mar 2024 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="n2ZQ5N9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFED51E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691482; cv=none; b=kVE7ADtZ5CEWCkeMcW+FtXiMRof6WDCDIxSBTyebhirWYnnZJxkwV27wSxULNP30cjJ6L+xBPJ4x4f6MpYBZBdKmuIhArTlINNiTNHvxmQsKzLTY/x2AH8eAHP1OJaw1EyHdbGEhrcFwh+Tc5LJ2mmg+39q0yXOBzD1aO+yB1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691482; c=relaxed/simple;
	bh=NtlAdQVanrHnuavArlrSacR53ojymwrNjvlYbyL8GMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joaSZDecNL60vslJJQyEcR8Ej3YiF/JjEO2kJkcC4bc9HGFpDzdvKDFll0qw5g9aoPSzuqYebLdn2Yz9DqLP5hrMxDGa+g+sFVvdsGGIN1VvQEBVnhyqvFsh89mxyXwCfG55Pny5nihq4dWT3vlXqzl0DqcBSIkDjTjGRIdOcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=n2ZQ5N9l; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Received: from nebulosa.vulpes.eutheria.net (71-212-26-68.tukw.qwest.net [71.212.26.68])
	by endrift.com (Postfix) with ESMTPSA id 33426A2A9;
	Tue,  5 Mar 2024 18:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1709690925; bh=NtlAdQVanrHnuavArlrSacR53ojymwrNjvlYbyL8GMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2ZQ5N9l0LwGmvE8GiHuPSWryv6iwbz90RU7jU1jUmDHfheiq6ALDFL8tjKtvXqH9
	 /AO0b4yMGyVcRAaik2dANYBhThC0xGaEeVYV90jyr1Q+edkEaalzrAi6xvlh9ElU8O
	 WR71sgXLBrqdXzW8XtJX3pX+kwnDffbvLyEuxpEDJxXKAmbrKqC37md16u40f356ja
	 +ZsLBOu/NUYnmmIwlhyiDQX0vgtqiTyW1kCkenKocNB+O80KJmzdvIzLtdUmsaqeZt
	 tfYpnugYhA8sDikacExYUc2gmWOrSDCV3UpdYrXPtsf0oQTXXJZumMG4Hgzl+bmyl6
	 tKAOkOVhq+FIA==
From: Vicki Pfau <vi@endrift.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 2/3] fsnotify: Fix misspelling of "writable"
Date: Tue,  5 Mar 2024 18:08:27 -0800
Message-ID: <20240306020831.1404033-2-vi@endrift.com>
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
"writtable" in the comments. This patch fixes it in the fsnotify header.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 include/linux/fsnotify_backend.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7f63be5ca0f1..8f40c349b228 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -31,8 +31,8 @@
 #define FS_ACCESS		0x00000001	/* File was accessed */
 #define FS_MODIFY		0x00000002	/* File was modified */
 #define FS_ATTRIB		0x00000004	/* Metadata changed */
-#define FS_CLOSE_WRITE		0x00000008	/* Writtable file was closed */
-#define FS_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
+#define FS_CLOSE_WRITE		0x00000008	/* Writable file was closed */
+#define FS_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
 #define FS_OPEN			0x00000020	/* File was opened */
 #define FS_MOVED_FROM		0x00000040	/* File was moved from X */
 #define FS_MOVED_TO		0x00000080	/* File was moved to Y */
-- 
2.44.0


