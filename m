Return-Path: <linux-fsdevel+bounces-5829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380C810DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495C51F21216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A93224CE;
	Wed, 13 Dec 2023 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUEdBuJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE0A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 02:09:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcca990ee9so863550276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 02:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702462162; x=1703066962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMjiZ1Mla0TJIvfZN07yuuMqisYwNLMlxhRR40WgnKE=;
        b=rUEdBuJWwCar4cLrt6t73JyuSbctkJAChccfZ4x8p8fIffEyv+tcx1ffnERubMQCAL
         w01J4bT8p7cldJfJH2WUF5CvL7O3AW7TZ1kVZqGuUf0aMzytoLgawo2IVWb6wPY/2fam
         Ae0m0vM7tEVKSvU28bh1OKe5KIrVNXCitCJQKvseQAI00MuqWPEhgRC26sL+kBTxMO7o
         V/PxVIxFiqWyFtLHdZP0Qjanl6e/rFuwsQTBoYpNHzCG2+Ne/6DAK+GpW9BQELv+5lND
         1wjRKQ91IPdY++DDTXiocHiKDyKs7LXTtJv65EgzmDuGt4LUNEl7n9FEma7HJVJJ55Zy
         uDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462162; x=1703066962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMjiZ1Mla0TJIvfZN07yuuMqisYwNLMlxhRR40WgnKE=;
        b=ZfV061PlaFp40+nJ5bDlVGD+lGowmwzhzIfBBCXsdcMeffXp/Hbjpgie71i4i8guEr
         lq/OOH57pIcztCJoaVfB/0tvHrcvCUAhAauXlWroRJzi4zEL8EG92UTiqlkccxJnFAa+
         6XU8m8fDicE/9xq3D9faQUJ7MH+oLG0J7HcyFtW5e0M2upijcIypYWYb5lpSNhh4ywLr
         a022ArmDzFtj6o7ukaGHtilBAKpK0rInKIY6PYLbFHfbIgkeufUMy29MSZltWAxlcSoH
         1bKyjWlPshVJ1QgVZKrJji5XoURZt0Iz6VByYEquPv/oldnTfpJilkpibRWR3wjE9hwO
         RMHQ==
X-Gm-Message-State: AOJu0YzEpMob+ld3mZgVsXlZZza7pA/cwsLWdmFg06J7YV6KINKWLLxs
	lSr76FqEYOTiKMxk6gWmqM5G6RUDaJTV7CI=
X-Google-Smtp-Source: AGHT+IH1VF9gQH/zvDo8sZsOOMLcD8dWkfvwJA1iOSJh8Gow9jwJUdpnt5y5GZa/kNlrATJlzEmAqJR3Np4SOuA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:c78d:0:b0:dbc:c98f:8075 with SMTP id
 w135-20020a25c78d000000b00dbcc98f8075mr10120ybe.12.1702462161656; Wed, 13 Dec
 2023 02:09:21 -0800 (PST)
Date: Wed, 13 Dec 2023 10:09:18 +0000
In-Reply-To: <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213100918.435104-1-aliceryhl@google.com>
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
>> and here we can said,
>> 
>> "per type invariant, `qproc` cannot publish `cv.wait_list` without
>> proper RCU protection, so it's safe to use `cv.wait_list` here, and with
>> the synchronize_rcu() in PollCondVar::drop(), free of the wait_list will
>> be delayed until all usages are done."
> 
> I think I am missing how the call to `__wake_up_pollfree` ensures that
> nobody uses the `PollCondVar` any longer. How is it removed from the
> table?

The __wake_up_pollfree function clears the queue. Here is its
documentation:

/**
 * wake_up_pollfree - signal that a polled waitqueue is going away
 * @wq_head: the wait queue head
 *
 * In the very rare cases where a ->poll() implementation uses a waitqueue whose
 * lifetime is tied to a task rather than to the 'struct file' being polled,
 * this function must be called before the waitqueue is freed so that
 * non-blocking polls (e.g. epoll) are notified that the queue is going away.
 *
 * The caller must also RCU-delay the freeing of the wait_queue_head, e.g. via
 * an explicit synchronize_rcu() or call_rcu(), or via SLAB_TYPESAFE_BY_RCU.
 */

The only way for another thread to touch the queue after it has been
cleared is if they are concurrently removing themselves from the queue
under RCU. Because of that, we have to wait for an RCU grace period
after the call to __wake_up_pollfree to ensure that any such concurrent
users have gone away.

Alice

