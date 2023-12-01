Return-Path: <linux-fsdevel+bounces-4548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63628800853
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CEA1C20B28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102E20B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRDiVXl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FFD1700
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 01:06:40 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50bc42e2bffso2235876e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701421599; x=1702026399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JTU9CaHiSbs+o3JtKXRUkQIh0ncmcY1dLiLoH2GmSc=;
        b=eRDiVXl/J1Agej0Ydb4tN2X57AnRHeJUzyHAhbzAm1VWss/THydLxgLa0hQdGZN8dw
         5pEH1Tys+h+JWpqEmUDzLS+jB9fR8AhUGSjO/2KrqKOH5R4Tw3h6QeGxa+hxFjYFdkgJ
         dcXgR4C7Cqy9PcvY5RVP7yDmEtcqAoQNOl4eL3Xc0/ym1QruDVjN3sAq2VtCwtZ6dh64
         sqkH4mM51y9XsWFRtNawvuDHB36V3dWG8ClVyHMvuszrjpEMU+nWQzoOaBXcwlE+bwiw
         QYG8i/depsz5/nDVozJaNkZLVsNB0wwkg1MVUttrLEoWWFpg8j4XHlT4QZgpURCzFQwK
         Kwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421599; x=1702026399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JTU9CaHiSbs+o3JtKXRUkQIh0ncmcY1dLiLoH2GmSc=;
        b=heeC/odsq8OjUwQJovwOLPUdlPMqheLgj8K2Wbzi1lIUwAfpleY6c7DptUxo67DZla
         JLhmw3rChjYBn03sVy6YWZBQLEq0I7S6Bu3Y4b8puybn4e5l4eR4kDMlFhWdS6oBdMLV
         mIwNx1giVb2SQZpeWXaoQo4ty91ZYzjDOEeVhYOKJd7Nw/lTknzYg1lktBdWQ1ge7P7Z
         4DQnEzv/HSAIhvLywB69s8xoHFQKM+s1AeTewMDlNZBYmpSViJY4kq1/LyouaxmlnGjn
         MJD2vK5kBiV/a5m/4FmmgQHtnsoAbZMZx9zfpQIS7BSeWciDa9p11DT11XP2AZXVey1e
         m1dA==
X-Gm-Message-State: AOJu0YwRLHiCh3rHdq7sAngvzJkREBj3wddWSQAdFNXUDaFvM6OJ4cZo
	FWaedFPjkSG3YLiJFj0SBAcsx9EZwaRulAA=
X-Google-Smtp-Source: AGHT+IF1d71ZSf2Kl5mbx0A46QnrKWBkTAOhf3JIYbyOUWPIwbkOelkfoAfTB16bjtarCcRq9aTx9X9Pkee6Tmo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:203:b0:50a:bbf5:6697 with SMTP
 id a3-20020a056512020300b0050abbf56697mr34127lfo.4.1701421598775; Fri, 01 Dec
 2023 01:06:38 -0800 (PST)
Date: Fri,  1 Dec 2023 09:06:35 +0000
In-Reply-To: <W6StBLpVsvvGchAT5ZEvH9JJyzu401dMqR3yN73NZPjPeZRoaKAuoYe40QWErmPwrnJVTH7BbLKtWXDOMYny5xjwd3CSLyz5IYYReB6-450=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <W6StBLpVsvvGchAT5ZEvH9JJyzu401dMqR3yN73NZPjPeZRoaKAuoYe40QWErmPwrnJVTH7BbLKtWXDOMYny5xjwd3CSLyz5IYYReB6-450=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201090636.2179663-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/7] rust: cred: add Rust abstraction for `struct cred`
From: Alice Ryhl <aliceryhl@google.com>
To: benno.lossin@proton.me, brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Benno Lossin <benno.lossin@proton.me> writes:
> On 11/29/23 13:51, Alice Ryhl wrote:
>> +    /// Returns the credentials of the task that originally opened the file.
>> +    pub fn cred(&self) -> &Credential {
>> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
>> +        //
>> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
>> +        //
>> +        // TODO: Replace with `read_once` when available on the Rust side.
>> +        let ptr = unsafe { core::ptr::addr_of!((*self.0.get()).f_cred).read_volatile() };
>> +
>> +        // SAFETY: The signature of this function ensures that the caller will only access the
>> +        // returned credential while the file is still valid, and the credential must stay valid
>> +        // while the file is valid.
> 
> About the last part of this safety comment, is this a guarantee from the
> C side? If yes, then I would phrase it that way:
> 
>     ... while the file is still valid, and the C side ensures that the
>     credentials stay valid while the file is valid.

Yes, that's my intention with this code.

But I guess this is a good question for Christian Brauner to confirm:

If I read the credential from the `f_cred` field, is it guaranteed that
the pointer remains valid for at least as long as the file?

Or should I do some dance along the lines of "lock file, increment
refcount on credential, unlock file"?

Alice

