Return-Path: <linux-fsdevel+bounces-75371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKL+AWtAdWlYCwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 22:58:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B87F196
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 22:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5526F300E39C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2152701CF;
	Sat, 24 Jan 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="PUDLW4l0";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="RHsybFpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D653EBF0C;
	Sat, 24 Jan 2026 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769291873; cv=pass; b=TNAu9nQ5p4eja0O0/XxWi//J787Ibb3b66DbKjgsKVbx81gpKealDm5/YAzSqSmbpMtcoDJzOsZRJmiVwFbc9YAlYt0fSxandIdhQNUyHrMKK+hN8y4Looud/Dd1PgeZkmRzDS9QfuYs48jcnacyVvviLH775INgMxpaKRTs/kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769291873; c=relaxed/simple;
	bh=28yKNY+NYBGVViR0FEqfyWNycyPBbProorV6cMFxCDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAY0cVzC3YMGQBPYym1t/wBBHABhGTjO0ajr7SA8ArPoK8BJTcIEz6/rQThaqHxZLbOUCKOi4NKEPFdhVGrDRXhTfmBLL0rbolwtJXWpbWyLJzCbejPf8gBobb52F/RWKxYBiuuYPe/ylBfrVWUWDc/o8ZIqrA50s4Pzf2wooh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=PUDLW4l0; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=RHsybFpv; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1769291858; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NakMbT9O7oy+tau+4mCmCBeBoQNuevHDgq9omZxNTtrHs5qFlbg5LCb+l04YGoaRGT
    HkiSgpyB800Lf3aDPmssWtawWrQz4/PKGRdsiktNac1q9c6juBXOs7XGEAJlQJ4aVcxE
    GYBRj3gdLPzPVFFrK4750x5lMVJW+9xF+JFWdGNmXhdYknUSKv/XjoZUXh1Hfp+sYu8F
    x9cOcqsSLbh7Lo99GstMEyHUEj+Li5aGP+vj7NNU9B8Jlla2dI954VXKUA0HOAoKIBSU
    0+B0Qo593xtEHQD08Y6HRhyOQdSJC8GKozLNB8XcUNnvb56s91DMQJuN6y+nPQkkcTG9
    EylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769291858;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+e9LbZFh0I9pMLnZwL9mt/V8UWOH237l3EWxsDj9KXo=;
    b=Jl4OcPJPoWb1x5cLwz2Ne3jbOBqbGxZtYrz4hpterUfcWqTYMn9605OX+kFuMbh//l
    C3s+v84xi3PAt7Lquwm9uGI8zsxy7Oz8VhlTX/gqqOkbja7IbCctckUapNohxW7mdhGP
    MEDTuPQ2YSSx+gJ4wTTi8eknoEt9YRJbwkzYD7dBF44QdutKlDzP20ajF0YkV59LQiCp
    ByuNao0G+bF7o1/KN5wfIMAjI9Q4Vt+zn6HSkTjzN11JAxVOjnZbK2wzJAEQc+5jK2qM
    dlpD3J6OPyZdsU9fK3LJgXUNA0o+pZmzmOmSv6SQMTR+CjI99fL0GAxkJhyvC4GduTaJ
    UnTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769291858;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+e9LbZFh0I9pMLnZwL9mt/V8UWOH237l3EWxsDj9KXo=;
    b=PUDLW4l0/2Hsioz2PwIQ+WlGN7zc1B91zxPwX0OjV6hIlVkfLhO/zRKD7FFdrFaR4S
    QAze5dwlvbFZRKUxNjkvuGpRgzG7qsbZCOG90dKAuFPegpS8GdgVyk+Nky5mdldfKBQq
    G1TT3jDt2193EoOsXjHSM99Cz7kWzLA6bVGA/ngQCzlUjWtssKgq0qkM3M/rqqayudKr
    yKSk3W6xtRZ96wCb7yxYXCfKdYYm53//1fxZogPcgeOZVTqRm8rNyZc2ULVmQ5oLFXzs
    g0joTaqPvkcQF+9pxs1yhNMsCKV+JYMS5nitVhPXAanajI6IPXLNfLpMQU+4mnyz/0Tx
    4yrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769291858;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+e9LbZFh0I9pMLnZwL9mt/V8UWOH237l3EWxsDj9KXo=;
    b=RHsybFpvAi4cBD7hHzKNjVo8uMoccy02OIXRBj9cnizHyI6FyqpVNblCo0NZPCBfEo
    /Mdxjx6rFquE8htI8PAw==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkR2kxTl8Z4is1DnAdcpsADTRHKai7ekfp4Nld"
Received: from [IPV6:2003:de:f721:6800:fd9d:517:52e9:f51c]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id 20d7db20OLvb65c
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 24 Jan 2026 22:57:37 +0100 (CET)
Message-ID: <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
Date: Sat, 24 Jan 2026 22:57:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
To: Rich Felker <dalias@libc.org>
Cc: Zack Weinberg <zack@owlfolio.org>, Alejandro Colomar <alx@kernel.org>,
 Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, GNU libc development <libc-alpha@sourceware.org>
References: <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx> <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
 <20260124213934.GI6263@brightrain.aerifal.cx>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <20260124213934.GI6263@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[infinite-source.de,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infinite-source.de:s=strato-dkim-0002,infinite-source.de:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infinite-source.de:+];
	TAGGED_FROM(0.00)[bounces-75371-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@infinite-source.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 728B87F196
X-Rspamd-Action: no action

On 24/01/2026 22:39, Rich Felker wrote:
> On Sat, Jan 24, 2026 at 08:34:01PM +0100, The 8472 wrote:
>> On 23/01/2026 01:33, Zack Weinberg wrote:
>>
>> [...]
>>
>>> ERRORS
>>>          EBADF  The fd argument was not a valid, open file descriptor.
>>
>> Unfortunately EBADF from FUSE is passed through unfiltered by the kernel
>> on close[0], that makes it more difficult to reliably detect bugs relating
>> to double-closes of file descriptors.
> 
> Wow, that's a nasty bug. Are the kernel folks not amenable to fixing
> it?

Not when I brought it up last time, no[0]

> I wonder if that could even have security implications. I think
> you could detect these fraudulent EBADFs (albeit not under conditions
> where there's a race bug) by performing fcntl/F_GETFD before close and
> knowing the EBADF from close is fake is fcntl didn't EBADF, but that
> seems like an unreasonable cost to work around FUSE behaving badly.
> 
> Rich

That's pretty much the workaround[1] we use, but due to the extra syscall it's
only done in debug builds.

[0] https://lore.kernel.org/linux-fsdevel/1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de/
[1] https://github.com/rust-lang/rust/blob/021fc25b7a48f6051bee1e1f06c7a277e4de1cc9/library/std/src/sys/fs/unix.rs#L981-L999

