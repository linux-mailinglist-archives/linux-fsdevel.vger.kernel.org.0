Return-Path: <linux-fsdevel+bounces-5838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B459F810F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FA62819A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728D23742;
	Wed, 13 Dec 2023 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMeN+1N/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B295
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:02:48 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2cc3005da23so8057251fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702465367; x=1703070167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wF8JoHNULRLQuvkLOWSPJJbTKCRhS7xnLTzqlYvSs1g=;
        b=TMeN+1N/ZauI5KZf61b3oHUXaDJqbktHfTdUC5kh6SdT1BOtnxHFjcIVlAryO9meS6
         O4xMnR2KEFnp5XSrpek2R2J6I4/Xxc1DDbUlyoFQS2mYcnCORUEuU1nOsNwuZqAbKRXN
         Tvz6ZVsxcveRIVLQP/4sCRHtXBoGdHODMLJ3X5dubCzsIbqfb9fE74PS2lqTRyeUw7R7
         ECwPiDhq9PTiz2UlNx9lg/w3spCLAMPDM49iN2O+aB3Kj5sbZ4FpOhO47OYNSaZdFKpw
         zVwiL4Rhab5yH0UDfiOrTnao4o/nZ5lWNArn2MYqZ0dOrIFIu1BPJe7cgRrsmir+2pSA
         1XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465367; x=1703070167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF8JoHNULRLQuvkLOWSPJJbTKCRhS7xnLTzqlYvSs1g=;
        b=o4CtwWjjKlDn3HRAD1o7+iTR+XxJQnTZ63NXyDCHwkXiwr6+FBsAXkkIY0jJc+EynQ
         Mm7lBsvtYgIzapTJjcs+Tg3yq925mtELe+xOV17gSLvOHHqAa7VIJjmHo+1I48bhbpGK
         unV1A5esgwmPwZHPVTf6cvUxv7kk3DrVqX1egpwnnnuQRa9iJGOKJJkyiPSljkW/WFce
         In/z6J7OtKeMb2jgZvw6t2Bo7E3VG1CsRschcu9N9jlm3dlrmuk+EFeOaSBYknzA3Tgm
         QP1K5gn5Ji4ikqDc2w5zVhBFNhbDaPiCzYJ/1lHvJRs4Wj/7ZOi1DyZMKKKl/Ff32gYS
         eplw==
X-Gm-Message-State: AOJu0Yxf7425jfk6U28WIO/RwPg5NgUI0pXfbqtTqJg2lSDogFehtwKG
	K+a3YaiqsZxyYBPX6/OLIfjiRr/YfzIFVGA=
X-Google-Smtp-Source: AGHT+IG8r/n61eq7vzq1h7EddFgGLqT69C2TTHTuuwMHQzYKsTazngtWEvA6k0fmgGuhq8lXkQ0iXrRHMRNxYbs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9c8e:0:b0:2c9:f93d:994b with SMTP id
 x14-20020a2e9c8e000000b002c9f93d994bmr127544lji.4.1702465366826; Wed, 13 Dec
 2023 03:02:46 -0800 (PST)
Date: Wed, 13 Dec 2023 11:02:44 +0000
In-Reply-To: <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <E-jdYd0FVvs15f_pEC0Fo6k2DByCDEQoh_Ux9P9ldmC-otCvUfQghkJOUkiAi8gDI8J47wAaDe56XYC5NiJhuohyhIklGAWMvv9v1qi6yYM=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213110244.446502-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
From: Alice Ryhl <aliceryhl@google.com>
To: benno.lossin@proton.me
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Benno Lossin <benno.lossin@proton.me> writes:
>>>> +#[pinned_drop]
>>>> +impl PinnedDrop for PollCondVar {
>>>> +    fn drop(self: Pin<&mut Self>) {
>>>> +        // Clear anything registered using `register_wait`.
>>>> +        //
>>>> +        // SAFETY: The pointer points at a valid wait list.
>>>
>>> I was a bit confused by "wait list", since the C type is named
>>> `wait_queue_head`, maybe just use the type name?
>> 
>> I will update all instances of "wait list" to "wait_queue_head". It's
>> because I incorrectly remembered the C type name to be "wait_list".
> 
> Maybe we should also change the name of the field on `CondVar`?
> 
> If you guys agree, I can open a good-first-issue, since it is a very
> simple change.

I think that change is fine, but let's not add it to this patchset,
since it would need to be an eight patch. I'll let you open an issue for
it.

Alice

