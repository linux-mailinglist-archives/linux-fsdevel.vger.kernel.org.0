Return-Path: <linux-fsdevel+bounces-78280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHhaM7/EnWnsRwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:33:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0928B1890F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D209D30591BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49627FB18;
	Tue, 24 Feb 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iaInRZKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4827E1DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947184; cv=none; b=F5Y+hgaS31ioXOdRx3Q4NX62/wJjIZzpBPtI7RBRTXUA7htgRtxBPx5/S5dP6a6Sy1pvA9cz8D7JoRNdFGwStU4B563DUXe7NU1eY07iuOaDVvzMUCI9G7YdQlD7ZDdxDf8LY8JP4ebtZrmlrtgEHeqzkBHjsz2kOGGCJYQIpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947184; c=relaxed/simple;
	bh=VQTDYyp2KUyp65Y3HfpJzq+MwHKYQd3K/vE5/GWxUW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rri8CcgCr/d61PmokHCnJNtZ9wb5a2YyAmgHOYMdVrMN+QU3eMdMYKYoL5Q1sqc0Q2XdHN1Lwv+0hdQ+7hHaaNLMVotlIshn1Sa8ZJKJSnS5M9pQJFaEEF+SRprVjpF36utOJD9MHAzmitfpJRL5OyUNdgKgFtkVxBs9urVFfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iaInRZKz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-111-182.bstnma.fios.verizon.net [173.48.111.182])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61OFWSmh014511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 10:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771947151; bh=LCrtRQLNlXJ2+RMPTomjO9zvY5ULKnNAP+Rx2oaqJTY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=iaInRZKzaFmwbD0wNIxEZWWMO9hrAn0VLeTMlSnaY8bAvNdERtlqSNJqsF2bJHGuX
	 QFTUQ40h14UmMAB+ncnFFpT0n19A1u3+PcUUoB1Kvo7YBT1cJo6vxIluKw5TCdWwnQ
	 CrPTx0zFGW8olNTbS6tCe7DuT9RnRtPPrbW83S4LbIRrCk6L537bh/PH5bXvI4LNZl
	 5vv1Kp2MunTQo7PLw27xom0Qf25XsuYY+gdpSJSqBIpiHvqG+5D+UYF91Elf/qy57I
	 lVz6s9o8sopQ3AAZbLd9bafx/4ccNWwFICzmU70GxeSbGtysyQjvMGflGIkzopWr5d
	 wesJycyrLZSMw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 712BC59B49DC; Tue, 24 Feb 2026 10:32:28 -0500 (EST)
Date: Tue, 24 Feb 2026 10:32:28 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fsverity: add dependency on 64K or smaller pages
Message-ID: <20260224153228.GC16846@macsyma-wired.lan>
References: <20260221204525.30426-1-ebiggers@kernel.org>
 <20260224145156.GA13173@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224145156.GA13173@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78280-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[macsyma-wired.lan:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0928B1890F4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 03:51:56PM +0100, Christoph Hellwig wrote:
> Do we want to throw in the towel here for the forseable future and if we
> ever need to support fsverity on > 64k page size just do a on-disk
> version rev?
> 
> Because if so we could just simply the pending xfs fsverity support to
> drop all the offset adjustment and simplify it a lot..

I wholeheartedly agree.  Especially given the benefit of large folios,
increasing the base page size beyond 64k has enough downsides without
compelling upsides that can't be achieved via other means, I'm highly
skeptical that page sizes > 64k is going to be appealing for most
system designers.  So trying to design in support for this possibility
in fsverrity is not worth it.

						- Ted

