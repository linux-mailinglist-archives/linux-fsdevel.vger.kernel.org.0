Return-Path: <linux-fsdevel+bounces-56501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E772B17DB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 09:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D53956759D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9C1F582E;
	Fri,  1 Aug 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kGi2ZJGe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUl8Vj+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A6F9D9;
	Fri,  1 Aug 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033925; cv=none; b=lT1RuyZI0B6EVrrQ7Ir9OhZPhXA/0p+2Z0fkLNvt6HzkwgDMobbgL79R+HAaGEhLSxyDnklcet3jepHFa0qgqWl83z8uHoMUM1CJmXkkhYa+BFbXY5PyJ56Uqss4f4vNhLfIKxKVLku71Uu+gd56dSZybdbWhZY+Q5GU3gTQj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033925; c=relaxed/simple;
	bh=PGSS8x7qm8EIe3sbWot/wbVpmWKX74SZE2yiS8a1uXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pT5rbU1h2DowCyq+JwGMZpqpnIhuMKGP2/H7AYV2j+y/kMYWrXfiAQtbVUACk6oQiwA6k36QQEA7Lu91MRVyiVb4MikJURx1syrXNSXDsw4aR8h2+f5iRXaBEXvb2mcbghxnQdpaU4Unf7+MAIyjDziF+WaJ7EscdeaIF9CgiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kGi2ZJGe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUl8Vj+D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754033921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5kF2WlUlEx7Vqnbj22AkyXv6Snlc8aWmu7qYKOYjR2Y=;
	b=kGi2ZJGe64q7dEkyQUw2e1Ec9kq+WN2oRBAJDaj42ercgCEJGmN1Nl6Y2XXxl5JX6aLTjy
	0UXenrKnJI8nvaB2mNmJgUnwgNX9szLLQfdD82PlTE4umiPou9wIcEkgiKl5z/hWPDWFLF
	vMfuZM1n83zxQBo2zsxwl3HaT8DznH9qNRBBF9p3cVpmkVHDGrjk5SkBkqubUHfdh1BMQY
	AtAbEu9xLaqr7vvbU5Pu0XlU/ycfxT3BnJJZtMmIA71Yu7Srr5TSVPcZnJP+bn1d/90GKo
	Ntp+Cnk6sHpOrq12h92iqwISvrOXIfpb8llZ6XbedK9w5EC0JIdAzuR7PwVeZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754033921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5kF2WlUlEx7Vqnbj22AkyXv6Snlc8aWmu7qYKOYjR2Y=;
	b=iUl8Vj+DMODle1VAKyqzKCwTXzSUGWrP6rXXRLozwpiXCTtWAcL4cUxsEITAer4V8rPjnB
	8cNaeIrl7zruV6Dw==
Date: Fri, 01 Aug 2025 09:38:38 +0200
Subject: [PATCH] fs: correctly check for errors from replace_fd() in
 receive_fd_replace()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAP1ujGgC/x2M4QpAQBAGX0X729U5HfIqknT7HVtCeyUl7+7yc
 2pmHkpQQaK+eEhxSZJjz1CVBYV13hcY4czkrPO2s5WJchtFgFyYIk+Kc5sDTBuZfUDja8eU41O
 RzX88jO/7AY2Nv/hoAAAA
X-Change-ID: 20250801-fix-receive_fd_replace-7fdd5ce6532d
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754033920; l=1294;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=PGSS8x7qm8EIe3sbWot/wbVpmWKX74SZE2yiS8a1uXw=;
 b=OOn1jtA+R/DDitrIWgv1RnQw5cNJhSUhdhc3wUpCSB/tOmMJUfGj+BsCUhw662PgfLeaVLHqg
 lwetsICDeSKAF1LWTkt/23USztKQlF+6fcWWRF1n31YkM7rvKmEzXZl
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

replace_fd() returns either a negative error number or the number of the
new file descriptor. The current code misinterprets any positive file
descriptor number as an error.

Only check for negative error numbers, so that __receive_sock() is called
correctly for valid file descriptors.

Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Untested, it stuck out while reading the code.
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 6d2275c3be9c6967d16c75d1b6521f9b58980926..56c3a045121d8f43a54cf05e6ce1962f896339ac 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1387,7 +1387,7 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	if (error)
 		return error;
 	error = replace_fd(new_fd, file, o_flags);
-	if (error)
+	if (error < 0)
 		return error;
 	__receive_sock(file);
 	return new_fd;

---
base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
change-id: 20250801-fix-receive_fd_replace-7fdd5ce6532d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


