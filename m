Return-Path: <linux-fsdevel+bounces-850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5C7D1597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70641F2353A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347EB22301;
	Fri, 20 Oct 2023 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnELUURj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j7Kzw/sB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30C2032B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 18:19:22 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8D1A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 11:19:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDC8C2183B;
	Fri, 20 Oct 2023 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697825959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SQZJAtfC87KQBCCis3ZuPkYlJ0N4ARt9F2P/VMgScWg=;
	b=lnELUURj6kkBfJrOIf8gsigundi16NouRuPxEQjb11DjUZD90U7tchPUV3Xq5w9eoW+Gll
	n/OGOLrRYp5mJDmii5HvQzAh8vNVwlViI4XYJ2j6L4vGyz4y5ecHmN1j97/Db9q8oGQ4qZ
	zhCLDo73jArzLMI+TPg9J37sDOPSxbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697825959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SQZJAtfC87KQBCCis3ZuPkYlJ0N4ARt9F2P/VMgScWg=;
	b=j7Kzw/sBqbShLeSUTCNe/++u3Z3lWriHboBTpdP1MXs44UHJTU13fKxD7FDvI90JN15Xih
	18wcfP7u9v9w0HBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC52813584;
	Fri, 20 Oct 2023 18:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vUD4KafEMmVAOAAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 20 Oct 2023 18:19:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B742A06E3; Fri, 20 Oct 2023 20:19:19 +0200 (CEST)
Date: Fri, 20 Oct 2023 20:19:19 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fanotify fix for 6.6-rc7
Message-ID: <20231020181919.kavthbalswc7irnm@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.44
X-Spamd-Result: default: False [-6.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.84)[99.30%]

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.6-rc7

to get a fix for fanotify that disables superblock / mount marks for
filesystems that can encode file handles but not open them (currently only
overlayfs). It is not clear the functionality is useful in any way so let's
better disable it before someone comes up with some creative misuse. Patch
changelog has more details. 

Top of the tree is 97ac489775f2. The full shortlog is:

Amir Goldstein (1):
      fanotify: limit reporting of event with non-decodeable file handles

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

