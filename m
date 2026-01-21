Return-Path: <linux-fsdevel+bounces-74839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MK3ALitcGkgZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:43:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF55565F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96544661166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47330480DE9;
	Wed, 21 Jan 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5MflvXD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="chxBhIO8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5MflvXD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="chxBhIO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1C449EA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991510; cv=none; b=eUy7h/drXIRrDae76a7lahwSaa6KOKbbAag/Fr7Gvi+sCSnwDr1x7RNE4r1GmWCA4QO7culhDq5u6CweOmcMVKtVkSmVjF/JoPqSdVX7hfIzU4UDbfqkCe1wKg4suwilFSaYmMYYcLvNFM+mF6ro8GzR6goQVDXbhOQyga2gTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991510; c=relaxed/simple;
	bh=9H4CxxiXq4M9SWrhBTr2a0GOmUcI0s0Ksf1LWqthyNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpXOr7cPEvwcF/RBeW3hIMs9KMmg2a81DL2hRuXs3840E5qqFh/9qllshe7NdNbOwFNLsWIpnA8OshDedM+jIPLDFpv6E3oZOyDGnA1M6+8vw2bydTMFfi+yEj8kmSSM6OXDPpl9yzeestHY3bHZEA6NKE0WHlT/zh/SzNgGsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5MflvXD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=chxBhIO8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5MflvXD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=chxBhIO8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F210E5BCD4;
	Wed, 21 Jan 2026 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768991504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnop+OuAl6QRtG3Dk07SDoxqUEzaCa0agsjIcN4UEo=;
	b=J5MflvXDd7clI8ndYuD2NBwbtfiHg+8DVO7CGAY+7WldkAILhH/7Fn/4Q1G0ArKIhRv1d5
	cVZQVwpMdVr+IG2bOvnqDcveQ+xmXezKB7uDkBgF2EBkC2gzkL7CmwEIiNts+BTZ6rJ1AE
	hsk76nUKpqQlJAaWMZo34gxM2SxznNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768991504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnop+OuAl6QRtG3Dk07SDoxqUEzaCa0agsjIcN4UEo=;
	b=chxBhIO8gbLE+3whvbhQumGP9OxPuIWqPgZi3gZYrMTPFICz2gcQlv6JjKjsYLepQddXIC
	s/57ra1FY3W85ZBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J5MflvXD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=chxBhIO8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768991504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnop+OuAl6QRtG3Dk07SDoxqUEzaCa0agsjIcN4UEo=;
	b=J5MflvXDd7clI8ndYuD2NBwbtfiHg+8DVO7CGAY+7WldkAILhH/7Fn/4Q1G0ArKIhRv1d5
	cVZQVwpMdVr+IG2bOvnqDcveQ+xmXezKB7uDkBgF2EBkC2gzkL7CmwEIiNts+BTZ6rJ1AE
	hsk76nUKpqQlJAaWMZo34gxM2SxznNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768991504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnop+OuAl6QRtG3Dk07SDoxqUEzaCa0agsjIcN4UEo=;
	b=chxBhIO8gbLE+3whvbhQumGP9OxPuIWqPgZi3gZYrMTPFICz2gcQlv6JjKjsYLepQddXIC
	s/57ra1FY3W85ZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E11323EA63;
	Wed, 21 Jan 2026 10:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gweuNg+rcGlOfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 10:31:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A09DEA09E9; Wed, 21 Jan 2026 11:31:35 +0100 (CET)
Date: Wed, 21 Jan 2026 11:31:35 +0100
From: Jan Kara <jack@suse.cz>
To: Chenglong Tang <chenglongtang@google.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [Regression 6.12] NULL pointer dereference in submit_bio_noacct
 via backing_file_read_iter
Message-ID: <ydl36oot3rtdt3q3j7gvcry3v4hikcz2iv3sjiutveroqstxyt@dkl6ftxogcwy>
References: <CAOdxtTZ=SuV2GMPuqQJe6h-h-CDiG5yBW+07f1QYEw+kTA4-2w@mail.gmail.com>
 <CAOQ4uxggQekxqavkt+RiJd9s9cdDgXZuVfQrL_qNciBNf=4Lww@mail.gmail.com>
 <CAOdxtTaz7=TzQizrdMEhjgt7LpuuHWzTO80783RLcB_GP3nPdw@mail.gmail.com>
 <CAOdxtTZv_B_pE1d1vgaE8+ar58y7pTiw0bL-djB1rhE-5wu2zQ@mail.gmail.com>
 <kptrliv7cflmaven5mcfn3bywpwe7zrevw4qvuei6eqq3ubcaj@3n33v7w4bgfj>
 <CAOdxtTaTXZw9FxwpVnVKonytwerKGQLQb=CcyOdLipd1gJG0tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOdxtTaTXZw9FxwpVnVKonytwerKGQLQb=CcyOdLipd1gJG0tw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org,szeredi.hu];
	TAGGED_FROM(0.00)[bounces-74839-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email,pvpanic.cc:url,vex_dns.cc:url];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96BF55565F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

On Tue 20-01-26 13:48:22, Chenglong Tang wrote:
> Hi, Amir and Jan,
> 
> Thanks for the reply.
> 
> addr2line -e vmlinux -f -i submit_bio_noacct+0x21d
> blk_should_throtl
> /build/lakitu/tmp/portage/sys-kernel/lakitu-kernel-6_12-6.12.55-r86/work/lakitu-kernel-6_12-6.12.55/block/blk-throttle.h:184
> (discriminator 4)
> blk_throtl_bio
> /build/lakitu/tmp/portage/sys-kernel/lakitu-kernel-6_12-6.12.55-r86/work/lakitu-kernel-6_12-6.12.55/block/blk-throttle.h:196
> (discriminator 4)
> submit_bio_noacct
> /build/lakitu/tmp/portage/sys-kernel/lakitu-kernel-6_12-6.12.55-r86/work/lakitu-kernel-6_12-6.12.55/block/blk-core.c:866
> (discriminator 4)

OK, so it seems that although cgroup throttling is enabled for the device,
bio->bi_blkg is NULL and that upsets the code in blk_should_throtl(). Now
it is strange that bio->bi_blkg is NULL because bio_associate_blkg() called
from bio_init() should have set this. So I think you need to debug what's
exactly happening there on your kernel.

								Honza

> 
> Changelog:
> 
> git log --oneline cos/release-R117-cos-6.6..cos/release-R125-cos-6.12
> block/blk-throttle.h
> 3bf73e6283ef blk-throttle: remove last_low_overflow_time
> 0a751df4566c blk-throttle: Fix incorrect display of io.max
> a3166c51702b blk-throttle: delay initialization until configuration
> bf20ab538c81 blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW
> 
> git log --oneline cos/release-R117-cos-6.6..cos/release-R125-cos-6.12
> block/blk-core.c
> [TRUE NEW]      2ad0f19a4e99 block: add a rq_list type...
> [TRUE NEW]      d313ff5308fd block: don't update BLK_FEAT_POLL in
> __blk_mq_update_nr_hw_queues...
> [TRUE NEW]      e278c7ff7574 block: check BLK_FEAT_POLL under q_usage_count...
> [TRUE NEW]      b12cfcae8a83 block: always verify unfreeze lock on the
> owner task...
> [TRUE NEW]      a6fc2ba1c7e5 block: model freeze & enter queue as lock
> for supporting lockdep...
> [TRUE NEW]      ea6787c695ab scsi: block: Don't check REQ_ATOMIC for reads...
> [TRUE NEW]      73e59d3eeca4 block: avoid polling configuration errors...
> [TRUE NEW]      f2a7bea23710 block: Remove REQ_OP_ZONE_RESET_ALL emulation...
> [TRUE NEW]      63db4a1f795a block: Delete blk_queue_flag_test_and_set()...
> [TRUE NEW]      9da3d1e912f3 block: Add core atomic write support...
> [TRUE NEW]      8023e144f9d6 block: move the poll flag to queue_limits...
> [TRUE NEW]      1122c0c1cc71 block: move cache control settings out of
> queue->flags...
> [TRUE NEW]      9a42891c35d5 block: fix lost bio for plug enabled bio
> based device...
> [TRUE NEW]      060406c61c7c block: add plug while submitting IO...
> [TRUE NEW]      811ba89a8838 bdev: move ->bd_make_it_fail to ->__bd_flags...
> [TRUE NEW]      49a43dae93c8 bdev: move ->bd_ro_warned to ->__bd_flags...
> [TRUE NEW]      ac2b6f9dee8f bdev: move ->bd_has_subit_bio to ->__bd_flags...
> [TRUE NEW]      3f9b8fb46e5d Use bdev_is_paritition() instead of
> open-coding it...
> [TRUE NEW]      99a9476b27e8 block: Do not special-case plugging of
> zone write operations...
> [TRUE NEW]      bca150f0d4ed block: Do not check zone type in
> blk_check_zone_append()...
> [TRUE NEW]      ccdbf0aad252 block: Allow zero value of
> max_zone_append_sectors queue limit...
> [TRUE NEW]      3ec4848913d6 block: fix that blk_time_get_ns() doesn't
> update time after schedule...
> [TRUE NEW]      ad751ba1f8d5 block: pass a queue_limits argument to
> blk_alloc_queue...
> [TRUE NEW]      d690cb8ae14b block: add an API to atomically update
> queue limits...
> [TRUE NEW]      48ff13a618b5 block: Simplify the allocation of slab caches...
> [TRUE NEW]      06b23f92af87 block: update cached timestamp post
> schedule/preemption...
> [TRUE NEW]      da4c8c3d0975 block: cache current nsec time in struct
> blk_plug...
> 
> As for the suggestion to try newer kernel versions, yes I'll do that
> as well. It takes some time to figure out the best way to compile the
> new kernel and run the test.
> 
> Best,
> 
> Chenglong
> 
> On Fri, Jan 16, 2026 at 4:27 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi!
> >
> > On Thu 15-01-26 21:56:06, Chenglong Tang wrote:
> > > [Follow Up] We have an important update regarding the
> > > submit_bio_noacct panic we reported earlier.
> > >
> > > To rule out the Integrity Measurement Architecture (IMA) as the root
> > > cause, we disabled IMA verification in the workload configuration. The
> > > kernel panic persisted with the exact same signature (RIP:
> > > 0010:submit_bio_noacct+0x21d), but the trigger path has changed.
> >
> > OK, can you please feed this through addr2line so that we know what exactly
> > is wrong with the bio? Thanks!
> >
> > Also do you have a chance to try with some recent upstream kernel? The
> > crash might also be specific to the set of backports in that particular
> > stable branch...
> >
> >                                                                 Honza
> >
> > >
> > > New Stack Traces (Non-IMA) We are now observing the crash via two
> > > standard filesystem paths.
> > >
> > > Stack Trace:
> > > Most failures are still similar:
> > > I0115 20:30:23.535402    8496 vex_console.cc:116] (vex1): [
> > > 158.519909] BUG: kernel NULL pointer dereference, address:
> > > 0000000000000156
> > > I0115 20:30:23.535483    8496 vex_console.cc:116] (vex1): [
> > > 158.542610] #PF: supervisor read access in kernel mode
> > > I0115 20:30:23.585675    8496 vex_console.cc:116] (vex1): [
> > > 158.565011] #PF: error_code(0x0000) - not-present page
> > > I0115 20:30:23.585702    8496 vex_console.cc:116] (vex1): [
> > > 158.583855] PGD 800000007c7da067 P4D 800000007c7da067 PUD 7c7db067 PMD
> > > 0
> > > I0115 20:30:23.585709    8496 vex_console.cc:116] (vex1): [
> > > 158.590940] Oops: Oops: 0000 [#1] SMP PTI
> > > I0115 20:30:23.636063    8496 vex_console.cc:116] (vex1): [
> > > 158.598950] CPU: 1 UID: 0 PID: 6717 Comm: agent_launcher Tainted: G
> > >        O       6.12.55+ #1
> > > I0115 20:30:23.636092    8496 vex_console.cc:116] (vex1): [
> > > 158.629624] Tainted: [O]=OOT_MODULE
> > > I0115 20:30:23.694223    8496 vex_console.cc:116] (vex1): [
> > > 158.639965] Hardware name: Google Google Compute Engine/Google Compute
> > > Engine, BIOS Google 01/01/2011
> > > I0115 20:30:23.694252    8496 vex_console.cc:116] (vex1): [
> > > 158.684210] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > > I0115 20:30:23.738566    8496 vex_console.cc:116] (vex1): [
> > > 158.705662] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 46 af 89 01 49 83
> > > fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 99 ca 7d 01 00
> > > 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 fc 9f
> > > 02
> > > I0115 20:30:23.738598    8496 vex_console.cc:116] (vex1): [
> > > 158.765443] RSP: 0000:ffffa74c84d53a98 EFLAGS: 00010202
> > > I0115 20:30:23.793126    8496 vex_console.cc:116] (vex1): [
> > > 158.771022] RAX: ffffa319b3d6b4f0 RBX: ffffa319bdc9a3c0 RCX:
> > > 00000000005e1070
> > > I0115 20:30:23.793158    8496 vex_console.cc:116] (vex1): [
> > > 158.778730] RDX: 0000000010300001 RSI: ffffa319b3d6b4f0 RDI:
> > > ffffa319bdc9a3c0
> > > I0115 20:30:23.843309    8496 vex_console.cc:116] (vex1): [
> > > 158.802189] RBP: ffffa74c84d53ac8 R08: 0000000000001000 R09:
> > > ffffa319bdc9a3c0
> > > I0115 20:30:23.843336    8496 vex_console.cc:116] (vex1): [
> > > 158.846780] R10: 0000000000000000 R11: 0000000069a1b000 R12:
> > > 0000000000000000
> > > I0115 20:30:23.889620    8484 vex_dns.cc:145] Returning NODATA for DNS
> > > Query: type=a, name=servicecontrol.googleapis.com.
> > > I0115 20:30:23.898357    8496 vex_console.cc:116] (vex1): [
> > > 158.877737] R13: ffffa31941421f40 R14: ffffa31955419200 R15:
> > > 0000000000000000
> > > I0115 20:30:23.948602    8496 vex_console.cc:116] (vex1): [
> > > 158.908715] FS:  00000000059efe28(0000) GS:ffffa319bdd00000(0000)
> > > knlGS:0000000000000000
> > > I0115 20:30:23.948640    8496 vex_console.cc:116] (vex1): [
> > > 158.937522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > I0115 20:30:23.948645    8496 vex_console.cc:116] (vex1): [
> > > 158.958522] CR2: 0000000000000156 CR3: 000000006a20a003 CR4:
> > > 00000000003726f0
> > > I0115 20:30:23.948650    8496 vex_console.cc:116] (vex1): [
> > > 158.968648] Call Trace:
> > > I0115 20:30:23.948655    8496 vex_console.cc:116] (vex1): [  158.974419]  <TASK>
> > > I0115 20:30:23.948659    8496 vex_console.cc:116] (vex1): [
> > > 158.978222]  ext4_mpage_readpages+0x75c/0x790
> > > I0115 20:30:24.004540    8496 vex_console.cc:116] (vex1): [
> > > 158.983568]  read_pages+0x9d/0x250
> > > I0115 20:30:24.004568    8496 vex_console.cc:116] (vex1): [
> > > 158.987263]  page_cache_ra_unbounded+0xa2/0x1c0
> > > I0115 20:30:24.004573    8496 vex_console.cc:116] (vex1): [
> > > 158.992179]  filemap_fault+0x218/0x660
> > > I0115 20:30:24.004576    8496 vex_console.cc:116] (vex1): [
> > > 158.996311]  __do_fault+0x4b/0x140
> > > I0115 20:30:24.004580    8496 vex_console.cc:116] (vex1): [
> > > 159.000143]  do_pte_missing+0x14f/0x1050
> > > I0115 20:30:24.054563    8496 vex_console.cc:116] (vex1): [
> > > 159.018505]  handle_mm_fault+0x886/0xb40
> > > I0115 20:30:24.105692    8496 vex_console.cc:116] (vex1): [
> > > 159.063653]  do_user_addr_fault+0x1eb/0x730
> > > I0115 20:30:24.105721    8496 vex_console.cc:116] (vex1): [
> > > 159.094465]  exc_page_fault+0x80/0x100
> > > I0115 20:30:24.105726    8496 vex_console.cc:116] (vex1): [
> > > 159.116472]  asm_exc_page_fault+0x26/0x30
> > >
> > > Though there is a different one:
> > > I0115 20:31:14.891091    7372 vex_console.cc:116] (vex1): [
> > > 163.902122] BUG: kernel NULL pointer dereference, address:
> > > 0000000000000157
> > > I0115 20:31:14.950131    7372 vex_console.cc:116] (vex1): [
> > > 163.955031] #PF: supervisor read access in kernel mode
> > > I0115 20:31:15.057629    7372 vex_console.cc:116] (vex1): [
> > > 163.986899] #PF: error_code(0x0000) - not-present page
> > > I0115 20:31:15.057665    7372 vex_console.cc:116] (vex1): [
> > > 164.075132] PGD 0 P4D 0
> > > I0115 20:31:15.057670    7372 vex_console.cc:116] (vex1): [
> > > 164.085940] Oops: Oops: 0000 [#1] SMP PTI
> > > I0115 20:31:15.108501    7372 vex_console.cc:116] (vex1): [
> > > 164.090592] CPU: 0 UID: 0 PID: 399 Comm: jbd2/nvme0n1p1- Tainted: G
> > >        O       6.12.55+ #1
> > > I0115 20:31:15.157731    7372 vex_console.cc:116] (vex1): [
> > > 164.146188] Tainted: [O]=OOT_MODULE
> > > I0115 20:31:15.210631    7372 vex_console.cc:116] (vex1): [
> > > 164.172362] Hardware name: Google Google Compute Engine/Google Compute
> > > Engine, BIOS Google 01/01/2011
> > > I0115 20:31:15.266673    7372 vex_console.cc:116] (vex1): [
> > > 164.243113] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > > I0115 20:31:15.369886    7372 vex_console.cc:116] (vex1): [
> > > 164.276230] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 46 af 89 01 49 83
> > > fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 99 ca 7d 01 00
> > > 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 fc 9f
> > > 02
> > > I0115 20:31:15.369913    7372 vex_console.cc:116] (vex1): [
> > > 164.413258] RSP: 0000:ffffa674004ebc80 EFLAGS: 00010202
> > > I0115 20:31:15.422131    7372 vex_console.cc:116] (vex1): [
> > > 164.420124] RAX: ffff9381c25d4790 RBX: ffff9381d0e5e540 RCX:
> > > 00000000000301c8
> > > I0115 20:31:15.522750    7372 vex_console.cc:116] (vex1): [
> > > 164.464474] RDX: 0000000010300001 RSI: ffff9381c25d4790 RDI:
> > > ffff9381d0e5e540
> > > I0115 20:31:15.522784    7372 vex_console.cc:116] (vex1): [
> > > 164.542751] RBP: ffffa674004ebcb0 R08: 0000000000000000 R09:
> > > 0000000000000000
> > > I0115 20:31:15.576921    7372 vex_console.cc:116] (vex1): [
> > > 164.578174] R10: 0000000000000000 R11: ffffffff8433e7a0 R12:
> > > 0000000000000000
> > > I0115 20:31:15.577224    7372 vex_console.cc:116] (vex1): [
> > > 164.595801] R13: ffff9381c1425780 R14: ffff9381c196d400 R15:
> > > 0000000000000001
> > > I0115 20:31:15.628049    7372 vex_console.cc:116] (vex1): [
> > > 164.626548] FS:  0000000000000000(0000) GS:ffff93823dc00000(0000)
> > > knlGS:0000000000000000
> > > I0115 20:31:15.732793    7372 vex_console.cc:116] (vex1): [
> > > 164.665104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > I0115 20:31:15.785564    7372 vex_console.cc:116] (vex1): [
> > > 164.757565] CR2: 0000000000000157 CR3: 000000007c678003 CR4:
> > > 00000000003726f0
> > > I0115 20:31:15.843034    7372 vex_console.cc:116] (vex1): [
> > > 164.831021] Call Trace:
> > > I0115 20:31:15.843065    7372 vex_console.cc:116] (vex1): [  164.851014]  <TASK>
> > > I0115 20:31:15.900287    7372 vex_console.cc:116] (vex1): [
> > > 164.872000]  jbd2_journal_commit_transaction+0x612/0x17e0
> > > I0115 20:31:15.900315    7372 vex_console.cc:116] (vex1): [
> > > 164.914012]  ? sched_clock+0xd/0x20
> > > I0115 20:31:15.952673    7372 vex_console.cc:116] (vex1): [
> > > 164.963930]  ? _raw_spin_unlock_irqrestore+0x12/0x30
> > > I0115 20:31:16.004440    7372 vex_console.cc:116] (vex1): [
> > > 164.989978]  ? __try_to_del_timer_sync+0x122/0x160
> > > I0115 20:31:16.004471    7372 vex_console.cc:116] (vex1): [
> > > 165.029451]  kjournald2+0xb1/0x220
> > > I0115 20:31:16.004477    7372 vex_console.cc:116] (vex1): [
> > > 165.033558]  ? __pfx_autoremove_wake_function+0x10/0x10
> > > I0115 20:31:16.004481    7372 vex_console.cc:116] (vex1): [
> > > 165.044022]  kthread+0x122/0x140
> > > I0115 20:31:16.004486    7372 vex_console.cc:116] (vex1): [
> > > 165.048012]  ? __pfx_kjournald2+0x10/0x10
> > > I0115 20:31:16.004490    7372 vex_console.cc:116] (vex1): [
> > > 165.052944]  ? __pfx_kthread+0x10/0x10
> > > I0115 20:31:16.004494    7372 vex_console.cc:116] (vex1): [
> > > 165.057597]  ret_from_fork+0x3f/0x50
> > > I0115 20:31:16.057453    7372 vex_console.cc:116] (vex1): [
> > > 165.062127]  ? __pfx_kthread+0x10/0x10
> > > I0115 20:31:16.057484    7372 vex_console.cc:116] (vex1): [
> > > 165.079674]  ret_from_fork_asm+0x1a/0x30
> > > I0115 20:31:16.109674    7372 vex_console.cc:116] (vex1): [
> > > 165.113023]  </TASK>
> > > I0115 20:31:16.212548    7372 vex_console.cc:116] (vex1): [
> > > 165.131001] Modules linked in: nft_chain_nat xt_MASQUERADE nf_nat
> > > xt_addrtype nft_compat nf_tables kvm_intel kvm irqbypass crc32c_intel
> > > aesni_intel crypto_simd cryptd loadpin_trigger(O) fuse
> > > I0115 20:31:16.262933    7372 vex_console.cc:116] (vex1): [
> > > 165.269971] CR2: 0000000000000157
> > > I0115 20:31:16.316433    7372 vex_console.cc:116] (vex1): [
> > > 165.306980] ---[ end trace 0000000000000000 ]---
> > > I0115 20:31:16.365756    7372 vex_console.cc:116] (vex1): [
> > > 165.361889] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > > I0115 20:31:16.518250    7372 vex_console.cc:116] (vex1): [
> > > 165.406957] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 46 af 89 01 49 83
> > > fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 99 ca 7d 01 00
> > > 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 fc 9f
> > > 02
> > > I0115 20:31:16.518278    7372 vex_console.cc:116] (vex1): [
> > > 165.558880] RSP: 0000:ffffa674004ebc80 EFLAGS: 00010202
> > > I0115 20:31:16.568463    7372 vex_console.cc:116] (vex1): [
> > > 165.575239] RAX: ffff9381c25d4790 RBX: ffff9381d0e5e540 RCX:
> > > 00000000000301c8
> > > I0115 20:31:16.568490    7372 vex_console.cc:116] (vex1): [
> > > 165.590012] RDX: 0000000010300001 RSI: ffff9381c25d4790 RDI:
> > > ffff9381d0e5e540
> > > I0115 20:31:16.568495    7372 vex_console.cc:116] (vex1): [
> > > 165.597793] RBP: ffffa674004ebcb0 R08: 0000000000000000 R09:
> > > 0000000000000000
> > > I0115 20:31:16.568499    7372 vex_console.cc:116] (vex1): [
> > > 165.608408] R10: 0000000000000000 R11: ffffffff8433e7a0 R12:
> > > 0000000000000000
> > > I0115 20:31:16.568502    7372 vex_console.cc:116] (vex1): [
> > > 165.616602] R13: ffff9381c1425780 R14: ffff9381c196d400 R15:
> > > 0000000000000001
> > > I0115 20:31:16.618734    7372 vex_console.cc:116] (vex1): [
> > > 165.631823] FS:  0000000000000000(0000) GS:ffff93823dc00000(0000)
> > > knlGS:0000000000000000
> > > I0115 20:31:16.618770    7372 vex_console.cc:116] (vex1): [
> > > 165.653088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > W0115 20:31:16.649110    7355 pvpanic.cc:136] Guest kernel has panicked!
> > > I0115 20:31:16.671568    7372 vex_console.cc:116] (vex1): [
> > > 165.668488] CR2: 0000000000000157 CR3: 000000007c678003 CR4:
> > > 00000000003726f0
> > > I0115 20:31:16.671599    7372 vex_console.cc:116] (vex1): [
> > > 165.686744] Kernel panic - not syncing: Fatal exception
> > >
> > > This confirms the issue is not specific to IMA, but is a fundamental
> > > race condition in the Block I/O layer or Ext4 subsystem under high
> > > concurrency.
> > >
> > > Since the crash occurs at the exact same instruction offset in
> > > submit_bio_noacct regardless of the caller (IMA, Page Fault, or JBD2),
> > > we suspect a bio or request_queue structure is being corrupted or
> > > hitting a NULL pointer dereference in the underlying block device
> > > driver (NVMe) or Device Mapper.
> > >
> > > Best,
> > >
> > > Chenglong
> > >
> > > On Thu, Jan 15, 2026 at 6:56 PM Chenglong Tang <chenglongtang@google.com> wrote:
> > > >
> > > > Hi Amir,
> > > >
> > > > Thanks for the guidance. Using the specific order of the 8 commits
> > > > (applying the ovl_real_fdget refactors before the fix consumers)
> > > > resolved the boot-time NULL pointer panic. The system now boots
> > > > successfully.
> > > >
> > > > However, we are still hitting the original kernel panic during runtime
> > > > tests (specifically a CloudSQL workload).
> > > >
> > > > Current Commit Chain (Applied to 6.12):
> > > >
> > > > 76d83345a056 (HEAD -> main-R125-cos-6.12) ovl: convert
> > > > ovl_real_fdget() callers to ovl_real_file()
> > > > 740bdf920b15 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
> > > > 100b71ecb237 fs/backing_file: fix wrong argument in callback
> > > > b877bca6858d ovl: store upper real file in ovl_file struct
> > > > 595aac630596 ovl: allocate a container struct ovl_file for ovl private context
> > > > 218ec543008d ovl: do not open non-data lower file for fsync
> > > > 6def078942e2 ovl: use wrapper ovl_revert_creds()
> > > > fe73aad71936 backing-file: clean up the API
> > > >
> > > > So it means none of these 8 commits were able to fix the problem. Let
> > > > me explain what's going on here:
> > > >
> > > > We are reporting a rare but persistent kernel panic (~0.02% failure
> > > > rate) occurring during container initialization on Linux 6.12.55+
> > > > (x86_64). The 6.6.x is good. The panic is a NULL pointer dereference
> > > > in submit_bio_noacct, triggered specifically when the Integrity
> > > > Measurement Architecture (IMA) calculates a file hash during a runc
> > > > create operation.
> > > >
> > > > We have isolated the crash to a specific container (ncsa) starting up
> > > > during a high-concurrency boot sequence.
> > > >
> > > > Environment
> > > > * Kernel: Linux 6.12.55+ (x86_64) / Container-Optimized OS
> > > > * Workload: Cloud SQL instance initialization (heavy concurrent runc
> > > > operations managed by systemd).
> > > > * Filesystem: Ext4 backed by NVMe.
> > > > * Security: AppArmor enabled, IMA (Integrity Measurement Architecture) active.
> > > >
> > > > The Failure Pattern(In every crash instance, the sequence is identical):
> > > > * systemd initiates the startup of the ncsainit container.
> > > > * runc executes the create command:
> > > > `Bash
> > > > `runc --root /var/lib/cloudsql/runc/root create --bundle
> > > > /var/lib/cloudsql/runc/bundles/ncsa ...
> > > >
> > > > Immediately after this command is logged, the kernel panics.
> > > >
> > > > Stacktrace:
> > > > [  186.938290] BUG: kernel NULL pointer dereference, address: 0000000000000156
> > > > [  186.952203] #PF: supervisor read access in kernel mode
> > > > [  186.995248] Oops: Oops: 0000 [#1] SMP PTI
> > > > [  187.035946] CPU: 1 UID: 0 PID: 6764 Comm: runc:[2:INIT] Tainted: G
> > > >          O       6.12.55+ #1
> > > > [  187.081681] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > > > [  187.412981] Call Trace:
> > > > [  187.415751]  <TASK>
> > > > [  187.418141]  ext4_mpage_readpages+0x75c/0x790
> > > > [  187.429011]  read_pages+0x9d/0x250
> > > > [  187.450963]  page_cache_ra_unbounded+0xa2/0x1c0
> > > > [  187.466083]  filemap_get_pages+0x231/0x7a0
> > > > [  187.474687]  filemap_read+0xf6/0x440
> > > > [  187.532345]  integrity_kernel_read+0x34/0x60
> > > > [  187.560740]  ima_calc_file_hash+0x1c1/0x9b0
> > > > [  187.608175]  ima_collect_measurement+0x1b6/0x310
> > > > [  187.613102]  process_measurement+0x4ea/0x850
> > > > [  187.617788]  ima_bprm_check+0x5b/0xc0
> > > > [  187.635403]  bprm_execve+0x203/0x560
> > > > [  187.645058]  do_execveat_common+0x2fb/0x360
> > > > [  187.649730]  __x64_sys_execve+0x3e/0x50
> > > >
> > > > Panic Analysis: The stack trace indicates a race condition where
> > > > ima_bprm_check (triggered by executing the container binary) attempts
> > > > to verify the file. This calls ima_calc_file_hash ->
> > > > ext4_mpage_readpages, which submits a bio to the block layer.
> > > >
> > > > The crash occurs in submit_bio_noacct when it attempts to dereference
> > > > a member of the bio structure (likely bio->bi_bdev or the request
> > > > queue), suggesting the underlying device or queue structure is either
> > > > uninitialized or has been torn down while the IMA check was still in
> > > > flight.
> > > >
> > > > Context on Concurrency: This workload involves systemd starting
> > > > multiple sidecar containers (logging, monitoring, coroner, etc.)
> > > > simultaneously. We suspect this high-concurrency startup creates the
> > > > IO/CPU contention required to hit this race window. However, the crash
> > > > consistently happens only on the ncsa container, implying something
> > > > specific about its launch configuration or timing makes it the
> > > > reliable victim.
> > > >
> > > > Best,
> > > >
> > > > Chenglong
> > > >
> > > > On Wed, Jan 14, 2026 at 3:11 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jan 14, 2026 at 1:53 AM Chenglong Tang <chenglongtang@google.com> wrote:
> > > > > >
> > > > > > Hi OverlayFS Maintainers,
> > > > > >
> > > > > > This is from Container Optimized OS in Google Cloud.
> > > > > >
> > > > > > We are reporting a reproducible kernel panic on Kernel 6.12 involving
> > > > > > a NULL pointer dereference in submit_bio_noacct.
> > > > > >
> > > > > > The Issue: The panic occurs intermittently (approx. 5 failures in 1000
> > > > > > runs) during a specific PostgreSQL client test
> > > > > > (postgres_client_test_postgres15_ctrdncsa) on Google
> > > > > > Container-Optimized OS. The stack trace shows the crash happens when
> > > > > > IMA (ima_calc_file_hash) attempts to read a file from OverlayFS via
> > > > > > the new-in-6.12 backing_file_read_iter helper.
> > > > > >
> > > > > > It appears to be a race condition where the underlying block device is
> > > > > > detached (becoming NULL) while the backing_file wrapper is still
> > > > > > attempting to submit a read bio during container teardown.
> > > > > >
> > > > > > Stack Trace:
> > > > > > [  OK  ] Started    75.793015] BUG: kernel NULL pointer dereference,
> > > > > > address: 0000000000000156
> > > > > > [   75.822539] #PF: supervisor read access in kernel mode
> > > > > > [   75.849332] #PF: error_code(0x0000) - not-present page
> > > > > > [   75.862775] PGD 7d012067 P4D 7d012067 PUD 7d013067 PMD 0
> > > > > > [   75.884283] Oops: Oops: 0000 [#1] SMP NOPTI
> > > > > > [   75.902274] CPU: 1 UID: 0 PID: 6476 Comm: helmd Tainted: G
> > > > > >  O       6.12.55+ #1
> > > > > > [   75.928903] Tainted: [O]=OOT_MODULE
> > > > > > [   75.942484] Hardware name: Google Google Compute Engine/Google
> > > > > > Compute Engine, BIOS Google 01/01/2011
> > > > > > [   75.965868] RIP: 0010:submit_bio_noacct+0x21d/0x470
> > > > > > [   75.978340] Code: 8b 73 48 4d 85 f6 74 55 4c 63 25 b6 ad 89 01 49
> > > > > > 83 fc 06 0f 83 44 02 00 00 4f 8b a4 e6 d0 00 00 00 83 3d 09 c9 7d 01
> > > > > > 00 7e 3f <43> 80 bc 3c 56 01 00 00 00 0f 84 28 01 00 00 48 89 df e8 4c
> > > > > > a0 02
> > > > > > [   76.035847] RSP: 0018:ffffa41183463880 EFLAGS: 00010202
> > > > > > [   76.050141] RAX: ffff9d4ec1a81a78 RBX: ffff9d4f3811e6c0 RCX: 00000000009410a0
> > > > > > [   76.065176] RDX: 0000000010300001 RSI: ffff9d4ec1a81a78 RDI: ffff9d4f3811e6c0
> > > > > > [   76.089292] RBP: ffffa411834638b0 R08: 0000000000001000 R09: ffff9d4f3811e6c0
> > > > > > [   76.110878] R10: 2000000000000000 R11: ffffffff8a33e700 R12: 0000000000000000
> > > > > > [   76.139068] R13: ffff9d4ec1422bc0 R14: ffff9d4ec2507000 R15: 0000000000000000
> > > > > > [   76.168391] FS:  0000000008df7f40(0000) GS:ffff9d4f3dd00000(0000)
> > > > > > knlGS:0000000000000000
> > > > > > [   76.179024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > [   76.184951] CR2: 0000000000000156 CR3: 000000007d01c006 CR4: 0000000000370ef0
> > > > > > [   76.192352] Call Trace:
> > > > > > [   76.194981]  <TASK>
> > > > > > [   76.197257]  ext4_mpage_readpages+0x75c/0x790
> > > > > > [   76.201794]  read_pages+0xa0/0x250
> > > > > > [   76.205373]  page_cache_ra_unbounded+0xa2/0x1c0
> > > > > > [   76.232608]  filemap_get_pages+0x16b/0x7a0
> > > > > > [   76.254151]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > > > [   76.260523]  filemap_read+0xf6/0x440
> > > > > > [   76.264540]  do_iter_readv_writev+0x17e/0x1c0
> > > > > > [   76.275427]  vfs_iter_read+0x8a/0x140
> > > > > > [   76.279272]  backing_file_read_iter+0x155/0x250
> > > > > > [   76.284425]  ovl_read_iter+0xd7/0x120
> > > > > > [   76.288270]  ? __pfx_ovl_file_accessed+0x10/0x10
> > > > > > [   76.293069]  vfs_read+0x2b1/0x300
> > > > > > [   76.296835]  ksys_read+0x75/0xe0
> > > > > > [   76.300246]  do_syscall_64+0x61/0x130
> > > > > > [   76.304173]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > >
> > > > > > Our Findings:
> > > > > >
> > > > > > Not an Ext4 regression: We verified that reverting "ext4: reduce stack
> > > > > > usage in ext4_mpage_readpages()" does not resolve the panic.
> > > > > >
> > > > > > Suspected Fix: We suspect upstream commit 18e48d0e2c7b ("ovl: store
> > > > > > upper real file in ovl_file struct") is the correct fix. It seems to
> > > > > > address this exact lifetime race by persistently pinning the
> > > > > > underlying file.
> > > > >
> > > > > That sounds odd.
> > > > > Using a persistent upper real file may be more efficient than opening
> > > > > a temporary file for every read, but the temporary file is a legit opened file,
> > > > > so it looks like you would be averting the race rather than fixing it.
> > > > >
> > > > > Could you try to analyse the conditions that caused the race?
> > > > >
> > > > > >
> > > > > > The Problem: We cannot apply 18e48d0e2c7b to 6.12 stable because it
> > > > > > depends on the extensive ovl_real_file refactoring series (removing
> > > > > > ovl_real_fdget family functions) that landed in 6.13.
> > > > > >
> > > > > > Is there a recommended way to backport the "persistent real file"
> > > > > > logic to 6.12 without pulling in the entire refactor chain?
> > > > > >
> > > > >
> > > > > These are the commits in overlayfs/file.c v6.12..v6.13:
> > > > >
> > > > > $ git log --oneline  v6.12..v6.13 -- fs/overlayfs/file.c
> > > > > d66907b51ba07 ovl: convert ovl_real_fdget() callers to ovl_real_file()
> > > > > 4333e42ed4444 ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
> > > > > 18e48d0e2c7b1 ovl: store upper real file in ovl_file struct
> > > > > 87a8a76c34a2a ovl: allocate a container struct ovl_file for ovl private context
> > > > > c2c54b5f34f63 ovl: do not open non-data lower file for fsync
> > > > > fc5a1d2287bf2 ovl: use wrapper ovl_revert_creds()
> > > > > 48b50624aec45 backing-file: clean up the API
> > > > >
> > > > > Your claim that 18e48d0e2c7b depends on ovl_real_fdget() is incorrect.
> > > > > You may safely cherry-pick the 4 commits above leading to 18e48d0e2c7b1.
> > > > > They are all self contained changes that would be good to have in 6.12.y,
> > > > > because they would make cherry-picking future fixes easier.
> > > > >
> > > > > Specifically, backing-file: clean up the API, it is better to have the same
> > > > > API in upstream and stable kernels.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

