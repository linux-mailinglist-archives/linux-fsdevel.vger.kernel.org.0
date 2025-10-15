Return-Path: <linux-fsdevel+bounces-64314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E39EDBE0834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 21:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE99189BA3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF36310627;
	Wed, 15 Oct 2025 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAY0f2Ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AD27510B;
	Wed, 15 Oct 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557520; cv=none; b=MZ+iKuOH3JVz8pe7FlFufBYjqD4z8NR4nSr+8GUecevoIMudZfeOaNQiG2FMSsyTVOOrw/1cYvYJpMcTxWBDI4RiTH6DYtQ33rBhOrW/wvapl7DZgS+ab6sPJSdk0hCg3E20lNnRTCfN4cL2QU5r7YpOfPATAnMvoysxLDOv2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557520; c=relaxed/simple;
	bh=IWDvgHrNRXsJC6ijNTXcpCrTPLdLcwSZQO75DuUtld4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQQo+i4p+TYSmFbGGMkSYPJAIHQD1ZAsiAOg/0ZoNqfWdXxwnAThB+BCzIm3cPhOhmtDFSIcQYNEc2bAdWpPEW4n6rospcz7xkHKQIPJu1yT99YNjU0DnbRmGZVsQJv2ZVKlEs9mXCCMVlJ4kMBk8+OMZluyjs9rLNOqLBP3d0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAY0f2Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55264C4CEF8;
	Wed, 15 Oct 2025 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760557519;
	bh=IWDvgHrNRXsJC6ijNTXcpCrTPLdLcwSZQO75DuUtld4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fAY0f2JaiK+L78/flAUN8QiA5PLdaoco58+74U03xlfzkq7U/ceNc/ryrYaS/ShbG
	 U2sWY6LTCXaRyPKSzJaOTD5r1+T8tX8j8AEheIroLYNCmhfWcWFFR8DxVuWVFzCExC
	 kAKWHgyFVND72AlJBnalQty5cj8/LJZy+bwkG+K1r6L+SiChRTrsODC7FE5qQsnvVW
	 fFst4rhw9wTAALS2Y+w9mqzXtmkBxQZh/5QW36NZjxh8ucfILsXZ8IochlHBEcNhe1
	 gF80a3Gen9Y9T0e/PhiiPQNuzq2GzakAezxFK3ZGLUkk2gqzf9M3qV5Z4/OMKv8r9d
	 sdjlTwLMcku2Q==
Message-ID: <8274ea26-b08c-466e-a323-f8ddc7fdaa8a@kernel.org>
Date: Wed, 15 Oct 2025 21:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 07/11] rust: debugfs: use `kernel::fmt`
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
 <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 9:24 PM, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
> 
> This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
> callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
> support for read-only files").
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

