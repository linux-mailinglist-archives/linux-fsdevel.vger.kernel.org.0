Return-Path: <linux-fsdevel+bounces-4572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49531800D45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC3F281AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27753E47C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc/qSrKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA831C6B3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 13:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3FBC433C7;
	Fri,  1 Dec 2023 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701436345;
	bh=mwXvmonhK0kvb4Hd4Bn3q8lUCjHbnh42rU6UreeSc10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oc/qSrKoNqcy+kEMpvr6qnHKiLXuhgALaxSEv/Al8CFuaFMMnnB5IDBqr2RvFcY+K
	 InoQ7cdNS9kHpxJaszyCLWe24Gsja0NwaSwndevnUXdtnL6cPR8J2wLDYlm9FeGQoq
	 KqrYYIdUMspk+p2Dl7ddA789fes+JpXbRRXDa1o66SyPl9K+jeveCJuq/5yJsCHw3I
	 S+GhMEQp7fazNKRkTMeVh4msmoHeRPu+96OIBJaRQlYPpWYn0bvuNWQTZRxvmjsPgD
	 lJNKvBGHw5kJBA95muXytdsjbDNtyInKgocIlu1QBIGNHapYDrKB+Iq0rKVIb1nngr
	 ELVChW4UahHow==
Date: Fri, 1 Dec 2023 14:12:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 5/5] file: remove __receive_fd()
Message-ID: <20231201-wehrhaft-analog-33b26c79ce25@brauner>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-5-e73ca6f4ea83@kernel.org>
 <ZWiMEwj/PE24AYLj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWiMEwj/PE24AYLj@casper.infradead.org>

> > +extern int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
> 
> You could drop the 'extern' while you're at it.

Done.

