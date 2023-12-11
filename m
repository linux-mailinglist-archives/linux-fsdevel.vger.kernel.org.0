Return-Path: <linux-fsdevel+bounces-5507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B680CFA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3212821CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047B4BA86;
	Mon, 11 Dec 2023 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWhHsPc5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576CED
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db8d6cadc6aso5390019276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702308872; x=1702913672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiZZ9BWQrfU3B+itk0uJFctS4sy+cPBcfjf8sS4Yi9w=;
        b=CWhHsPc53L99xpDSpeF0SBWwLHvlPUff999OwvzcmiKbbYpR3GnWiThPbjcfHGrVUD
         7iIxJbHrdgImBkd9hNsjCZAk5Rv8mF8umKh1RdViUzIdPwo2PUAwna3ZYuWndVvMtYHB
         jKuHT1jyvqS9a0BVsqNu4Rn2Uy7sMIdDkJMjOoWiKCPC7X/CYmqTB9xuL4uORXlLLGjx
         u4czkqOHRJQrgGZZ0VsHUmTxw1Oozm0zhwDvGSQJg9SPqvsh4kHU1cBmlz+OcWoW/Pam
         rP2Jvw65C1Z2Yinypw92b+2tfnClS4gAHOGwzrNQX9SXUGIXEanjYYfuhnhvddRje4Rr
         hd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308872; x=1702913672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiZZ9BWQrfU3B+itk0uJFctS4sy+cPBcfjf8sS4Yi9w=;
        b=mTZV4NBnteNA01Be0ZImWGLWHADkPNluQ+Yntc+92kxGJ9uN4KbxlTSfBjXU2Mxnkm
         fOsqg7wadZ5yjlv4kT13UjqbgaMi9zAXdy3MLnR/QHb9C7yrhSOTN3RNXWDrOHIoyiA9
         s9frL/ZR7HENfH8WQFqeF+8Zl1bSfMW88u0T8Quxr2nLyJ0LkvY5C1pT7NTFTEfi7jO0
         rweiEd/STJ1CMzBcZ2+ykanfnil1V2uO6sTIDByqBvP6tCmBK0OJ5l3v3VcQ37cpAVl5
         cQVhGwNVuwkck6t3IMqpqFVBQE/6OKaxQbOsGfYA0CwbC0zf4NB/kZggTOumvKeTJpCH
         bWNQ==
X-Gm-Message-State: AOJu0YzxL45oJR4M1q2bcA16gNsIhHIYT0zwyUfJaMzgxxcE+3eCGftd
	LhSNG8r5eTC7yoMViq1KA9C8J33awF3/SjE=
X-Google-Smtp-Source: AGHT+IHjep4U52xAMd+Y/b1o+2FrpgTrAImOr+BT/csxNQyrNZAhy+3hPBTOFvPRd40QEX6hnE3AilS3NrISjn8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:698e:0:b0:db5:3fa6:d4d1 with SMTP id
 e136-20020a25698e000000b00db53fa6d4d1mr40063ybc.13.1702308871579; Mon, 11 Dec
 2023 07:34:31 -0800 (PST)
Date: Mon, 11 Dec 2023 15:34:29 +0000
In-Reply-To: <ZXZjoOrO5q7no4or@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZXZjoOrO5q7no4or@boqun-archlinux>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211153429.4161511-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/7] rust: cred: add Rust abstraction for `struct cred`
From: Alice Ryhl <aliceryhl@google.com>
To: boqun.feng@gmail.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Boqun Feng <boqun.feng@gmail.com> writes:
> On Wed, Dec 06, 2023 at 11:59:47AM +0000, Alice Ryhl wrote:
> [...]
> > @@ -151,6 +152,21 @@ pub fn as_ptr(&self) -> *mut bindings::file {
> >          self.0.get()
> >      }
> >  
> > +    /// Returns the credentials of the task that originally opened the file.
> > +    pub fn cred(&self) -> &Credential {
> 
> I wonder whether it would be helpful if we use explicit lifetime here:
> 
>     pub fn cred<'file>(&'file self) -> &'file Credential
> 
> It might be easier for people to get. For example, the lifetime of the
> returned Credential reference is constrainted by 'file, the lifetime of
> the file reference.
> 
> But yes, maybe need to hear others' feedback first.
> 
> Regards,
> Boqun

That would trigger a compiler warning because the lifetime is
unnecessary.

The safety comment explains what the signature means. I think that
should be enough.

Alice

