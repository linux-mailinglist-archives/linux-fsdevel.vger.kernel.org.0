Return-Path: <linux-fsdevel+bounces-71371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043CFCC002A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E01AB3088630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586432D7E0;
	Mon, 15 Dec 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJFBVJaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663E283CB5;
	Mon, 15 Dec 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834853; cv=none; b=l4BVOQWB7e7Z+OugWCJfnO1HqpMesY2FiKYMB8pT+1Ml8KUheNRCO5YZkCUHRVyJ/h55YOWLNW/s82SpmvlG4+5oLF144UC5Oi9NnuFMeXc3+kUhP8ackpR/ZphNT3cPZOmjJqqBAKhGjP9vTG2uNNQDLhPb3EzZHCGx/Ea/tcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834853; c=relaxed/simple;
	bh=8+QhW2cFWJDaIsuT5yDSI4nyUtquLCwiDgHnqtP3F00=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=iZa8a7r+2ylEoXN/5AMjvVHz+9Ocf5w3clQGeqvOoL6mU6WaxQPrufYZ6bmS0TTyy0qv1XHS+IX4Jjp9r7x4HS+Yru/w75me2GbY0seOLoSjNuANpxYIhUgPWfnUtkuUDJnjrHQLol4NXiGRvslMzo0SMqZwm2ACrDUOeawsdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJFBVJaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C486BC4CEF5;
	Mon, 15 Dec 2025 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834852;
	bh=8+QhW2cFWJDaIsuT5yDSI4nyUtquLCwiDgHnqtP3F00=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=qJFBVJaC0an3Wy7ck/NW3yKgi9jI3ce1I7gVQW8XUmK+OrJgE8FAW+WL7g4D9LvFe
	 /YXSYPoFx2CSzUrpqi11o2qDr8G6z/1Di0ZaklBXTyTMLUzpgYiEXa6CG+nuC9aEPB
	 oPLpWQpGwbvBrApASVSXJtWBeD5j9+j8eCEqoYfQukbOTAQU4/7mRVkdeQh7josQjH
	 EqqCHJPOqdShwjRa6dHuASX87J1if9DJv4RbmhpyPx7LNZQF9y9tpD3TU8/KUvv9Fl
	 o6XLqSg9GmBVn/+MChjQ3SmuTHxo55lUfl8ovjSyyVqKmJtl1P2uKHl4dlIN5739w4
	 bHhzsM+PVC1lg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 22:40:36 +0100
Message-Id: <DEZ47GQSH2NC.UBRRY2WDHUJJ@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Carlos Llamas" <cmllamas@google.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 <linux-block@vger.kernel.org>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <linux-clk@vger.kernel.org>, "Benno Lossin" <lossin@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 <linux-security-module@vger.kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Robin Murphy" <robin.murphy@arm.com>, "Lyude
 Paul" <lyude@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 <linux-fsdevel@vger.kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, <linux-kselftest@vger.kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Andrew Ballance" <andrewjballance@gmail.com>,
 <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Vitaly Wool" <vitaly.wool@konsulko.se>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>, <devicetree@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-pci@vger.kernel.org>, "Remo Senekowitsch" <remo@buenzli.dev>, "Paul
 E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>, "Will Deacon"
 <will@kernel.org>, "Fiona Behrens" <me@kloenk.dev>, "Gary Guo"
 <gary@garyguo.net>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Waiman
 Long" <longman@redhat.com>, "Mitchell Levy" <levymitchell0@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>,
 <linux-usb@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Matthew Wilcox" <willy@infradead.org>, "Tamir
 Duberstein" <tamird@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/46] Allow inlining C helpers into Rust when using LTO
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>

On Tue Dec 2, 2025 at 8:37 PM CET, Alice Ryhl wrote:

Applied to driver-core-testing, thanks!

> Alice Ryhl (46):
>       rust: auxiliary: add __rust_helper to helpers
>       rust: device: add __rust_helper to helpers
>       rust: dma: add __rust_helper to helpers
>       rust: io: add __rust_helper to helpers
>       rust: irq: add __rust_helper to helpers
>       rust: pci: add __rust_helper to helpers

        [ Consider latest helper additions. - Danilo ]

>       rust: platform: add __rust_helper to helpers
>       rust: property: add __rust_helper to helpers
>       rust: scatterlist: add __rust_helper to helpers

