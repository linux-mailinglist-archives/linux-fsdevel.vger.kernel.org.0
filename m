Return-Path: <linux-fsdevel+bounces-6503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF49818BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2951C2487F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF111DDCF;
	Tue, 19 Dec 2023 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rz5K5x5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC591D521;
	Tue, 19 Dec 2023 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=znNsi/FwfGWyvqcVQI282vSklPfeCpZisa0qhu0toGk=; b=Rz5K5x5lR5vTHywnybXfcDm7SY
	LFOYRaYfiZV5OO1MmiDCaRuLev/+6y8sk4Rzkb3JpMzwAJjMSwY6REupdx4PJfPbliF/aKAOdskGS
	/DNHU309iZXZ2EhY+7A/c9kHriv48k9q8v/SQ50J95+0BluKE5a5Vvjmv3UNVjuYCeioAEKFPEAU2
	xCDE5+08WmHjfmWo5jsAP+Peb+suLqfPBepYKsNTe33HkN6Vi3evbkDB/FXtUlbokkE+j5e19YxGm
	DuSLlp5f4sRdWAuj1C/yeZikNNSA+fo23p/VMa2k870EuCqkf4ktfeXj/47sFRiQhX6CxGoTC4+EH
	GcFoqCdQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFcbx-0037O7-TT; Tue, 19 Dec 2023 16:06:25 +0000
Date: Tue, 19 Dec 2023 16:06:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	andrii@kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, daniel@iogearbox.net,
	peterz@infradead.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org
Subject: Re: pull-request: bpf-next 2023-12-18
Message-ID: <ZYG/gR6Kl9+11Myl@casper.infradead.org>
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <20231219-kinofilm-legen-305bd52c15db@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-kinofilm-legen-305bd52c15db@brauner>

On Tue, Dec 19, 2023 at 11:23:50AM +0100, Christian Brauner wrote:
> Alexei, Andrii, this is a massive breach of trust and flatout
> disrespectful. I barely reword mails and believe me I've reworded this
> mail many times. I'm furious. 
> 
> Over the last couple of months since LSFMM in May 2023 until almost last
> week I've given you extensive design and review for this whole approach
> to get this into even remotely sane shape from a VFS perspective.

This isn't new behaviour from the BPF people.  They always go their own
way on everything.  They refuse to collaborate with anyone in MM to make
the memory allocators work with their constraints; instead they implement
their own.  It feels like they're on a Mission From God to implement the
BPF Operating System and dealing with everyone else is an inconvenience.

https://lore.kernel.org/bpf/20220623003230.37497-1-alexei.starovoitov@gmail.com/

