Return-Path: <linux-fsdevel+bounces-77829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H0vbGp7cmGnBNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:13:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D147016B213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 948403011C6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065830F931;
	Fri, 20 Feb 2026 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRtCWix5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7D189F30
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625627; cv=pass; b=hTBuxbCR6h7vxP/tcUgVKbt4rcKOyobF08XCrKpo2M70R4EeeV0AFCjiMY/zWlrefTPqkU5wJulfUFiqMt2E2H6Q14+bHiqvLuY41WmfMImj6hFYOjCn39cXnTiJ9t5zoeS63AETyV0xwQ6XQ4E9aDkptw1qoko+6gA6muRaUBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625627; c=relaxed/simple;
	bh=aQQaRPkF9Af/HxAveUVH8+CWYJecFixMOYAW5ajrekU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6dl7mqIgAcrG2JZVEuJhXO8vDmZFbOcYTjpUChPjXQzg3LdxGq7UrDUWemE0MhOYkSzOz0JMTqD7xqixw5nVzocWBbRWiFyuoptJJyHhvSPAHYwK+Wl7xCe7YY69vDu4223s4zDK0Wudmn+J7N7/sQDYJp255oOGvqHXHDSbnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRtCWix5; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb38e6d164so284924285a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 14:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625625; cv=none;
        d=google.com; s=arc-20240605;
        b=YG4VEVMIRfS1ehiimlRViaT8aDR8YO1GOCtCCEFBfWrMFz03OhnfhediQnqu/VR9Xp
         YyiWx8dnN/GBL0lJfhvvWSYsZL4n/Ql8kFWnryoDIpmnIfIL/Fvywu0njmanMTYgxWQY
         AQKshLTVKlKmtlbAvhftpyW7fkhAaAX+VwPCCfkINYvT39HXdWKmhgwhG5NYJoQpario
         iOFxT5JrG/nf+GCvQYgFv6H+vTWTsmhlDwg12VZkpQcWv+gUA/CBF/RZuogxok/MpQhS
         v6BxIPk1zXwbC4Hnpbk5gyIySE1arQlQtmKSmMN4DhG3cfSWH2MaLq2DwflLN8ZM5mq7
         Tm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkF+JLqSPjbmD4HGif44J1WystlNFJ5Sq67bNUlrgK0=;
        fh=/8clLXfgzSifzie0twlOsNGT5gzZgLu/nC6SRI5Ga+Q=;
        b=d5weNl4obkI+3js06f09VXb4ww3Es0BPS8IxpTFjvy5zcNTPRUpI+nTpvDbFW7FcvB
         5fSnzcN6mI984WDZK+Cekzltgt3EUsuNN2ovcUQcyqt6BMUnUr0bGVpE9OyX407d3imH
         I81ZE/wBIrVqpb2uWgggPF5GinnV/mOaHUi4/EpQ+IFYI+ON3/BarGZM4VKjsRyfqrmt
         hrqOkNXfCUFotqeOJV13Dza9Hg7RP1uBI5HV37P+qWnZYJ+UKC0IgeKfd+AOK5aMDOla
         zJr8ZXfvJyzpua9TzG1rh8KtPE4hrr2P5ubSPo3340Dmt/JQbyoGUC4wNlxXgbZElpzv
         H1Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771625625; x=1772230425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkF+JLqSPjbmD4HGif44J1WystlNFJ5Sq67bNUlrgK0=;
        b=FRtCWix5Dezwdef0F4X+bpn/XAlUtPWrJ5B4lNkWjWFYNvncwQAc6g22vU8Lmzt7sR
         wAbIKnjMrr0UhlFExkqKC/cNj1qIw8VgLwPeHcFJM6M8EFZaE2NFvuWufzzFb4X42MWs
         Vzt8kCR3phWgUSAaTzNIEwQZVYN3p8eUYuTTB29jGuR1B+IC26fSGINv2yzbbQqHutxu
         3bvJRbuYyfbAFJZrbBR1hx2ewISLq9lEcNmCyiyGwNGjbBLCmvZxepNyPRYP084i57xe
         M4mrrKynnbbmdPu3rhihVt8cME61AOt6JldvRV3h7cOT14BYxDNa4K+aj+N3gfCM2RF3
         nffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625625; x=1772230425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkF+JLqSPjbmD4HGif44J1WystlNFJ5Sq67bNUlrgK0=;
        b=dj24AnPwuF7Drra8EsXaURGueStzu+YxpOFLs+swSWsoySFuW30euzupWWG8edo+dH
         VMnxHe/zKZx3GfHAHJppdUzgd/v7zhpwThW/LAoJ1p05Og5LA5NZW7rD1v/YhaTlL4+D
         4P3tJfiwus++1VK5XyN4VEguQbp+ShC6FLPjykCxClBl1zJ7hCV1zMfSyIPGZQWA9zHe
         jz07qTz4lFDasc6jPMwd65j4KHRJNxhjttdMwM+2yuCfZ8el/g4pttYmj5rBbFBzjGBs
         6DcFZM0aJ2LuhRxO406XbUKvWUP1MhcwroiV+c2+5GVKucgnKXz08C/EB+2QTITq9dkw
         xnPw==
X-Forwarded-Encrypted: i=1; AJvYcCW+84gMD3h5sZIoXeYQDHTt4dsLt8t/Yzoa+FyFxhntmcn/x4mOik1JOH5AOwOFARglxsjD/SwS+wqmgHBx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6M4u5+VN5kqMlkydTrAunxZ+H4kbgvE74ldy+5N/6/ONL45n6
	EIpA+Rle0eB4alsC00hkRmSnHy+ZbNhPL0jutYqMqsz8+Hv3/kkYQ3TNJmaEfj8tc6oMj6JKRrM
	yN8Y4gx4d+nCbaT34A7a3D9dnzaBdOIvlrVAW
X-Gm-Gg: AZuq6aJL8G1lfaQyyO5ii9Ar0YUgJB9AttxDvZo7xUo0O5ivYHYMaUdEqSm0ZgGJbM3
	NVe+JBotYUaf+Srn2rULgv9AWJxxTw2GTqFxejciR+QlS2jHoPKEFfE1IECf6XHSVIRvJHpabfx
	AssILL6++21s9Pj8opQ16baK2Fr5Ktey0d6VqnWrsm5qZNZUetdVGhjEtv5UEkG+mRF0LasoLQm
	vIjMtTWLpqtAfxd0lk420C1zYwORectEIr0w2WCu1A4SEWdtyLtb6HD1ZKLQViLpxwOh2I/RGBv
	89g8wg==
X-Received: by 2002:a05:620a:7086:b0:8b2:767c:31ab with SMTP id
 af79cd13be357-8cb8ca8a72bmr142401685a.60.1771625625046; Fri, 20 Feb 2026
 14:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com> <20260219024534.GN6467@frogsfrogsfrogs>
 <aZaQO0jQaZXakwOA@casper.infradead.org> <20260219061101.GO6467@frogsfrogsfrogs>
In-Reply-To: <20260219061101.GO6467@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Feb 2026 14:13:34 -0800
X-Gm-Features: AaiRm51fIgZJr3LfwRj8TzR0aj5YKHoVvqDiiKe8jQ_aQkC_kZmqLcnmAZ2vUDA
Message-ID: <CAJnrk1aJJqafDkxMypUym6iFQ-HkaSxneOe6Sc746AwrmrDK4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, wegao@suse.com, 
	sashal@kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77829-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D147016B213
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:11=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Thu, Feb 19, 2026 at 04:23:23AM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 18, 2026 at 06:45:34PM -0800, Darrick J. Wong wrote:
> > > On Wed, Feb 18, 2026 at 04:39:11PM -0800, Joanne Koong wrote:
> > > > If a folio has ifs metadata attached to it and the folio is partial=
ly
> > > > read in through an async IO helper with the rest of it then being r=
ead
> > > > in through post-EOF zeroing or as inline data, and the helper
> > > > successfully finishes the read first, then post-EOF zeroing / readi=
ng
> > > > inline will mark the folio as uptodate in iomap_set_range_uptodate(=
).
> > > >
> > > > This is a problem because when the read completion path later calls
> > > > iomap_read_end(), it will call folio_end_read(), which sets the upt=
odate
> > > > bit using XOR semantics. Calling folio_end_read() on a folio that w=
as
> > > > already marked uptodate clears the uptodate bit.
> > >
> > > Aha, I wondered if that xor thing was going to come back to bite us.
> >
> > This isn't "the xor thing has come back to bite us".  This is "the ioma=
p
> > code is now too complicated and I cannot figure out how to explain to
> > Joanne that there's really a simple way to do this".
> >
> > I'm going to have to set aside my current projects and redo the iomap
> > readahead/read_folio code myself, aren't I?
>
> Well you could try explaining to me what that simpler way is?
>
> /me gets the sense he's missing a discussion somewhere...

This is the link to the prior discussion
https://lore.kernel.org/linux-fsdevel/20251223223018.3295372-1-sashal@kerne=
l.org/T/#mbd61eaa5fd1e8922caa479720232628e39b8c9da

Thanks,
Joanne
>
> --D

