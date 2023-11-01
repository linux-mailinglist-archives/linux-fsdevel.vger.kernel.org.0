Return-Path: <linux-fsdevel+bounces-1716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E937DDF76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8FAB20E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467141096C;
	Wed,  1 Nov 2023 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cy/3uez9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NHnf2lA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90779E6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:31:58 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B09103
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:31:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67FF11F74A;
	Wed,  1 Nov 2023 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698834711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=WRnl1UIpcSHorZEpJboU9fjXjyqAqmRIF4Qm8fFRtfM=;
	b=cy/3uez9dzx6Kmr+HfUkx9usUkUWmtvI3+jQL1BOxDWFcfYZhRa5jV569q/1VC78z3bzvl
	EFXUA/ECLyrc1WoT1Xjt5ydKLQB2USfnG0wTOpVd2P9DBPAt98CEQk9g+rhFSAD0ZtClgy
	0CGC2Pl6JdqxthvX4Gs8pKGnEUWdAdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698834711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=WRnl1UIpcSHorZEpJboU9fjXjyqAqmRIF4Qm8fFRtfM=;
	b=NHnf2lA1txqWxzTCryttq2sAA9mOo6kQgFpdu4ZbwRReeEnOaYBXADGi/hZmPK/gyj4EMH
	4rnuqxbmTpfjw3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A98E1348D;
	Wed,  1 Nov 2023 10:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1Y0bFhcpQmWWIgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 10:31:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDF60A06E3; Wed,  1 Nov 2023 11:31:50 +0100 (CET)
Date: Wed, 1 Nov 2023 11:31:50 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 6.7-rc1
Message-ID: <20231101103150.xa6ghs54s6fz4q7g@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.7-rc1

This time just one tiny cleanup for fsnotify.

Top of the tree is 1758cd2e95d3. The full shortlog is:

Alexey Dobriyan (1):
      fanotify: delete useless parenthesis in FANOTIFY_INLINE_FH macro

The diffstat is

 fs/notify/fanotify/fanotify.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

