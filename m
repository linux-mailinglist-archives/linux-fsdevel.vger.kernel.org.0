Return-Path: <linux-fsdevel+bounces-6580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880C819DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B37B22AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC2A21340;
	Wed, 20 Dec 2023 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Muzb5feU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B121345;
	Wed, 20 Dec 2023 11:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D10CC433C8;
	Wed, 20 Dec 2023 11:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703071089;
	bh=hEF8/ziAY1v3IYwu0TAV76QObnrnN3uPJHzJ4KIa2q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Muzb5feUImmz+T+Vwyl1k/6PGi9FStRMA9PaF7o7SamS3yfUGFaoNCgTKtkL/8bS3
	 bGa0It53elx0DYnFHsXwnma7DPykB0BrGRz5rnQCwBDCUw9hCggPf/tN1CWMWGVfrL
	 kzFj1WrLkllAHgJ++KeGsKv4WQfvoPUyIi+x7n3TaTxL7l7eeAX+NamUpd7FqRZLcy
	 7YX9tihokPZ6XDKjXN8kza6xH0eqUo9WOz8gsf8co0ShgJ78IpJ9vROyWXcmjFpCZu
	 00WlGu5yBVeeAElleFMNoB1S43nryZklQwPBwoVTcLnyXMV5jaqE38fSiIUo7NOB7C
	 7EnZiGOZ8zboA==
Date: Wed, 20 Dec 2023 12:18:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: pull-request: bpf-next 2023-12-18
Message-ID: <20231220-einfiel-narkose-72cf400ae7e6@brauner>
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner>
 <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQK6CkFTGukQyCif6AK045L_6bwaaRj3kfjQjL4xKd9AhQ@mail.gmail.com>

> The patch 4 that does:
> if (attr->map_token_fd)
> wasn't sneaked in in any way.
> You were cc-ed on it just like linux-fsdevel@vger
> during all 12 revisions of the token series over many months.
> 
> So this accusation of breach of trust is baseless.

I was expecting this reply and I'm still disappointed.

Both of you were explicitly told in very clear words that special-casing
fd 0 is not ok.

Fast forward a few weeks, you chose to not just add patches that forbid
fd 0 again, no, the heinous part is that you chose to not lose a single
word about this: not in the cover letter, not in the relevant commit,
not in all the discussions we had around this.

You were absolutely aware how opposed we are to this. It cannot get any
more sneaky than this. And it's frankly insulting that you choose to
defend this by feigning ignorance. No one is buying this.

But let's assume for a second that both you and Andrii somehow managed
to forget the very clear and heated discussion on-list last time, the
resulting LWN article written about it and the in-person discussion
around this we had in November at LPC.

You still would have put a major deviation from file descriptor
semantics in the bpf specific parts of the patches yet failed to lose a
single word on this anywhere. Yet we explicitly requested in the last
thread that if bpf does deviate from core fs semantics you clearly
communicate this.

But shame on me as well. I should've caught this during review. I
trusted you both enough that I only focussed on the parts that matter
for the VFS which were the two patches I ACKed. I didn't think it
necessary to wade through the completely uninteresting BPF bits that I
couldn't care less about. That won't happen again.

What I want for the future is for bpf to clearly, openly, and explicitly
communicate any decisions that affect core fs semantics. It's the exact
same request I put forward last time. This is a path forward.

