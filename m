Return-Path: <linux-fsdevel+bounces-66326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDDC1BED3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BE66E015E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEF3358A7;
	Wed, 29 Oct 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p14OK/pA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74132862C;
	Wed, 29 Oct 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751597; cv=none; b=akKfZtf4CaToVDCuul9bE4RMs/pdlFX2rflZTV3NruECeS86ClDNVew2KOwb6kqreNLXd7t6FulUVEWCC0+i/iALyj6PJreMlbxe/aaVHMH/+AAnfTMELaDDtALYrIsnBQJdPiFWKJbtxdupyPAhnGJxGmd0B6dlTeNHARtwWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751597; c=relaxed/simple;
	bh=DOI6gyVeo4a6kw7xLiiWwg46FMQvx6VSCtZfRDcnTjc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=d2jqfL8tu/mvZkLu07JrC91QyT5cAIXe6++/emF/7UDH2yyLZ9/iw1IQs/D0hSGibeRP9xMTSLQ1I58IINoyjT6vjrQV9R9/qB9Z8D5yQDqvCoOQlVfYCBcteXYnfn3ZYbDCCKABPzX9EQd+EQsoevVO7a9y9O/ebBlpsNJn5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p14OK/pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1052C4CEF7;
	Wed, 29 Oct 2025 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751597;
	bh=DOI6gyVeo4a6kw7xLiiWwg46FMQvx6VSCtZfRDcnTjc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=p14OK/pAxog1HFDJrJs0vo0gmUYhgqGQcPcbeoSNofB1v6oECmN/OP5xhM1Fi8l3p
	 2WIxf/xTZwds0sAujVxkm9LHAvP9RBIlYG8w1xccSzVIyvp2kwTsalJbW3Aapwfzf+
	 qtzlEGqjkC8JVRM95YcopwoEa632ZaMeu/lmd1w2PEn+GehZQO0gP3eXSKPlBLghKa
	 bHxi7jtVm9Zw556OHI8yk8/sZ1awvekCUj51stG+qYAVxNd4wGCjUNEWvwcNFwdUs/
	 UBlGJrhIhdtxV4jufH+UaT+KUaj+bCpebyrjoF8eCeJNff/c/3OCJx5YCJ3n1cKbKx
	 vEc/yUZesOZOA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 16:26:31 +0100
Message-Id: <DDUWTG8C84CF.TIASKA4B1K6Q@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-2-dakr@kernel.org>
 <20251029-orgel-eishockey-44848cc46a6d@brauner>
In-Reply-To: <20251029-orgel-eishockey-44848cc46a6d@brauner>

On Wed Oct 29, 2025 at 1:49 PM CET, Christian Brauner wrote:
> On Tue, Oct 21, 2025 at 12:26:13AM +0200, Danilo Krummrich wrote:
>> Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
>> avoid using raw bindings types, this seems to be the better alternative
>> compared to just using i64.
>>=20
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>> Al, Christian: If you are okay with the patch, kindly provide an ACK, so=
 I can
>> take it through the driver-core tree.
>> ---
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks Christian!

Based on Miguel's suggestion [1] v3 of the series introduces a new type for
file::Offset rather than just a type alias.

Therefore, v3 [2] is significantly different, hence I will wait for you to =
reply
to v3 before picking up the entire series.

Thanks,
Danilo

[1] https://github.com/Rust-for-Linux/linux/issues/1198
[2] https://lore.kernel.org/lkml/20251022143158.64475-2-dakr@kernel.org/

