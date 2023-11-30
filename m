Return-Path: <linux-fsdevel+bounces-4350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6AA7FED04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89ABBB20F16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004B3C06B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHdfCe8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD28D48
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:36:07 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c892080ad3so12282071fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701336965; x=1701941765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtfFST1hu6uQIKluftk2Tkqzt/TD9qBiJocJOhpEzS8=;
        b=KHdfCe8keuWUgAPjOeEBq96V8I+CZ69pSO8tI5z7racW97tRUBucF7XQPu5yVYdQQ7
         +/DBWgGuXANUs37ZI6dKFc9o7iE+YwowB6u+nlEeFXLgVOiiKzsIx9iseSVZ8DUoFKN+
         bUGxVZ4uH5i3E9f7OSZovdBpLgynqvavU7hk0J5RvnQ0ZRQ66Ru3a8+7XEaOAtVwXMyN
         Ur49PBPfJEOk+PwY4YrpkQqprniBQ/z+VtBnq48CvZBrDnM6VwBYO0DDhGN2Q4X0ssdI
         TxGoO1kly1HyyouhobuXJtP1ynSbO0TpmKXZr2vi0hWeW1MnKlsqqa0xyKHPe+S8HDT7
         y+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336965; x=1701941765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtfFST1hu6uQIKluftk2Tkqzt/TD9qBiJocJOhpEzS8=;
        b=UyNNy6cz5va7khxCiOMEehwJJ6UtXk0gJR+mdDiJFouitWPq58ZeAKecpHURXajT4F
         jpl52A9zbp17wrROehxOwIQJmIWEe7C8MeAhp+jEo203VYJQI1S+Bv1O+s05M3NnS1XG
         b1OCV/tWz343++lOwjoooXxgKqVhMYrzSQiUF3qLLfQRYF8GALiOUJV3fQaLQcaWGrMG
         0UcG7tmOUL3HXbmH7q8W4LzkA9jKBz+DQ8m1mnBCiwzpPoee7mdjlaXrn2CeKU6qZ62z
         znt02NPTKetOoeMVBBxH786BZuHCwbKDfv7w6xnxbCxry/TT8jywKV6223mpwo1SXqqx
         rOSw==
X-Gm-Message-State: AOJu0YwpiKjt6UQaVvyj5Zg6ls3iXf9ZK/o3DrmLY1PnzU37lNa3nk6P
	P2QTMlBmnUdfnl+F+QM+zh7V4qkzaDaLOdI=
X-Google-Smtp-Source: AGHT+IGr3t6cRp0wtyHhcLDzWjsIAFKJ15RL7mKVn9SyM4cYRc5icSBSb3WXOwXPFhH5FEUuXjC70CHhIaK8Z5c=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3e0c:b0:50b:d3ab:daaa with SMTP
 id i12-20020a0565123e0c00b0050bd3abdaaamr5314lfv.0.1701336965612; Thu, 30 Nov
 2023 01:36:05 -0800 (PST)
Date: Thu, 30 Nov 2023 09:36:03 +0000
In-Reply-To: <20231129-etappen-knapp-08e2e3af539f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-etappen-knapp-08e2e3af539f@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130093603.113036-1-aliceryhl@google.com>
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Christian Brauner <brauner@kernel.org> writes:
> I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> why they are needed? Because they are/can be static inlines and that
> somehow doesn't work?

Yes, it's because the methods are inline. Rust can only call C methods
that are actually exported by the C code.

>> +    /// Converts this kernel UID into a UID that userspace understands. Uses the namespace of the
>> +    /// current task.
>> +    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
> 
> Hm, I wouldn't special-case this. Just expose from_kuid() and let it
> take a namespace argument, no? You don't need to provide bindings for
> namespaces ofc.

To make `from_kuid` safe, I would need to wrap the namespace type too. I
could do that, but it would be more code than this method because I need
another wrapper struct and so on.

Personally I would prefer to special-case it until someone needs the
non-special-case. Then, they can delete this method when they introduce
the non-special-case.

But I'll do it if you think I should.

>> +impl PartialEq for Kuid {
>> +    fn eq(&self, other: &Kuid) -> bool {
>> +        // SAFETY: Just an FFI call.
>> +        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
>> +    }
>> +}
>> +
>> +impl Eq for Kuid {}
> 
> Do you need that?

Yes. This is the code that tells the compiler what `==` means for the
`Kuid` type. Binder uses it here:

https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/context.rs#L174

Alice

