Return-Path: <linux-fsdevel+bounces-12257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7785D6C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 12:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD6B1C22CA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337733FB3C;
	Wed, 21 Feb 2024 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Qazc9y6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward202c.mail.yandex.net (forward202c.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96313F8DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514650; cv=none; b=f7IJkgZgw1C6asALJkSgxHk4wFmn4LO19SUcu+db+ZpMt2u5SJWlfsjVTfw01yaj5WJJ/QDY3VKwNV/vlUjkVebtNPvDqIDVPgkHDPmahabi0pRO6oaEIj+EGU9Ngxy6Y5C0Ajf8e+/PgLoyvg9ip/bo3ZV5BWHXubepoGed3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514650; c=relaxed/simple;
	bh=5B1v+GSW0KNawNGspWptB6v+kveDZ0cfBgr43OW0hds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlycZt3Re3/s1VMfgjaKtl5QNRqNE+Y+8LAxi9Npjj2cXZGP9/jeaSKBlrim00sIuWllaOCgH9VBjkRdPo7/lKmrbai8WlR3oj4YU1zNFfK7g5ZW+H3d32XgKfXpF/raUsOOiWw/+Xt2xJCtjyQToBsbRJtmIM7zcj3jEF+W1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Qazc9y6Y; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward202c.mail.yandex.net (Yandex) with ESMTPS id AACEB64746
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 14:24:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:291a:0:640:791e:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 5BB8F60B54;
	Wed, 21 Feb 2024 14:23:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rNQqDK0oH4Y0-Gq4RMmaV;
	Wed, 21 Feb 2024 14:23:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1708514634; bh=/2K5WkY6huAzgSsUx1MjMrRZqXwVrspkA9joziiw7Is=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Qazc9y6YWcOWjsYEAbJ5ZBEPuhjLq9qs5pSx9h3tscKb9F3q4qKp9bf5D2GzL5Zel
	 qlbOWZgIfEKuA1BBSi7o8E/yxKkHn8MIi9CJBrr1hXUCHqXvpXQPKrt9h1dc98gDr7
	 6bOS0Vsz6f5EOn4hl+kbc7iI31nxY0fitqfNM44M=
Authentication-Results: mail-nwsmtp-smtp-production-main-37.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] eventpoll: prefer kfree_rcu() in __ep_remove()
Date: Wed, 21 Feb 2024 14:22:05 +0300
Message-ID: <20240221112205.48389-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221112205.48389-1-dmantipov@yandex.ru>
References: <20240221112205.48389-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In '__ep_remove()', prefer 'kfree_rcu()' over 'call_rcu()' with
dummy 'epi_rcu_free()' callback. This follows commit 878c391f74d6
("fs: prefer kfree_rcu() in fasync_remove_entry()") and should not
be backported to stable as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/eventpoll.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 786e023a48b2..39ac6fdf8bca 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -678,12 +678,6 @@ static void ep_done_scan(struct eventpoll *ep,
 	write_unlock_irq(&ep->lock);
 }
 
-static void epi_rcu_free(struct rcu_head *head)
-{
-	struct epitem *epi = container_of(head, struct epitem, rcu);
-	kmem_cache_free(epi_cache, epi);
-}
-
 static void ep_get(struct eventpoll *ep)
 {
 	refcount_inc(&ep->refcount);
@@ -767,7 +761,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
 	 * use of the rbn field.
 	 */
-	call_rcu(&epi->rcu, epi_rcu_free);
+	kfree_rcu(epi, rcu);
 
 	percpu_counter_dec(&ep->user->epoll_watches);
 	return ep_refcount_dec_and_test(ep);
-- 
2.43.2


