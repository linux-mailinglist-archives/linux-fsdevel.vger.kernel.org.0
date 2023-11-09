Return-Path: <linux-fsdevel+bounces-2664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419407E7486
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 23:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2882B21010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466F38DC7;
	Thu,  9 Nov 2023 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="jzPgAP7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4725374D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:47:05 +0000 (UTC)
Received: from butterfly.pear.relay.mailchannels.net (butterfly.pear.relay.mailchannels.net [23.83.216.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4CE4206
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:47:05 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 15555500A98
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:38:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C4F0D500803
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:38:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699569483; a=rsa-sha256;
	cv=none;
	b=rJAEcgT6rEWj31KtNo3JlOleC4QTsJkssem8NKam9KEk0q1abfuPK7szepks8HgD0Tu8o3
	WJAkGDi/CULeYagF9f1h9QaCZAsRMSEV4IHbPTI3Tdu8bM/pufURi5xr/Y1NRhR1iMyNb3
	IJ1AkxeGru8JjD3laBulI/xWTipvzoBwmTHj40CK99RPiTHiuqUswZBlKgmPsMR3sSTlcO
	yYK6kzDeN1zyudFiHcUcDRsVb4PbIRPo4SnxUgy9VSgs92r0xCE6c2/pZ3BdoDAuIXVPHb
	6I4vK55y51mRjCWyY7PnoNloWYeeiTvjVp4lre1PlN7x48hAgUImOFXs+7t+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1699569483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8FdBTqj7EnOPCatPq6Ewwon91Yw3IOaAcb1fC3zTNWc=;
	b=dT43mdYlA08dv8vbA5+yN5SnMZooDaZmCc7Kj/iLTYCTjw7V/3xWjxqnb/2CxN3tbaktJU
	DQEBsWCQ6nXHt326BkoWe1DDfpwHNFSAb58AoYHFbmAcUGxW7ngxLLF2lZrccCMCn8FYMa
	wwuRAnCNIJWlD5Am5aUh9P4pvNFPSQKjJiDhhdlDNwifx1fHcbR9Q1YByhGNh95ctu6K2z
	udQBwoj91oDsoYGaZeTX1gqOku/Gq+JtcK6HYuKk+oMCzsHdKvV4K7dHPtg24Wj/qydDDT
	DukPN/AdX3wp75L+5Iie0NGYrVd22GAXiTVyjefrjx+ZUU8YE+jDAdzNJtgOBg==
ARC-Authentication-Results: i=1;
	rspamd-6f98f74948-x6h89;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Interest: 7744d43e4fae0da8_1699569483918_1346114827
X-MC-Loop-Signature: 1699569483918:1245935214
X-MC-Ingress-Time: 1699569483917
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.137.45 (trex/6.9.2);
	Thu, 09 Nov 2023 22:38:03 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4SRH0W1WQxz11v
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1699569483;
	bh=8FdBTqj7EnOPCatPq6Ewwon91Yw3IOaAcb1fC3zTNWc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jzPgAP7uZ6rT3mB5778Ifk3l3q2mOMiYDkuhop9ZKq+5ttWMlmoNDQ8EHme+aRYKD
	 CKYw/PGY2R/JRoSsw8BcPWrEHhtq15gAN8ef5lPkynJM33OiiIKyD75hZH9ZLOvYNb
	 QM5SIlEFURBw9NOa5W3yRHj9XE3GSfVHdE4vlQrOijeKEF2C1EsxF9AGZclfjr3qZV
	 hhdyFKp2HkQwlJ7Y0/lGMGW4p5aQb01Cvv/5SYK4cZcjErbrcyDNHL5p7EE7uC6RLG
	 xN1D1Wkaze8YkLJHZeFh193QhX1HHG5Q0viRff8kKl7RVGoDca1WhtK6uUphAR3YOu
	 lvM6maUVzg3ng==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0044
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 09 Nov 2023 14:37:28 -0800
Date: Thu, 9 Nov 2023 14:37:28 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>, Greg Kurz <groug@kaod.org>,
	Max Reitz <mreitz@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
	regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] fuse: ensure submount_lookup is initialized on alloc
Message-ID: <d80c0df75fc601ffd3f957084574f10abaf3bedc.1699564053.git.kjlx@templeofstupid.com>
References: <cover.1699564053.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699564053.git.kjlx@templeofstupid.com>

When introduced, the submount lookup reference tracking neglected to set
an initial value in the fuse inode as part of fuse_inode_alloc.  Users
running with SLUB_DEBUG enabled caught and reported this error.  Fix by
ensuring that this value is always initialized to NULL.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 513dfacefd71 ("fuse: share lookup state between submount and its parent")
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 243bda3cfdf6..d7ebc322e55b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -103,6 +103,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
+	fi->submount_lookup = NULL;
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget)
 		goto out_free;
-- 
2.25.1


