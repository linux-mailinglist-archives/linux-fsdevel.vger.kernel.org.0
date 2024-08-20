Return-Path: <linux-fsdevel+bounces-26379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C9A958BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6058B1F23316
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA9219D8BB;
	Tue, 20 Aug 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ur7gB0XH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C073176;
	Tue, 20 Aug 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170428; cv=none; b=vE/5I5+QpnkeXSNBPrWVR6N2W1d29NgN+d94Q91YHlIBTzElPeXBOJiR34J2lbjnd4omYNxYsXB+YQzYB0dx/PMi1gBTL3HeH5ExwPcU38jRnjPoEzXhgRX74nhoZLWBxPbXxbqRTPlnzy0yK/wB/8WPZ7S0TXZ4HngEFXTZvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170428; c=relaxed/simple;
	bh=u1OBCw8lhJ/KBGXPAHwJBxAiK9D1v7xPpp+SY2QNN4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQZZD1erbnEVjFKf2QRxAiNgqYU/Fergix2tPVPTCk6TBSjnGzn6kI9rzdUWZKW0p75iwn14fF2wRzKHygcekNTsWqQfRF4N+m+dLukRB2uToQOqqa/V3smtH4ZKavAKzHXIppVWlCsj0cs9RBmg0SnB8+xV6rLzGAvsoDNhyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ur7gB0XH; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WpDzP4qljz9slY;
	Tue, 20 Aug 2024 18:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724170417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MRDbeKxPsqXdChWWngfAVr7jcYfztwIhGfk2/Sk7XsE=;
	b=ur7gB0XH7LiF+8vnFRN+mF+Zx5CGOcBWZ8NS/yjaFQRbNqHiyQSf+9GtrZBpfh+RTqhHWV
	dvEN/lLkCNIis8RyIsdzMFgIlYkaERQPnn+d5laIj6KBXUFvsotuPBPYxCNhkWaHQ5dZfa
	0T/U0Lr8YeKqsRP0IZDlcR3G/jaBJY1twHM+ljo6G196UVVKv8vqRC7IyJDRsKntxjnnhG
	+AHZ3FpXOAxlPCmQFblJ2g0+0EF0xVJD260OgQDzXeyK1urkq/V9wDBzV315Pxi9u+9sfF
	EVW7Aax0wEjiu+JL9u1K0TfNSC95ubs9tupLO1NyH1uG3l3KsneWraYXTW/Nug==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Jonathan Corbet <corbet@lwn.net>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] Documentation: iomap: fix a typo
Date: Tue, 20 Aug 2024 18:13:29 +0200
Message-ID: <20240820161329.1293718-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WpDzP4qljz9slY

From: Pankaj Raghav <p.raghav@samsung.com>

Change voidw -> void.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 Documentation/filesystems/iomap/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index 37594e1c5914..7261b1b2c379 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -165,7 +165,7 @@ structure below:
      u16                 flags;
      struct block_device *bdev;
      struct dax_device   *dax_dev;
-     voidw               *inline_data;
+     void                *inline_data;
      void                *private;
      const struct iomap_folio_ops *folio_ops;
      u64                 validity_cookie;
-- 
2.44.1


