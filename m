Return-Path: <linux-fsdevel+bounces-76691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EwDH5WpiWnfAQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 10:32:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAB10D945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 10:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E544300647B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5234405C;
	Mon,  9 Feb 2026 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU38W9dG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9A17D2;
	Mon,  9 Feb 2026 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629519; cv=none; b=DXx7h/6l5f3STZKKSTVb/oia4eGoPhBl+3+KeY5e1PiwGFP3gzLV9kWel/e8gASQww6AXvj8u99sHUYzm9UzKxaLeF/wDotcgXFrXWy94z9B8XL6pmnt/p58GETq6zKh2ZuL1En9lW0DBgVrVJEcmHEKAn4RrXMUcPpEVDuf/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629519; c=relaxed/simple;
	bh=b+4YxUOdAFGl+k3bEmZfIQ3+L9nXb/JcUHKxaOg+jTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz7RmTqfybBAzV4qMq74q0drarxVae0XnW2mhFvVulG1lxrH9YPenwfW4PsxXfjR5Drm1zUiPyMMLHE9d+wa5lhby6nr/ZsI+4UTGhI+3RXZ+NX1pi6+jFW5uOl3l59VGJZrKcL8M3h6YS17zzBNwp1Y3LRBR+dWlU/ZNjzDR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU38W9dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0616C116C6;
	Mon,  9 Feb 2026 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629519;
	bh=b+4YxUOdAFGl+k3bEmZfIQ3+L9nXb/JcUHKxaOg+jTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IU38W9dG8ucUpns9ALdMOU8cnsibRNaig6LYlW76drYzJY5WUFBFBYEnQEkxRv2MZ
	 Hb7gJfBMEvNtR3memi+pjspxLE3jm/KJhxJEDLnHUcw5lk2iSLRogHMPBJNjO3WAcD
	 YYKOjH/KaW7M2hyQWbGLc+BCIBtIkYsEh1CcJYlU2XhYqnq9gIyFGnHisAYC7edQm6
	 EAeEXnsTd9q4pISlm1I1vIMNWK21GDLO1IUdTix1DmDKiIj3P8csm3KEhLDb63kjOb
	 fnjsXgeO/iZhVcvKsOc1TghY6wYlv9XLt2sz3QlkKf3uk0MQyQvxaSwLM/IoOhVvCI
	 h512ABRo3xbRg==
Date: Mon, 9 Feb 2026 10:31:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 12/12 for v7.0] vfs misc
Message-ID: <20260209-dienen-datei-f29959f187d9@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
 <20260206-vfs-misc-v70-be6f713f9fa9@brauner>
 <20260207051114.GA2289557@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260207051114.GA2289557@ax162>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76691-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25BAB10D945
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:11:14PM -0600, Nathan Chancellor wrote:
> On Fri, Feb 06, 2026 at 05:50:08PM +0100, Christian Brauner wrote:
> > David Laight (1):
> >       fs: use min() or umin() instead of min_t()
> 
> This needs a fix up for 32-bit builds:
> 
>   https://lore.kernel.org/20260113192243.73983-1-david.laight.linux@gmail.com/
> 
>   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig fs/fuse/file.o
>   In file included from <command-line>:
>   In function 'fuse_wr_pages',
>       inlined from 'fuse_perform_write' at fs/fuse/file.c:1347:27:
>   include/linux/compiler_types.h:705:45: error: call to '__compiletime_assert_508' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
>     705 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>         |                                             ^
>   include/linux/compiler_types.h:686:25: note: in definition of macro '__compiletime_assert'
>     686 |                         prefix ## suffix();                             \
>         |                         ^~~~~~
>   include/linux/compiler_types.h:705:9: note: in expansion of macro '_compiletime_assert'
>     705 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>         |         ^~~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>         |                                     ^~~~~~~~~~~~~~~~~~
>   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
>         |         ^~~~~~~~~~~~~~~~
>   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
>      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>         |         ^~~~~~~~~~~~~~~~~~
>   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
>     105 | #define min(x, y)       __careful_cmp(min, x, y)
>         |                         ^~~~~~~~~~~~~
>   fs/fuse/file.c:1326:16: note: in expansion of macro 'min'
>    1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
>         |                ^~~
> 
> David sent another patch before that one (though it does not look like
> you were explicitly sent that one). Arnd also sent one.
> 
>   https://lore.kernel.org/20251216141647.13911-1-david.laight.linux@gmail.com/
>   https://lore.kernel.org/20251223215442.720828-1-arnd@kernel.org/

Huh, I didn't not see the mails and they're from 23rd December. Maybe
they got lost during the holidays. Sorry about that. Thanks for
reporting this. Linus, would you mind applying:

https://lore.kernel.org/all/20251223215442.720828-1-arnd@kernel.org

directly? Otherwise I can reassemble the pull request and resend. Let me
know what you prefer.

