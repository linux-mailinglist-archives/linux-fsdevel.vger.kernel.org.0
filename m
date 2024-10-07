Return-Path: <linux-fsdevel+bounces-31259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F39938FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 23:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE752841AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662311DE8A4;
	Mon,  7 Oct 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K+c0Vpa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74101DE3D4;
	Mon,  7 Oct 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336078; cv=none; b=Q5P89axv9NyCu1x8yatLYaLzkGzz5eZp4F+y9grB22jgBCM0mQJaNK7ojFi6dxCOehBOkAHeHlI7Uffnf+HLG/8+07aynTQNpUUn22vdh5kDpFhRF9DHgTb87BLNVjz8UvVqoyI3rbjiT6T42MN7dvx2NYpU68I0wpPmqIdMdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336078; c=relaxed/simple;
	bh=P0wp8Ar+Fe987qJWI+iuSl/lj0zHc+3mwh9/cmjZDTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOkh6erverHgJvRWUM5/rkgU9ntARNufnzXiLiRpQ/PphEyIl4pVN2/mo4Gb5mttjpnGY48rpnovrju3FiofeBUVaE2237HYpCXxPMs7FYVWXaQwbDBQgzavaMsG9HK1pSGEReyx9WHoVKBQ5XFhEsNuXaIR0allios/UR8ZT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=K+c0Vpa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF7DC4CEC6;
	Mon,  7 Oct 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K+c0Vpa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728336075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16iMzTxBGdyzEHCA/Hs9xCkU+UXDvdsuKAWymIRdgqU=;
	b=K+c0Vpa9WpAjW9pKPzjpcUdNbnvm0Fk1oV/jXfgjGQerdcUQYvST86ienv2hszZGqcMDb6
	a7oYRP1V4buOPRMjl+SEUH7syFHtCiUFw8kOyHkeFmDQhrPVJsmiz64Nh5A+D0fN4B3/G5
	jo80IkJP6qgbL2FRYQBfBI+UW7tIfak=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cda84601 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 21:21:14 +0000 (UTC)
Date: Mon, 7 Oct 2024 23:21:12 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <ZwRQyA-xcKwWz6lm@zx2c4.com>
References: <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
 <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
 <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
 <ZwP341bZ9eQ0Qyej@zx2c4.com>
 <6hjoiumgl3sljhjtmgvsifgu2kdmydlykib3ejlm5pui6zjla4@u7g2bjk4kcau>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6hjoiumgl3sljhjtmgvsifgu2kdmydlykib3ejlm5pui6zjla4@u7g2bjk4kcau>

On Mon, Oct 07, 2024 at 03:59:17PM -0400, Kent Overstreet wrote:
> On Mon, Oct 07, 2024 at 05:01:55PM GMT, Jason A. Donenfeld wrote:
> > On Sun, Oct 06, 2024 at 03:29:51PM -0400, Kent Overstreet wrote:
> > > But - a big gap right now is endian /portability/, and that one is a
> > > pain to cover with automated tests because you either need access to
> > > both big and little endian hardware (at a minumm for creating test
> > > images), or you need to run qemu in full-emulation mode, which is pretty
> > > unbearably slow.
> > 
> > It's really not that bad, at least for my use cases:
> > 
> >     https://www.wireguard.com/build-status/
> > 
> > This thing sends pings to my cellphone too. You can poke around in
> > tools/testing/selftests/wireguard/qemu/ if you're curious. It's kinda
> > gnarly but has proven very very flexible to hack up for whatever
> > additional testing I need. For example, I've been using it for some of
> > my recent non-wireguard work here: https://git.zx2c4.com/linux-rng/commit/?h=jd/vdso-test-harness
> > 
> > Taking this straight-up probably won't fit for your filesystem work, but
> > maybe it can act as a bit of motivation that automated qemu'ing can
> > generally work. It has definitely caught a lot of silly bugs during
> > development time.
> 
> I have all the qemu automation:
> https://evilpiepirate.org/git/ktest.git/

Neat. I suppose you can try to hook up all the other archs to run in TCG
there, and then you'll be able to test big endian and whatever other
weird issues crop up.

