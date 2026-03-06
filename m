Return-Path: <linux-fsdevel+bounces-79626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G9sNWrrqmmOYAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:57:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DA2232EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4DB8303E4AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2933ACEFA;
	Fri,  6 Mar 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGREv9Gw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53C3A9DAD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808962; cv=none; b=QQIw5oxSeIN6lGlPS/rKhaUgWZOsIZt2VjPbie0pEDcvpQm8mDv1hSrMyFShvhxSLdWvG8kE6+iA2EaaneHpV7KD7bh/sVQ7lkodX8Y5udEeD9Fp9elq/+iMsQplzMiD+MFo+NuXCr4VZnwzwFzcdq577QSUnMEPmXLEcBgvwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808962; c=relaxed/simple;
	bh=aVl5Zkfm845Up2tgXtaQ2s3MGIl6I7L20/OprGe/lPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJsnE58Ox3Zbek57OyQENQIulHOXIoKEw1Rhb4Vj/7jNUT01rlDdEw0j2l7vHdVONArR+usaMP7wX3EUuHSinFb0igdQ7TRAcZ65JIW1F1GX2eVGcXakHSF04tOGZQn9+MgWjWpUPEzivnb4as9tObfvzIDxMMEDKxfGR7oeOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGREv9Gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2892C2BC86
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772808961;
	bh=aVl5Zkfm845Up2tgXtaQ2s3MGIl6I7L20/OprGe/lPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WGREv9GwfThV+pV2iYhUXMspe/zxG5mWI4JGmDVtozXtrPgwibteqvjv2I6MJ/S1F
	 XzhHmsU604WkQqgAeMg7ziOdqEKTAM7lClLj3w3G1TbKMAV8IH5bPProqTy9veg5Fm
	 jBEEfYUsILavm1Vr51lyHygPNpD7TaL1nbM4bqGAvEXcqqnjgsD9nSobAY+M2rUAS0
	 qjqrIUNx/imyIRSNErAqe0fN7Yfp7KTtgm22ZBbumQBzACA55rJgUwfObcWWLfQ8lT
	 BWurO46v7AA8iBWKbv1WXAz0+87d8TtbUWfxhHvbvTsrSPkntN/y/GE8ineqchZhaC
	 URS7VDRnmWO5g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-660d2e48383so6370840a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 06:56:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDIgSgKa9WwqyPM+TD3IkepcyEPhFGOnn0uVI4a3lvTw0BvDDEmkuLkYyJRXZRfgRwGIbtRZw0NHgWkQu+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/r/9M4RMldxBZRiPJXn7yQugAOd+X1YagSnh3SrLti41PMb8
	Eo8fyTOmNhsKBmGHn8BkWlgIeA0zLwosyB4SXmu85mg77i/ZI25Ho7O1hLZqbmIe+4d3q1GDf+1
	RXPaaQGe2nQBugEsD1OPAFZmugr+Jciw=
X-Received: by 2002:a17:907:6e8a:b0:b88:716a:e4ae with SMTP id
 a640c23a62f3a-b942dfc9f67mr151533566b.61.1772808960280; Fri, 06 Mar 2026
 06:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1e2690efeb8570651894567d80511144424fb5e.1772106022.git.fdmanana@suse.com>
 <aarmPHmLnGtvhUcO@infradead.org>
In-Reply-To: <aarmPHmLnGtvhUcO@infradead.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 6 Mar 2026 14:55:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5r5_FuTSUM_5TqFGFPSZ4qC=qG49_JuLpUfzFCa=8YyQ@mail.gmail.com>
X-Gm-Features: AaiRm50HXeNGzp7FTrY-MoS_w-nAVvy1G-S0F27vExRZn5JtgIaSagVqKWJ-LRM
Message-ID: <CAL3q7H5r5_FuTSUM_5TqFGFPSZ4qC=qG49_JuLpUfzFCa=8YyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test create a bunch of files with name hash collision
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 554DA2232EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79626-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 2:35=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Feb 26, 2026 at 02:34:37PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we create a high number of files with a name that results =
in
> > a hash collision, the filesystem is not turned to RO due to a transacti=
on
> > abort. This could be exploited by malicious users to disrupt a system.
>
> Umm, file systems must handle an unlimited number of name collisions.
> While going read-only is of course really bad, just rejecting them
> can also pretty easily break things.

I don't think in practice we get a large enough number of names with a
crc32c hash collision in btrfs.
Never heard yet of any users reporting problems with that.

The fix related to this test is more to prevent a bad intentioned user
from turning the fs into read-only mode (this is actually a regression
introduced a few years ago).

Adding support for an unlimited number of collisions is simply not
easily doable, it would require an on-disk format change (new key
type, item, etc, update btrfs-progs, etc).
The motivation for that is very low, as I'm not aware of users ever complai=
ning.

>
> Also it seems like part of this test is generic, and only the subvolume
> creation part is btrfs-specific?

Specifying a 4K leaf size at mkfs, all the comments, and verifying
that we can't create a file beyond the limit, are also btrfs specific.

>

