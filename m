Return-Path: <linux-fsdevel+bounces-4342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC47FECFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF79B20E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72553C07D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/y9wWP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F330D66
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:18:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so843002276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701335879; x=1701940679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O12+T4VHs59BbmEd4p1QKD8uv+vZIjQpPLDFbLiopH8=;
        b=F/y9wWP4HV0Cs8PzAfsCU7uJrkH9qlj1xMQmJwIlr7ExMwwylsCI3LE09vRBZ8WC0t
         pv/qjMkOn4OC8fQvOFHsHjS/sPZi4KHnsp73E9/yJcihOugDKt8TQ2Ezb+PUxDss+t7U
         lSj5EUn3iE4oR4dCPqC++yQwpzktZu4dZ7kRCpQl0ITgu5xwinnRGsjRGOmLclWoS3tV
         Etb6KA/cjAVz6Dew7A946kKLYaoTSx1qKSMySKaxqPExxldT4vx/n+3ZFkVFUSkmRCMy
         cUKuR9yJ1elKEpGsWrPtaranGSUY2HAah7+LEawhlFQ+QzxCXODv0JR43MTG6vxXNiZK
         lXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335879; x=1701940679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O12+T4VHs59BbmEd4p1QKD8uv+vZIjQpPLDFbLiopH8=;
        b=auzkjJqeAWRMBPiB8EQIahg2FKGPyAEJ0/ymYOecReRyJifNbeOPva4LVfOKTv2Zsh
         yWrjrb4kk2bqnEO24D+lxTv+hvYU7RzNaMcNEgdojZO8oTw19oMotBLzzbJAEXrdyZjj
         m7ywKlFB3eVNUFkourRljF8AJMd8hbpnXoKBs7UlQhr0r3o2teUlANedEdYISej2h2qX
         qCi/kY4HiyzXdjCG9G6kpR8HtGj+FhtQSeesy+OZy6z8FvTc7SD4QztDdecqfSZ/aiiB
         WZSdfJLf3keSjxoNufCUnwZlNQfq44WuVQSb5nsM6zHdKWbO2xG0w0zBl49ICPHd9JV7
         VzdA==
X-Gm-Message-State: AOJu0Yz+qFru4v9xMgce94cnrSjVhePPP2Hvoh69MiCghpdqXVDDSpoQ
	M75v/NDj5ZYbHVFHDteVxQVD+Ekr2XkYKqY=
X-Google-Smtp-Source: AGHT+IHzPN7vc8Ym+e7HloN4Bx1IsbMnveO7SXtX9AogNS+hR0lbo+Q4FrLB3KXr1ynr8S4Zs45Va9u9mfVb9Gc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:d604:0:b0:db5:3b5e:3925 with SMTP id
 n4-20020a25d604000000b00db53b5e3925mr45069ybg.12.1701335879254; Thu, 30 Nov
 2023 01:17:59 -0800 (PST)
Date: Thu, 30 Nov 2023 09:17:56 +0000
In-Reply-To: <20231130-lernziel-rennen-0a5450188276@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231130-lernziel-rennen-0a5450188276@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130091756.109655-1-aliceryhl@google.com>
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
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
>>>> +    /// Prevent values of this type from being moved to a different task.
>>>> +    ///
>>>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
>>>> +    /// owns the fd in question.
>>>> +    _not_send_sync: PhantomData<*mut ()>,
>>> 
>>> I don't fully understand this. Can you explain in a little more detail
>>> what you mean by this and how this works?
>> 
>> Yeah, so, this has to do with the Rust trait `Send` that controls
>> whether it's okay for a value to get moved from one thread to another.
>> In this case, we don't want it to be `Send` so that it can't be moved to
>> another thread, since current might be different there.
>> 
>> The `Send` trait is automatically applied to structs whenever *all*
>> fields of the struct are `Send`. So to ensure that a struct is not
>> `Send`, you add a field that is not `Send`.
>> 
>> The `PhantomData` type used here is a special zero-sized type.
>> Basically, it says "pretend this struct has a field of type `*mut ()`,
>> but don't actually add the field". So for the purposes of `Send`, it has
>> a non-Send field, but since its wrapped in `PhantomData`, the field is
>> not there at runtime.
> 
> This probably a stupid suggestion, question. But while PhantomData gives
> the right hint of what is happening I wouldn't mind if that was very
> explicitly called NoSendTrait or just add the explanatory comment. Yes,
> that's a lot of verbiage but you'd help us a lot.

I suppose we could add a typedef:

type NoSendTrait = PhantomData<*mut ()>;

and use that as the field type. The way I did it here is the "standard"
way of doing it, and if you look at code outside the kernel, you will
also find them using `PhantomData` like this. However, I don't mind
adding the typedef if you think it is helpful.

Alice

