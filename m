Return-Path: <linux-fsdevel+bounces-64315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73550BE089E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC5848049E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A530E847;
	Wed, 15 Oct 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmObyqqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF0306D54;
	Wed, 15 Oct 2025 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557605; cv=none; b=iYs9nSyupPZUo+OmcFcVYISuVT4UPP/vGe+hl3DDRulneFMN8uGMc93ZIXjNAqnE01jXK7eogi5oD7Qc4VxDJyx97a0UEae54r641DNwUgQ8M5PiTLk/5o2N7b4tc6LNwYZh0SFzDVu+PgPnC7x3umXyAFhy3/5hvbMGZF4Fxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557605; c=relaxed/simple;
	bh=trNVlACVEPgu/xTitsGyA6WROkVMAJ73k0f72uIbq9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awfNPF2MzRQDvqjAT0Pe0ykKGJ1OWk0XpQubUCwcYrP/hHCSfEr3ahm1ho4nZZo7K6ZOHycrW/2/itDbItaQTctzfMMxrvtL6jKkLAvM9qnEAoB7flIPyzW+f6PYXz/2YPRY96CK7q4DJxvJ5aMuXtJHtKdlwEqd5vehN4ZszSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmObyqqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC874C4CEF8;
	Wed, 15 Oct 2025 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760557602;
	bh=trNVlACVEPgu/xTitsGyA6WROkVMAJ73k0f72uIbq9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PmObyqqrrXdgPiR6pShRrB6vaHUSCGHOOCIIRlke82WNd1memIa+huxaOAudBJjar
	 G7rrlBkbwN+IS97TIGrepcpGkJzWvXTy27x/oJIfdKaNkJy8ClErmR+4IYD4Jve7Pr
	 Iz+tycZOrgcK1lU1Zzqt1uzgcrR8usTt1syL1oDl166B645Ez/uPrioHc520aFWAe0
	 N5AKIzvQZEkRHlUiwx1V3+AykIk9EIFaTpLiyjiraj5F3ZEW6Ht7pleK357zCcdsO5
	 /tGXPc65kk523Y5v4HNCtMaYdBwmtF6pUCQZyQdFOxHRIp7xw1W+lJm39sLiulSJUS
	 ecg3YsxQVF40Q==
Message-ID: <4c1f4cf1-a00e-4145-80eb-a1dbc86258f6@kernel.org>
Date: Wed, 15 Oct 2025 21:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/11] rust: pci: use `kernel::fmt`
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
 <20251015-cstr-core-v17-8-dc5e7aec870d@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251015-cstr-core-v17-8-dc5e7aec870d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 9:24 PM, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit ed78a01887e2 ("rust: pci: provide access to PCI
> Class and Class-related items").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

