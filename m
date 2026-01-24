Return-Path: <linux-fsdevel+bounces-75364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHw5H8YedWkaBAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:34:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9B7EBB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DFB30107FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E826D4DF;
	Sat, 24 Jan 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="IzeIonma";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="6tX2Uf5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDC21D3D2;
	Sat, 24 Jan 2026 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769283261; cv=pass; b=k95tKkYomDSe0h4AqVRfbLF4uWJ5W4K0ALe2Z+QxXlNO8B/RX7NNW5wTKZPRb3+Zgw7YvrAkBaAzCmku9SbAuRvxkag6CgzXOSno9sXX1nAc2lb3nHix+KH8femnwPjhNtcHywdNbn//K/cigMLo3gyj5hC1ferEyc10ao5rR88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769283261; c=relaxed/simple;
	bh=Ww6B8s6vvcxfak6xZvlSPOhqiUz5oYN9P2FrKyMSwZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMmGG5k4OIsd4kvtau3amLL0+KTD16DMcwAb0cynhGHqaPD/trhLyWA8nzL9zK1wv10TphSxZqOabx1g4aSBLGyLp4FhtPzx8ZGVKA14V2a0XiCAsW1l/5Jm0PpHOoqaE7WshT6ItibsTE8AVIQg59ilQ5PFlDcRW0RTmEACGLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=IzeIonma; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=6tX2Uf5P; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1769283247; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cOvOTykKMtFhkq2TE6z8nJvfvLk4jKCvMD2caoGQZ4jtz9XOcPEkwNK+lQFViQOtLC
    7PhEhJ8ITe792G/94b/Spn3Z94FNKV9oNqOq2d4jtPeYq8e2yGn6IRmu3bo+jpqn9GX5
    tIlL0AUwM0qRxabrcy7LFm6g2bTu7rId18oKRv04dg4rMDuVbJFGVGHqF4Kl24mBnMML
    8OBCl58sL2Z8JvS1r6wTAgRa9ITZkv4yLWhNMhQPAMJoByVrEza88Rfn3HMiGqgkuzjm
    24ICq8l/hCr6q+eaeO8Vhlbx0hcxlz22IQ/mPYjIKpsnZMc3vjeJWaOZAOqgXLZFWVKB
    jc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769283247;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=P18DiHWT3Gr6TAsHR2Rq3B52pRRYC8gJRxRr6a3FGsA=;
    b=lv7z1FFtEMjE/i472EvXslLrmJri89esZ/CyOLaZB+CeaYLjuz0qfpcUHJlskOtq6n
    Gb4rUacotzFcIA32NNltrzhmOebcq4YmJJptrTlryXGwBrV249Wax7l6UYJVsqDWIIbf
    YmGLAi6kGOQs6oXC+yWYvSt2KZITOr6e+cAk5EpOMqIyu6Co075Lp7sqTDj2aqL+e66+
    sXt9TotZYPK5F0xh3zKq0itq/PQ6zNG9g8slMCWASYzaQssqFz9p3W2NSZmYrxiSxUNL
    3lkZriBhnJ1qJDF7qB54n4SWdFSPsfoXm37/i2ALge5XmY9dCFeIBVi6IUVTE+gx/52c
    +p0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769283247;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=P18DiHWT3Gr6TAsHR2Rq3B52pRRYC8gJRxRr6a3FGsA=;
    b=IzeIonmad2qrtHDVOObIL9Vinsh0Huk+pJHDDZWSOuA8Q1ntCGA/AGFVvHcaK5r0Bj
    k0yPQWEPnZAzgnYbymBly1GfJZUFIX+xXk51vyOvyH5E2Jrh7w9+l3HtFH3yj+4j89DZ
    u39DIVH/twPWdDbYGEaGpFI5//p2m/taiXeXriZozlaXc4zKSnmXuP9sHgZf+WEvXdFi
    4skhbmZoFkXYwDKwfXftIFxnBT7DA6jTyNxMoaanMJWNNSEPQf4SE3Uy9X07PhU9gkwf
    70iBvU9E/jgxHU+ZNN090P14utXLmOxjXUhvMQcnDGUGlaTo3ZC4FtPhw3jiVcnFJeKA
    e0Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769283247;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=P18DiHWT3Gr6TAsHR2Rq3B52pRRYC8gJRxRr6a3FGsA=;
    b=6tX2Uf5PTjWgaqYVHItSbLjibCd4HzxJQy4piV2JpH3ypNSbMyfRuZW5a6yZuRKD70
    wBukMXBw7yMItIUbZNAA==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkR2kxTl8Z4itmUnxMb6cJkSw+o9KUqW8cqdTmgQ=="
Received: from [IPV6:2003:de:f721:6800:5855:2641:744d:5026]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id 20d7db20OJY75w9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 24 Jan 2026 20:34:07 +0100 (CET)
Message-ID: <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
Date: Sat, 24 Jan 2026 20:34:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
To: Zack Weinberg <zack@owlfolio.org>, Alejandro Colomar <alx@kernel.org>
Cc: Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Rich Felker <dalias@libc.org>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 GNU libc development <libc-alpha@sourceware.org>
References: <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx> <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[infinite-source.de,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infinite-source.de:s=strato-dkim-0002,infinite-source.de:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75364-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infinite-source.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@infinite-source.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9E9B7EBB0
X-Rspamd-Action: no action

On 23/01/2026 01:33, Zack Weinberg wrote:

[...]

> ERRORS
>         EBADF  The fd argument was not a valid, open file descriptor.

Unfortunately EBADF from FUSE is passed through unfiltered by the kernel
on close[0], that makes it more difficult to reliably detect bugs relating
to double-closes of file descriptors.

[...]

>     Delayed errors reported by close()
> 
>         In a variety of situations, most notably when writing to a file
>         that is hosted on a network file server, write(2) operations may
>         “optimistically” return successfully as soon as the write has
>         been queued for processing.
> 
>         close(2) waits for confirmation that *most* of the processing
>         for previous writes to a file has been completed, and reports
>         any errors that the earlier write() calls *would have* reported,
>         if they hadn’t returned optimistically.  Especially, close()
>         will report “disk full” (ENOSPC) and “disk quota exceeded”
>         (EDQUOT) errors that write() didn’t wait for.
> 
>         (To wait for *all* processing to complete, it is necessary to
>         use fsync(2) as well.)
> 
>         Because of these delayed errors, it’s important to check the
>         return value of close() and handle any errors it reports.
>         Ignoring delayed errors can cause silent loss of data.
> 
>         However, when handling delayed errors, keep in mind that the
>         close() call should *not* be repeated.  When close() has a
>         delayed error to report, it still closes the file before
>         returning.  The file descriptor number might already have been
>         reused for some other file, especially in multithreaded
>         programs.  To make another attempt at the failed writes, it’s
>         necessary to reopen the file and start all over again.
> 
>      [QUERY: Do delayed errors ever happen in any of these situations?
> 
>         - The fd is not the last reference to the open file description
> 
>         - The OFD was opened with O_RDONLY
> 
>         - The OFD was opened with O_RDWR but has never actually
>           been written to
> 
>         - No data has been written to the OFD since the last call to
>           fsync() for that OFD
> 
>         - No data has been written to the OFD since the last call to
>           fdatasync() for that OFD
> 
>         If we can give some guidance about when people don’t need to
>         worry about delayed errors, it would be helpful.]
> 

The Rust standard library team is also interested in this topic, there
is lively discussion[1] whether it makes sense to surface errors from
close at all. Our current default is to ignore them.
It is my understanding that errors may not have happened yet at
the time of close due to delayed writeback or additional descriptors
pointing to the description, e.g. in a forked child, and thus
close() is not a reliable mechanism for error detection and
fsync() is the only available option.

Some users do care specifically about the unusual behavior
on NFS, and don't want to use a heavy hammer like fsync. It's unfortunate
that there's no middle ground to get errors on an open file descriptor
or initiate the NFS flush behavior without a full fsync.


[0] https://lore.kernel.org/linux-fsdevel/1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de/
[1] https://github.com/rust-lang/libs-team/issues/705


