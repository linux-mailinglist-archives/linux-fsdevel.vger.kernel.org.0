Return-Path: <linux-fsdevel+bounces-55576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD11B0BF98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A97A17B9EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF14288C17;
	Mon, 21 Jul 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVw9oMZQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvpNVwMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA133C463;
	Mon, 21 Jul 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088708; cv=none; b=YbJKr23puFXxofPIOdtd7ymRP3/DnyIcGNF/gztuPH9DXWtnjLmHj/oC+P+119mPCEIRlAsjOlXaLOKPoDp9z+V89MhsjIRqVwI6X1QTO3stWBkA3OGXUEL89TlEtk9cujW8/pyXbJIYDAAG5Sctdh/NjmdV3RPblqWYKM8ov5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088708; c=relaxed/simple;
	bh=XUez0qzb1XxTxBFFSHpKERH/bWxLNcie0otjxRbGjk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cbPs1ynhLp2p6arSo7P9OMXOd4xBRUSZCYt+Vz9jRDi8jL+7fH/F7tHZc1JrpCCJ7315olZZYFT6R13ClZcvg7HxA3GLAecH6/wZ8e++o7xZBsY5XYM20ti32JPtHDc5ml+kazK0kZS8Im9K4wXWg1nw2tnRIVtJURFIUQ+jWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVw9oMZQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvpNVwMt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753088704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v7xwhbM4ewVSUaK6LjsBDrkhD8VT3UYS2YiOSlfKy+I=;
	b=bVw9oMZQmFhBoQjLz3YVGtxCHj11YIzddmPltbORk7Bwpm74+KMIQJkjPRkbiWZa5l3TLF
	9s7P+6nG08ykq1Aqq4Bv7JwfqQUyOU+VavFT34ClqVj3yUrrNBgCkFaH7GIzmx5Qs+w4Ns
	pgqhACQxyOTGDXBPxdNtZHib+xDlqtFY0/h4DEs8Y7zY4riLftmd0M3UoybDFNrz5OAGxU
	EfS2N0sNtoRIWtwsKI8LvmHYflKBA9scISGGANntftYFnLkL+ps99OdyjYg6bRO63tfTcq
	SXIo6DdQD1jvJLNt2dICaE2sLMKeIiTHJyu6WZ4t8JCSVJnopeE1tu34MX+/aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753088704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v7xwhbM4ewVSUaK6LjsBDrkhD8VT3UYS2YiOSlfKy+I=;
	b=xvpNVwMtspikSnKCOv6wCA7olKBjwF+Y/LZHah4hsCZWhEqmQlw4zavJ+BhCSmPIepfX4v
	b4U7oG9/K81zVpAA==
Subject: [PATCH bpf-next 0/2] umd: Remove usermode driver framework
Date: Mon, 21 Jul 2025 11:04:40 +0200
Message-Id: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKgCfmgC/x3MQQqDMBBG4avIrDsQA0H0KuLCJn90FiYyaYMg3
 r2hy7f43k0FKig0dTcpqhTJqUX/6sjva9rAElqTNdaZwfasOHIFf5s7cgAHlQrlFT7Cjs54N1L
 DpyLK9R/P9D4jJ1wfWp7nB5S5wK5yAAAA
X-Change-ID: 20250721-remove-usermode-driver-aecfe2950c59
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753088703; l=666;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XUez0qzb1XxTxBFFSHpKERH/bWxLNcie0otjxRbGjk4=;
 b=phF9AoagASovhoGeUtXwmm3h3ZyDYoesRXck1e1Phmgkbe5DX/T46CKpQn8QgzP0n6s5yj9N5
 yZQ8cd1Bm0UAO0alZZQfLZqNviGb0xqcSSC9sec+Vm7h73WJU2zj1rf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The code is unused, remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      bpf/preload: Don't select USERMODE_DRIVER
      umd: Remove usermode driver framework

 include/linux/usermode_driver.h |  19 ----
 kernel/Makefile                 |   1 -
 kernel/bpf/preload/Kconfig      |   5 --
 kernel/usermode_driver.c        | 191 ----------------------------------------
 4 files changed, 216 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250721-remove-usermode-driver-aecfe2950c59

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


