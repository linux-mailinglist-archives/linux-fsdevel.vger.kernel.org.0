Return-Path: <linux-fsdevel+bounces-74678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBC5KIW5b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:21:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3224875B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 696F19819FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78828853A;
	Tue, 20 Jan 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5NDBiUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA021D3F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921226; cv=pass; b=X7SlNViOCdb4ZlijJhjsz5iiUg6xmZLdxRohVFBjaRERH7mgScJJd98COxpX054buzTjoUnQ719HaR12tCOsN5/6M9zWJnVqM9VOGIbpO2fT98KN3Or9Oa6ElK8WUM6ER55uJm+qL3uMbJmX2X2wGAVfJD+pe33bC88fZe9Bbvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921226; c=relaxed/simple;
	bh=eCRx2JPQZx3ZvKTps6ymy9n1zPP8OVOc8iEEBj86Fzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+VR1RkqXQbEWJek1brgF40RuxQ04uVUKe1vij74L0cTWzniqhAjqa2It9sdMPSMrAIHl+25Bn7s9wY62tG3LP0Fmp0rh/mMVoFTTZmzGxUMML9hX2T8UeTmrykUICS+IT0l4biU7g5C520GAIbGfvEbMR/XPeGO/RxErcEVHmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5NDBiUX; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c2dc870e194so2413251a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:00:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768921224; cv=none;
        d=google.com; s=arc-20240605;
        b=iJt7VS9iIgAeYjSr6zZUOjng8hVcjzvgmtJZ2+ea7iCH68fff0e4xVKopsvfevz2IF
         TdU7drbaoRCLcSomeynrsJ7zn1V7ajGOGnNPinTa7uOSq8Cars9w4VG1OgMZC9HLr7aP
         ike3vcnNJE53piqHx+u7JrRWzL+Htb8T0kZe78t51CbMxi7gLok8IQGYcKKSOkz88nnl
         D3KRouPIDp6hPEygdTTERi4IxkirLqbGIptt7+5OD1O69/N8NKs+Z59PxIs5apglEnAD
         dM8rTM3WCgb+KnCQfJpTrmzbUO5T8KFwov3Cn2sKQsWlH9uGM4BGDmHSWPSH2+Tacg3z
         3GBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntN0FZOXCuO4g6oSeU/oj/orWdbf+RbpRvRGbr360pw=;
        fh=JYYWW3g8whfORb/1EuUSHCwp7G/D+Vz+wd6hjLkMK9U=;
        b=eE6mlqH59qPhxzh3lul360bDuGbK405YnnzVLGqc3hqqAciQiZaka906GczBml/I+U
         3ROizDV84Ial7eeIiI+fBMWBgarIg03exjhlSDMsKwuL7Z+2c5gYETvhMSuACowiYspM
         BssN5w7IIHDbUR4h0h8Up8OAuNUxuE03rygp3jlb7wlQdDnnBOum+Ls+zWsNnnlj+HUj
         Rsg2/WuF2XsIF96Oa2LDbY8r660BgWgwuELRflmQKzIE2K3CmrrBDBDyW9lSp0XEUGOV
         m4TYjHZy+CqR/hqoTAZuauk/JHUytCqaPsbFYtvkeuv30m/DsjEJt8VFd90TrQnAJqcs
         xFuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921224; x=1769526024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntN0FZOXCuO4g6oSeU/oj/orWdbf+RbpRvRGbr360pw=;
        b=a5NDBiUX5vtJT8lC3C9aqlC/zrbHGf49Llqi87uGCrJO1f7rdfJmPQJrZ9SsjEiU7E
         n31NAkFJ/ly2IDC4ESYdia7emawlZRYfltLg40qSNku/wwaVTtPfdXmC57uU8rUQKsHn
         byiB6FekTYZ4/DnyPq6M3hmLQnmD9pafnryDs3FTg1CSu2RJGw9S0LoVFI26xOPx7qVH
         qYIFMk3Wj3lfjZkyCQ4rPM8QnyeoSgZs7tloM9cKWhIcqGkP51+m3wL6LkuyOaADJ9mg
         RzKzKwOq4pciAL8fGDKqTDpkMtFlNbehMi3ObcUGZ2bR0bkuUU8dEEVI/EJ0I68w79cf
         mlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921224; x=1769526024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntN0FZOXCuO4g6oSeU/oj/orWdbf+RbpRvRGbr360pw=;
        b=R8bc+fAguFuO27da17Nj5ct72ps9KJLAr3R2izhQkwgPFEKmcLlBL07oMXdcyqL4i/
         SzCIA+thyZmfMYSG4ks+Lt9ZQR+6gh4Sdifa88D/d2gpWGf066EcII2K4pRVjUy9VYal
         Ef0E6nTT7WqdIxEGDq6T7ZdIsGhbpgd9DXif8VSzKn4qFgUX5r3i2esfqX7I3G0o4wd7
         Eny02XDtCiDpi8gAyk/iHpspTPEJJoMk92A0z6UdLHnmfej0czsKNp5vik17koH9bzca
         /C5eoFEFJHwcchdv8QWlaoFG4YVSUDL46b2cSKiUXJoy4A9mq9q1pDjn/BixWt/Zrv0s
         wBVw==
X-Forwarded-Encrypted: i=1; AJvYcCV2F+hTCKZDqClWuZJgHbRRu7/KiNqLgGEmHcbywbaJFrBDz68aPX3h4rU20xgBzfvd7Lw1OlC0F2DxaDhf@vger.kernel.org
X-Gm-Message-State: AOJu0YwAnO8lexT5nNu3tSCh8NsjPQ/tKCqVTBi5BBWEMe7Kp0Sa63o6
	H3JVUZv8u/xCicnSD3j26SErJOOq/PP/X8JxEB8r4UXSRYsQMEVFKhm4oG4GxE6NTRTRQKZYQ8M
	0Tsm0ycXVHfuY1SMixNehejNx3XXPrkA=
X-Gm-Gg: AZuq6aJH2I3A3gBrnZ2s/hiDv5YANjv0ePJlJCDfBSNRKOPoYoH+lTI5sz2PkmF1udf
	qiLe47ikElio10xLXoFCqgFMVmqEIxdbF8AsFsTb6qvYt81PCLWx9i1VLpunnUdLMeS+81oyaCG
	ZL0hVkbk2674pgaolaphao7a0ZRP5YC1DQWyxfvppl2+EiP8SKgMKUfX2sE/7LkxX5knCVH6LiJ
	ypbuoD8+XuW0rWZaXXN8RhaEUultFZt1sU8XNKWXQzH62PejLiusMMyoRduVvInZf69XWPUCfjG
	/199+a08fxpKfNCFX4RyNRL8fWAPxlIFyBNspZLgOQ==
X-Received: by 2002:a17:90b:248f:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-352c4078ce9mr1038446a91.28.1768921223677; Tue, 20 Jan 2026
 07:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120140235.126919-1-foster.ryan.r@gmail.com> <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net>
In-Reply-To: <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net>
From: ryan foster <foster.ryan.r@gmail.com>
Date: Tue, 20 Jan 2026 07:00:11 -0800
X-Gm-Features: AZwV_QjeGRbyhZcETrF_TlxFkw6vcha9H78rOCj2rh-0zrtc3n41bt0LtnhvBhY
Message-ID: <CAHtS32__f9=ndqaueWUB1SuuppR2L+ye8b2XeNP4qOindTSoSA@mail.gmail.com>
Subject: Re: [PATCH] rust: replace `kernel::c_str!` with C-Strings in seq_file
 and device
To: Gary Guo <gary@garyguo.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-74678-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,protonmail.com,google.com,umich.edu,linuxfoundation.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fosterryanr@gmail.com,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,garyguo.net:email]
X-Rspamd-Queue-Id: 1C3224875B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gary,
Thi is now fixed, great catch thanks.

Best ,Ryan

On Tue, Jan 20, 2026 at 6:50=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Jan 20, 2026 at 2:02 PM GMT, Ryan Foster wrote:
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible.
> >
> > This patch updates seq_file and device modules to use the native
> > C-string literal syntax (c"...") instead of the kernel::c_str! macro.
> >
> > Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
> > ---
> >  rust/kernel/device.rs   | 5 +----
> >  rust/kernel/seq_file.rs | 4 ++--
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 71b200df0f40..1c3d1d962d15 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -12,9 +12,6 @@
> >  };
> >  use core::{any::TypeId, marker::PhantomData, ptr};
> >
> > -#[cfg(CONFIG_PRINTK)]
> > -use crate::c_str;
> > -
> >  pub mod property;
> >
> >  // Assert that we can `read()` / `write()` a `TypeId` instance from / =
into `struct driver_type`.
> > @@ -462,7 +459,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Ar=
guments<'_>) {
> >              bindings::_dev_printk(
> >                  klevel.as_ptr().cast::<crate::ffi::c_char>(),
> >                  self.as_raw(),
> > -                c_str!("%pA").as_char_ptr(),
> > +                c"%pA".as_char_ptr(),
> >                  core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>()=
,
> >              )
> >          };
> > diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> > index 855e533813a6..518265558d66 100644
> > --- a/rust/kernel/seq_file.rs
> > +++ b/rust/kernel/seq_file.rs
> > @@ -4,7 +4,7 @@
> >  //!
> >  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_f=
ile.h)
> >
> > -use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadS=
afe, types::Opaque};
> > +use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, ty=
pes::Opaque};
>
> As you're changing the import list, can you also convert it to the new ke=
rnel
> import style?
>
> Best,
> Gary
>
> >
> >  /// A utility for generating the contents of a seq file.
> >  #[repr(transparent)]
> > @@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
> >          unsafe {
> >              bindings::seq_printf(
> >                  self.inner.get(),
> > -                c_str!("%pA").as_char_ptr(),
> > +                c"%pA".as_char_ptr(),
> >                  core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(=
),
> >              );
> >          }
>

