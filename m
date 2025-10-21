Return-Path: <linux-fsdevel+bounces-64969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9BBF7A52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEE61895834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68C3491F7;
	Tue, 21 Oct 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIpUjTDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1252DECB0;
	Tue, 21 Oct 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063919; cv=none; b=b676Xn2a5V33X7dhfK5XZCE0VMq6rL2CY9qiPfDebqhdG4xa++cJQcql8xBT9hlXU65RB/TY67zboZtLi+41BiQ8Cni3rbuERYb7SMfnXZSoBB/LXIGvD4Y8f+MYZElrcT72baRM3yMA3mJb65NPdFLHVSUASR55DRAAxn/4u3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063919; c=relaxed/simple;
	bh=GLITs9zjBdBSvzzK+ZY0HT3b2sXh0hAOul8PY5ytXgs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gtDR/b037cTZJU2LmUlQchHVXdL0OC0VLGv6Yj6OyTw9NI0IUAcKE76U7dk33LhoSChuoL3jo1J3Yks+p7TD5kxMJW2aaq57ro8RkOOEuOILXXdwEqlhYxgQ4Pe1ckgMHGE0kiMgaj+Egfx0oN86If2SH/ulhupzTUnQonsTAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIpUjTDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69490C113D0;
	Tue, 21 Oct 2025 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761063919;
	bh=GLITs9zjBdBSvzzK+ZY0HT3b2sXh0hAOul8PY5ytXgs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=BIpUjTDkqAI6vPrOLhNtZyWgzjiiBCif8978z7YcatrcV2X0hUk5Be/b66Be3dQhE
	 D0lDE2f1v0HR/eFqOlFOrMIiMj1vFaiNfY9zngnT706UdrNlLK5kqWRxv75NTmPLl3
	 QtKFOOdi0b9JLMl9jJJdtPhZisVzNdrUOcAVKckXX6gl66KUSHMl4mfAwgBVGkgKKA
	 jFxogmhPnHq7V91cWMoWdagGpiDJf36eddEntQV+IfYriqCH/BPW8Wfin4Wi8fyymp
	 EeYKIgh0e4JXZB0WUvcFwaxPX9Kya5N8f1nMqTr8WAh9JUteeGlWhTOtqUSBse4gO/
	 uLiQgZDcraQdw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 18:25:13 +0200
Message-Id: <DDO521751WXE.11AAYWCL2CMP0@kernel.org>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
 <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
 <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>
In-Reply-To: <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>

On Tue Oct 21, 2025 at 6:00 PM CEST, Miguel Ojeda wrote:
> On Tue, Oct 21, 2025 at 5:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> Yeah, I don't think there's any value making this a new type in this cas=
e. There
>> are no type invariants, useful methods, etc.
>>
>> In fact, not even the type alias is strictly needed, as i64 would be suf=
ficient
>> as well.
>
> Even if there are no type invariants nor methods, newtypes are still
> useful to prevent bad operations/assignments/...
>
> In general, it would be ideal to have more newtypes (and of course
> avoid primitives for everything), but they come with source code
> overhead, so I was wondering here, because it is usually one chance we
> have to try to go with something stronger vs. the usual C way.

We need arithmetic operations (e.g. checked_add()) and type conversions (e.=
g.
from/into usize). That'd be quite some code to write that just forwards to =
the
inner primitive.

So, I think as by now a new type makes sense if there is some reasonable
additional semantics to capture. Of course, if we'd have modular derive mac=
ros I
think it is reasonable and makes sense to also do it in cases like this one=
.

Maybe the action to take from this is to add this to the list of (good firs=
t)
issues (not sure this is actually a _good first_ issue though :).

