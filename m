Return-Path: <linux-fsdevel+bounces-75556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LO3N6ELeGllngEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:49:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3E8E8A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D229C301BCFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78291C862E;
	Tue, 27 Jan 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcVtDr/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B133B2BA;
	Tue, 27 Jan 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769474971; cv=none; b=kjdH6MaAIPNMUXFVhtyC17rzOmPYe6LS8KmDEzo7bp1EBBn98D4WyYftokipoYCuZeK6pDnDTkbQSUwEUJ5xvPCVLeOeEMt0gFtOdc/hkLP3jb9xtgGVofiRgL+UxpCumsUNalAy635BMvsQovSO9xtjeE0M4caiwk8PdnJwLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769474971; c=relaxed/simple;
	bh=YxPRChELy5zFQlHPCSp/HP6hX6wcOkeilJU/ZU2JF6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VH/n+Pfyjd36Ka5NYMI8vPk9LQ7LFwDnV9JkHCvzFvUbWiBqSaB96vaMeLxny9XCr47M3Qo5NcQgFxxYoXss7XpzUhlKfdSZeZRmw74nTVxJpJWtDNARX6eU8ObaAg0tsdLolrnLXd6kYmCAqgeNhlLiM2UIzkmU1odRwE1FkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcVtDr/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA89FC116C6;
	Tue, 27 Jan 2026 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769474971;
	bh=YxPRChELy5zFQlHPCSp/HP6hX6wcOkeilJU/ZU2JF6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OcVtDr/qj2olVgPGFRtCcZwaOehVSAOJ3a3KspOklSaiLtOMhtKc2ZwfsrrYQJ4GL
	 wk7Wxwga3PXJknSqt5LNs/FAxoqHX51RICx8n8Bp0LLG1gD9L0WjpIe16CjyXBMiPS
	 hzquXAiT5gtJ9zr39MIk0+/9CqDErUSzVC0fx7UDQIWeGVr6VK9FobSWoazW92ZZTH
	 T4z6UaYaTOKpeiZIX9IHTdTobcF/T16FevALVKKGTljJlWaIkb/IBIWLvkcxBXEQc4
	 e0dpn2hYZhPYK3OBOcJw/dE7o4jRph3fH3lo4OuXZH1nyKiSlnSku/uOM8GzR0kCMm
	 ob+ARstMY0KLw==
Message-ID: <2d6276fca349357f56733268681424b0de5179f7.camel@kernel.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
From: Jeff Layton <jlayton@kernel.org>
To: Trevor Gross <tmgross@umich.edu>, Jan Kara <jack@suse.cz>, The 8472
	 <kernel@infinite-source.de>
Cc: Zack Weinberg <zack@owlfolio.org>, Rich Felker <dalias@libc.org>, 
 Alejandro Colomar	 <alx@kernel.org>, Vincent Lefevre <vincent@vinc17.net>,
 Alexander Viro	 <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, 	linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, GNU libc development	 <libc-alpha@sourceware.org>
Date: Mon, 26 Jan 2026 19:49:28 -0500
In-Reply-To: <DFYW8O4499ZS.2L1ABA5T5XFF2@umich.edu>
References: <20260120174659.GE6263@brightrain.aerifal.cx>
	 <aW_jz7nucPBjhu0C@devuan> <aW_olRn5s1lbbjdH@devuan>
	 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
	 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
	 <20260124213934.GI6263@brightrain.aerifal.cx>
	 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
	 <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
	 <whaocgx6bopndbpag2wazn2ko4skxl4pe6owbavj3wblxjps4s@ntdfvzwggxv3>
	 <c59361e4-ad50-4cdf-888e-3d9a4aa6f69b@infinite-source.de>
	 <pt7hcmgnzwveyzxdfpxtrmz2bt5tki5wosu3kkboil7bjrolyr@hd4ctkpzzqzi>
	 <72100ec4b1ec0e77623bfdb927746dddc77ed116.camel@kernel.org>
	 <DFYW8O4499ZS.2L1ABA5T5XFF2@umich.edu>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75556-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B3E8E8A4
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 17:01 -0600, Trevor Gross wrote:
> On Mon Jan 26, 2026 at 10:43 AM CST, Jeff Layton wrote:
> > On Mon, 2026-01-26 at 16:56 +0100, Jan Kara wrote:
> > > On Mon 26-01-26 14:53:12, The 8472 wrote:
> > > > On 26/01/2026 13:15, Jan Kara wrote:
> > > > > On Sun 25-01-26 10:37:01, Zack Weinberg wrote:
> > > > > > On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
> > > > > > > >       [QUERY: Do delayed errors ever happen in any of these=
 situations?
> > > > > > > >=20
> > > > > > > >          - The fd is not the last reference to the open fil=
e description
> > > > > > > >=20
> > > > > > > >          - The OFD was opened with O_RDONLY
> > > > > > > >=20
> > > > > > > >          - The OFD was opened with O_RDWR but has never act=
ually
> > > > > > > >            been written to
> > > > > > > >=20
> > > > > > > >          - No data has been written to the OFD since the la=
st call to
> > > > > > > >            fsync() for that OFD
> > > > > > > >=20
> > > > > > > >          - No data has been written to the OFD since the la=
st call to
> > > > > > > >            fdatasync() for that OFD
> > > > > > > >=20
> > > > > > > >          If we can give some guidance about when people don=
=E2=80=99t need to
> > > > > > > >          worry about delayed errors, it would be helpful.]
> > > > > >=20
> > > > > > In particular, I really hope delayed errors *aren=E2=80=99t* ev=
er reported
> > > > > > when you close a file descriptor that *isn=E2=80=99t* the last =
reference
> > > > > > to its open file description, because the thread-safe way to cl=
ose
> > > > > > stdout without losing write errors[2] depends on that not happe=
ning.
> > > > >=20
> > > > > So I've checked and in Linux ->flush callback for the file is cal=
led
> > > > > whenever you close a file descriptor (regardless whether there ar=
e other
> > > > > file descriptors pointing to the same file description) so it's u=
pto
> > > > > filesystem implementation what it decides to do and which error i=
t will
> > > > > return... Checking the implementations e.g. FUSE and NFS *will* r=
eturn
> > > > > delayed writeback errors on *first* descriptor close even if ther=
e are
> > > > > other still open descriptors for the description AFAICS.
> >=20
> > ...and I really wish they _didn't_.
> >=20
> > Reporting a writeback error on close is not particularly useful. Most
> > filesystems don't require you to write back all data on a close(). A
> > successful close() on those just means that no error has happened yet.
> >=20
> > Any application that cares about writeback errors needs to fsync(),
> > full stop.
>=20
> Is there a good middle ground solution here?
>=20
> It seems reasonable that an application may want to have different
> handling for errors expected during normal operation, such as temporary
> network failure with NFS, compared to more catastrophic things like
> failure to write to disk. The reason cited around [1] for avoiding fsync
> is that it comes with a cost that, for many applications, may not be
> worth it unless you are dealing with NFS.
>=20
> I was wondering if it could be worth a new fnctl that provides this kind
> of "best effort" error checking behavior without having the strict
> requirements of fsync. In effect, to report the errors that you might
> currently get at close() before actually calling close() and losing the
> fd.
>=20

For a long-held fd, I can see the appeal: spray writes at it and just
check occasionally (without blocking) that nothing has gone wrong.
Maybe when things are idle, you fsync().

A new fcntl(..., F_CHECKERR, ...) command that does a
file_check_and_advance_wb_err() on the fd and reports the result would
be pretty straightforward.

Would that be helpful for your use-case? This would be like a non-
blocking fsync that just reports whether an error has occurred since
the last F_CHECKERR or fsync().

> Alternatively, it would be interesting to have a deferred fsync() that
> schedules a nonblocking sync event that can be polled for completion/
> errors, with flags to indicate immediate sync or allow automatic syncing
> as needed. But there is probably a better alternative to this
> complexity.
>=20
> [1]: https://github.com/rust-lang/libs-team/issues/705


Aside from the polling, I suppose you could effectively do this with
io_uring. I'm pretty sure you can issue an fsync() or sync_file_range()
that way, but I think it just ends up blocking a kernel thread until
writeback is done.

We've had people ask for a non-blocking fsync before. Maybe it's time
to get serious about adding one. What would such a thing look like?

It would be pretty simple to add a new fcntl(..., F_DATAWRITE) command
that kicks off writeback a'la filemap_fdatawrite().

Then add fcntl(..., F_WB_CHECK):

That could do a non-blocking version of filemap_fdatawait(), and return
whether any folios are still under writeback. If there is a writeback
error, it can return that instead.

The catch of course is that a polling mechanism like this could easily
livelock. If there is a lot of memory pressure, it might always return
that something is still under writeback, no matter how often you hammer
F_CHECKERR.

Maybe that's ok? You can always issue a blocking fsync() if you really
need to know draw a line in the sand.
--=20
Jeff Layton <jlayton@kernel.org>

