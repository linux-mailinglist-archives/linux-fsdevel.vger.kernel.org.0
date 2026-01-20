Return-Path: <linux-fsdevel+bounces-74700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAb+ASzYb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:31:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3244A741
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4643B7A902F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D934D3BF;
	Tue, 20 Jan 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="b28UhvJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QoWUg9A/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5F34D3AA;
	Tue, 20 Jan 2026 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928778; cv=none; b=f1AyoKqPLza8tt2vQSBcqsXt85N0fB3WyO7k1/CJphQ+z++d3Hln1jqujUCl9BNFeIkQraG4mSGJV3CW+splGc/Fr2szQiWm232ZBVm29ATPz1kQ74qT1PgRPbU6MOZ6XyXPWPCYdUS8DFn7Deafn/h5vkAwugQQt1gzKwtXRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928778; c=relaxed/simple;
	bh=gQUn6VgMD2aVniL9VRjxy/FxzKf3Kxl5uh/tYUZlGdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SbrnUGRSPc8Me/c6UXrgynR1b997gy6biDwTHAgP9FPChGuE+gBePgQ7cofKzEET2HTsSG43KErwnZ0GA3yKHZTPS9+UZSQOcwu/QaXvXMmGap90AlEMsJ3lRfncnFZgXbfbR7aFMDZOIOndwFGiZq32H/AGH0ksyMMkyLjW+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=b28UhvJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QoWUg9A/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31AB0140012B;
	Tue, 20 Jan 2026 12:06:13 -0500 (EST)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 12:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768928773;
	 x=1769015173; bh=nAiW6WegsgPmLl1q3wuzftZ9jw7egh7KDiRbpWI6gOk=; b=
	b28UhvJ7RWijKq8NymkdFRxFys45388bX3GgfJFP9RjAKxI9tG9T/GHhlyeXEzmp
	gQUTFSUzSjtx1tM7oFx67GfYceub4Q/GqQoQKHCT84WYqAF2GJi408Dyw7MzXaEC
	A6K62g9c9wijO3hNZ9iAf/NuGCD0eBHAyx30UItt8IIsKXESWBszT95fL/vb5YSs
	4QzWmphqA/NmeYahEELgOng1q2MnXIiXty6os3bOxGDo3Ism9u8nosuEbS9FfD2m
	MOp9yyUHrTnxbqThQFFEdf6kGbH0w6E3/7mDf3B9gEC77a+wQlgfUYG97LmMybFk
	kTI0B/cQDTj9uHUM961ZGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768928773; x=
	1769015173; bh=nAiW6WegsgPmLl1q3wuzftZ9jw7egh7KDiRbpWI6gOk=; b=Q
	oWUg9A/WI8IDBLt7XyKJmdg3PNkNnGDgUNOT+JBtYA9gdG5pIwCZEJ8gle9puZXy
	l82nYIdZKgBCiWT7ncNzCMVlutX5OeNwJVzzH9JjAgdtVljII60SzzYp3bfEnuu9
	CUmccPdPzw2DKsBCkubEmiUu7MOt4gJctc24oGLdtEp6ByW1asVkcrhOjNvKURgm
	IYKQZXIWKaBTXEQ6cCF35iftqnAvoLRwxgt+0GVRwCmQxx47S+vx6LDP0ZxvKyV1
	wRDOLrXIAWuRCdEQtNK//3hRntsDM9pqV/e5xKRifx7SbHMuw4ZnNV7ewIEeWo1N
	gfgN213FD3mSY8vkDbdgw==
X-ME-Sender: <xms:BLZvaWlEHfyoJj6fmWMEhWtTbkQY-hYh0fO9h3eboiETJyxri1VcPQ>
    <xme:BLZvaYpKR54EseELv4SNHncY8_mb6qIEv3H1FZY8JlHGaG7BPgOj8Wa9z5nHvITMN
    z17y8EAlUk_ulFd48wCxerrIvX5IVr1XpYpP_RAh4YhJAHNd0K7UnXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhepheehgeejffeiieeigeetffdvgfefvdduieegkeejteeitddttdduhedt
    gfefkeffnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiigrtghksehofihlfhholhhi
    ohdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtph
    htthhopehlihgstgdqrghlphhhrgesshhouhhrtggvfigrrhgvrdhorhhgpdhrtghpthht
    ohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqrghpihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhinhgtvghnthesvhhinhgtud
    ejrdhnvghtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhu
    kh
X-ME-Proxy: <xmx:BLZvaWY6KDOvdpyNiyHobPUIh5r-lxMWfKzw9vkHXpNtjcaOJu1iHg>
    <xmx:BLZvaWxZvpL8_T-4NEHDHZVVXhLkPTqNtIyoPoCVMpVbIP5rs4DBNw>
    <xmx:BLZvaYSS9W8sK7AfiEH3IY8d-5W_N8E4-p7__4AXfU2nuDYUEDsq9w>
    <xmx:BLZvaTJjompQDStO2YC36OA0dp7SXDTMz-JAfBxMHPwKOsAHDPv_QQ>
    <xmx:BbZvaaQAkjhAFYAcHC3i5LaxK3N2Cjh_cRrY3h0DmfDsS0PCP7lBnI-W>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7683BC4006E; Tue, 20 Jan 2026 12:06:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANFeMez8yEXZ
Date: Tue, 20 Jan 2026 12:05:52 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Rich Felker" <dalias@libc.org>
Cc: "Alejandro Colomar" <alx@kernel.org>,
 "Vincent Lefevre" <vincent@vinc17.net>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
In-Reply-To: <20250524022416.GB6263@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[owlfolio.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DMARC_POLICY_ALLOW(0.00)[owlfolio.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74700-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[owlfolio.org:+,messagingengine.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack@owlfolio.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opengroup.org:url,owlfolio.org:dkim,messagingengine.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7A3244A741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
>>     close() always succeeds.  That is, after it returns, _fd_ has
>>     always been disconnected from the open file it formerly referred
>>     to, and its number can be recycled to refer to some other file.
>>     Furthermore, if _fd_ was the last reference to the underlying
>>     open file description, the resources associated with the open file
>>     description will always have been scheduled to be released.
...
>>     EINPROGRESS
>>     EINTR
>>            There are no delayed errors to report, but the kernel is
>>            still doing some clean-up work in the background.  This
>>            situation should be treated the same as if close() had
>>            returned zero.  Do not retry the close(), and do not report
>>            an error to the user.
>
> Since this behavior for EINTR is non-conforming (and even prior to the
> POSIX 2024 update, it was contrary to the general semantics for EINTR,
> that no non-ignoreable side-effects have taken place), it should be
> noted that it's Linux/glibc-specific.

I am prepared to take your word for it that POSIX says this is
non-conforming, but in that case, POSIX is wrong, and I will not be
convinced otherwise by any argument.  Operations that release a
resource must always succeed.

Now, the abstract correct behavior is secondary to the fact that we
know there are both systems where close should not be retried after
EINTR (Linux) and systems where the fd is still open after EINTR
(HP-UX).  But it is my position that *portable code* should assume the
Linux behavior, because that is the safest option.  If you assume the
HP-UX behavior on a machine that implements the Linux behavior, you
might close some unrelated file out from under yourself (probably but
not necessarily a different thread).  If you assume the Linux behavior
on a machine that implements the HP-UX behavior, you have leaked a
file descriptor; the worst things that can do are much less severe.

The only way to get it right all the time is to have a big long list
of #ifdefs for every Unix under the sun, and we don't even have the
data we would need to write that list.

> While I agree with all of this, I think the tone is way too
> proscriptive. The man pages are to document the behaviors, not tell
> people how to program.

I could be persuaded to tone it down a little but in this case I think
the man page's job *is* to tell people how to program.  We know lots of
existing code has gotten the fine details of close() wrong and we are
trying to document how to do it right.

> Aside: the reason EINTR *has to* be specified this way is that pthread
> cancellation is aligned with EINTR. If EINTR were defined to have
> closed the fd, then acting on cancellation during close would also
> have closed the fd, but the cancellation handler would have no way to
> distinguish this, leading to a situation where you're forced to either
> leak fds or introduce a double-close vuln.

The correct way to address this would be to make close() not be a
cancellation point.

> It sounds like you are intentionally omitting that POSIX says the
> opposite of what you want it to, and treating the standard behavior
> as a historical HP-UX quirk/bug. This is polemic, not the sort of
> documentation that belongs in a man page.

To be clear, when I wrote all this I thought the POSIX.1-2024 change
did in fact make the semantics be that close() closes the descriptor
no matter what it returns.

However, I insist that the correct behavior is in fact for close to
close the descriptor no matter what it returns, and to the extent
POSIX says anything else, POSIX is wrong.  Again, you cannot change
my mind about this.

N.B. I have skimmed the current text of
https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html
and it appears to me that the committee more or less agrees with me,
but wishes to avoid declaring HP-UX (and any other systems with the
same behavior) nonconformant.  So instead of just saying the fd is
closed no matter what, they've invented a new variant on close that
they have more scope to modify the behavior of, and they're nudging
implementations to not return EINTR from (posix_)close at all.

I don't think we (authors of this particular set of manpages) need to
care about the Austin Group's reluctance to declare existing legacy
systems nonconformant.

> An outline of what I'd like to see instead:
>
> - Clear explanation of why double-close is a serious bug that must
>   always be avoided. (I think we all agree on this.)
>
> - Statement that the historical Linux/glibc behavior and current POSIX
>   requirement differ, without language that tries to paint the POSIX
>   behavior as a HP-UX bug/quirk. Possibly citing real sources/history
>   of the issue (Austin Group tracker items 529, 614; maybe others).
>
> - Consequence of just assuming the Linux behavior (fd leaks on
>   conforming systems).
>
> - Consequences of assuming the POSIX behavior (double-close vulns on
>   GNU/Linux, maybe others).
>
> - Survey of methods for avoiding the problem (ways to preclude EINTR,
>   possibly ways to infer behavior, etc).

This outline seems more or less reasonable to me but, if it's me
writing the text, I _will_ characterize what POSIX currently says
about EINTR returns from close() as a bug in POSIX.  As far as I'm
concerned, that is a fact, not polemic.

I have found that arguing with you in particular, Rich, is generally
not worth the effort.  Therefore, unless you reply and _accept_ that
the final version of the close manpage will say that POSIX is buggy,
I am not going to write another version of this text, nor will I be
drawn into further debate.

zw

