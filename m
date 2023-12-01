Return-Path: <linux-fsdevel+bounces-4566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48344800B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AE51C20803
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959C2555A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyZfR5+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890991708
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 03:47:53 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50bc102a951so2493201e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701431272; x=1702036072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6g1GqQ4TrIojcjyDirpeDTGx+n3XD+xjD29/oGpLNfI=;
        b=MyZfR5+SGN0FhAH/+aiSSa5Fxv2pKfXcJ+75yqnXxvQjqbNBeRDcQcievpFYglujkc
         DhXM1fo4edTrakiCOx0FM97hNtPZ2d3TUjRlBcWqMTBlNK/4vsxmoZySEsnRr/lIbh0o
         u13iyIyylhncz+mzUvZwCrjXs/UfStO5j6AhlIKNWYz42BpacRM98h6iUwOnQglafX7W
         GAOwVQGkKhXO/IieXBopZMOZFizm3nmcYWuhdnIU+tIqdfdw17KzDTYq5s5QV8bCEyoc
         SPyvuLP+6BEN9O+/33w0xAM3ikaYuwNxU1t2+J1Z4htSXGgZ+ufmSa90DdR6GLXR/fFD
         0xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431272; x=1702036072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g1GqQ4TrIojcjyDirpeDTGx+n3XD+xjD29/oGpLNfI=;
        b=uD9whBKgAR7hDHEz64n0n2AT3pOagON2jagf/m6rSLgnAh86EVH8CrDluRRvTIC1KN
         CTOwwu/C344dPGC8OQoIM1yScYJti8Qj37Yez7oEZdHYPweUUNpbrUgNoCsOO/CUCWfV
         DJ/59zPO7Vuh8TP7tapj7cMNIy7ClgC2rym/TswRvdgkj8FhphGeDFEadMMcRymy9W+A
         Fjl6vym+R6L+8wmJGmHBtbIHbPGPOSXblzSrtTiD8j1sgdMnZX5Nc2nm9zYa6+bwUjfH
         NmsXjoqM4IEM3nxPqaSJXgnq0EJNvut9g2wRbqAXZwfxc5b3V+tC+S0V3jmGpVVTY2bz
         GOzw==
X-Gm-Message-State: AOJu0Yx3JXyR3EXn6pBRFwdt+YP+Gvd486xFQ2ceKSn//hPdIrIeluA0
	Pzw3mkfjin591OGdRa82XQCdpUtaUeAFscY=
X-Google-Smtp-Source: AGHT+IGmdHD9ndeAoG99U6CjjEVBhoGpQPpovxP6HXHrU+LrFLBMj6V3Szk+lEYNslRiUnlO96T3DeFoBd52niY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a19:c207:0:b0:509:440f:3c5 with SMTP id
 l7-20020a19c207000000b00509440f03c5mr41495lfc.1.1701431271741; Fri, 01 Dec
 2023 03:47:51 -0800 (PST)
Date: Fri,  1 Dec 2023 11:47:48 +0000
In-Reply-To: <bH_zaB8RmZZW2QrGBx1ud7-YfKmh6QvTU0jYKC0ns7jjoDkCWYnW3u1qX_YrN5P0VwsZGd7U5r8p-7DxH7pb4-6UUE0htwTkFNdDIYZb4os=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bH_zaB8RmZZW2QrGBx1ud7-YfKmh6QvTU0jYKC0ns7jjoDkCWYnW3u1qX_YrN5P0VwsZGd7U5r8p-7DxH7pb4-6UUE0htwTkFNdDIYZb4os=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201114749.2207060-1-aliceryhl@google.com>
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
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
>> +#[pinned_drop]
>> +impl PinnedDrop for PollCondVar {
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // Clear anything registered using `register_wait`.
>> +        self.inner.notify(1, bindings::POLLHUP | bindings::POLLFREE);
> 
> Isn't notifying only a single thread problematic, since a user could
> misuse the `PollCondVar` (since all functions of `CondVar` are also
> accessible) and also `.wait()` on the condvar? When dropping a
> `PollCondVar` it might notify only the user `.wait()`, but not the
> `PollTable`. Or am I missing something?

Using POLLFREE clears everything. However, this should probably be updated to
use `wake_up_pollfree` instead.

Note that calls to `.wait()` are definitely gone by the time the destructor
runs, since such calls borrows the `PollCondVar`, preventing you from running
the destructor.

Alice

