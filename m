Return-Path: <linux-fsdevel+bounces-27407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719839613E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2D1F2396C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595B1CDA2D;
	Tue, 27 Aug 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZnlG62M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C71C4EE3
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775813; cv=none; b=DGxYO7fQ7VIWz1mYGqweOYKWvwm5EhJ61Uja27Ay/sNU2jsSYyPn6QzVyVm4hHfC9AdqTngQl0A5eOGLxhyILmm/djNV9TkODHYYT2L3xXa8fkk+QhV3nIIM7CWV7mGD3Xacp3+b7NCHuQmf3y3Od5GPnpgTJGCAGtwmmzYG4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775813; c=relaxed/simple;
	bh=rd63YkIL9487GOLG6/Jc3gLl9tCEqEZuYuQRCxqy3U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4A0rlqYSRjhmh6tXid3vM5IUrsK0vDrUv67P1Gz023pMsadP2w82sVwifXlSTKinBbRqgdliT2Sp1YgMqY3zvMcELdLoH1x4sYq4hWvM/lvFmIL/9eiOTw0vyPA2NRwq0vBft9aNu11COqKnT2A5wyPdxTT/wgLcXy59DQU7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZnlG62M; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Aug 2024 12:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724775808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htkUwT1XE4QM6RoTgmwAjSxaCzoDMjE3DAY/HRSuk30=;
	b=sZnlG62MyXzTfLQSuvstTkB7jcfdIpA/QECcst659aF+Mwrmk4sVIpFuxLNIMJyH77X/si
	44PqmljGbjKPXlbmyn5qUz+RX+9UX9J02JwIMNkhlcYEyXZpOTxSgxhq95RFpN0pitq8GO
	x8Shdiv52IoPQhxPawdX6c0i+9Ia1V8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11, v2
Message-ID: <ltl35vocjtma5an2yo7digcdpcsvf6clrvcd4vdkf67gwabogf@syqzgnw5rodw>
References: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>
 <d0da8ba5-e73e-454a-bbd7-a4e11886ea8b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0da8ba5-e73e-454a-bbd7-a4e11886ea8b@stanley.mountain>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 01:53:55PM GMT, Dan Carpenter wrote:
> On Thu, Jul 19, 2024 at 06:36:50PM -0400, Kent Overstreet wrote:
> >       bcachefs: Unlock trans when waiting for user input in fsck
> 
> Hello Kent Overstreet,
> 
> ommit 889fb3dc5d6f ("bcachefs: Unlock trans when waiting for user
> input in fsck") from May 29, 2024 (linux-next), leads to the
> following (UNPUBLISHED) Smatch static checker warning:
> 
> fs/bcachefs/error.c:129 bch2_fsck_ask_yn() error: double unlocked 'trans' (orig line 113)
> 
> fs/bcachefs/error.c
>    102  static enum ask_yn bch2_fsck_ask_yn(struct bch_fs *c, struct btree_trans *trans)
>    103  {
>    104          struct stdio_redirect *stdio = c->stdio;
>    105  
>    106          if (c->stdio_filter && c->stdio_filter != current)
>    107                  stdio = NULL;
>    108  
>    109          if (!stdio)
>    110                  return YN_NO;
>    111  
>    112          if (trans)
>    113                  bch2_trans_unlock(trans);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^
> Unlock
> 
>    114  
>    115          unsigned long unlock_long_at = trans ? jiffies + HZ * 2 : 0;
>    116          darray_char line = {};
>    117          int ret;
>    118  
>    119          do {
>    120                  unsigned long t;
>    121                  bch2_print(c, " (y,n, or Y,N for all errors of this type) ");
>    122  rewait:
>    123                  t = unlock_long_at
>    124                          ? max_t(long, unlock_long_at - jiffies, 0)
>    125                          : MAX_SCHEDULE_TIMEOUT;
>    126  
>    127                  int r = bch2_stdio_redirect_readline_timeout(stdio, &line, t);
>    128                  if (r == -ETIME) {
>    129                          bch2_trans_unlock_long(trans);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Double unlock

Those are different types of unlocks.

The first unlock drops btree locks, but we still have pointers and lock
sequence numbers to those nodes so that we can do a bch2_trans_relock()
later, and continue the same transaction.

But we still have an SRCU read lock held which prevents those nodes
from being reclaimed, and we can't hold that for too long either.

So if we're blocked here too long we have to also do an unlock_long(),
which forces a transaction restart.

