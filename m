Return-Path: <linux-fsdevel+bounces-78317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCIcGK8lnmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:26:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F218D273
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 569E6309C285
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28823451B5;
	Tue, 24 Feb 2026 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SASpB0jn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkUvYZy2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215B33A9C4;
	Tue, 24 Feb 2026 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971968; cv=none; b=GrKhi4G6S1TsEDEcY4eheqOBVYxDi3EmI6VJpw1apCbbhLWWmb3+t9jX4sUYkekyskVQCzyxC0DPwbHQQ7ykrn15aDfO7WxdNiimOJA5vZ0aVilbUuGl9P0ybkxlH2pM5mKzVNd9KdAeWbFZw1Jo+XOh1qLOBIvFDxpo95s95Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971968; c=relaxed/simple;
	bh=8pfwM/oiJ7V1Xu1rcLqhbbFwuMvNN87UDEvkhe3kSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BT+7BYWB1lmhs2wbKEc+3ycHPgUlFQMedaYgxlmcW8OAdKItcxKzmRtU6FYlkBitk8rTwytx4pv335pdu3XQySK3L4toZH3GqE9fnFnA1pwKxnqdF14ut21EqYDWX/BrVdBo7FrnoSalcjof88PAzSwYyqm7CzOD02TSVGixjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SASpB0jn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkUvYZy2; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 645B9138052C;
	Tue, 24 Feb 2026 17:26:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1771971966;
	 x=1771979166; bh=bc9azlh/VG6ae6PkDsWsI4XhYvmFw1STenuoUYZ/MBs=; b=
	SASpB0jnygHPumGAlWS91bgfQg5zVUOVMHKOq00zAYqspcXFZUx++8j5Hyoq/V9Q
	WNdWgMStsw9ANiYmzA7M3hNAS3fajikRG71Ds+45ffN+sPaj4NcnlwGzxEt10udz
	ns2nO1tlPzw4vFYEmZGJjelVSMf/Brv43bJZ/BxF2YzDBbfs9Wt7Z9rcraW4UaKU
	waRkVw8ZqH9j4XRXgPW+T/Xrw0kNsC1HgwMzato61qaky2k7CGGtgZIgZRiRZOmL
	b5geKeh9nRq1D94XwELilFtZKQtbPcv/VjmRR1ao3z+MUB/HjdO7mYBLgroHWNvI
	bHL1JyrEHpW5QIqszOvl+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771971966; x=1771979166; bh=b
	c9azlh/VG6ae6PkDsWsI4XhYvmFw1STenuoUYZ/MBs=; b=HkUvYZy25Jt1baGUe
	y+N7jaWMDyzl16a97dbnGlyoya0pq0RMyJWNFHRfeyGiahB1YCSgP2dZqyPBXnrj
	//JjdCMdIc1Gc80UI5/smG0EfUrXqxRxeIiGbpmdrQQu8kRhuf9vPWv5z47MKYf+
	GBfMklXEPmTX9loCgJ9bLF4te9SL+L93IgIRkLPh4SoNrU2zkEX88jRLrOxTKGzf
	xl+01llOci5Br22sgxJUNpKZmsjd+Lcvu0f8qiOR2opMbJ/6nJMaKdYlVvgb3XVP
	MOTvzrs2DuS4LMiIYDmhIzBLDaOJCeVP5eJlfsqvs6GW9OzNYa1/Ye2qBq3UqI1B
	YXCjg==
X-ME-Sender: <xms:fiWeaVvsfF-xHqqo3ZT9m5ybwhqP8j8L2nLlKeGn9OVurzfPnnjbKQ>
    <xme:fiWeaSasmIAJNymyu2js4bZRukDYsbTv_SxaEfJ4qNFj0MSRrkAwsWWOeDtvj0IJO
    FlmfN4VtolELg8PmO_xvp1_-L04of8NUDTOo5m8HPX3UIfI1Q>
X-ME-Received: <xmr:fiWeaRSwcNulcCAF78z6aWWOuEwDP_37RjeQnUtrHjQsVHTxcdkHc13qUAlT9BDfkGrGnUWyKPH4F9gJZrjIyqRNZda5mtenH7SE1Pvz3oS3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfevjeduvdeufeeileefteegudetheetffdtjeegvdfgtdetjeeihfeigeffffehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
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
X-ME-Proxy: <xmx:fiWeaVwBeclayjunEON81xneBywxAcijxwNWzT2nxJm7prXC2je-Rg>
    <xmx:fiWeadeOVle6LoJcuB7GYIr4sdGubHipyUId2sGFvNtxwKy9baCr8g>
    <xmx:fiWeaWoNrRPg_DhKUrc0fjTq4SosmgdvMP3hyHG2HbbDhD8IyJBksg>
    <xmx:fiWeaVMYZXTSPlErtC7h9Ng2j8FrxFSq2lPawevy4o_1KQOshdEd-Q>
    <xmx:fiWeaX1Y6CT_dtMx4OtF1zm23cMrJswGeEQYFIrkC1o5joZJvixR0F9o>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:26:00 -0500 (EST)
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
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v3 01/15] VFS: note error returns in documentation for various lookup functions
Date: Wed, 25 Feb 2026 09:16:46 +1100
Message-ID: <20260224222542.3458677-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260224222542.3458677-1-neilb@ownmail.net>
References: <20260224222542.3458677-1-neilb@ownmail.net>
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
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-78317-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim]
X-Rspamd-Queue-Id: CB9F218D273
X-Rspamd-Action: no action

From: NeilBrown <neil@brown.name>

Darrick recently noted that try_lookup_noperm() is documented as
"Look up a dentry by name in the dcache, returning NULL if it does not
currently exist." but it can in fact return an error.

So update the documentation for that and related functions.

Link: https://lore.kernel.org/all/20260218234917.GA6490@frogsfrogsfrogs/
Cc: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..6f595f58acfe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3124,7 +3124,8 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  * @base:	base directory to lookup from
  *
  * Look up a dentry by name in the dcache, returning NULL if it does not
- * currently exist.  The function does not try to create a dentry and if one
+ * currently exist or an error if there is a problem with the name.
+ * The function does not try to create a dentry and if one
  * is found it doesn't try to revalidate it.
  *
  * Note that this routine is purely a helper for filesystem usage and should
@@ -3132,6 +3133,11 @@ static int lookup_one_common(struct mnt_idmap *idmap,
  *
  * No locks need be held - only a counted reference to @base is needed.
  *
+ * Returns:
+ *   - ref-counted dentry on success, or
+ *   - %NULL if name could not be found, or
+ *   - ERR_PTR(-EACCES) if name is dot or dotdot or contains a slash or nul, or
+ *   - ERR_PTR() if fs provide ->d_hash, and this returned an error.
  */
 struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
 {
@@ -3208,6 +3214,11 @@ EXPORT_SYMBOL(lookup_one);
  *
  * Unlike lookup_one, it should be called without the parent
  * i_rwsem held, and will take the i_rwsem itself if necessary.
+ *
+ * Returns: - A dentry, possibly negative, or
+ *	    - same errors as try_lookup_noperm() or
+ *	    - ERR_PTR(-ENOENT) if parent has been removed, or
+ *	    - ERR_PTR(-EACCES) if parent directory is not searchable.
  */
 struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap, struct qstr *name,
 				   struct dentry *base)
@@ -3244,6 +3255,10 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * It should be called without the parent i_rwsem held, and will take
  * the i_rwsem itself if necessary.  If a fatal signal is pending or
  * delivered, it will return %-EINTR if the lock is needed.
+ *
+ * Returns: A dentry, possibly negative, or
+ *	   - same errors as lookup_one_unlocked() or
+ *	   - ERR_PTR(-EINTR) if a fatal signal is pending.
  */
 struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 					    struct qstr *name,
@@ -3283,6 +3298,10 @@ EXPORT_SYMBOL(lookup_one_positive_killable);
  * This can be used for in-kernel filesystem clients such as file servers.
  *
  * The helper should be called without i_rwsem held.
+ *
+ * Returns: A positive dentry, or
+ *	   - ERR_PTR(-ENOENT) if the name could not be found, or
+ *	   - same errors as lookup_one_unlocked().
  */
 struct dentry *lookup_one_positive_unlocked(struct mnt_idmap *idmap,
 					    struct qstr *name,
@@ -3311,6 +3330,10 @@ EXPORT_SYMBOL(lookup_one_positive_unlocked);
  *
  * Unlike try_lookup_noperm() it *does* revalidate the dentry if it already
  * existed.
+ *
+ * Returns: A dentry, possibly negative, or
+ *	   - ERR_PTR(-ENOENT) if parent has been removed, or
+ *	   - same errors as try_lookup_noperm()
  */
 struct dentry *lookup_noperm_unlocked(struct qstr *name, struct dentry *base)
 {
@@ -3335,6 +3358,10 @@ EXPORT_SYMBOL(lookup_noperm_unlocked);
  * _can_ become positive at any time, so callers of lookup_noperm_unlocked()
  * need to be very careful; pinned positives have ->d_inode stable, so
  * this one avoids such problems.
+ *
+ * Returns: A positive dentry, or
+ *	   - ERR_PTR(-ENOENT) if name cannot be found or parent has been removed, or
+ *	   - same errors as try_lookup_noperm()
  */
 struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 					       struct dentry *base)
-- 
2.50.0.107.gf914562f5916.dirty


