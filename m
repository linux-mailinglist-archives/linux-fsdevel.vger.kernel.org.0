Return-Path: <linux-fsdevel+bounces-67018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE4CC3378B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7EA4EA081
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF91235C1E;
	Wed,  5 Nov 2025 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHoP5FKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6DEEAB;
	Wed,  5 Nov 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302349; cv=none; b=Y8Ofdi97y1o0HcfFbq/YxqanS5toU2oV0BUku/0UYulZqZhbtjMFaA839IzT6WTAlxF5LMXPGzBVDd+gw1GsaV+/WNBvsK4XOJ5GHSNNxgdzKRMctNFci+xJzczgx4CHXy0UEUCwa3bEXBDcvV1R5+aLtLFK+ULmrpaK8sYrvTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302349; c=relaxed/simple;
	bh=Z8w2z+03SmQ97nB4usv2XGNg4zk5LCc+uhg74KhVCAE=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:Mime-Version:
	 References:In-Reply-To; b=EimtM2uhIV/rTdsYaC5+u5HehqAo8yLgrGH2sr/t2oeXk66xloHxFkLfyX8bOMTZPU8FW0IEZwLyqwYkkwXDyzpMEl4+hdgO9t3QGWO9FhcDYSrp4UYMT2omowALwJ1xByHf+2wyNWMjxDHg1aQ7bRAVeFdcP7nDjIbXME5Z+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHoP5FKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6EAC116B1;
	Wed,  5 Nov 2025 00:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302348;
	bh=Z8w2z+03SmQ97nB4usv2XGNg4zk5LCc+uhg74KhVCAE=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=AHoP5FKWHvQwMDVguAOkh27Pgb/nzrse8MvVV4epZRXHRUBwUlrpH14MwU8g+vRWA
	 GSwBlXV1Jb9xrXNvLEL5rf4VejJPtNM/SQZ5FnezjYSx32F+HFoygS4TFCCugJFpBW
	 J1KBm2nx3UPRv3A2le48B+tHJODYxnmvSuFzlf7l3K1uOQQ77Y0arc4UySxsEqOALj
	 C7BMiBGHkoQZY7GEMFuy26pPzU8K0LfyX7x18eMKg+KJiNEhukGAZQTXIV2kJOpyyd
	 vnrues8Ca+jRU2CB505T1cJJmQ1rvfPotOjv24o3YPnw0LanBan02xIGVxYOnpPT2I
	 vdXpi4l2GB7ZQ==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 01:25:43 +0100
Message-Id: <DE0C1KA14PDQ.Q2CJDDTQPWOK@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <mmaurer@google.com>,
 <brauner@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 00/10] Binary Large Objects for Rust DebugFS
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-1-dakr@kernel.org>

On Wed Oct 22, 2025 at 4:30 PM CEST, Danilo Krummrich wrote:

Applied to driver-core-testing, thanks!

> Danilo Krummrich (10):
>   rust: fs: add new type file::Offset

    I picked up the version from v2 [1] for now and send a follow-up series=
 for
    the new type approach [2].

>   rust: uaccess: add UserSliceReader::read_slice_partial()

    [ Replace map_or() with let-else; use saturating_add(). - Danilo ]

>   rust: uaccess: add UserSliceReader::read_slice_file()

    [ Replace saturating_add() with the raw operator and a corresponding
      OVERFLOW comment. - Danilo ]

>   rust: uaccess: add UserSliceWriter::write_slice_partial()

    [ Replace map_or() with let-else; use saturating_add(). - Danilo ]

>   rust: uaccess: add UserSliceWriter::write_slice_file()

    [ Replace saturating_add() with the raw operator and a corresponding
      OVERFLOW comment. - Danilo ]

>   rust: debugfs: support for binary large objects
>   rust: debugfs: support blobs from smart pointers
>   samples: rust: debugfs: add example for blobs
>   rust: debugfs: support binary large objects for ScopedDir
>   samples: rust: debugfs_scoped: add example for blobs

[1] https://lore.kernel.org/all/20251020222722.240473-2-dakr@kernel.org/
[2] https://lore.kernel.org/lkml/20251105002346.53119-1-dakr@kernel.org/

