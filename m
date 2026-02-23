Return-Path: <linux-fsdevel+bounces-78002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPCRH1rInGkwKQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:36:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E321017D9F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C90D3063757
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614EA378D64;
	Mon, 23 Feb 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwriYbY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5019361654
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882581; cv=none; b=vF/CH26jNZU2tcvjJDe3I1ykIleCiQkyb93KB/MroSdmw5KQqVPbFgPaJu5ZpfedboRs8sgEx8/UbgG9rkXstkF1ZANJCOmW3b0Oi56ThLcbThnym+qU+WQCL4QXrGEjCoA1ZFaVMnpscYOcabqbUugyq1DvQT+pgom9xDoqOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882581; c=relaxed/simple;
	bh=dgBlKs1JJdh5wlt3u1oPFVnvLe8Pn4zy18/qDggH1kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r22fNfkWuUOtUYgPh5JCCt+7AIJcUq9V1PzFEf95eVr3fQ+9bVnpicS4hQMO2FOZagvKk6B8pVYI0671JAXns2R7xuRkB5C2c/7hxgisAr/vWTzOaLVXWYa3SvtOAJ22j+BPiRiMcDt4AHbQqRx85WocOMicA4E+2psjV3qtJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwriYbY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AA0C116C6;
	Mon, 23 Feb 2026 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771882580;
	bh=dgBlKs1JJdh5wlt3u1oPFVnvLe8Pn4zy18/qDggH1kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwriYbY34PdQllaZjFMusa/FgHO/fWbcHL72EWWy4o3MnvQNN7lRreFJvwTehR0ds
	 w+jTUsl4N+v3bMGhDJmeDmL7meTJxtieloW0EDrmyepfkkFyOaRg7wFWWKpy6dNc9n
	 vOER6OqEjdcbHEpYAQMakoh7UzaBL2NAmsYKHp6ZKJmo2cS6bu54FvKoalJo2WJQBC
	 yUs1gUJGNRAum6owpPmnOUau/VXi+uXvvFNOTqwbvl0ylXJlACodcN2ZQCJwfU2lb4
	 ltQUlSNIOZXCHGuPTYVmxHozsTMd/GjZ6A66B5jYJJx9arnt9Ip7R9hkhLhTbfqI4H
	 W2f1eZqJH1Tew==
Date: Mon, 23 Feb 2026 21:36:18 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Nanzhe Zhao <nzzhao@126.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	yi.zhang@huaweicloud.com, Chao Yu <chao@kernel.org>,
	Barry Song <21cnbao@gmail.com>, wqu@suse.com
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
Message-ID: <aZzIUnYprj_wTyqn@google.com>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <aZiCV2lPYhiQzYUJ@infradead.org>
 <aZiqsQsWFSCjcfE_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZiqsQsWFSCjcfE_@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78002-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,126.com,lists.linux-foundation.org,vger.kernel.org,huaweicloud.com,kernel.org,gmail.com,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E321017D9F9
X-Rspamd-Action: no action

On 02/20, Matthew Wilcox wrote:
> On Fri, Feb 20, 2026 at 07:48:39AM -0800, Christoph Hellwig wrote:
> > Maybe you catch on the wrong foot, but this pisses me off.  I've been
> > telling you guys to please actually fricking try converting f2fs to
> > iomap, and it's been constantly ignored.
> 
> Christoph isn't alone here.  There's a consistent pattern of f2fs going
> off and doing weird shit without talking to anyone else.  A good start
> would be f2fs maintainers actually coming to LSFMM, but a lot more design
> decisions need to be cc'd to linux-fsdevel.

What's the benefit of supporting the large folio on the write path? And,
which other designs are you talking about?

I'm also getting the consistent pattern: 1) posting patches in f2fs for
production, 2) requested to post patches modifying the generic layer, 3)
posting the converted patches after heavy tests, 4) sitting there for
months without progress.

E.g.,
https://lore.kernel.org/lkml/20251202013212.964298-1-jaegeuk@kernel.org/

