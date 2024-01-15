Return-Path: <linux-fsdevel+bounces-8001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BA82E1E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729A2B21CB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1901AAC5;
	Mon, 15 Jan 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ug9FFR/K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABB199DC;
	Mon, 15 Jan 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1705351332;
	bh=0GZMuy83Qkf0CT/wQsE+OjcK1LFAZ6r3ajEM94ed9LM=;
	h=From:To:Cc:Subject:Date;
	b=Ug9FFR/KsLbVoL5B811EdsJ/O1Zm6j1L9J0D1ecV4MZKvKLvqbMMJn5OuuThujw6k
	 mObChAZmRLKX7Az1jtOIH5gBZWPvT9lU4cf2vLqVasOpbFeKJNS2zzAGmdlaHXbfq9
	 V3NkTFqjeIBPie+58H1P4DckWWMDe9XtucoW3FxM=
Received: from localhost.localdomain ([2409:8a60:2a63:2f30:a63a:c84e:620:9928])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 6CEB9CA0; Mon, 15 Jan 2024 23:27:14 +0800
X-QQ-mid: xmsmtpt1705332434ty7d94vs3
Message-ID: <tencent_B0B3D2BD9861FD009E03AB18A81783322709@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6cs2bsyymhyvFqUuhCAPk9ul8rNUG4VgNtxtY0dH5g0uBkpcTsB
	 Xht6BF+QP6s/SL7G30S5jJjmR9o9pGVmdbyo0afFDoykRUnsEIRuL/slsLeyxIsSMcSpSRJK9nsa
	 BGOIcuOBVl0f8IjUpdQidRA2UVg7Jcc/fMhtNUYkq4v8IkhJGn2++cmIX1kANYAgqumj6aiArSQi
	 spHPN5Bsa+kzRM2OsW65efjjbaoSE7yIvQ67OfC3jhn/loPgArhha3ZanBxWUbijIl/7t40PO+xI
	 cyWe/Esj80/zuIQ4cAgOjMvZgMIb+FfHLjHCoeDFXk8ou5mGPwa2jjN+5WGE/UoKtSZ/ZYFjD/GI
	 /hq9Pzp0YU7IkC1HZLLI9wZN6KpSJqotegBefXd6GBgQbF7eMGTD/BrTqGfACRAPoH+IkbXMXTMG
	 JmOVE6WmtbmFKfDSXUdTzvVWWQmJa5YUhTQop0dn5jmRQQ1/BWDR4LlttoaBIhJdUKyO2L1eLOW1
	 ZtnDQrySnyr3Opx4GNpUE76ruKiXMGVHbGGNyl9gvKNIhgSCyx9c+jJfVCP8p+csJjTmnDYeeXmu
	 TufLAOGpht3SEYSeWGi9i73wh2rKk93v/ipkSuO3syhB0hy7fkgeMWUDAHWMOGOCr20QLV9+/g+K
	 2sONJK53otXGWAG39h+cq+Q36Hxnjz1tE4Xw8jF363dsUql1p3KY8Z/FJqlRJsCPfZ6nmjYn+gka
	 G4TndEWzv3wMPbhgwC/NpNiDU6vNC9t8nBkcIhBmjSE6S/+HZcvaumWTCwLklRPZl/ukMsNmNA77
	 gleYm58lShb6aW6HckH1eZmQspSiu+Y404pzf0R+A1SKTaF1p7Z1yZs27XmvTRTkByd1RAspEmO7
	 dNEXFz4NInc0Uxxt7vCPwLIzjd6O20lXL+22MrbZfGD1wBhRX/QydfetnLSTsHhJnmQBK+L+l3Eh
	 xJox79qv8uVd9ClDyzaRkpQtw8Lq6GCvKEINwtUeoOp7goGQbQZ57E3QSaHz1HJQUXO2+EPckXm0
	 PIx4CMkr9TNZVs54qr
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: wenyang.linux@foxmail.com
To: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Dylan Yudaken <dylany@fb.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] eventfd: move 'eventfd-count' printing out of spinlock
Date: Mon, 15 Jan 2024 23:27:00 +0800
X-OQ-MSGID: <20240115152700.9478-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

When printing eventfd->count, interrupts will be disabled and a spinlock
will be obtained, competing with eventfd_write(). By moving the
"eventfd-count" print out of the spinlock and merging multiple
seq_printf() into one, it could improve a bit, just like timerfd_show().

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index ad8186d47ba7..a6fa6ee748df 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -283,13 +283,18 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct eventfd_ctx *ctx = f->private_data;
+	unsigned long long cnt;
 
 	spin_lock_irq(&ctx->wqh.lock);
-	seq_printf(m, "eventfd-count: %16llx\n",
-		   (unsigned long long)ctx->count);
+	cnt = ctx->count;
 	spin_unlock_irq(&ctx->wqh.lock);
-	seq_printf(m, "eventfd-id: %d\n", ctx->id);
-	seq_printf(m, "eventfd-semaphore: %d\n",
+
+	seq_printf(m,
+		   "eventfd-count: %16llx\n"
+		   "eventfd-id: %d\n"
+		   "eventfd-semaphore: %d\n",
+		   cnt,
+		   ctx->id,
 		   !!(ctx->flags & EFD_SEMAPHORE));
 }
 #endif
-- 
2.25.1


