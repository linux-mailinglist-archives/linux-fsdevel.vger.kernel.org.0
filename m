Return-Path: <linux-fsdevel+bounces-78813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u9J1F++jomne4gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:14:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76291C1576
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D271304EA88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD13D649D;
	Sat, 28 Feb 2026 08:14:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B926E6FA;
	Sat, 28 Feb 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772266471; cv=none; b=BYgUZp3K7B+6zdkMzokzkiWWwJc71F6jmoVZ/MKr+sHwUY98xGkP7ywvwA2zeJbxK8JcGm1Sb8UfyOEH1o3cRnUjMZ0VMSjZci9xEgpSgnBa2luIBn8F7G8fdpaTs5o8ptMrre2vR1IdAcUJ9cfPmYYlS9bPaEHC+fYAZDus45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772266471; c=relaxed/simple;
	bh=V1W9NcUjEZhMLBLwwnXFVTT8TKXnLNRLDRN89DKiQJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnLV5ac3ag31kQDGQ/BsE6MQaKDXtczRQb+yq+wYck1Ui5BFvw5rSyBKcsgRx6L27UOGwUdlNgTjymvjQhrHq80/T9tPo+Rf5a+/M+0V9ZdMPJ/GRKViXmS6vYbsz9dlU7ko6qcz6WBAl+WmoeEp55mFAJT35pRP8ntwpi0fi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id 85C11E024E;
	Sat, 28 Feb 2026 09:14:19 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sat, 28 Feb 2026 09:14:18 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v6 3/3] fuse: add an implementation of
 open+getattr
Message-ID: <aaKiWhdfLqF0qI3w@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box>
 <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78813-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.de:email,birthelmer.com:email]
X-Rspamd-Queue-Id: A76291C1576
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:07:20AM -0800, Joanne Koong wrote:
> On Fri, Feb 27, 2026 at 9:51 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Thu, Feb 26, 2026 at 11:48 PM Horst Birthelmer <horst@birthelmer.de> wrote:
> > >
> > > On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> > > > On Thu, Feb 26, 2026 at 8:43 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> > > > >
> > > > > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > > > >
> > > > > The discussion about compound commands in fuse was
> > > > > started over an argument to add a new operation that
> > > > > will open a file and return its attributes in the same operation.
> > > > >
> > > > > Here is a demonstration of that use case with compound commands.
> > > > >
> > > > > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > > > > ---
> > > > >  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--------
> > > > >  fs/fuse/fuse_i.h |   4 +-
> > > > >  fs/fuse/ioctl.c  |   2 +-
> > > > >  3 files changed, 99 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > > index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241bdf727e00a2bc714f35 100644
> > > > > --- a/fs/fuse/file.c
> > > > > +++ b/fs/fuse/file.c
> > > > >  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> > > > > -                                unsigned int open_flags, bool isdir)
> > > > > +                               struct inode *inode,
> > > >
> > > > As I understand it, now every open() is a opengetattr() (except for
> > > > the ioctl path) but is this the desired behavior? for example if there
> > > > was a previous FUSE_LOOKUP that was just done, doesn't this mean
> > > > there's no getattr that's needed since the lookup refreshed the attrs?
> > > > or if the server has reasonable entry_valid and attr_valid timeouts,
> > > > multiple opens() of the same file would only need to send FUSE_OPEN
> > > > and not the FUSE_GETATTR, no?
> > >
> > > So your concern is, that we send too many requests?
> > > If the fuse server implwments the compound that is not the case.
> > >
> >
> > My concern is that we're adding unnecessary overhead for every open
> > when in most cases, the attributes are already uptodate. I don't think
> > we can assume that the server always has attributes locally cached, so
> > imo the extra getattr is nontrivial (eg might require having to
> > stat()).
> 
> Looking at where the attribute valid time gets set... it looks like
> this gets stored in fi->i_time (as per
> fuse_change_attributes_common()), so maybe it's better to only send
> the compound open+getattr if time_before64(fi->i_time,
> get_jiffies_64()) is true, otherwise only the open is needed. This
> doesn't solve the O_APPEND data corruption bug seen in [1] but imo
> this would be a more preferable way of doing it.
> 
Don't take this as an objection. I'm looking for arguments, since my defense
was always the line I used above (if the fuse server implements the compound,
it's one call).

What made you change your mind from avoiding the data corruption to worry 
about the number of stat calls done? Since you were the one reporting the
issue and even providing a fix.

ATM I would rather have data consistency than fewer requests during open.

> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20240813212149.1909627-1-joannelkoong@gmail.com/
> 
> >
> > Thanks,
> > Joanne
> 

