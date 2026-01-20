Return-Path: <linux-fsdevel+bounces-74708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLSnIqnrb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:55:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03D4BCF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8762FA88E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73444CF4F;
	Tue, 20 Jan 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLFyp0GD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1D3D300A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934407; cv=none; b=B/uSP6aod2l9jlnRr7gIy8sQNOlVt9c7aDWLlOHq7gLq6qzC2vwyAAGRW38F+jd93OOSph3dKoUOxJr9voPPSOkUPylqqeyqpID+YIzKmopOzUKuIzqYCyLyCX+TX5+Y2C87OYupCHc2Jsz3Ud+Bd4nxX+Vkg/46AIzuudPpmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934407; c=relaxed/simple;
	bh=Zza830QDX7/YH0isvrNuprKo3OcbbOJ78ALBKZafhTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pd1IaqG4miyu2o2J3d/oJjM41PAKtI3vgsv/S3l4FdVO0fc2HBTwcCwT/pPSXaH4IBi0Bm0fK52NemubTSD9jdw70+K9S5v3EeLEfRtukM+2XylXCw93XPfvaD66jrhtHBm4LOWXBi79WmcOE1jlVELqffv8s1qMyegq5ze2WB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLFyp0GD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768934403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THjQFFSV3DJfvlnHS0Up529R6QYEj32SFVau+c8Z0ts=;
	b=eLFyp0GDB0TuumpjLWyTG5QvpptP19nQ7lXrzzoLgCse3IXsi1dLF3iycPLJ2i56xFqXhX
	vvHayjLCUDTDCnh5w3dYQqOYYlsc2r9/rP0tlsfH5OQdRHLAerBbmJfMKh/YpaAE48xrZP
	wBQ4EEmc68H8/u8Y+deufCsMUxwFgK0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-nV3Res_uPBqUvVJ875JxXw-1; Tue,
 20 Jan 2026 13:39:58 -0500
X-MC-Unique: nV3Res_uPBqUvVJ875JxXw-1
X-Mimecast-MFC-AGG-ID: nV3Res_uPBqUvVJ875JxXw_1768934396
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1B3A18005B0;
	Tue, 20 Jan 2026 18:39:55 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BA631800577;
	Tue, 20 Jan 2026 18:39:51 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Rich Felker <dalias@libc.org>
Cc: Zack Weinberg <zack@owlfolio.org>,  Alejandro Colomar <alx@kernel.org>,
  Vincent Lefevre <vincent@vinc17.net>,  Jan Kara <jack@suse.cz>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-api@vger.kernel.org,  GNU libc development
 <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
In-Reply-To: <20260120174659.GE6263@brightrain.aerifal.cx> (Rich Felker's
	message of "Tue, 20 Jan 2026 12:46:59 -0500")
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
	<efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
	<20250516130547.GV1509@brightrain.aerifal.cx>
	<20250516143957.GB5388@qaa.vinc17.org>
	<20250517133251.GY1509@brightrain.aerifal.cx>
	<5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
	<8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
	<20250524022416.GB6263@brightrain.aerifal.cx>
	<1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
	<20260120174659.GE6263@brightrain.aerifal.cx>
Date: Tue, 20 Jan 2026 19:39:48 +0100
Message-ID: <lhubjio5dsb.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74708-lists,linux-fsdevel=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oldenburg.str.redhat.com:mid]
X-Rspamd-Queue-Id: EE03D4BCF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

* Rich Felker:

> On Tue, Jan 20, 2026 at 12:05:52PM -0500, Zack Weinberg wrote:
>> > On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
>> >>     close() always succeeds.  That is, after it returns, _fd_ has
>> >>     always been disconnected from the open file it formerly referred
>> >>     to, and its number can be recycled to refer to some other file.
>> >>     Furthermore, if _fd_ was the last reference to the underlying
>> >>     open file description, the resources associated with the open file
>> >>     description will always have been scheduled to be released.
>> ...
>> >>     EINPROGRESS
>> >>     EINTR
>> >>            There are no delayed errors to report, but the kernel is
>> >>            still doing some clean-up work in the background.  This
>> >>            situation should be treated the same as if close() had
>> >>            returned zero.  Do not retry the close(), and do not report
>> >>            an error to the user.
>> >
>> > Since this behavior for EINTR is non-conforming (and even prior to the
>> > POSIX 2024 update, it was contrary to the general semantics for EINTR,
>> > that no non-ignoreable side-effects have taken place), it should be
>> > noted that it's Linux/glibc-specific.
>> 
>> I am prepared to take your word for it that POSIX says this is
>> non-conforming, but in that case, POSIX is wrong, and I will not be
>> convinced otherwise by any argument.  Operations that release a
>> resource must always succeed.
>
> There are two conflicting requirements here:
>
> 1. Operations that release a resource must always succeed.
> 2. Failure with EINTR must not not have side effects.
>
> The right conclusion is that operations that release resources must
> not be able to fail with EINTR. And that's how POSIX should have
> resolved the situation -- by getting rid of support for the silly
> legacy synchronous-tape-drive-rewinding behavior of close on some
> systems, and requiring close to succeed immediately with no waiting
> for anything.

What about SO_LINGER?  Isn't this relevant in context?

As far as I know, there is no other way besides SO_LINGER to get
notification if the packet buffers are actually gone.  If you don't use
it, memory can pile up in the kernel without the application's
knowledge.

Thanks,
Florian


