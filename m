Return-Path: <linux-fsdevel+bounces-55023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E560FB06663
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CE1AA1F9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5B2BEC24;
	Tue, 15 Jul 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na0gU3ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E7223DD0;
	Tue, 15 Jul 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605944; cv=none; b=G9FGGf1Cmo3hIDP7pok19GQcLjkG7Ix/5wDRYPCCoxAHvCIeeWa+sI3PvESCuIg+7Ngsf/CPDCLPcRSJwm/Z63RWaJcQEdbdt6zUJzPDxuJkChbHUjxkwZk7AzdwPYaEa2vH0Gp77LTcAT5VSptkEyHrTHgqYWfVB2F3N6u9CMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605944; c=relaxed/simple;
	bh=CvItC95DS+pbvx0GKSq0P7nNfXOXqmBFL0Kobkkiv8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaB1k2cGp11q/7Fg8D63/xg5BLc3ZDmNscTr/BOu+CpAOfMdvJm6Z7LMK0ldhjW61Qm4Ui5rRuyvQVZSuW5MtD6xv6hLiz3bQ+jXxeCbITnu8zE1Sbvzl0da8AWDGzaO3EbIzty2PjwWHq5WhWI+jwnCvqeht8df6DrlMRlTHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na0gU3ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD51C4CEE3;
	Tue, 15 Jul 2025 18:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605944;
	bh=CvItC95DS+pbvx0GKSq0P7nNfXOXqmBFL0Kobkkiv8A=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=na0gU3ju6BrACgT56hXjDIK69gVbLb5PiNaKhAZOoEba9LTN4FExx7cfAlvFlV3Cg
	 f4DbD59n23aS+dnmdfJskEfg+ljAFAZMtFt9HVh7y25YLEI4Xd6sEN0ajME1BGX35y
	 um4aMP9s4MaiHzUs11/+puhm33+60IPMx2/eI38sS7JUtIQet0y7zBnSNmCwgho017
	 jznW4zFfDGPq+6BOxPUpWE42BA34ZSci3qiiqhoBASf2BHqNOemRy6hJqh4SqAO01i
	 /DMg5bpGKk5ljmIEOhvhHd3D/veEQIPZ0Nt/MnbZCdxUXL9HjsM685OIr37Expfey6
	 +bSVK+N9VpUyQ==
Message-ID: <b340eb9f-a336-461c-befe-6b09c68b731e@kernel.org>
Date: Tue, 15 Jul 2025 20:58:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v3] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: Vlastimil Babka <vbabka@suse.cz>, Daniel Gomez <da.gomez@samsung.com>,
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
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
References: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 10.43, Vlastimil Babka wrote:
> Christoph suggested that the explicit _GPL_ can be dropped from the
> module namespace export macro, as it's intended for in-tree modules
> only. It would be possible to restrict it technically, but it was
> pointed out [2] that some cases of using an out-of-tree build of an
> in-tree module with the same name are legitimate. But in that case those
> also have to be GPL anyway so it's unnecessary to spell it out in the
> macro name.
> 
> Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
> Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Shivank Garg <shivankg@amd.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Nicolas Schier <n.schier@avm.de>
> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Daniel, please clarify if you'll take this via module tree or Christian
> can take it via vfs tree?

Patch 707f853d7fa3 ("module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper")
from Peter was merged through Masahiro in v6.16-rc1. Since this is a related
fix/rename/cleanup, it'd make sense for it to go through his kbuild tree as
well. Masahiro, please let me know if you'd prefer otherwise. If not, I'll queue
it up in the modules tree.

