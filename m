Return-Path: <linux-fsdevel+bounces-46519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716BA8ABF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0E44198D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137A2D8DA5;
	Tue, 15 Apr 2025 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="CbBsLxYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B41C54B2;
	Tue, 15 Apr 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759006; cv=pass; b=FLACfqwbfTJnn73JWx8vqzZI/+FDCxCP0MUF+Vt1iYkxQMPKMSyn5jS1UkDMj+lz78xobfwRn0DICr6SfHsT2fMSgZyruy6kqFZrBLkT8VM1FNKE0aAnFKBIDeqp/KLmg4Hsk0rlz+c2+AiV8mIpMFLChj1GEi2UJOgVkkbpHTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759006; c=relaxed/simple;
	bh=KUm5xGir/0VpEIjIlG6g9LAW0Io9LcBFnf9ab+7HQgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TfFeV6KsOZWeewlFB0qpIrJifhAv5RHrTX79hb0bBVFGzixz471X74IPWXX99RWw890pTvtZKfV2BVoLxNbOwAFVwxMtjV5IDsN6eOEUe5/cdKzd0MN7L6/OqK2fVv3Q+ufIlkuWQl/50suYq/zNlkCA+RVcNLmuEt/TN7W9oZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=CbBsLxYG; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4632816290D;
	Tue, 15 Apr 2025 23:16:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.109.225.20])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D21901628D6;
	Tue, 15 Apr 2025 23:16:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759002; a=rsa-sha256;
	cv=none;
	b=XzgyKDs5lBmnDgzjKj2I0i95/idDLEBi4cyaK3/QsmeFN82w58mI4Ah3qIUblVFbcyL5R4
	jFdx/nrt/B6BbNTwTtf04ebnVehAPkxqFAy84z6EknHysqw0PV+EMvF6u7gsoJSIX1umau
	2Cn0j2vy5DiPY3GQfCN+TRNsRk2gXHiiVtKsrngfvI+XHbYTB2B+Y01rkL2RCrzij30ws0
	JGNU7riZvWZXeLH6IWKHLkDY7y19Mhxg71wdZ0tyBRdYgZDm0Z7xSNki0j9UGo30o7bav9
	+TuB9p7bGInOOahXziwNWYSHGcxNpQX2ggpeoBOx3EUFq3icc+VkXcFvrZRyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=XynydnE2Tq5LdLSDlwUgzvavdOLsZiKLpf6KVZXBWuc=;
	b=Tle0eZFZZf4hJBf2Jjsdkn/Ls9OxP3CzaPLm5V2W7g9NP2qT3R9HUTRwdf+SIzy9kTRIV2
	ZG1vJ98xOjgpqWR7tS6uihq7ltHECxNCvZEMrG4qdjDaoM5qiKSErfK4VI1vqsZ79sHOpE
	ebESxR53N3Ofrj/40MNgmCqyvtFjxvTHf+GjiCOlhlkMwrItPMn3h7Ss7HgJQQhq60dhoQ
	4HG/wSgB5S2lx+t2RApjqRKM8t2YDUTnDaXRK4mJVm5dzw2lr315wqHcjO63AI7gGhf1a7
	q4arECNAkUcVzpKtvRczpRpJvyZUL/o07usJUV6LyRdSxsZSybmp32XHV0D02g==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-l8v7l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Exultant: 470624bd04d610ae_1744759003143_2494839585
X-MC-Loop-Signature: 1744759003143:2629595215
X-MC-Ingress-Time: 1744759003143
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.225.20 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:43 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5j6Kvfz6g;
	Tue, 15 Apr 2025 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759002;
	bh=XynydnE2Tq5LdLSDlwUgzvavdOLsZiKLpf6KVZXBWuc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=CbBsLxYGVhToqyfMvcrlp50LpU9eCXN0HxfjEp+uirvvbQ3Dhx5M/Zz3jCLC8dA3s
	 2tQ6Ir+JLFVxmXQvTNG7wKCEnX/QHw9F9MirBuzfgaa+e6SBR0Zg1XXsBrNG8u+cpu
	 fOIjaKyKw6Y7nEsp59tOVY/oou2F4kA68Mw3W+V9v7s7h3rUoxfmRwOTgO6bEP8EKE
	 N7ySjMf6YQuHWJkgTitXt/lrb3NdVOrPpT0ZCksEz1IQ1JwQ/V1kB4XgpBZy/b2iLK
	 Y5fbC7c2+tShUqKILAlwfbuy1j+b9tlXDnNGK0WVBugburwaCpb5lQmr7DQc4GvE60
	 IrcQokPdWKmpQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -next 0/7] fs/buffer: split pagecache lookups into atomic or blocking
Date: Tue, 15 Apr 2025 16:16:28 -0700
Message-Id: <20250415231635.83960-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a respin of the series[0] to address the sleep in atomic scenarios for
noref migration with large folios, introduced in:

      3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")

The main difference is that it removes the first patch and moves the fix (reducing
the i_private_lock critical region in the migration path) to the final patch, which
also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
users will take the folio lock and hence wait for migration, and otherwise nonblocking
callers will bail the lookup if a noref migration is on-going. Blocking callers
will also benefit from potential performance gains by reducing contention on the
spinlock for bdev mappings.

It is noteworthy that this series is probably too big for Linus' tree, so there are
two options:

 1. Revert 3c20917120ce61, add this series + 3c20917120ce61 for next. Or,
 2. Cherry pick patch 7 as a fix for Linus' tree, and leave the rest for next.
    But that could break lookup callers that have been deemed unfit to bail.

Patch 1: carves a path for callers that can block to take the folio lock.
Patch 2: adds sleeping flavors to pagecache lookups, no users.
Patches 3-6: converts to the new call, where possible.
Patch 7: does the actual sleep in atomic fix.

Thanks!

[0] https://lore.kernel.org/all/20250410014945.2140781-1-mcgrof@kernel.org/

Davidlohr Bueso (7):
  fs/buffer: split locking for pagecache lookups
  fs/buffer: introduce sleeping flavors for pagecache lookups
  fs/buffer: use sleeping version of __find_get_block()
  fs/ocfs2: use sleeping version of __find_get_block()
  fs/jbd2: use sleeping version of __find_get_block()
  fs/ext4: use sleeping version of sb_find_get_block()
  mm/migrate: fix sleep in atomic for large folios and buffer heads

 fs/buffer.c                 | 73 +++++++++++++++++++++++++++----------
 fs/ext4/ialloc.c            |  3 +-
 fs/ext4/mballoc.c           |  3 +-
 fs/jbd2/revoke.c            | 15 +++++---
 fs/ocfs2/journal.c          |  2 +-
 include/linux/buffer_head.h |  9 +++++
 mm/migrate.c                |  8 ++--
 7 files changed, 82 insertions(+), 31 deletions(-)

--
2.39.5


