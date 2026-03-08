Return-Path: <linux-fsdevel+bounces-79723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN0zKv3irWks8wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 21:58:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9912323EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 21:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D63FA301F30A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08679356A1C;
	Sun,  8 Mar 2026 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Nyy1fGep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHGSibMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA22DC76A;
	Sun,  8 Mar 2026 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003493; cv=none; b=B297i3ac83a5LtfAnTu3QFoAx73NrDezv0WPCCdQDnNvZRRpKusj/PbsUypdprXyGYdwpq1rPQn+2EJM0tVq6GE6s+JcLapx1t7ZGNqeZFNMtElaPXZ/ZoTgvoQjgDVX3O1H5lFmDvTHelvofJDHjyWz5aHhtUmAYkiNOywHR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003493; c=relaxed/simple;
	bh=YvwnwHgyC3oEQa0I1j525crmDtzyCfGyFwtXdz585BU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JGIWJJs+q6wT81end9ZjfD6AqjuQ9n0tTyTG0nSJUtrnZ5xYp3HPxcYa5qYbDfuAo1+c067qa6AH9vbBSM1vfagItGITJjlWtnMdCZMnFx3vt09TEHahhYTFXJFZ17emeQj8GRz7WcMpAUa3YvQoL73sV65tfvajw6D2LRhFrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Nyy1fGep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GHGSibMw; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id E5D3B13808ED;
	Sun,  8 Mar 2026 16:58:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 08 Mar 2026 16:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1773003489; x=1773010689; bh=+iypvS0zaTSKL0sJFSGnV+90rJ7NwnakODh
	88UBVbxc=; b=Nyy1fGep1NAOdoC4ys0fihQQOAa4IL42zfq0IvtSw9HwYJLZAur
	Ps92XTBfup1MiJY2jk4/AQz2th5KZLEBqfMaYNhvwb99g0LBwKnM8xUEEKXdgKTn
	iEZgi2XRPUc5mOsju+U1SsZ0XuTk97e1G+TvaUs0UgEWuCEpGvKxHub7Fr8NzePQ
	F6jc70Xi+GLzG48D6AKuJRyzr/qNVEz6PSACk6zG7NyURmA+z9W+GYGQUz9Sequ0
	MDP8DWX9s7NcXZnQ17acBLw3uNCm42d4dV4qgFTfdT/1lWc1ZOIsJxzbxZXjIvWM
	uVaaeebTvdn1kw4vaeRvQyoQY4+vkAqWiiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773003489; x=
	1773010689; bh=+iypvS0zaTSKL0sJFSGnV+90rJ7NwnakODh88UBVbxc=; b=G
	HGSibMweZXfcFPVEa8qTAg1920mH8b3M5plTJQ4y5f96lM0ypf27HM4c/UAySBmm
	DZNhGy5ImsPGICRiTdhRP+TGXvBFmWPZY17dh7fXetsdhXCks4IMB/rP6iNp1iaU
	LK91YfzxM0GOGNH9+s3glVWI7DpuSJrqrRuxGMPR04EVCO/4tRv4OyVYYCSthsLo
	hVCdX/pAxOcMFN6CQkYecarwAp2sSGJQEDC2Nu+eqjJ5ZgA6455m7flLIqp54XFo
	jil7fvItfzmz1OnLWw0UW+svzSwXlPLSAQBfEev4w8rFBaDivkzKy7ULy0nxmm+M
	KgkBFxXdL2RO4I2Y5xVNQ==
X-ME-Sender: <xms:3-KtaSVctBSQ0SV_4hXsjWRkglm51vBgsco7eLnJzRkXOELG71FzoQ>
    <xme:3-KtaSjB2rGOr7OFkyfnq7Dp2t1nYH99sV9ZG2WLPsYFsLSdpnH6BKGWxcSwcl7o1
    oNTwtE7rLcKtqp-tzupFwXpCKt77cRv4Z4yxSfn4e5V4MeQvxs>
X-ME-Received: <xmr:3-Ktae5tS02XwBv-i39mfEyQVpaoQ-u3VFqQO8y4dRUul7KOwa5yqttp3ypt5BxZU3mf45hpnrzPGzLEU1_5oKoiZkHPceyr5LfUBLIaf1ix>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epffetfedvgeevjeelhffhkefgffejvddtvefftdegueeiveffjeeukeffkeefkefhnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehsvghlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtii
X-ME-Proxy: <xmx:3-KtaS6zJduiAbAHq99KcsXa77lpCopPadKmwp3x8ZIfGmkzNTCohA>
    <xmx:3-KtaUHxOA8u3U6E4eLAbRpC0yb57cCfAxRA4ha_pVtvmLiUgg9e7w>
    <xmx:3-KtaYwwNGnKGgahf3vu9ylTclTI_dSyC-frB-eGtBIC_WzxhkiWWA>
    <xmx:3-Ktac2Z1yfOcKeBZZnd8l7Su01udxDrDDt7_G5Nnt_T2jF2UNTW8g>
    <xmx:4eKtaa8I7VALp6o1nHvBb2BSlMCJyvLkZlfOMwwpOLNHk0sla81lLmFr>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 16:58:01 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Subject: [PATCH] FIXUP: cachefiles: change cachefiles_bury_object to use
 start_renaming_dentry()
In-reply-to: <20260306-stolz-verzichten-2ee626da4503@brauner>
References: <20260224222542.3458677-1-neilb@ownmail.net>,
 <20260224222542.3458677-11-neilb@ownmail.net>,
 <20260306-stolz-verzichten-2ee626da4503@brauner>
Date: Mon, 09 Mar 2026 07:57:58 +1100
Message-id: <177300347820.5556.314358492166337403@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 1B9912323EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79723-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,kernel.org,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,ownmail.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,noble.neil.brown.name:mid]
X-Rspamd-Action: no action


From: NeilBrown <neil@brown.name>

[[This fixup for f242581e611e in vfs/vfs-7.1.directory provides a new
commit description has preserves the error returns and log message, and
importantly calls cachefiles_io_error() in exactly the same
circumstances as the original - thanks]]

Rather then using lock_rename() and lookup_one() etc we can use
the new start_renaming_dentry().  This is part of centralising dir
locking and lookup so that locking rules can be changed.

Some error conditions are checked in start_renaming_dentry() but need to
be re-checked when an error is reported to ensure correct handling.
The check that ->graveyard is still d_can_lookup() is dropped as this
was checked when ->graveyard was assigned, and it cannot be changed.

Signed-off-by: NeilBrown <neil@brown.name>
Link: https://patch.msgid.link/20260224222542.3458677-11-neilb@ownmail.net
---
 fs/cachefiles/namei.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 3af42ec78411..c464c72a51cb 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -309,7 +309,26 @@ int cachefiles_bury_object(struct cachefiles_cache *cach=
e,
 	rd.flags =3D 0;
 	ret =3D start_renaming_dentry(&rd, 0, rep, &QSTR(nbuffer));
 	if (ret) {
-		cachefiles_io_error(cache, "Cannot lock/lookup in graveyard");
+		/* Some errors aren't fatal */
+		if (ret =3D=3D -EXDEV)
+			/* double-lock failed */
+			return ret;
+		if (d_unhashed(rep) || rep->d_parent !=3D dir || IS_DEADDIR(d_inode(rep)))=
 {
+			/* the entry was probably culled when we dropped the parent dir
+			 * lock */
+			_leave(" =3D 0 [culled?]");
+			return 0;
+		}
+		if (ret =3D=3D -EINVAL || ret =3D=3D -ENOTEMPTY) {
+			cachefiles_io_error(cache, "May not make directory loop");
+			return -EIO;
+		}
+		if (ret =3D=3D -ENOMEM) {
+			_leave(" =3D -ENOMEM");
+			return -ENOMEM;
+		}
+
+		cachefiles_io_error(cache, "Lookup error %d", ret);
 		return -EIO;
 	}
=20
--=20
2.50.0.107.gf914562f5916.dirty


