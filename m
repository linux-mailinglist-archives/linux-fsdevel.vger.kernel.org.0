Return-Path: <linux-fsdevel+bounces-6362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF032816E07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 13:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F95AB22014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DC7EFA7;
	Mon, 18 Dec 2023 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPWCQdG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4F7EFA1;
	Mon, 18 Dec 2023 12:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C90C433C7;
	Mon, 18 Dec 2023 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903165;
	bh=0PY//jHcNSpAPBMjzTyNT7kr17tD9ZNoMx4Cb+GGtkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPWCQdG9/Ev7kXmdsF9q6RbTgvVb1bvzuSeLVv2L5EWP4cwEJYatFXzD8p0jNCBRe
	 yBN3ul2yiBXw9v154taJKII31upB8XaI9f+vq3CMRWhCyPoPuKBa+nmvlnA4IVvlbg
	 K96KALufQ+7QwD+k4jObhvbs0AzTLwcH3rITJrS/9WTCB66qibRTiYe3W+cYD9dLhQ
	 M+cmjCrRbReTFIslJ+RoXfVMsXA0mWKVrUMbgTdRGg2WydCtLgLEJe1LaYbqsq8rne
	 o7Y2zrlysvGlSKc1eQUhvj5lhVMV7qip6y+RHnvzos6pGH/Dd8fGttW1nI3MrO7bV7
	 GXqF8DjXVsfqA==
Date: Mon, 18 Dec 2023 13:39:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, tglx@linutronix.de,
	x86@kernel.org, tj@kernel.org, peterz@infradead.org,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org,
	keescook@chromium.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com
Subject: Re: [PATCH 25/50] wait: Remove uapi header file from main header file
Message-ID: <20231218-lacke-hiebe-aa4508561256@brauner>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231216032957.3553313-4-kent.overstreet@linux.dev>

On Fri, Dec 15, 2023 at 10:29:31PM -0500, Kent Overstreet wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> There's really no overlap between uapi/linux/wait.h and linux/wait.h.
> There are two files which rely on the uapi file being implcitly included,
> so explicitly include it there and remove it from the main header file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

