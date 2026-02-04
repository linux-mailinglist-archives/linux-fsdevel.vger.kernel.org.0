Return-Path: <linux-fsdevel+bounces-76245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMP6DlHUgml5cQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:08:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7343E1AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 06:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6580305DEDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746A352F87;
	Wed,  4 Feb 2026 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CiEJ6Hua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgfRNb3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B734F27D;
	Wed,  4 Feb 2026 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181688; cv=none; b=CAIU4rDl4axAOlIVwqtBhxAJVbHRmjEsVPv6ah1jv8LxBlkXLaqcQjaCyq3ECgByoxL2JwGYRe+KsANfnWxc6Axiy9EPlauYFxljqC64umfeNBRUy6awOCKSn8hGxe8ib02I/bpLexCbcLz5KD/KjtTdgFn/OaCvBzYxi3AZjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181688; c=relaxed/simple;
	bh=dC323i3a5pzLmkG4eSohnUBpRgc+HMW7uI7HFtwc31Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tP5TdREN3KPScYzXW7dBou+cOTknhAbmMSSPpVY0YFYEQxL2wXq/pNAHRJaNa6vbvVq081Uq+DwX7uflLdW8pDWzkPUjMN9n3sM8+WSTLa6z9alzUiKccK+TZLI/3etTaxSTc+u59ZS9ocwbk+lVAhEmwVPCbGg3JxyGbYpn1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CiEJ6Hua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgfRNb3G; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 033571380778;
	Wed,  4 Feb 2026 00:08:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Feb 2026 00:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1770181686; x=1770188886; bh=XrOETrfLvn
	IX9izHaz3N3kjXjvH1wtHjpHJBz8OfYz8=; b=CiEJ6HuaYbyBncQK0Lqj0/lNF8
	DhAmxjQyJmxvozS5jXPzzY+XP7IqzDOshTUQIx5F8q3jdVkAJYIqxAnNmTKZc1Gc
	Rz6Gaz9g7gPNDWVQt/eBmoyqW1ED0k4S51L6PgC88F91vhkAkANrbidvxi4Ft6kn
	Z2QnDJeyZyYC7DOrS8xQ4bely67rhZsZ1nPcgZbLnLAfZTV0geZRruUBh41QxYNj
	RMHAnpZjEY2jeseKrnxpnBqyZa169DbRKrWWyH1qV5TRi5qaQv0Q/gzB/4Frw3Sj
	gqXeBzBZPeZAkYNF4LZQWDkWzdvk596wFMvuBn/FtrqS50DqnP9FXdCRp3DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770181686; x=1770188886; bh=XrOETrfLvnIX9izHaz3N3kjXjvH1
	wtHjpHJBz8OfYz8=; b=pgfRNb3GFaNvHPggUPmqU3BzhV1DYsxFsfCeubzJ34Z2
	IAXUcDPPY6B4jFTc/sHFd+FFVWOCN61ZY1n4FSp/lZ/Gm8OL3IoxKdmtGG4mwtRB
	0cvuLMaVwfbCkuk6RJ2Z63jD94vV4qNep/luiPmUR+3LvEv6P8s37xlYrISuSGuK
	wEYDRQ498aJsPgxTcI5zvZ6ka/ASQo1kuhn1czQJTHfYm1VOYKS8UMSqyacqcxV7
	WNLo000OpWyqHhPs34vOA0xlHoFgXDDUMaUZybJyVpOdqP0l7sYl91BeFNKbwqHN
	X25D7DUOSE4gBsH5flU2yCWtokXqSMsawaOX095y/A==
X-ME-Sender: <xms:NdSCacyHAcWi0GB6-jJHZwbkg7Gp-Z8lim-4rJwYDEn4tUsEpVVp5A>
    <xme:NdSCaUi2sidAli4k4HESJm4YuHT-yfhGDUFNfA9wk6-Xew_E4Id6MUquzyDqQgKWj
    6oVs_Or_AOLCF3MayEIM7vc75zzFysDBEkNd25_ItQdv_Uc0w>
X-ME-Received: <xmr:NdSCaR5AjfPMw9UHtqMCUY3gZiF0HwOinEkXMxQrj_q1sM-SP-zb0drYuARdpjKpES6FgKhhf7urx73AS9dGuMBwFTAN-m-EErtLCvsusGkf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghp
    thhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:NdSCaZpRkxJWPNmIpcpGeNAy50vMwvTXVXySj4QxXdsBDVBq8ly_5w>
    <xmx:NdSCaXXqpBY4J628Zt1MD0CWCDQFIjb_nD-zpyZCDCVuAS2xOS78Aw>
    <xmx:NdSCaQ5LAQWkq85YI4N5auTuRMssrLuYMh8Grxsq06CB1xQnOGG43A>
    <xmx:NdSCaV3QDW52SEeAdjmfBcdJhYLQR-XjBl5pKwa3C3AKajI2bStWiA>
    <xmx:NtSCaTz-dtrlfjILOYM9GTMXnZa_VQglEYUC71RT6cu45HHOJ53g7HKW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 00:08:00 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 00/13] Further centralising of directory locking for name ops.
Date: Wed,  4 Feb 2026 15:57:44 +1100
Message-ID: <20260204050726.177283-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-76245-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,ownmail.net:mid,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: C7343E1AF3
X-Rspamd-Action: no action

I am working towards changing the locking rules for name-operations: locking
the name rather than the whole directory.

The current part of this process is centralising all the locking so that
it can be changed in one place.

Recently "start_creating", "start_removing", "start_renaming" and related
interaces were added which combine the locking and the lookup.  At that time
many callers were changed to use the new interfaces.  However there are still
an assortment of places out side of fs/namei.c where the directory is locked
explictly, whether with inode_lock() or lock_rename() or similar.  These were
missed in the first pass for an assortment of uninteresting reasons.

This series addresses the remaining places where explicit locking is
used, and changes them to use the new interfaces, or otherwise removes
the explicit locking.

The biggest changes are in overlayfs.  The other changes are quite
simple, though maybe the cachefiles changes is the least simple of those.

I'm running the --overlay tests in xfstests and nothing has popped yet.
I'll continue with this and run some NFS tests too.

Thanks for your review of these patches!

NeilBrown


 [PATCH 01/13] fs/proc: Don't lock root inode when creating "self" and
 [PATCH 02/13] VFS: move the start_dirop() kerndoc comment to before
 [PATCH 03/13] libfs: change simple_done_creating() to use
 [PATCH 04/13] Apparmor: Use simple_start_creating() /
 [PATCH 05/13] selinux: Use simple_start_creating() /
 [PATCH 06/13] nfsd: switch purge_old() to use start_removing_noperm()
 [PATCH 07/13] VFS: make lookup_one_qstr_excl() static.
 [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
 [PATCH 09/13] cachefiles: change cachefiles_bury_object to use
 [PATCH 10/13] ovl: change ovl_create_real() to get a new lock when
 [PATCH 11/13] ovl: use is_subdir() for testing if one thing is a
 [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
 [PATCH 13/13] VFS: unexport lock_rename(), lock_rename_child(),

