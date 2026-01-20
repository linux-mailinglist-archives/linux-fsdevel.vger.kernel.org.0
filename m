Return-Path: <linux-fsdevel+bounces-74690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF0wFFC7b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:28:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C4848918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04E264C349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DAC3358B7;
	Tue, 20 Jan 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="dWMSNTMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIqcMaTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2363358B5;
	Tue, 20 Jan 2026 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925740; cv=none; b=rQxk+Lq5gdTPhbQJnIpvYtgihPVgJBS3Oz7gzs0RnwyQanSqBTjBIsyf9U8Bi3OdbrgFQU0ZfBJFPx0ULBKll5fDBScb0VSH+bdDrBswlMgD7bTP6Yp5j0jJcwEFsby/t+TBbVUR2t/E+TJJzdzyBcZPJhmUliPV84RKgBIUHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925740; c=relaxed/simple;
	bh=0qTFGHTWPQ23b0mBSiFZ940V3ZP2w0PXN6e0fjrDBZQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o61ymgzn1BSwmBJwmcthhgPlqAE4r5rkk3rSpSn4CNsBvEd5Ppy96qjqvySCSD5HzmwWughd+VUZWf4RTGDpiIgzAUkKTKUyWZS7UT9bX4hSspI/RY6fKy9L3TSWHtTJc6J/D0M954zBRGPzLhaPzmsXrrmXnu8pmxBFRaORRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=dWMSNTMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIqcMaTq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE0981400082;
	Tue, 20 Jan 2026 11:15:36 -0500 (EST)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 11:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768925736;
	 x=1769012136; bh=GU1drl9GZahcBOIBWcTf4xeUqRMoqHT4H9pPPAY3MqU=; b=
	dWMSNTMuwE0WMBjsh8PYgzdEciRp8tbPUb4o1pM1HcsRJK4yeI7cK8giygoFb8bf
	vyeL8CM4uRcY7rxtuR/jyJJr46aS5oLjRPOqcYiiKRmUroNE5IJQMvHY34liiMV1
	Z9ESB14fyK6U/USFITQI6CjfsVG5YteSWSKR7F5/scRXANvLHuKHSdLNdkTeP8SO
	H2Il7CpczUBxzZPdZSzBjuJFobwCfM8NygPOeHBcNUQP/nELNjXPuXUc83ozrPKu
	5M9NgVx21OLo1CR7w0ucwzMO1T4aphond4T2gyANcLYkPWkW8nGTZeKo/Krz9ngH
	QkDFUQ72OscZPDFtszemFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768925736; x=
	1769012136; bh=GU1drl9GZahcBOIBWcTf4xeUqRMoqHT4H9pPPAY3MqU=; b=U
	IqcMaTq/hG8YFVYFlU+GgkrZTiJw3/AvMzF22fKvwNJuDHFiCx9m/KteYSq1w1S8
	Yj6p4s44BoTGiZi4haekQvdsLef9Ljnk/npTFn+YleIGgykXyNwdwu0qcjJBKqq/
	z6MqYgREud3oZ6z4qFcf+LWs8tErDjekSnPcAzT1Guuw6Crv4W/YB/UTkkcLaRP6
	96sYoyIj9DaLCUrnD7vwUbIqUudD8AIwrlfhovW4u/MDT1Suzo0k5krCbIdOLIyj
	7Lr/iuNzhUSat3zjpbvaYJ5l9dI77S+zI6EqLumdMFiLEAstRHp4f0t7qpzVl4ky
	MO2zCJ5fEpHmOgAu+J6qw==
X-ME-Sender: <xms:J6pvaUi8iI6FkdtW8_53fE4jpXW6V4EfE2Pj2EeY7Jqxa5x-SnyN4w>
    <xme:J6pvaX2uT2ceM7qMKXGz3zihge653gdENXiVXSX6ZI8q6bh5O9Y3S47uHjo-BJ4iC
    dr1XlDUd0d2gXhZk4UdSOhKrm8r1XgtVOCx7lDNX-jb8LGigm44Xxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhepueeugfefleeuteejveejffelteehudegffetveevteeihefgueelveek
    tdegiefgnecuffhomhgrihhnpegrlhgvjhgrnhgurhhoqdgtohhlohhmrghrrdgvshenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggtkhes
    ohiflhhfohhlihhordhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegrlhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgr
    uhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghlihgrsheslhhisggtrd
    horhhgpdhrtghpthhtoheplhhisggtqdgrlhhphhgrsehsohhurhgtvgifrghrvgdrohhr
    ghdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqd
    grphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhntggvnh
    htsehvihhntgdujedrnhgvthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhu
    gidrohhrghdruhhk
X-ME-Proxy: <xmx:J6pvaQBomNTSWkT63mVXjVisUuNSnxtiHw6wsqwopswD_hqxmXOXqA>
    <xmx:J6pvaVlJyYLUGx9eOQ1hswSTPJtyzTdUcLUL9rhaeTS0Nxwror-qZw>
    <xmx:J6pvaeMIxK-JdtVtgM-SmZiNl8WFrqFh0PEPWvfgKW36ZN6PtkPvDw>
    <xmx:J6pvaS8yutroK14YT86M2PG1AkqonHqotkPuGVdF5lFSKDne4Jy3Hg>
    <xmx:KKpvaV8zxeJ8L9rn87X-tpEZsoB9VFpuAY8S9Qgbu_gjHWKrTqIWtuFD>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9E3A8C4006F; Tue, 20 Jan 2026 11:15:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANFeMez8yEXZ
Date: Tue, 20 Jan 2026 11:15:15 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Alejandro Colomar" <alx@kernel.org>
Cc: "Rich Felker" <dalias@libc.org>, "Vincent Lefevre" <vincent@vinc17.net>,
 "Jan Kara" <jack@suse.cz>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <60c77e5c-dbab-4cca-8d0d-9857875c73fb@app.fastmail.com>
In-Reply-To: <aW1dE9j91WAte1gf@devuan>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <aW1dE9j91WAte1gf@devuan>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[owlfolio.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DMARC_POLICY_ALLOW(0.00)[owlfolio.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74690-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[owlfolio.org:+,messagingengine.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack@owlfolio.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alejandro-colomar.es:url,messagingengine.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,app.fastmail.com:mid,owlfolio.org:dkim]
X-Rspamd-Queue-Id: B1C4848918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rich and I have an irreconciliable disagreement on what the semantics of=
 close
_should_ be.  I'm not going to do any more work on this until/unless he
changes his mind.

On Sun, Jan 18, 2026, at 5:23 PM, Alejandro Colomar wrote:
> Hi Zack and others,
>
> Just a gentle ping.  It would be nice to have an agreement for some
> patch.
>
>
> Have a lovely night!
> Alex
>
> On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
>> Taking everything said in this thread into account, I have attempted =
to
>> wordsmith new language for the close(2) manpage.  Please let me know
>> what you think, and please help me with the bits marked in square
>> brackets. I can make this into a proper patch for the manpages
>> when everyone is happy with it.
>>=20
>> zw
>>=20
>> ---
>>=20
>> DESCRIPTION
>>     ... existing text ...
>>=20
>>     close() always succeeds.  That is, after it returns, _fd_ has
>>     always been disconnected from the open file it formerly referred
>>     to, and its number can be recycled to refer to some other file.
>>     Furthermore, if _fd_ was the last reference to the underlying
>>     open file description, the resources associated with the open file
>>     description will always have been scheduled to be released.
>>=20
>>     However, close may report _delayed errors_ from a previous I/O
>>     operation.  Therefore, its return value should not be ignored.
>>=20
>> RETURN VALUE
>>     close() returns zero if there are no delayed errors to report,
>>     or -1 if there _might_ be delayed errors.
>>=20
>>     When close() returns -1, check _errno_ to see what the situation
>>     actually is.  Most, but not all, _errno_ codes indicate a delayed
>>     I/O error that should be reported to the user.  See ERRORS and
>>     NOTES for more detail.
>>=20
>>     [QUERY: Is it ever possible to get delayed errors on close() from
>>     a file that was opened with O_RDONLY?  What about a file that was
>>     opened with O_RDWR but never actually written to?  If people only
>>     have to worry about delayed errors if the file was actually
>>     written to, we should say so at this point.
>>=20
>>     It would also be good to mention whether it is possible to get a
>>     delayed error on close() even if a previous call to fsync() or
>>     fdatasync() succeeded and there haven=E2=80=99t been any more wri=
tes to
>>     that file *description* (not necessarily via the fd being closed)
>>     since.]
>>=20
>> ERRORS
>>     EBADF  _fd_ wasn=E2=80=99t open in the first place, or is outside=
 the
>>            valid numeric range for file descriptors.
>>=20
>>     EINPROGRESS
>>     EINTR
>>            There are no delayed errors to report, but the kernel is
>>            still doing some clean-up work in the background.  This
>>            situation should be treated the same as if close() had
>>            returned zero.  Do not retry the close(), and do not report
>>            an error to the user.
>>=20
>>     EDQUOT
>>     EFBIG
>>     EIO
>>     ENOSPC
>>            These are the most common errno codes associated with
>>            delayed I/O errors.  They should be treated as a hard
>>            failure to write to the file that was formerly associated
>>            with _fd_, the same as if an earlier write(2) had failed
>>            with one of these codes.  The file has still been closed!
>>            Do not retry the close().  But do report an error to the u=
ser.
>>=20
>>     Depending on the underlying file, close() may return other errno
>>     codes; these should generally also be treated as delayed I/O erro=
rs.
>>=20
>> NOTES
>>   Dealing with error returns from close()
>>=20
>>     As discussed above, close() always closes the file.  Except when
>>     errno is set to EBADF, EINPROGRESS, or EINTR, an error return from
>>     close() reports a _delayed I/O error_ from a previous write()
>>     operation.
>>=20
>>     It is vital to report delayed I/O errors to the user; failing to
>>     check the return value of close() can cause _silent_ loss of data.
>>     The most common situations where this actually happens involve
>>     networked filesystems, where, in the name of throughput, write()
>>     often returns success before the server has actually confirmed a
>>     successful write.
>>=20
>>     However, it is also vital to understand that _no matter what_
>>     close() returns, and _no matter what_ it sets errno to, when it
>>     returns, _the file descriptor passed to close() has been closed_,
>>     and its number is _immediately_ available for reuse by open(2),
>>     dup(2), etc.  Therefore, one should never retry a close(), not
>>     even if it set errno to a value that normally indicates the
>>     operation needs to be retried (e.g. EINTR).  Retrying a close()
>>     is a serious bug, particularly in a multithreaded program; if
>>     the file descriptor number has already been reused, _that file_
>>     will get closed out from under whatever other thread opened it.
>>=20
>>     [Possibly something about fsync/fdatasync here?]
>>=20
>> BUGS
>>     Prior to POSIX.1-2024, there was no official guarantee that
>>     close() would always close the file descriptor, even on error.
>>     Linux has always closed the file descriptor, even on error,
>>     but other implementations might not have.
>>=20
>>     The only such implementation we have heard of is HP-UX; at least
>>     some versions of HP-UX=E2=80=99s man page for close() said it sho=
uld be
>>     retried if it returned -1 with errno set to EINTR.  (If you know
>>     exactly which versions of HP-UX are affected, or of any other
>>     Unix where close() doesn=E2=80=99t always close the file descript=
or,
>>     please contact us about it.)
>>=20
>>     Portable code should nonetheless never retry a failed close(); the
>>     consequences of a file descriptor leak are far less dangerous than
>>     the consequences of closing a file out from under another thread.
>
> --=20
> <https://www.alejandro-colomar.es>
>
> Attachments:
> * signature.asc

