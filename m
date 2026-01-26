Return-Path: <linux-fsdevel+bounces-75483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OvTFRCbd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:49:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F918AE9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3BC3027967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25B344D95;
	Mon, 26 Jan 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKliyaYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506D34405F;
	Mon, 26 Jan 2026 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445803; cv=none; b=CstaEWxpyMEtX03LBa0Y3gOR55juzVBKEgc68NGWlNyR6J4LnDRY4XEem2lHOkvQqKUiIck/PULuP+1BECxG5MLFzXv1FhsdPE1ELUWf258t/QbfeB9WUxNpZSLwCzQOrhbBKKBmxL7tfVJ9PZ0QAcakJpAYOtVC1GRCYTVEtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445803; c=relaxed/simple;
	bh=Djrf+cJzXQjlNmv5PYu7w8wCjREH3nuaFEicgxVzJDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGppe6SU57GEn0Hp9wivqUV9EHXIXLWJ0AehASj3YqXPlcbYKuZZu11dLGFhL1BvX27K27qETyMFzQwmkiDcMjq2PI+CYOOMkvDJfQJyOwt37yu5VdTLqsla7rXidHtxQpZ7/kgyGZwyUlxe3N9makYe6tbV37qqMM3+aJ2qh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKliyaYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1E5C116C6;
	Mon, 26 Jan 2026 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769445803;
	bh=Djrf+cJzXQjlNmv5PYu7w8wCjREH3nuaFEicgxVzJDo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gKliyaYwUvTlNh7gIK8mRy0qWNtcWaqmpBcmNF0NwbYdeqc18iV/Uz/j0ED5FvaL3
	 AYkmkhrY2R9VaKUOi6VljWTv4DPLbHbsumMGTrQWakReONKmTjyqd1NPp11/MzBn5e
	 wPrXWa5s/whOVfoRsc0sSQqpS20l2LofrcRZQ4HsMMOgAH/7oeec2QQwb+MRBtcc0+
	 xStpBqgYcJJnxCQIw8b9lduln7Kd+eI6ai5WpCKwLH/bpDFOZ4YOTtyHZqTjHGh/ge
	 /4Iw01C5+g/WkX0IcpFaZ+BdhzQJgGJbhldpXQUNX1Yonct//9VaZ7WY0W7F6B9t2b
	 f30LAhreq0fwQ==
Message-ID: <72100ec4b1ec0e77623bfdb927746dddc77ed116.camel@kernel.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, The 8472 <kernel@infinite-source.de>
Cc: Zack Weinberg <zack@owlfolio.org>, Rich Felker <dalias@libc.org>, 
 Alejandro Colomar	 <alx@kernel.org>, Vincent Lefevre <vincent@vinc17.net>,
 Alexander Viro	 <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, 	linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, GNU libc development	 <libc-alpha@sourceware.org>
Date: Mon, 26 Jan 2026 11:43:20 -0500
In-Reply-To: <pt7hcmgnzwveyzxdfpxtrmz2bt5tki5wosu3kkboil7bjrolyr@hd4ctkpzzqzi>
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
	TAGGED_FROM(0.00)[bounces-75483-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F918AE9B
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 16:56 +0100, Jan Kara wrote:
> On Mon 26-01-26 14:53:12, The 8472 wrote:
> > On 26/01/2026 13:15, Jan Kara wrote:
> > > On Sun 25-01-26 10:37:01, Zack Weinberg wrote:
> > > > On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
> > > > > >       [QUERY: Do delayed errors ever happen in any of these sit=
uations?
> > > > > >=20
> > > > > >          - The fd is not the last reference to the open file de=
scription
> > > > > >=20
> > > > > >          - The OFD was opened with O_RDONLY
> > > > > >=20
> > > > > >          - The OFD was opened with O_RDWR but has never actuall=
y
> > > > > >            been written to
> > > > > >=20
> > > > > >          - No data has been written to the OFD since the last c=
all to
> > > > > >            fsync() for that OFD
> > > > > >=20
> > > > > >          - No data has been written to the OFD since the last c=
all to
> > > > > >            fdatasync() for that OFD
> > > > > >=20
> > > > > >          If we can give some guidance about when people don=E2=
=80=99t need to
> > > > > >          worry about delayed errors, it would be helpful.]
> > > >=20
> > > > In particular, I really hope delayed errors *aren=E2=80=99t* ever r=
eported
> > > > when you close a file descriptor that *isn=E2=80=99t* the last refe=
rence
> > > > to its open file description, because the thread-safe way to close
> > > > stdout without losing write errors[2] depends on that not happening=
.
> > >=20
> > > So I've checked and in Linux ->flush callback for the file is called
> > > whenever you close a file descriptor (regardless whether there are ot=
her
> > > file descriptors pointing to the same file description) so it's upto
> > > filesystem implementation what it decides to do and which error it wi=
ll
> > > return... Checking the implementations e.g. FUSE and NFS *will* retur=
n
> > > delayed writeback errors on *first* descriptor close even if there ar=
e
> > > other still open descriptors for the description AFAICS.

...and I really wish they _didn't_.

Reporting a writeback error on close is not particularly useful. Most
filesystems don't require you to write back all data on a close(). A
successful close() on those just means that no error has happened yet.

Any application that cares about writeback errors needs to fsync(),
full stop.

> > Regarding the "first", does that mean the errors only get delivered onc=
e?
>=20
> I've added Jeff to CC who should be able to provide you with a more
> authoritative answer but AFAIK the answer is yes.
>=20
> E.g. NFS does:
>=20
> static int
> nfs_file_flush(struct file *file, fl_owner_t id)
> {
> ...
>         /* Flush writes to the server and return any errors */
>         since =3D filemap_sample_wb_err(file->f_mapping);
>         nfs_wb_all(inode);
>         return filemap_check_wb_err(file->f_mapping, since);
> }
>=20
> which will writeback all outstanding data on the first close and report
> error if it happened. Following close has nothing to flush and thus no
> error to report.
>=20
> That being said if you call fsync(2) you'll still get the error back agai=
n
> because fsync uses a separate writeback error counter in the file
> description. But again only the first fsync(2) will return the error.
> Following fsyncs will report no error.
>=20

Note that NFS is "special" in that it will flush data on close() in
order to maintain close-to-open cache consistency.

Technically, what nfs is doing above is sampling the errseq_t in the
mapping, and then writing back any dirty data, and then checking for
errors that happened since the sample. close() will only report
writeback errors that happened within that window. If a preexisting
writeback error occurred before "since" was sampled, then it won't
report that here...which is weird, and another good argument for not
reporting or checking for writeback errors at close().


> > I.e. if a concurrent fork/exec happens for process spawning and the
> > fork-child closes the file descriptors then this closing may basically
> > receive the errors and the parent will not see them (unless additional
> > errors happen)?
>=20
> Correct AFAICT.
>

It will see them if it calls fsync(). Reporting on close() is iffy.

> > Or if _any_ part of the program dups the descriptor and then closes it
> > without reporting errors then all uses of those descriptor must conside=
r
> > error delivery on close to be unreliable?
>=20
> Correct as well AFAICT.
>=20
> I should probably also add that traditional filesystems (classical local
> disk based filesystems) don't bother with reporting delayed errors on
> close(2) *at all*. So unless you call fsync(2) you will never learn there
> was any writeback error. After all for these filesystems there are good
> chances writeback didn't even start by the time you are calling close(2).
> So overall I'd say that error reporting from close(2) is so random and
> filesystem dependent that the errors are not worth paying attention to. I=
f
> you really care about data integrity (and thus writeback errors) you must
> call fsync(2) in which case the kernel provides at least somewhat
> consistent error reporting story.=20
>=20

+1.

tl;dr: the only useful error from close() is EBADF.
--=20
Jeff Layton <jlayton@kernel.org>

