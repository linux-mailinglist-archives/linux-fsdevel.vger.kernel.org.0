Return-Path: <linux-fsdevel+bounces-62814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1237BA1C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBAC1C27231
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDCA321F2A;
	Thu, 25 Sep 2025 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTWBqhfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A0235358;
	Thu, 25 Sep 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838340; cv=none; b=WRyxPvZSdl1f8/xFIg91nVUZqFvydUg6j9NwO4tGzdrvmHRZrLtWYeNugo+sdx9s9MZrwQE22ZCzEecDMvqhWiJzWyzQ4329SVKacJNNecoOE3mQSnNYg0QYOTT7ZYvWl+gjG2XX4Fs4aJ78R/pUi3vdEeG5abw8blVAM33LKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838340; c=relaxed/simple;
	bh=c7108jwqpOV4+pWr+PhgmM1iKDmFVdJiyCtcy1mN2cY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uFMc8n1x2uc33QxPaTXpwANG/F3V/KVZ66ciIgadO+oILGUaPZ1O1t98BTFu0PRn5cmJXyctiqsoGRuJ5k7bpXfWJiYIq2yeL6NqK0ZYjJCgtOi34meIvh0HnTQvFLT7jeKBeSfSlvLTgDyZdRQHoznxRtTuVq2CT1O6BqNDDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTWBqhfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ABBC4CEF0;
	Thu, 25 Sep 2025 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758838339;
	bh=c7108jwqpOV4+pWr+PhgmM1iKDmFVdJiyCtcy1mN2cY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JTWBqhfZxOwUEuDpU8HMg9wskI7rQ2bhGgOMM5JaFNn7OZZFkUYF4DgZwGNQkmdSW
	 uUwJNNV218XJp0cK8cfwzwLs7Y7nccd+DXiv+vZwJwGkE0zT8ajUaBaFMKgRE9gt3J
	 9wJxt7DaG1GR5DAVStev5fRHal9v7CCXed3tI99B/OCRd4Hn5VB67ZOu9Qx6V2G49c
	 ygdytilAIcB13MK2jUDvK/mgpCE2ElRi29eO4U51HhfN/tOS9AdZ7GDL4qtZp63cLK
	 RRkdPTmB5EafZ3qqXa1AHfBZRax0WxluH7Pa0aPnnXhrY9IMZpWhF2xxg8bk9Nq1xl
	 ctKy2Ch/HdHxA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 00:12:06 +0200
Message-Id: <DD285GJWLA78.10DN8N20YVHQI@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 18/19] rust: io: replace `kernel::c_str!` with
 C-Strings
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Jens
 Axboe" <axboe@kernel.dk>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
 <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-18-78e0aaace1cd@gmail.com>

On Thu Sep 25, 2025 at 3:54 PM CEST, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/io/mem.rs | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

