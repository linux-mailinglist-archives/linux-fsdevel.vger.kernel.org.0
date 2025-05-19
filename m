Return-Path: <linux-fsdevel+bounces-49467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24626ABCB5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 01:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA93F3BC2CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 23:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E1021FF46;
	Mon, 19 May 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="kNTOgLZb";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="r3IfHaT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C494431;
	Mon, 19 May 2025 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696765; cv=none; b=Mz3Kkd00XByGMVT5xPihliQDLDmgBHXVOMcNyYODPgH/jv6hOJKNTK1f+JnVu6JFedmLXyE6/JxDOt1IBrCtcKNd+s+h3a1CGG/tXu4g2wRKIp1Jfs5/E/queD4cxnjLyV/trkW6LHrFdgEetri7/xy9PjJCNyy2WHmcYFBvAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696765; c=relaxed/simple;
	bh=uOc3rJGUqvoDfcvK7y6BEGn2H8Bg5ffGSS9alrstSOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=QrHCLR2/ICXQuUHDHTELLyHT9bYWGFccjkXOYzetXSTKfxW3DSDbZ1wGRgkWAAZee5/eLut52Zse+EgoZY7bGJG2tc9dCHmlCrHjGjo4w3GutE4HVaPcTILFvE9NseNVp5F35kYCR2wvrdytUsIGhkadIZIxEemQ/J2ldl5scSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=kNTOgLZb; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=r3IfHaT6; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1747696760; x=1748363426; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=+H/y5PstxCGbCuwkDwY6FCDmHNVzyCl20zhQ0IE3Yyc=;
 b=kNTOgLZbfwc01t/KncqfXaIQaUO9q9/cDQzJTpZt+w+PwtIHL9x7CQbuKodbC3sxaYO4MsTt
  Ooa8n8ZiiLxjJCxUvSlettHZFQiu/17bXllqSi7ayQUHYQ6UmO94dzavJOQFFYTNjMqnA17aY6
  4bPHtfL02q6QkaPVHvwKOOrn53Exc4UZZaTWMU3K268cHLxoqgrTDifzpVxPET4fIKlc7HhQJG
  JmhVE2s4NAxjGYGODBWU0ILvGQ6m6sWNdmLgw8gBGeukqNLuPzcrb8E5QdbO+Lu/C6OjC12sPo
  2lRX2yiE+oUI7QBqN9RCFDQ+W7FozxyiIlvcjdHqxWPUd1HA==
DKIM-Signature: v=1; a=adaed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1747696760; x=1748363426; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  author:from:subject:date:to:cc:resent-author:resent-date:resent-from:
  resent-sender:resent-to:resent-cc:resent-reply-to:resent-message-id:
  in-reply-to:references:mime-version:content-type:
  content-transfer-encoding:content-disposition:content-id:
  content-description:message-id:mail-followup-to:openpgp:blahblahblah;
 bh=+H/y5PstxCGbCuwkDwY6FCDmHNVzyCl20zhQ0IE3Yyc=;
 b=r3IfHaT6btiHYDYwtYSTnz1cGLVDWdFA6gm+rR1/z4WJ8mtZdNJEVqe6anue9owmJ/trD++M
  pvulc5UDOw2CCg==
Date: Tue, 20 May 2025 01:19:19 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Alejandro Colomar <alx@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <20250519231919.StJ5Lkhr@steffen%sdaoden.eu>
In-Reply-To: <20250516124147.GB7158@mit.edu>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
 <20250516124147.GB7158@mit.edu>
Mail-Followup-To: "Theodore Ts'o" <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>, Alejandro Colomar <alx@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.25-653-gb160e2cb86
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Theodore Ts'o wrote in
 <20250516124147.GB7158@mit.edu>:
 |On Fri, May 16, 2025 at 12:48:56PM +0200, Jan Kara wrote:
 |>> Now, POSIX.1-2024 says:
 |>> 
 |>>  If close() is interrupted by a signal that is to be caught, then
 |>>  it is unspecified whether it returns -1 with errno set to
 |>>  [EINTR] and fildes remaining open, or returns -1 with errno set
 |>>  to [EINPROGRESS] and fildes being closed, or returns 0 to
 |>>  indicate successful completion; [...]
 |>> 
 |>> <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
 |>> 
 |>> Which seems to bless HP-UX and screw all the others, requiring them to
 |>> report EINPROGRESS.
 |>> 
 |>> Was there any discussion about what to do in the Linux kernel?
 |> 
 |> I'm not aware of any discussions but indeed we are returning EINTR while
 |> closing the fd. Frankly, changing the error code we return in that \
 |> case is
 |> really asking for userspace regressions so I'm of the opinion we just
 |> ignore the standard as in my opinion it goes against a long established
 |> reality.
 |
 |Yeah, it appears that the Austin Group has lost all connection with
 |reality, and we should treat POSIX 2024 accordingly.  Not breaking
 |userspace applications is way more important that POSIX 2024
 |compliance.  Which is sad, because I used to really care about POSIX.1
 |standard as being very useful.  But that seems to be no longer the
 |case...

They could not do otherwise than talking the status quo, i think.
They have explicitly added posix_close() which overcomes the
problem (for those operating systems which actually act like
that).  There is a long RATIONALE on this, it starts on page 747 :)

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

