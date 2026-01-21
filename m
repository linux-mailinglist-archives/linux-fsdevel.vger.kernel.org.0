Return-Path: <linux-fsdevel+bounces-74881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMB7IHImcWl8eQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:18:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F235BF87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9827584BDB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C3A3C1FEF;
	Wed, 21 Jan 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aI19GJ3H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pAh3Sb8I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vbuj+ygm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q5V04+M/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692732F77B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016477; cv=none; b=kDNW4scicKbQkIt2XWwCY0YDGRvNsljxLvuSWIP9BXTt4Fe25oMNG9vdY879aG11qJJniE9agSuYBSg1BS00cQ2Jbc+4+4VGdnr3AOQAynI5kxJYiq03ITOqux2mMEjjzGVQoyGqEO3kJuhFkqE7psIf6CizvvouVJrSntXeDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016477; c=relaxed/simple;
	bh=9brRciqO7AZGSJjHiTuC/KG7Oa0VQpLP0+AuKFzuW+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9VrY0NLbJ9UgEYshHHkV7HAy79l9T8qY4gV3Pl0FHuS81lD7NhEr6uUcogMw9sy24N7Ya5GtmSLPUYwiolDZHy3ybRyy9peqrOL1TCjfREiUvja9hIBXlSUdDjzy8eBSvijjjHEeqLrdXyqq2YbtLO5bb8KoICuxbT2GQgL5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aI19GJ3H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pAh3Sb8I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vbuj+ygm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q5V04+M/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2F5A5BD52;
	Wed, 21 Jan 2026 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mg8qMJcBbzQLVQyzC7TJKVdmUFD6HD0Objs0efQfWIA=;
	b=aI19GJ3HPLncs0RbjYTxr9p3hqVaWM5/1+Dlh6kXRyFkil7Z0VanaVvSnA+FsbC6FopO+w
	Pe3AK2I8Pr7UguGHqe2dO0R2i6JocHzn0rWmkiey5LDUzgOkuZgu/jqXQEKH9aTj053Q2k
	2MBaynWQEU/LmB5D97eYcDLJcs4bO0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mg8qMJcBbzQLVQyzC7TJKVdmUFD6HD0Objs0efQfWIA=;
	b=pAh3Sb8IYd+aQCsuZ5trZjT+l75vU4kP1L0evWN2lLjEeoePiUTUYG8yw5Mt/eFwTfUeEI
	j9rckCOuIAaPeSAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vbuj+ygm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Q5V04+M/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mg8qMJcBbzQLVQyzC7TJKVdmUFD6HD0Objs0efQfWIA=;
	b=vbuj+ygmSIiMnAVWaiKER10OeYPY/xfGsTnNCWpj2r/u6fxoKKjw4iR0KjjCtkB5NcrVx2
	lagopqPcZb2rnO7Sx/NropuALfG2vvl5WoWniVlaSitNS2LNbSV9EOKrdn0ymuqSJeKA+i
	f/v45ZbFyav9XJ06l/ot/ILLSNFbH2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mg8qMJcBbzQLVQyzC7TJKVdmUFD6HD0Objs0efQfWIA=;
	b=Q5V04+M/ZDaa865RFErfVhJ8JTLmsaiK0zjQUyA1HbOpx+gS28O7/iwrwREM7ON4lFK+MI
	GeuzuOKMlGVfxQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB2DD3EA63;
	Wed, 21 Jan 2026 17:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0VpeKJgMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:52 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/8] SQUASH: test and improve cpio hex header validation
Date: Thu, 22 Jan 2026 04:12:48 +1100
Message-ID: <20260121172749.32322-1-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74881-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 56F235BF87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset is a combination of my
https://lore.kernel.org/linux-fsdevel/20260120204715.14529-1-ddiss@suse.de/
and Andy's
https://lore.kernel.org/linux-fsdevel/20260119204151.1447503-1-andriy.shevchenko@linux.intel.com/
patchsets.

The reason for combining them is so that a the initramfs_test case can
track the user-facing change in header parsing behaviour for cpio
fields that carry a "0x" hex prefix.

@Andy: please feel free to squash the two SQUASH flagged patches into
your 4/8 hex2bin() patch.

The initramfs_test changes are based atop commit aaf76839616a3cff
("initramfs_test: kunit test for cpio.filesize > PATH_MAX") queued at
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git .
@Christian: If possible, please fix the commit subject in the above
commit: it should be "cpio.namesize" instead of "cpio.filesize".

Andy Shevchenko (4):
      initramfs: Sort headers alphabetically
      initramfs: Refactor to use hex2bin() instead of custom approach
      vsprintf: Revert "add simple_strntoul"
      kstrtox: Drop extern keyword in the simple_strtox() declarations

David Disseldorp (4):
      initramfs_test: add fill_cpio() format parameter
      initramfs_test: test header fields with 0x hex prefix
      SQUASH initramfs: propagate parse_header errors
      SQUASH initramfs_test: expect error for "0x" prefixed header

 include/linux/kstrtox.h |  9 +++---
 init/initramfs.c        | 68 +++++++++++++++++++++-----------------
 init/initramfs_test.c   | 72 +++++++++++++++++++++++++++++++++--------
 lib/vsprintf.c          |  7 ----
 4 files changed, 101 insertions(+), 55 deletions(-)


