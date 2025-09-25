Return-Path: <linux-fsdevel+bounces-62817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B9BA1CAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A07E740C23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841431FEC6;
	Thu, 25 Sep 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQIm0ooO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D81F4E34;
	Thu, 25 Sep 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839294; cv=none; b=AcnIasDvt4uLnn8n4OJ/7VP7WoUXUTU7SgSZ6zJiFhBhzhBkGr4zGBb43e9grAFXYM24dOn2MvgIHA3o4zs+5ERppwe7a94RT49hCM4ybzGUwN5UiHa0DtEl2XgV2/hOYG/T2Jp+jaEU7MAlMIN6qlCmF1p5OTM3/R4ElkZNa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839294; c=relaxed/simple;
	bh=kqb8fzGVd59PR/cr9Fw/1pkA0NoxO9pgMywQ6tYTnsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ5opp7UyWu5T0DVxnYefg073Jnui35RCPUFs5mlvyqvq/zajO5kJftmXgQHPTuoQaQPDe8Pv9TO1Bfe9SFDiK+TNl6OfDX6GPh3Bnd8B1y91o5+FG2fiwak8AVduqXOyFhSt55tEDjx7299T1lPiLdx02T3bEuIYOAaZL9Xbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQIm0ooO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74A5C4CEF0;
	Thu, 25 Sep 2025 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758839291;
	bh=kqb8fzGVd59PR/cr9Fw/1pkA0NoxO9pgMywQ6tYTnsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQIm0ooOSCzZ8Xjfi+AzvYjMrzjTxmST4cP3uFet3AFVT9nd+Dlbe0bFpgih5iDE6
	 a8IwCSI6ptyQVeyiHzhPv3pRweCCReRoUcBCqK6atlUoY/EuOcucSKVo+KW7Y9qzrA
	 5MNfjE5LPVVVjpMtqu1jErAcsVdQZZa/9Go6ALL59CAizH6RoGYigzXnJZzRaQsJjE
	 yaA1NzN55lIIVJQNDFWFPwhlyjVUf/Bx/zgpVmGleJZPlmcuE1KR8AwYtryFM+a6KD
	 NFTOnPJ5WlvFcpQtF1BKfnMHppf+9emazz/SP0ALJmOogCQ8qJoeUmmuei+4rvJyyi
	 7H0V7aStp1ahA==
Message-ID: <123868dc-a7c2-401c-9c99-9b0dcee6e922@kernel.org>
Date: Fri, 26 Sep 2025 00:28:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 1/3] samples: rust: platform: remove trailing commas
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
 <20250925-cstr-core-v16-1-5cdcb3470ec2@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250925-cstr-core-v16-1-5cdcb3470ec2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 3:42 PM, Tamir Duberstein wrote:
> This prepares for the next commit in which we introduce a custom
> formatting macro; that macro doesn't handle these spurious commas, so
> just remove them.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

