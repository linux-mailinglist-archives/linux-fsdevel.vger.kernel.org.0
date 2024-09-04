Return-Path: <linux-fsdevel+bounces-28620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D085696C6EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866171F2392B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D704C1E413C;
	Wed,  4 Sep 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eriXzhsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F51E4111
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476121; cv=none; b=B7OYlET5nhrbTQvS2HyJD0Or3okbdIw7QrgOK0mZJROXQbrr6TXxwLn34qb7wJlCcNp/NABYMHzRJo4G0GNdkSyby8cIJUdfyxU3QTgup8w3EpqRjPD0jTR7QNdz9AJFsFTLqX7AkTt3vu2yc71Lq/+Pwui2sXRZvfX2zTesX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476121; c=relaxed/simple;
	bh=XvcPlCNKOyAOcO2sDqDCAH3Ue4gDGxj5iEp625GeZWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCTnKEIWZIHnWwxDzp0UTxz8N/nQur3HD71bVzw+IFVlBBIoDVIIDuzmNN5ELTP3vJb0mnwyI4/Pem5TUvQkJpE3s4GKennx3kNFECFzhfW3xHbF0oXQo+dg3oSX8Y5EBUVzwiUjC8vnS3TWVHsyHeJyg/9UH70ioXX74M6z2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eriXzhsA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 14:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725476117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN5t1C2oeejKjejG+tL9rtMscYiZsZ0/XuO7UFNOY8w=;
	b=eriXzhsALVVtShspOtIV4NqrhZHSPMQoc/ClzxDimkxw5liPYru692WxFhqQdskN9R3gzH
	b875RZa3YZQ94FA2zl6B4Zr3Wkhb2fauqim5MfQ/PvlZyySpa5zlDbWKHAlzK+Py9bL7Ei
	rklKoe/tjUiAqKkXRo9qVd7w4wiPpQw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
Message-ID: <fvk7vjfz4f2c2x5hxjajiwz5doxeg54owgpzob2kskkftshcoo@5sl5lu6nenyu>
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
 <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWknzcmc1DZ3HSB9qp4poaEO5_ViCESvQChuAaiOBdr7Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 03:53:56PM GMT, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> Replying here, as there is (again) no patch email to reply to to report issues.
> 
> noreply@ellerman.id.au is reporting several build failures[1] in linux-next:
> 
>     fs/bcachefs/sb-members.c: In function ‘bch2_sb_member_alloc’:
>     fs/bcachefs/sb-members.c:503:2: error: a label can only be part of
> a statement and a declaration is not a statement
>       503 |  unsigned nr_devices = max_t(unsigned, dev_idx + 1,
> c->sb.nr_devices);
>           |  ^~~~~~~~
>     fs/bcachefs/sb-members.c:505:2: error: expected expression before ‘struct’
>       505 |  struct bch_sb_field_members_v2 *mi =
> bch2_sb_field_get(c->disk_sb.sb, members_v2);
>           |  ^~~~~~
> 
> Apparently this fails with gcc-10 and older, but builds with gcc-11
> and gcc-12.

Thanks for the report - it's fixed now (thanks, Hongbo)

> The failure is due to commit 4e7795eda4459bf3 ("bcachefs:
> bch2_sb_member_alloc()"), which is nowhere to be found on
> lore.kernel.org.  Please stop committing private unreviewed patches
> to linux-next, as several people have asked before.

They're still in git; I'd suggest just doing a git send-email and
tweaking the output if you want to start a review on a patch you find.

There's been some discussions in filesystem land about how/when we want
patches to hit the list - I'm not a huge fan of the patch bombs that
drown everything else out on the list, which is what it would be if I
did mail everything.

But if the email workflow is really what you want, and if it's going to
be generating useful review (list activity is growing...), I could be
convinced...

We're getting past the "just fix all the stupid shit" phase, and my
output is (I hope) trending toward something more stustainable, with a
stream of more _interesting_ patches to talk about, so - yeah, it's
starting to sound more reasonable, if that's what people want.

My priority is just going to be on fostering _useful_ technical
discussion. If the only reason you're wanting patches on the list is
because of trivial shit automated tests can and do catch - that's not a
win, to me. If I start posting patch series and we seem to be learning
from it, I'll stick with it.

