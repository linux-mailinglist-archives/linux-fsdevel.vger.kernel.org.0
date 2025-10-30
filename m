Return-Path: <linux-fsdevel+bounces-66491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA72C21060
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69336464AC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB22D738E;
	Thu, 30 Oct 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1SzNsdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8537A3B4;
	Thu, 30 Oct 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839192; cv=none; b=q9o4Kj8g0DrJM/BwyLhJRHBHlZd3R53Q0hRUyzRC9eyyUUdl4d2q96UPMVHas3nLutwsHR8zuyKIwpiPE0mcZq6MqhRhaGO6Ge2Jn6W/0g3Dp75xrscInwUUDWRE6TYacahAuw6t2eth9HbA92ruIeWBxweH8nhq+HZfJ7qtwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839192; c=relaxed/simple;
	bh=O/MqUXCRBsW16T+2gZ3rWCpjPcBmGWYAl4TCaK+lbCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPSOhkgxUKkh3nYrzaEkwtjgA1fHXoeOo8zKwp24HnQIE2bR2jebLYLcGzePRab92HcHO2knou83DyhcUFxDmuxiinw3p/GyB+DgN8hm7wB4y4Gz5S230v+bC5xDmckUnXJ/ZKnK/vzstfwPP9JFmSSMJLrh3r1hCuWmFsaWOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1SzNsdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFF2C4CEFF;
	Thu, 30 Oct 2025 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839192;
	bh=O/MqUXCRBsW16T+2gZ3rWCpjPcBmGWYAl4TCaK+lbCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1SzNsdp5hbJDctJABv9DD+krmMc+E7r+PzqKq+suUwPLPF2TnoDV97v51iZBhQQF
	 edKwc1fRvaceCyNvbBbLZdP7MIEs0B4Mz2XmTMyL1k2yIlYW7kymvud3qbDnatsq31
	 rGyz5mZOqxo94hgiBfIipp7MThtcOqLAY4AziBY1Ui61TZedHbo3buIszUfISRrUAv
	 CdxUoLHzvsg5zhcm0JeesYZSAtHIpYBkK3AwdMVDIWu72EekccXSOERPt3oyEwmiWL
	 +we2VxkBPIaV/T5/KRbYxQUsCqvk3nZFLhtYJ70Pofduob5Y8MTbffjVNLN5IdRqgS
	 a+CdDxqxwa/Qw==
Message-ID: <0fcabf65-e24e-4f7b-9217-15344c926dee@kernel.org>
Date: Thu, 30 Oct 2025 16:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
To: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Benno Lossin <lossin@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
 <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 11:03 AM, Oliver Mangold wrote:
>  rust/kernel/auxiliary.rs        |  7 +++++-
>  rust/kernel/device.rs           |  9 ++++++--
>  rust/kernel/device/property.rs  |  7 +++++-
>  rust/kernel/drm/device.rs       |  9 ++++++--
>  rust/kernel/drm/gem/mod.rs      |  7 +++++-
>  rust/kernel/pci.rs              |  7 +++++-
>  rust/kernel/platform.rs         |  7 +++++-

Acked-by: Danilo Krummrich <dakr@kernel.org>

@Miguel: Please expect a minor conflict with the drm-rust tree for the DRM GEM
changes.

