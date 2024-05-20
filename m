Return-Path: <linux-fsdevel+bounces-19766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D0B8C9A20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303371C20980
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF7208D7;
	Mon, 20 May 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="tltHW9Et"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B817582;
	Mon, 20 May 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196214; cv=none; b=eIUgVAzOcqhi1fGXDurskFaFdU2Pgdr3I3xF40FoBNV4d7A9Qz5RErJggpSFt15u04J3AviorvNrXaTMECvHFyoP700QrUwPNnQDjKlmvLXCHD3uRDa/lrjRkydrjBrkiX+rblgOGs9chATjMOjS11/PM9o+SOsTM4r/RDBRJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196214; c=relaxed/simple;
	bh=QMnAxaPzlL4eiJg04ZbAkcZo0hqXo9HoK8/+LMpK6qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCkpl7MprGYdY/lojSNSshA2+jppud95xjLYt62agdVd4IYBSC1DqUTYgYaFFcrzts0A+ORIWOhSBW9C2ayI/Qfdq24vK1W4KUGYCqayU6lIKeQ4fPMcNQqvrXE1C+rOfjLj+oSjR8jP7sjmRW4KSRBLHxCkfXyPw7ZvADpU7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=tltHW9Et; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0AD8C40205B8;
	Mon, 20 May 2024 09:10:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0AD8C40205B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1716196203;
	bh=cIAuQ05HL8dT+YuU57b7ICw2uMbJEDIVKdXTJG1CATY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tltHW9EtPDxPvt24ND6x0Rzcl8xX/NKIxbyf05UH5YVZKO+rFby8gSmx+VlIVeHtI
	 wnk6E5Lauv0HPtGmz51Xt7sOfP1XLptCOKCau34id8oSdvd/v7ji20VlYt3iwF4Gje
	 Y4YZHZJhpqzujxD3BXypeTr4fxJNRGNhkDSxyy/I=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 2/2] signalfd: drop an obsolete comment
Date: Mon, 20 May 2024 12:08:19 +0300
Message-Id: <20240520090819.76342-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520090819.76342-1-pchelkin@ispras.ru>
References: <20240520090819.76342-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fbe38120eb1d ("signalfd: convert to ->read_iter()") removed the
call to anon_inode_getfd() by splitting fd setup into two parts. Drop the
comment referencing the internal details of that function.

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/signalfd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 65fe5eed0be4..ec7b2da2477a 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -286,10 +286,6 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 		}
 		file->f_mode |= FMODE_NOWAIT;
 
-		/*
-		 * When we call this, the initialization must be complete, since
-		 * anon_inode_getfd() will install the fd.
-		 */
 		fd_install(ufd, file);
 	} else {
 		struct fd f = fdget(ufd);
-- 
2.39.2


