Return-Path: <linux-fsdevel+bounces-7628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C1828943
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D704B1F2581C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5623A268;
	Tue,  9 Jan 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yuCqZmQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u9NJlJkP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yuCqZmQz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u9NJlJkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2C3A1AA;
	Tue,  9 Jan 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 201881F813;
	Tue,  9 Jan 2024 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704815258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLXaYBDIft5KFgQ9nA2lRfdPYbiij75xCMbxbUzR9gg=;
	b=yuCqZmQzW1AAbNHxGs02nXFdpNObqdmT7cVUPlqGZWUY2Cjiadfxm2GwFhE5pUV0k2q9SN
	XxqN1xL0dzQCrxK7q8vAkKY39a7taea0SFd1iFJjtLq3PYYPchZvayNHmstm4eWqjc2zeU
	k3scUPV7z9DUCe9dn5HUACVOChF+A8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704815258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLXaYBDIft5KFgQ9nA2lRfdPYbiij75xCMbxbUzR9gg=;
	b=u9NJlJkPptNUeNQYK1ziJmCupDfn9OeuOVZWW9JWyDy66jNu/ayoh/itXoAY1xVygKBm2E
	58Uk61P1oab9WTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704815258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLXaYBDIft5KFgQ9nA2lRfdPYbiij75xCMbxbUzR9gg=;
	b=yuCqZmQzW1AAbNHxGs02nXFdpNObqdmT7cVUPlqGZWUY2Cjiadfxm2GwFhE5pUV0k2q9SN
	XxqN1xL0dzQCrxK7q8vAkKY39a7taea0SFd1iFJjtLq3PYYPchZvayNHmstm4eWqjc2zeU
	k3scUPV7z9DUCe9dn5HUACVOChF+A8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704815258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLXaYBDIft5KFgQ9nA2lRfdPYbiij75xCMbxbUzR9gg=;
	b=u9NJlJkPptNUeNQYK1ziJmCupDfn9OeuOVZWW9JWyDy66jNu/ayoh/itXoAY1xVygKBm2E
	58Uk61P1oab9WTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22D0713CB0;
	Tue,  9 Jan 2024 15:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WtI6BJlqnWVnVQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Tue, 09 Jan 2024 15:47:37 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id d854d863;
	Tue, 9 Jan 2024 15:47:32 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Jan Kara <jack@suse.cz>,  Matthew Wilcox <willy@infradead.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
  "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
  "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
In-Reply-To: <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com> (Johannes
	Thumshirn's message of "Mon, 8 Jan 2024 11:47:11 +0000")
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
	<20240105105736.24jep6q6cd7vsnmz@quack3>
	<20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com>
Date: Tue, 09 Jan 2024 15:47:32 +0000
Message-ID: <87cyua33vv.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: *****
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yuCqZmQz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u9NJlJkP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 201881F813
X-Spam-Flag: NO

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:

> On 05.01.24 11:57, Jan Kara wrote:
>> Hello,
>>=20
>> On Thu 04-01-24 21:17:16, Matthew Wilcox wrote:
>>> This is primarily a _FILESYSTEM_ track topic.  All the work has already
>>> been done on the MM side; the FS people need to do their part.  It could
>>> be a joint session, but I'm not sure there's much for the MM people
>>> to say.
>>>
>>> There are situations where we need to allocate memory, but cannot call
>>> into the filesystem to free memory.  Generally this is because we're
>>> holding a lock or we've started a transaction, and attempting to write
>>> out dirty folios to reclaim memory would result in a deadlock.
>>>
>>> The old way to solve this problem is to specify GFP_NOFS when allocating
>>> memory.  This conveys little information about what is being protected
>>> against, and so it is hard to know when it might be safe to remove.
>>> It's also a reflex -- many filesystem authors use GFP_NOFS by default
>>> even when they could use GFP_KERNEL because there's no risk of deadlock.
>>>
>>> The new way is to use the scoped APIs -- memalloc_nofs_save() and
>>> memalloc_nofs_restore().  These should be called when we start a
>>> transaction or take a lock that would cause a GFP_KERNEL allocation to
>>> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
>>> can see the nofs situation is in effect and will not call back into
>>> the filesystem.
>>>
>>> This results in better code within your filesystem as you don't need to
>>> pass around gfp flags as much, and can lead to better performance from
>>> the memory allocators as GFP_NOFS will not be used unnecessarily.
>>>
>>> The memalloc_nofs APIs were introduced in May 2017, but we still have
>>> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
>>> really sad).  This session is for filesystem developers to talk about
>>> what they need to do to fix up their own filesystem, or share stories
>>> about how they made their filesystem better by adopting the new APIs.
>>=20
>> I agree this is a worthy goal and the scoped API helped us a lot in the
>> ext4/jbd2 land. Still we have some legacy to deal with:
>>=20
>> ~> git grep "NOFS" fs/jbd2/ | wc -l
>> 15
>> ~> git grep "NOFS" fs/ext4/ | wc -l
>> 71
>>
>
> For everyone following out there being curious:
> 1 - affs
> 1 - cachefiles
> 1 - ecryptfs
> 1 - fscache
> 1 - notify
> 1 - squashfs
> 1 - vboxsf
> 1 - zonefs
> 2 - hfsplus
> 2 - tracefs
> 3 - 9p
> 3 - ext2
> 3 - iomap
> 5 - befs
> 5 - exfat
> 5 - fat
> 5 - udf
> 5 - ufs
> 7 - erofs
> 10 - fuse
> 11 - smb
> 14 - hpfs
> 15 - jbd2
> 17 - crypto
> 17 - jfs
> 17 - quota
> 17 - reiserfs
> 18 - nfs
> 18 - nilfs2
> 21 - ntfs
> 30 - xfs
> 37 - bcachefs
> 46 - gfs2
> 47 - afs
> 55 - dlm
> 61 - f2fs
> 63 - ceph
> 66 - ext4
> 71 - ocfs2
> 74 - ntfs3
> 84 - ubifs
> 199 - btrfs
>
> As I've already feared we (as in btrfs) are the worst here.

It probably won't make you feel any better, but the value for ceph isn't
correct as you're just taking into account the code in 'fs/ceph/'.  If you
also take 'net/ceph/', it brings it much closer to btrfs: 63 + 48 =3D 111

Cheers,
--=20
Lu=C3=ADs

