Return-Path: <linux-fsdevel+bounces-4990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2B806FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7041F2147D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5B36AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ab3ksY1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B4D44
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:02 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2ca0ab9a5e6so26340391fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864000; x=1702468800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bs2sSu7jP2NPZiCyS3HRAfCV2YiHx8SRHP9dJ3Owk1U=;
        b=ab3ksY1smRD7UsYS63q4Q5vv6b00yeagsS9vqYyFCEW1xm3RTdOUKlgmEpbrN/1CGt
         Y+HFHcNv4mxeQ446KuXztq3vloAlLtm1dtA58Djxw9QhCF+gUNJZTJKQ6V+LVLArpJ++
         XN/SYyok6MV1ZROqIHUlSODPm11p1rrn3lysUJwpUEOkEFwaWFkb6lzWk6JZvkV59YjT
         GGZskqWX1cg5xl+T+BdU6qZulUko5HQKfDOsMW9vWP6ObreePaeLduy6Wbp58s2UVtFK
         8zcI30dM/PJLJXn39NBViZMxhhV9RftsudWhjFh+OYixgxUH/I0AvwUn4MzJY/1SHT5s
         40Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864000; x=1702468800;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bs2sSu7jP2NPZiCyS3HRAfCV2YiHx8SRHP9dJ3Owk1U=;
        b=PHtNi5126NMjMwx1Wp6tPhiZVtbdrIvUJLoMu1o7ZhuQfruHphzP3eQWhngOe6qCRF
         jeFtUGW96ZRq1xaKN7g/I1I4ZKGVgPYAFll8cHjIJH7LbnStN1t5gOhZbC30XHR22cbL
         sRyL7w8BRVh1ehQliyJjU6W5adUojNFoSBHsffsk1ufda/ps4tAsLkj+NECU3f+J/AXR
         g8IATqgmo3fBCWaK93lYhk3fq3cQ3oi2zMvN4RyVpaPxSo1neUi4ZO54Ubt06v5lJ2u/
         ukqwsVjIJtMBKUqzl/yvEbhd7CILUsjj3vdiBuHDyS60ocb+qd93pv9MwBSva6QSIWll
         brhQ==
X-Gm-Message-State: AOJu0YybJ7tBWpoxQmiYLRorAvqJIiYLW/Zf6CDhqtoIN/Q6N5cQFe5i
	JIy1DvTEtWdGBRXyNDlieA4sJ6F8nakHkTA=
X-Google-Smtp-Source: AGHT+IHj1UUgeo0szNjNaqEOewQT3DWlMj81ympQxAzB2Stq8ZJbyOYne5sAvGvgJv7NdX2tQGaiw8vgeGUA2/4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a4cc:0:b0:2ca:217:3ad6 with SMTP id
 p12-20020a2ea4cc000000b002ca02173ad6mr9921ljm.8.1701864000377; Wed, 06 Dec
 2023 04:00:00 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:45 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADFicGUC/03MQQrCMBCF4auUWRtpptamrryHdBHjJB2IjSQSl
 JK7GwuCy//B+1ZIFJkSnJoVImVOHJYauGvAzHpxJPhWG7DFTkrshPZsSFj2JHrsr6MipQc8QD0 8Ill+bdhlqj1zeob43uwsv+uPGf+ZLEUrrJLakjIDHuXZheA87U24w1RK+QCfI8FDpQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3570; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ZtzAhf7x6vcHPQRySpbobpUqBvYjeJWg+KMtSmYWzlM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI4FncNrgyduHzDoDmHvtMDvKXsJQ+z4dAxN
 3XjiaHaNF+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOAAKCRAEWL7uWMY5
 RnG6D/9AYE0+4oRYwt77OJ3shdfyOzoTjvMm15rhUlKWpLWmHL71RXAwpBA8JSzXitefrJMhwSa
 M6kVu9QqTY1sCpLDGlt5wsNrMZL6BBvrTWzC7H2Lr2ifSf9LGzGaznEM/aWJgwGl5p05E1svT8T
 R0aqgoIYkIvucq/lOWyBmOBS0uqI/Fq43fuOzTbMzQCaw2IlqxBeBtUNlJ59DH7N+75Ib4NtL9C
 Y/ksXJi8nATaWY0Ea4tOgyO+vEwinVYglQSMuaT0JcWX3ZJaBmTCHVfQOPySsohtzotExn3e8EF
 nSKVjBYCb5leRqmA0IoOCZ7sjk+T5ljrKXknaw6cNnawO1D2tL5XDzRtq+/+YGs/lNXpw203wPL
 gCcax7y5Q3abpK3f75Lmqtqk1tBtApK1dD1IC0c4q3dy4fm9tJEfl6YiAoySvFkttaVym+LVQ2u
 XF/eAdxXq5jjaCC4DuZsn3XNm5JSM65FZMicORQm9q83Z5MLSAhZYUuB8H4+UwZ4O+s+QUONU3W
 v5XeF+cp42jO2rVdo3bc+xzb7vr/0EP1M9DADBLh40ew22lTk3F7a/tXG7zz0hwTRVMpN97Fx6b
 wh5cstlVcei/ccB8+SeFBBrWqfNLx1EFHf+P4t1w+2xvCFFJ0ZiHd1M4McemO69CxsRq3+0WQiT qHNjnhnNYWp3IAQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Subject: [PATCH v2 0/7] File abstractions needed by Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patchset contains the file abstractions needed by the Rust
implementation of the Binder driver.

Please see the Rust Binder RFC for usage examples:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/

Users of "rust: file: add Rust abstraction for `struct file`":
	[PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
	[PATCH RFC 03/20] rust_binder: add threading support

Users of "rust: cred: add Rust abstraction for `struct cred`":
	[PATCH RFC 05/20] rust_binder: add nodes and context managers
	[PATCH RFC 06/20] rust_binder: add oneway transactions
	[PATCH RFC 11/20] rust_binder: send nodes in transaction
	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support

Users of "rust: security: add abstraction for security_secid_to_secctx":
	[PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: file: add `FileDescriptorReservation`":
	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: file: add kuid getters":
	[PATCH RFC 05/20] rust_binder: add nodes and context managers
	[PATCH RFC 06/20] rust_binder: add oneway transactions

Users of "rust: file: add `DeferredFdCloser`":
	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support

Users of "rust: file: add abstraction for `poll_table`":
	[PATCH RFC 07/20] rust_binder: add epoll support

This patchset has some uses of read_volatile in place of READ_ONCE.
Please see the following rfc for context on this:
https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Update various docs and safety comments.
- Rename method names to match the C name.
- Use ordinary read instead of READ_ONCE in File::cred.
- Changed null check in secctx.
- Add type alias for PhantomData in FileDescriptorReservation.
- Use Kuid::from_raw in Kuid::current_euid.
- Make DeferredFdCloser fallible if it is unable to schedule a task
  work. And also schedule the task work *before* closing the file.
- Moved PollCondVar to rust/kernel/sync.
- Updated PollCondVar to use wake_up_pollfree.
- Link to v1: https://lore.kernel.org/all/20231129-alice-file-v1-0-f81afe8c7261@google.com/

Link to RFC:
https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/

---
Alice Ryhl (4):
      rust: security: add abstraction for secctx
      rust: file: add `Kuid` wrapper
      rust: file: add `DeferredFdCloser`
      rust: file: add abstraction for `poll_table`

Wedson Almeida Filho (3):
      rust: file: add Rust abstraction for `struct file`
      rust: cred: add Rust abstraction for `struct cred`
      rust: file: add `FileDescriptorReservation`

 rust/bindings/bindings_helper.h |   9 +
 rust/bindings/lib.rs            |   1 +
 rust/helpers.c                  |  94 +++++++++
 rust/kernel/cred.rs             |  73 +++++++
 rust/kernel/file.rs             | 431 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  79 ++++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/poll.rs        | 103 ++++++++++
 rust/kernel/task.rs             |  68 ++++++-
 rust/kernel/types.rs            |  10 +
 11 files changed, 871 insertions(+), 1 deletion(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


