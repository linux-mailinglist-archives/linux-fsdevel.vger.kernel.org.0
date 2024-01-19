Return-Path: <linux-fsdevel+bounces-8342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC050832FBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCBC28499C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC456B7B;
	Fri, 19 Jan 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xEV3nzmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7yV7JEs9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xEV3nzmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7yV7JEs9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512341C98
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695964; cv=none; b=nD9ANsI1FGmcy+v4s7ngFNEbrGhKR3a7BAhH31uqdd6aK/jK5eh+cdlZBH2LdXXxD/HTw76uRg0MuuWCoyuwHbC9oFpAEV+ToCTzhAX0QLPhUAfeHlvUuXaEC9H+ASV6n/eoqEgsy02+/G+gmCQum0kovpsnUIBX3cUx2BZ5C0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695964; c=relaxed/simple;
	bh=8729KaF8lic5I8uIbskO0AP/o0A9IgjqvOMS2hCtY/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJDn2vKystb/8zCraVtdERFXtVi1P6zZP2QHx5JgfHRr/5GRCCH7HOQd6p7sfMU5kK+uGU7QPlT6QFQRPtupODPyu0PuAu5kdzd5uFOJp8uP0eP8sc3EFttXVVnzFcdNiYeGTFWv19Ojc6g2UxXwmF5mCbCbi3dCGebxxLtaM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xEV3nzmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7yV7JEs9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xEV3nzmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7yV7JEs9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3D2221CD1;
	Fri, 19 Jan 2024 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705695950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OrJDAQiLNTkCMDxWISKfnPTZKagfYJo3bgpzRqerjOQ=;
	b=xEV3nzmU5wh5eBp/u8TZf06t6AZ84GNDe5D6+F3nJTAyvCJS3p+sqMCumr7RzS1IeQ2aYg
	q/B3rC7YwA+n89n+Ax5M9GMfkm/xzT0eI/xwGHz3wSSVgrbf/vB1kAUR9MxUYjBt4ihYQT
	f0w2NEAO+usm73pGtZl6qaOlIRWeJo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705695950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OrJDAQiLNTkCMDxWISKfnPTZKagfYJo3bgpzRqerjOQ=;
	b=7yV7JEs9Zx8SwEiXiSwWQBuOagoObSwjwVymPaUe9xr2diTPThFUpBZpiLc/CeFVb+HqBF
	HtGNHUXGE33FV+CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705695950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OrJDAQiLNTkCMDxWISKfnPTZKagfYJo3bgpzRqerjOQ=;
	b=xEV3nzmU5wh5eBp/u8TZf06t6AZ84GNDe5D6+F3nJTAyvCJS3p+sqMCumr7RzS1IeQ2aYg
	q/B3rC7YwA+n89n+Ax5M9GMfkm/xzT0eI/xwGHz3wSSVgrbf/vB1kAUR9MxUYjBt4ihYQT
	f0w2NEAO+usm73pGtZl6qaOlIRWeJo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705695950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OrJDAQiLNTkCMDxWISKfnPTZKagfYJo3bgpzRqerjOQ=;
	b=7yV7JEs9Zx8SwEiXiSwWQBuOagoObSwjwVymPaUe9xr2diTPThFUpBZpiLc/CeFVb+HqBF
	HtGNHUXGE33FV+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55029136F5;
	Fri, 19 Jan 2024 20:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t4glBs3aqmXnJQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 20:25:49 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	torvalds@linux-foundation.org
Cc: tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 0/2] Try exact-match comparison ahead of case-insensitive match
Date: Fri, 19 Jan 2024 17:25:41 -0300
Message-ID: <20240119202544.19434-1-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.78%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Linus, Al, Eric,

This small series implement the exact-match comparison ahead of the
case-insensitive comparison as suggested by Linus.  The first patch only
exposes dentry_string_cmp in a header file so we can use it instead of
memcmp and the second actually do the optimization in the
case-insensitive comparison code.

Gabriel Krisman Bertazi (2):
  dcache: Expose dentry_string_cmp outside of dcache
  libfs: Attempt exact-match comparison first during casefold lookup

 fs/dcache.c            | 53 ------------------------------------------
 fs/libfs.c             | 39 +++++++++++++++++--------------
 include/linux/dcache.h | 53 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 70 deletions(-)

-- 
2.43.0


