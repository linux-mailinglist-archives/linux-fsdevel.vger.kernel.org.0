Return-Path: <linux-fsdevel+bounces-6317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E9815B25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EACE1F23654
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4A31A68;
	Sat, 16 Dec 2023 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ykcwfrsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A823454B;
	Sat, 16 Dec 2023 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3hVE5RPWNcQ5hlL8FuG56P37WA0eyg5gChyAuDS+aI8=; b=YkcwfrsdywyoNzi62MbRk6S8wV
	AfjHfznQhSdfxjOP14qr0Yzyvs95QTVHHMGVFffCnais4+M3YDHOAqjNBNY6lM3UU/fbupZLJcyjD
	SzTTFXJEmPTP4IkxhpWS0/fo6Fm9hfU356RAk4COpEsRyRaSNx86oyLRKV0Dr6sQRGU7VQ152mmrn
	TtZm4V1CQlAW6ItB5/XrZ/0zL4+bHERCbs/PW0QBcl6ETAbarTGkAmgdQfqSU6zmpi/DiddbDlnzW
	LV26rKUsSUXIpXtfsP0M9oZn46SwR7ljtojN/CGXn1otxwqmEisjAmpUmv7StdoxcbQc+0p5GxSrL
	ZPTWMkxA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEZld-006Yxh-0o;
	Sat, 16 Dec 2023 18:52:05 +0000
Message-ID: <28e353de-1ea8-418b-8d96-a315a9469794@infradead.org>
Date: Sat, 16 Dec 2023 10:52:04 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/50] prandom: Remove unused include
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org,
 Suren Baghdasaryan <surenb@google.com>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-2-kent.overstreet@linux.dev>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231216032651.3553101-2-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 19:26, Kent Overstreet wrote:
> prandom.h doesn't use percpu.h - this fixes some circular header issues.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/prandom.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> index f2ed5b72b3d6..f7f1e5251c67 100644
> --- a/include/linux/prandom.h
> +++ b/include/linux/prandom.h
> @@ -10,7 +10,6 @@
>  
>  #include <linux/types.h>
>  #include <linux/once.h>
> -#include <linux/percpu.h>
>  #include <linux/random.h>
>  
>  struct rnd_state {

In this header file:

    22	void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);

so where does it get __percpu from?

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

