Return-Path: <linux-fsdevel+bounces-54587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AFB01276
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 07:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C9E1AA53A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 05:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430B1B4138;
	Fri, 11 Jul 2025 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02M1NCoI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwYVL3Dw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B78B660;
	Fri, 11 Jul 2025 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210145; cv=none; b=K8W15JUfEKH6SmpLYKsPpCxnOuwHRevsUDb8RIdwvSA45eXiZNiC63lucJqJPFjVYWbYNOj0Nj+MQG+RCSWHBXlmvqkYkO8srOHPS8EHrTE6jHFUDXzpZgftT3jgI3DS38MTgdzKM/VtPfdbqjceqGqRvQkPnM7LHBbs5K1Wwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210145; c=relaxed/simple;
	bh=2QSoiblwx9XXddcQYzdxBSa861AciILCjKcc0UKEJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK2boKXlrSmsdet4uTtWFM/no26RnblY9vD3LFbLlUm+llgNhF+r16PE57zD3bzmZ6NCTAvlMpipLUF3bwBNQutXduuF73d+A5Ndt5pk5JVdw7k8g8Q19pDqaLEQa/BwE03sFrt44jT35qCNvYF4JWFFFDuoQXvqJuERZcq3DzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02M1NCoI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwYVL3Dw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 07:02:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752210141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j59WDD2gzvtudEauuDI9ce9YLhlsFVKD79WIDcOOSs8=;
	b=02M1NCoIj98kR14JGLLJCmJunjqalyyp5w1aBhNpNyZEkBXB3qEIbHFPkDTWG3xqaXJhxN
	Q/cqnEI6pkT8rJh9/2z3DFadzSmnnIROhkboDAeDR9qtsJdVWkc+1SthIcCy/+4TVshoSO
	7eKD1bXnkksyiiYfKFoE8ukym+O2aYGQN/qcPF+wuXGAjaJtZUY6/7oHIgoRl2hcgrdLWO
	ZsB0g+i9IhenPPrXt/nDZ2l5ojrs+g1SWMoCP8RUmDVoJvF5ueFE7c61JZpWtdMTpiRtzq
	FaqptMLai1sGpNBH0U1mprMmLFYBrSvahfy22APApvKAN98MHFJkp/cQygE7TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752210141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j59WDD2gzvtudEauuDI9ce9YLhlsFVKD79WIDcOOSs8=;
	b=EwYVL3DwHtOVB+v4a+urbtpc1WXH1/pTVPYxd5AOoIkqidGHSkm0D6hBmHgQMIx0g9KC8K
	Lctr6nJR+E/yAxDw==
From: Nam Cao <namcao@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250711050217.OMtx7Cz6@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250701-wochen-bespannt-33e745d23ff6@brauner>
 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
 <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>

On Thu, Jul 10, 2025 at 05:47:57PM +0800, Xi Ruoyao wrote:
> It didn't work :(.

Argh :(

Another possibility is that you are running into event starvation problem.

Can you give the below patch a try? It is not the real fix, the patch hurts
performance badly. But if starvation is really your problem, it should
ameliorate the situation:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 895256cd2786..0dcf8e18de0d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1764,6 +1764,8 @@ static int ep_send_events(struct eventpoll *ep,
 		__llist_add(n, &txlist);
 	}
 
+	struct llist_node *shuffle = llist_del_all(&ep->rdllist);
+
 	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
 		init_llist_node(&epi->rdllink);
 
@@ -1778,6 +1780,13 @@ static int ep_send_events(struct eventpoll *ep,
 		}
 	}
 
+	if (shuffle) {
+		struct llist_node *last = shuffle;
+		while (last->next)
+			last = last->next;
+		llist_add_batch(shuffle, last, &ep->rdllist);
+	}
+
 	__pm_relax(ep->ws);
 	mutex_unlock(&ep->mtx);
 

