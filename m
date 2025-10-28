Return-Path: <linux-fsdevel+bounces-65907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FDEC144A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 12:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9992F543600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C43019DA;
	Tue, 28 Oct 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl08F8Au"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282425486D;
	Tue, 28 Oct 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649478; cv=none; b=fUC/41q+3rMkQqOoNRF/kxoHyFWbch1H8D+N1mInkhd06hB2YHmJdXH6KIUKCXrxlYvgdG+UYH+Y98232FR0b9plUzXNTDbZrY/7E0pXSy9MSrSzliuhZsSPkODG3OzuZKKunBznTyaN7NyCtsJEoUbHp5X+paD63rSs2IgNtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649478; c=relaxed/simple;
	bh=Nr1TjBvAVErLatk+EPKgN5nozMQN9Td3KH/r2qEfF4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=kfwTNXlcIacM9d7QaC8E5Fp/T8Xzkc1YayAVxXQ8PobjaT4aQDce0xAEXEaLQBDSibcdDrfqEOxBQQ8E4V8BeZbPI/iMBDERASwqTXC9vxu92fgG2+SeJ50C2XdCx8AXoybVwDsJ5VyfHWKV46wZFGmv87n7rOQuCoOw9dSPeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl08F8Au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF02BC4CEE7;
	Tue, 28 Oct 2025 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761649478;
	bh=Nr1TjBvAVErLatk+EPKgN5nozMQN9Td3KH/r2qEfF4E=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=Bl08F8AuQJBvtMag5RR24K8gRrQ4IncLRuDgGmGHk32wTdOzAB6rea7rLb9skx6wd
	 PfD3pJqefOEgYBdcxKLPRhYonV1Jv6J7Vx9LyqlKhZbTcFr3gFiOITS7vvHBeoZfed
	 eGZUXurUfRhrxT32jBU8IlG04aZ8EnvsibcmPp0Dk9tsrPIKj292Qyi/6AAMNZBVvm
	 GsnzvtyGT97GiPKu7dq9Rri+/5eXAK3Z0R0z0gvCZWO8GvT2AczajmGC45sCF2SYpC
	 3GelvsvbSdHGFr2FzjTmeLpy9uk5mtJ1fU0uXZCcm3vGKaklJP/1vxrO7BBi0N9cRz
	 RHSid2Aw3xXLQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 12:04:33 +0100
Message-Id: <DDTWMBN2Y0I1.1WS6NLZFDC2B2@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 01/10] rust: fs: add new type file::Offset
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>, "Jan Kara" <jack@suse.cz>
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-2-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-2-dakr@kernel.org>

On Wed Oct 22, 2025 at 4:30 PM CEST, Danilo Krummrich wrote:
> Add a new type for file offsets, i.e. bindings::loff_t. Trying to avoid
> using raw bindings types, this seems to be the better alternative
> compared to just using i64.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Christian, Al: If you agree with the patch, can you please provide an ACK, =
so I
can take it through the driver-core tree?

Thanks,
Danilo

