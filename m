Return-Path: <linux-fsdevel+bounces-54764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A723B02C6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 20:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD423A4807
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10A288CAF;
	Sat, 12 Jul 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTKGZei/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3611442E8;
	Sat, 12 Jul 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344784; cv=none; b=WX93NWdoXdQdiCBYsUXaBX3bRcu/DMsWKc7x/7fEoOMyS5J8WSqDEF9NrBXqmQIvlOoxZVtDKaVD5vGBrf+DzcTT0oQ2CQgR0zxtz4fE+XuYkcRy0gMsWh3GThW+cvfmNyDNfSOrKB4o8FLfQlgMSrjV6fdin0ZNUS9SV6uK9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344784; c=relaxed/simple;
	bh=dVHOVLobbxpJBiobMxxxyDbFXWxu0ncpCUVo+d4Jgys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxXyI6SyaaVqUJlZVLksn1r/Bs56OL2cJIWVF2/7gzmZj1lfgql8/SgJh0dV4iDX8xr3KbkZPvqTNQwZxTt/TsGMo2aRSxRlTwsDAYdZDyC4WwB7vGpQc9u+o7+M09gF2++xwgsQSUJIOm37mLXrpqAdVqpq9JANBfiT1IxXSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTKGZei/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A94C4CEEF;
	Sat, 12 Jul 2025 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344784;
	bh=dVHOVLobbxpJBiobMxxxyDbFXWxu0ncpCUVo+d4Jgys=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rTKGZei/AFGwW6fNmpxPvM258M3yFq21CpyDLqheql+XbVzOeLNG3dUY2UrKpG8HF
	 /DlXSPFhX7LJPacLyh3hVyfhPEIvKUKVe1IQenvpLq6mU3lJh0dz+/bv+My9j/gjyt
	 3FBUzenfutXM7ZiRnBa4c9IvN7fuoS79vu5J5mshiJY3qOQ4cDxtFaPrKiyrYbVYi9
	 pDIaMZ+1YmO9EdeSxcdgWdiyyVyEY8JtqnI+bjSbuyi4KEvh3zSc4sGti05RMLGHlw
	 ZuGXoBZgKVXPZ8Fp6wva6A+rSGvo6Bxgoft7ZR1wkiuChkdzJ4Mkwos5uV4tO6PnQh
	 5jAWr7qY4oipg==
Message-ID: <b9b74600-4467-4c76-aa41-0a36b1cce1f4@kernel.org>
Date: Sat, 12 Jul 2025 20:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: Vlastimil Babka <vbabka@suse.cz>, Matthias Maennich
 <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 16.05, Vlastimil Babka wrote:
> Christoph suggested that the explicit _GPL_ can be dropped from the
> module namespace export macro, as it's intended for in-tree modules
> only. It would be possible to resrict it technically, but it was pointed
> out [2] that some cases of using an out-of-tree build of an in-tree
> module with the same name are legitimate. But in that case those also
> have to be GPL anyway so it's unnecessary to spell it out.
> 
> Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
> Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Shivank Garg <shivankg@amd.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
> part to avoid controversy converting selected existing EXPORT_SYMBOL().
> Christoph argued [2] that the _FOR_MODULES() export is intended for
> in-tree modules and thus GPL is implied anyway and can be simply dropped
> from the export macro name. Peter agreed [3] about the intention for
> in-tree modules only, although nothing currently enforces it.
> 
> It seemed straightforward to add this enforcement, so v1 did that. But
> there were concerns of breaking the (apparently legitimate) usecases of
> loading an updated/development out of tree built version of an in-tree
> module.
> 
> So leave out the enforcement part and just drop the _GPL_ from the
> export macro name and so we're left with EXPORT_SYMBOL_FOR_MODULES()
> only. Any in-tree module used in an out-of-tree way will have to be GPL
> anyway by definition.
> 
> Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
> in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
> 8250: export RSA functions"). Hopefully it's resolvable by a merge
> commit fixup and we don't need to provide a temporary alias.
> 
> [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
> [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
> [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
> ---
> Changes in v2:
> - drop the patch to restrict module namespace export for in-tree modules
> - fix a pre-existing documentation typo (Nicolas Schier)
> - Link to v1: https://patch.msgid.link/20250708-export_modules-v1-0-fbf7a282d23f@suse.cz
> ---
>  Documentation/core-api/symbol-namespaces.rst | 8 ++++----
>  fs/anon_inodes.c                             | 2 +-
>  include/linux/export.h                       | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
> index 32fc73dc5529e8844c2ce2580987155bcd13cd09..6f7f4f47d43cdeb3b5008c795d254ca2661d39a6 100644
> --- a/Documentation/core-api/symbol-namespaces.rst
> +++ b/Documentation/core-api/symbol-namespaces.rst
> @@ -76,8 +76,8 @@ A second option to define the default namespace is directly in the compilation
>  within the corresponding compilation unit before the #include for
>  <linux/export.h>. Typically it's placed before the first #include statement.
>  
> -Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
> ------------------------------------------------
> +Using the EXPORT_SYMBOL_FOR_MODULES() macro
> +-------------------------------------------
>  
>  Symbols exported using this macro are put into a module namespace. This
>  namespace cannot be imported.

The new naming makes sense, but it breaks the pattern with _GPL suffix:

* EXPORT_SYMBOL(sym)
* EXPORT_SYMBOL_GPL(sym)
* EXPORT_SYMBOL_NS(sym, ns)
* EXPORT_SYMBOL_NS_GPL(sym, ns)
* EXPORT_SYMBOL_FOR_MODULES(sym, mods)

So I think when reading this one may forget about the _obvious_ reason. That's
why I think clarifying that in the documentation would be great. Something like:

Symbols exported using this macro are put into a module namespace. This
namespace cannot be imported. And it's implicitly GPL-only as it's only intended
for in-tree modules.

Other than that, it looks good.

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

