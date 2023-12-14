Return-Path: <linux-fsdevel+bounces-6160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F03813D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DDE1F2228D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8D66AC4;
	Thu, 14 Dec 2023 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wzgBoTd3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="av4ExMek";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mYx9TuMP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Z/56yfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCA671E8;
	Thu, 14 Dec 2023 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D2411F7F6;
	Thu, 14 Dec 2023 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702594076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rc7KJ4S5i21gRD67UWNoBNnEepjkHytPw5CV1g2C07Y=;
	b=wzgBoTd37u8HcjDIioFUKsZW4sEql8sO7sf4P1jY77dVzmhMk4yVkIMUJx1Hac3Akz5CWG
	sUkF8LMEZ5SlDgrLT3P6JchR7xpoGPlycsD3yWG1TwvQs7rcdUOO/Dv5KbsqZQMcGSRtU4
	DzDFzCrRKxjzc0xkL7X3Y/tnmwx6/2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702594076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rc7KJ4S5i21gRD67UWNoBNnEepjkHytPw5CV1g2C07Y=;
	b=av4ExMekhNsWYHvMRRRjDafS5IujHPjMmoMQlqsL/bz8y6Mf3rg0ZRgOsYuK41I/WT9/xx
	9/alOZS3ih8HDeAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702594074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rc7KJ4S5i21gRD67UWNoBNnEepjkHytPw5CV1g2C07Y=;
	b=mYx9TuMPBH0iFRPPHfBmLQvsg5lcjFANjYpYO2ZHaFjQMjcSgiZDWLR8ofz/9uQO0hq9V1
	m5MmiVgkOBkM74prQOvlyaZ5AcMRDZfYwFjQBWnj5ZKIlRgL8LFQtaZV0/qq4ZGr6KGjiR
	aJRGRAiwZyXeZYI22zC5Z+6d8c6L+xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702594074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rc7KJ4S5i21gRD67UWNoBNnEepjkHytPw5CV1g2C07Y=;
	b=4Z/56yfASukOmIAr0vDtKMYRbhIfPkLaQ0za1K/KE/i7BAX4TXTYkgiEewFGKP+nLD64Nt
	eLUMp+c3NWE+djAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55AFE1379A;
	Thu, 14 Dec 2023 22:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9CiPAxaGe2XlKwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 14 Dec 2023 22:47:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Amir Goldstein" <amir73il@gmail.com>, "Dave Chinner" <david@fromorbit.com>,
 "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
 "David Howells" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <20231213-umgearbeitet-erdboden-c2fd5409034d@brauner>
References: <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>,
 <20231212-impfung-linden-6f973f2ade19@brauner>,
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>,
 <20231212-neudefinition-hingucken-785061b73237@brauner>,
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>,
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>,
 <170241761429.12910.13323799451396212981@noble.neil.brown.name>,
 <20231213-umgearbeitet-erdboden-c2fd5409034d@brauner>
Date: Fri, 15 Dec 2023 09:47:47 +1100
Message-id: <170259406740.12910.16837717665385509134@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mYx9TuMP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4Z/56yfA"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[szeredi.hu,linux.dev,gmail.com,fromorbit.com,molgen.mpg.de,vger.kernel.org,aei.mpg.de,redhat.com,toxicpanda.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 2D2411F7F6
X-Spam-Flag: NO

On Wed, 13 Dec 2023, Christian Brauner wrote:
> On Wed, Dec 13, 2023 at 08:46:54AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Miklos Szeredi wrote:
> > > On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.de=
v> wrote:
> > >=20
> > > > Other poeple have been finding ways to contribute to the technical
> > > > discussion; just calling things "ugly and broken" does not.
> > >=20
> > > Kent, calm down please.  We call things "ugly and broken" all the
> > > time.  That's just an opinion, you are free to argue it, and no need
> > > to take it personally.
> >=20
> > But maybe we shouldn't.  Maybe we should focus on saying what, exactly,
> > is unpleasant to look at and way.  Or what exactly causes poor
> > funcationality.
>=20
> I said it's "ugly" and I doubted it's value. I didn't call it "broken".
> And I've been supportive of the other parts. Yet everyone seems fine
> with having this spiral out of control to the point where I'm being
> called a dick.
>=20
> You hade a privat discussion on the bcachefs mailing list and it seems
> you expected to show up here with a complete interface that we just all
> pick up and merge even though this is a multi-year longstanding
> argument.

I thought I was still having that private discussion on the bcachefs
mailing list.  I didn't realise that fsdevel had been added.

NeilBrown


>=20
> I've been supportive of both the subvol addition to statx and the
> STATX_* flag to indicate a subvolume root. Yet somehow you're all
> extremely focussed on me disliking this flag.
>=20
> > "ugly" and "broken" are not particularly useful words in a technical
> > discussion.  I understand people want to use them, but they really need
> > to be backed up with details.  It is details that matter.
>=20
> I did say that I don't see the value. And it's perfectly ok for you to
> reiterate why it provides value. Your whole discussion has been private
> on some other mailing list without the relevant maintainers Cced.
>=20


