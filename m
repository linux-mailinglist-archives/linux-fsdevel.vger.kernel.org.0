Return-Path: <linux-fsdevel+bounces-30041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E502498554E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47ED9B2267C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A6E156886;
	Wed, 25 Sep 2024 08:18:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC913AA26
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252292; cv=none; b=soq+gd/p/Nq2M8IRpmGzxiBTjB6/I1xIq+IGl/lkK8nrEQt99laEmkS+fbgAd8tiW7CcNkEsaBLGaWd5jhfsEjU+jM3LNHn7JnPKxheO4g5DunuopAd64l2vw8qo6Tx9etsS4+K1SakJJV1VCGyBYsgLj+BIWBNuZ7RkmGnMJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252292; c=relaxed/simple;
	bh=3QA6geJymr/V5/ofwUtTh8Ce06b5PEt6v8PSf9irocI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw/dHXqiWED2bM+6j+MwooaRtGrHqg51HbIpf7Cvvdf+FBntTIVSuQkX7WKbHJpc9/JSZ3wguwH/cCWqt3XVNZNdR2MtR3tadUE4Mksgaz124eRBzonhhimZnsSj+PcUObBhr8ySJqdlGJ7JNzj+ZTRovatyRW8ADHB5pcq2vOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15E4F21A63;
	Wed, 25 Sep 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B8E713A6A;
	Wed, 25 Sep 2024 08:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7VfLAkHH82YefQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 08:18:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5738A089B; Wed, 25 Sep 2024 10:18:08 +0200 (CEST)
Date: Wed, 25 Sep 2024 10:18:08 +0200
From: Jan Kara <jack@suse.cz>
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Message-ID: <20240925081808.lzu6ukr6pr2553tf@quack3>
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925081146.5gpfxo5mfmlcg4dr@quack3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 15E4F21A63
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 25-09-24 10:11:46, Jan Kara wrote:
> On Tue 24-09-24 12:07:51, Krishna Vivek Vitta wrote:
> > Please ignore the last line.
> > Git clone operation is failing with fanotify example code as well.
> > 
> > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue# ./fanotify_ex /mnt/c
> > Press enter key to terminate.
> > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue# ./fanotify_ex /mnt/c
> > Press enter key to terminate.
> > Listening for events.
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypatch.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypatch.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-msg.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-msg.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-commit.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-commit.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-checkout.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-checkout.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-watchman.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-watchman.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-commit-msg.sample
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-commit-msg.sample
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/description
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/description
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/tNbqjiA
> > read: No such file or directory
> > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue#
> 
> OK, so it appears that dentry_open() is failing with ENOENT when we try to
> open the file descriptor to return with the event. This is indeed
> unexpected from the filesystem. On the other hand we already do silently
> fixup similar EOPENSTALE error that can come from NFS so perhaps we should
> be fixing ENOENT similarly? What do you thing Amir?

But what is still unclear to me is how this failure to generate fanotify
event relates to git clone failing. Perhaps the dentry references fanotify
holds in the notification queue confuse 9p and it returns those ENOENT
errors?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

