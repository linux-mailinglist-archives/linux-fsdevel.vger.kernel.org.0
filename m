Return-Path: <linux-fsdevel+bounces-5509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8080CFA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E731C21484
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FE4C3AE;
	Mon, 11 Dec 2023 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVOG2RBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A84111
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:39 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50c1c0710f6so2452105e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308877; x=1702913677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=stu0ZJZ/iLBAZujmR+p0lyyYHMpojeVivEZwAc09IiI=;
        b=JVOG2RBXpgkYv28ZrIIeKFc+eDkGGcxdfTjlIh4qJJ25AWuruy/dtD+I2U2Kb6CcVp
         fht/4jrJi9scxT7Se98ChBYWUy43uuvyyIPzPShVfqCfsDxL1buvpBxP7pnO6l/lPLl9
         V3vDz9zzsXJIab5sCi4spx68TzQ41RnGtdarog3PIjgMDsh1CHi0a94MyMsXYin43+UC
         E23GXFSV3jvIV0KtKoomLUcWZxSJ5AxeZ2cqzzuL+DCuD0QAcKDZ9AzyD4ThD8PW5ROt
         qbLgHkmRfG+BMlwTjI0zEFWTTcb+g34UJ9148DADPIS/5UmwW23N2z/MTeUMnFoZ/PBh
         35RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308877; x=1702913677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stu0ZJZ/iLBAZujmR+p0lyyYHMpojeVivEZwAc09IiI=;
        b=kGiLQdHm6ud6dxRK800Y1L3YuiC2kX72PlNOI+G2ZJ/C6SBTE4gW2044NqpV39IrZc
         LAoNbe+QEQUvkqmcpuE6WIJ4nlyXk+3ddqKMr7ulOrsNesL7GQe9fULpekLfyaEyyYM3
         H47eafZt6/BExncosdrZiJpx8hdVDLFhRlJieBvjcoEId+MDzSO+Y805Lg2aPp/XPPQP
         c13D/FDYt715lSV9Wkd4aSjD7h7Q3VLPN3F4zobn8MTL48GREL1BQkWgHvQsVwneHFWX
         +DJFSyJRQ6DY4Y/qTeGdPMRo4ZyHWr3SJoBNVbwcENeaytS/JFeHkS4OFxXR07Lb2aH3
         VHPA==
X-Gm-Message-State: AOJu0YwzmcDGLRavAYmMZ6oioybP9odr48TXuKUstxIvO3vmlUcrQmji
	9Dh0L2im5t67DW39fe3AVvSxAKo0zsoGY8s=
X-Google-Smtp-Source: AGHT+IHe/749pN/R8WQkCJ1upgaYzu708xvKyEorYDCSSeYyZ0ox0S8WXyOzIyQ9xNHiCWGEDFo6MKwF6uX2Tes=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:4c0a:0:b0:50d:1395:ef0b with SMTP id
 t10-20020ac24c0a000000b0050d1395ef0bmr77884lfq.4.1702308877536; Mon, 11 Dec
 2023 07:34:37 -0800 (PST)
Date: Mon, 11 Dec 2023 15:34:35 +0000
In-Reply-To: <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ooDN7KSgDTAyd45wWcPa1VLmvo-fiqwDmffX1Yl8uiesYUcgnCZq5dcd6fGw5sVYMusZGpEI4L5avLCqNXXM7opR627oUp1NB-TIHOwJufg=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153435.4162296-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 4/7] rust: file: add `FileDescriptorReservation`
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
> On 12/6/23 12:59, Alice Ryhl wrote:
> > +    /// Commits the reservation.
> > +    ///
> > +    /// The previously reserved file descriptor is bound to `file`. This method consumes the
> > +    /// [`FileDescriptorReservation`], so it will not be usable after this call.
> > +    pub fn fd_install(self, file: ARef<File>) {
> > +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
> > +        // guaranteed to have an owned ref count by its type invariants.
> 
> There is no mention of the requirement that `current` has not changed
> (you do mention it on the `_not_send` field, but I think it should also
> be in the safety comment here).
> 
> [...]
> > +impl Drop for FileDescriptorReservation {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `self.fd` was returned by a previous call to `get_unused_fd_flags`.
> 
> Ditto.

I'll update this.

> > +/// Zero-sized type to mark types not [`Send`].
> > +///
> > +/// Add this type as a field to your struct if your type should not be sent to a different task.
> > +/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
> > +/// whole type is `!Send`.
> > +///
> > +/// If a type is `!Send` it is impossible to give control over an instance of the type to another
> > +/// task. This is useful when a type stores task-local information for example file descriptors.
> > +pub type NotThreadSafe = PhantomData<*mut ()>;
> 
> This should be in its own commit.
> 
> Then you can also change the usages of `PhantomData<*mut ()>` in
> `Guard` and `TaskRef`.
> 
> It would be nice to use `NotThreadSafe` as the value instead of
> `PhantomData`, since it is a bit confusing... 
> I think we might be able to also have a constant with the same name
> that is just `pub const NotThreadSafe: NotThreadSafe = PhantomData;`.

I was able to get this to work with a `const`, so I will use that.

Alice

