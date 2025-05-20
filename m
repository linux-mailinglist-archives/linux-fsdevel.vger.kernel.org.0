Return-Path: <linux-fsdevel+bounces-49506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1804ABD99D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D577AEB86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765C242922;
	Tue, 20 May 2025 13:37:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B92417F9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748253; cv=none; b=J9OQdWFtB2zRusa/lT9EXVhKeX9F4XE84CNqAaKJBJGpWxH4bl2OruafNWiPhjmtSS2IZ55wjHtwqp5AHUJAH/S6rLjvp0N+n+r6OTwew39OMY9H52F7ARnvd8sTKz2zNPdhbvGHcVDqinNMXww/sK9Qqt6nQissAvliKVQ1ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748253; c=relaxed/simple;
	bh=fSnSLiYqCdQ7A9wT/UOlfvfKhp3yUneMp34qkc5CXSo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYFUy8ex3fOL+g8ptVRAbISS/uNh9dn3NUnOTWY8ONCh34R4NmBfdLlrzMNK3yxSwbLDvSy1ivxMjHoEFWAEbRG44zK9V7XyuCTH4t3lpI6S3h/J4jGwVvJZHgWzNi31+624oVVlAYXGfAsl59GSedzzXQCZeS6uYUPgy5wP9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KDb5jq026157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:37:06 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CB56E2E00DD; Tue, 20 May 2025 09:37:05 -0400 (EDT)
Date: Tue, 20 May 2025 09:37:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>, Alejandro Colomar <alx@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <20250520133705.GE38098@mit.edu>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
 <20250516124147.GB7158@mit.edu>
 <20250519231919.StJ5Lkhr@steffen%sdaoden.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519231919.StJ5Lkhr@steffen%sdaoden.eu>

On Tue, May 20, 2025 at 01:19:19AM +0200, Steffen Nurpmeso wrote:
> 
> They could not do otherwise than talking the status quo, i think.
> They have explicitly added posix_close() which overcomes the
> problem (for those operating systems which actually act like
> that).  There is a long RATIONALE on this, it starts on page 747 :)

They could have just added posix_close() which provided well-defined
semantics without demanding that existing implementations make
non-backwards compatible changes to close(2).  Personally, while they
were adding posix_close(2) they could have also fixed the disaster
which is the semantics around close(2) and how advisory locks get
released that were held by other file descriptors and add a profound
apologies over the insane semantics demanded by POSIX[1].

[1] "POSIX advisory locks are broken by design."
    https://www.sqlite.org/src/artifact/c230a7a24?ln=994-1081

					- Ted

