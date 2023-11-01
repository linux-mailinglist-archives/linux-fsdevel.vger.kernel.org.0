Return-Path: <linux-fsdevel+bounces-1717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36F7DDF8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17A82814DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD87462;
	Wed,  1 Nov 2023 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Gt7HWqQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DSZJV0NH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397815C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:36:24 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6428FDA
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:36:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D6C11F74A;
	Wed,  1 Nov 2023 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698834979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5MJwwHbUG5J3v/reEJasPS2KH/yR9UZ9U5Evi3BMfoo=;
	b=2Gt7HWqQL0a4Y7393s3t6uu3k9xh76aIb07INEj7vbsiHD75RIphEsGKZ+WBZuyB17FvRL
	PuPDyzmnuV1nEIYKq5sdDoh8MkkwdEDrzmQyUcSruQcUF+k2ObkmeATac5TfqEe3KMF9OY
	9p6Mie63aGGCJmSlwuuYcw+Rw4hA0w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698834979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=5MJwwHbUG5J3v/reEJasPS2KH/yR9UZ9U5Evi3BMfoo=;
	b=DSZJV0NHZJFrv7BmsdrgnkWBRuL0SKtk1eKpYwyK7h9rpRVmKnO1kiD6kT6m8C8iUxQfjn
	upYFwgBDciojfyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3D551348D;
	Wed,  1 Nov 2023 10:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id alyAOyIqQmVcJAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 01 Nov 2023 10:36:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80BC1A06E3; Wed,  1 Nov 2023 11:36:18 +0100 (CET)
Date: Wed, 1 Nov 2023 11:36:18 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, udf, and quota changes for 6.7-rc1
Message-ID: <20231101103618.blacru23bck2xfe7@quack3>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.7-rc1

The pull contains:
	* conversion of ext2 directory code to use folios
	* cleanups in UDF declarations
	* bugfix for quota interaction with file encryption

Top of the tree is 82dd620653b3. The full shortlog is:

Eric Biggers (1):
      quota: explicitly forbid quota files from being encrypted

Jan Kara (1):
      udf: Avoid unneeded variable length array in struct fileIdentDesc

Kees Cook (1):
      udf: Annotate struct udf_bitmap with __counted_by

Matthew Wilcox (Oracle) (10):
      highmem: Add folio_release_kmap()
      ext2: Convert ext2_check_page to ext2_check_folio
      ext2: Add ext2_get_folio()
      ext2: Convert ext2_readdir to use a folio
      ext2: Convert ext2_add_link() to use a folio
      ext2: Convert ext2_empty_dir() to use a folio
      ext2: Convert ext2_delete_entry() to use folios
      ext2: Convert ext2_unlink() and ext2_rename() to use folios
      ext2: Convert ext2_make_empty() to use a folio
      ext2: Convert ext2_prepare_chunk and ext2_commit_chunk to folios

The diffstat is

 fs/ext2/dir.c           | 214 ++++++++++++++++++++++++------------------------
 fs/ext2/ext2.h          |  23 ++----
 fs/ext2/namei.c         |  32 ++++----
 fs/quota/dquot.c        |  14 ++++
 fs/udf/ecma_167.h       |   2 +-
 fs/udf/udf_sb.h         |   2 +-
 include/linux/highmem.h |  18 +++-
 7 files changed, 164 insertions(+), 141 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

