Return-Path: <linux-fsdevel+bounces-55402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26CB09CFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A097AF2A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90394292B31;
	Fri, 18 Jul 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qX2tw6Mb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJNR/fOc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B2289E2D;
	Fri, 18 Jul 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825164; cv=none; b=D3MXIHYnD2dLXtOOF7aITlpTzxYo1Cp7CKmTqAg6V3RMVoFs9T+gimLyhu0c4o52EfQMnX5akr2vyzPxg1HBKvBlM/LXwSZ8DGKh4a5S9opS/F9mAEEbJszXTpDDk0A8jgZr9Tfh75PUokDHZJ6M5yYckfKV0St9fl/w6ZIEdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825164; c=relaxed/simple;
	bh=sOfzeTwqTG7f/Ati4W9Z1NVr69xb5bIobrtCWGE8mdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSgZFK95+UeYWwA2ItGgQYv7cqXkyhYA/FzceQ0awetN2fZjZyuC6npRoUSN1wemXkV3YqFcqT3EPXBguCgo5O7ys9u61M6WGO5EtOi7twfiDA1wYivrxFyoQrgPFmPbBZmnpqhKhYkfWDQzbnceUiufU2IxCqM4QpXSYFZycaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qX2tw6Mb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NJNR/fOc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752825160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BwEWD4qvYzaENyWfAlwjrgaYMB82m+ofDaxmeiPkq9g=;
	b=qX2tw6Mb0TS6zwbmfVi8xraBvAL/sSFLNxVaMSIsf3XcEy21CRXBivKpuoXlb9FOkz9VeX
	G/YXqb80lw8zHzYa04h9JZTMHU+kUjOnGbzTTFQrbQCRuY6mzweUGZjBzhlQUBcSceoslK
	sebi4dAJtm3OCbzZrb3kr+1QBfcqXbBOPcGNPm/v3PK4N1rget+cDDAQDQ7WwS346UuS2w
	xidCac9oGmcisrea4+DPuG5jykZ95s3ew58nie58zSezOKCR7A2rGKB/+rEW5HjL8PsB73
	SjFcOBxYWYFA86+AGk0lG4uqXGihOiBTTOJo/yMvSpZYh0dWurzlSiRmBvhD9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752825160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BwEWD4qvYzaENyWfAlwjrgaYMB82m+ofDaxmeiPkq9g=;
	b=NJNR/fOcMTDz2z4bIUVgHNZeeRJXVFhJm1WgGHFuk2nugGWF0dzX5Qp4wDhLfDP94gnv/K
	Vgt7iW440dPFQuDQ==
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Khazhismel Kumykov <khazhy@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] eventpoll: Fix epoll_wait() report false negative
Date: Fri, 18 Jul 2025 09:52:27 +0200
Message-Id: <cover.1752824628.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While staring at epoll, I noticed ep_events_available() looks wrong. I
wrote a small program to confirm, and yes it is definitely wrong.

This series adds a reproducer to kselftest, and fix the bug.

Nam Cao (2):
  selftests/eventpoll: Add test for multiple waiters
  eventpoll: Fix epoll_wait() report false negative

 fs/eventpoll.c                                | 16 +------
 .../filesystems/epoll/epoll_wakeup_test.c     | 45 +++++++++++++++++++
 2 files changed, 47 insertions(+), 14 deletions(-)

--=20
2.39.5


