Return-Path: <linux-fsdevel+bounces-64316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE2BE0894
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA239506353
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F5307AFA;
	Wed, 15 Oct 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaaT76r+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD91D90DF;
	Wed, 15 Oct 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557668; cv=none; b=sfY484pj2WS/xas0k4+DTVqd1+0bicH0dX9BIfnuuXZZwm49pDAVJJiwLIBmn9HqEVvzzTUf/+dq/ijX9WZZU1lLYwd4H+3lPyElgFHm8OKtgzVVgLtIOs7wf8gNp5vqWSKFBDeSegljq/iAewRfrUr+b4U4iWRZ0kwFazfWwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557668; c=relaxed/simple;
	bh=Z1CdTAHH8JHN/znRHsXXPPZxO88StlEbFnN9lt1dK7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSSNrRtZ4AXGM07ik4CRWKAEa/9ISoGwBjEOl+qi1/2LduGi3ACqo82nDm/O6wW3G+oj9+RoRJ0kkBaXB4vBsY+8uLkJ0tj+Vh3SY11QivYDczCuzWpK2i2DVgSXlefrOMn7DonJK2wNImXsHioohihCZRFgxtpjsO4HT4kSJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaaT76r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CD7C4CEF8;
	Wed, 15 Oct 2025 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760557666;
	bh=Z1CdTAHH8JHN/znRHsXXPPZxO88StlEbFnN9lt1dK7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GaaT76r+gfRQKVdJLmns9ZAWbSkKnXLD6L8TrGWOmfLpiSNKE120e2/gVz98HZem2
	 WCkLjCifxsdqPkLRXrwKnzhB0X9Ae3ahn8nd5oDURJJPsSRZwBs2wGQV2emQFUUFmx
	 OCBcXU3z8msLmeGa+s+uTQJnDFZYn4M8lQ4IVwpg4TsVQg544E92xQLptgtI9bw96y
	 q1XY4h9Gg+GN6m8VlrVCI/SGw/ald38ofpdMVqwXDWvNveDaPxJ5NGVuYw1S6T26DC
	 yd8Kpd5+1hlv9CMO6CM2hnO4UbqVTkuFOIQHLUKyAxUo69eERDV2c7PhzlalLvbquq
	 QP4/bxUrIH7jA==
Message-ID: <624195ee-ec8c-4ed4-8ef8-f15fdfc005c4@kernel.org>
Date: Wed, 15 Oct 2025 21:47:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
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
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
 <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 9:24 PM, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit 9def0d0a2a1c ("rust: alloc: add
> Vec::push_within_capacity").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

