Return-Path: <linux-fsdevel+bounces-4189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1F7FD983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB702B20E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7461BDD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZPXqjwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FA10F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 04:51:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d10f5bf5d9so41704877b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 04:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701262287; x=1701867087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2N/ofzIt/J+wCFOM2pibimYKXpmkpO1wPP6NtnVIANM=;
        b=xZPXqjwkwhR7SRFuAgv1Lu2tgSn5EKrCVYq17tBaL7KJRVm+k5cJajpa30QasNFF3A
         wZS7Nfub4wzzQgew2gvJwDN8cjtlRbc6C4zZOSt+UiZLT6RTzdgzDmz+IefxGlSLvONU
         Ycw/rCCoQ5sEeNCS5cib5Xdt0W9KQvi6TX5+W6pPMJNMsZz4aBMLJYGtzdW/EYJASDhY
         EBvBkWxujPRzHAwC2VMffcFT7D2CtYAbEVeori5yPfSGrOzcxaWNxrKstUbtmw63yTVV
         ZqL5y7huNa3rHs27/ZXcQwZZ33Hg2A9nLsc80oVAGaFNiWGWXvXXY0Zvh0injtW6iNy4
         1djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262287; x=1701867087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2N/ofzIt/J+wCFOM2pibimYKXpmkpO1wPP6NtnVIANM=;
        b=mtak5rBoXWnCuUYAf39sgdzVYWmIHKnnQkD5sgNOdJyGqKx4Iepd5vDcohT+RJB8P0
         w7IO2pJxvxQGlQFfgKeKUGDQ3Jyd/Yq5CiJ+jNl/RCqPo29ErVCT2rkd04CLwRkvAabI
         lflDZBnBAG3nwZAPhL0ycCglrIlMoCEh7fc87JDJzakYPcmr0zbA1byXU7xeweBz1n2C
         i/4d9Qizqi9dOnrxAs3pG5Q9pYmivhFbBSV4t4mkZHY2K635R1llnJ/dqUjNPHDZw7Cc
         o8KiiTu5wai48e8P6mL+sQZc4lqsSI1CRKLzUZsbvgdZtyXaujN9dEj9we3sHxXY8r9/
         IyhQ==
X-Gm-Message-State: AOJu0YzCYRYCwF848pWinNPlgC/q7ZGUzWEXqN7BtL1VXL1pAeM0tfgY
	a/yK8yAJt7qSfnOkYmorYEbaPO+t+UNwlOo=
X-Google-Smtp-Source: AGHT+IESrOtQoQtAGRmxIIFtaD9grXO1Snn1SAzJMGNl8sCxMAVeC2bUeW+vcwDNyNNbUBFUz+R3QUJ8Rii/9mg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:842:b0:5cc:cd5e:8f0e with SMTP
 id bz2-20020a05690c084200b005cccd5e8f0emr544311ywb.0.1701262287138; Wed, 29
 Nov 2023 04:51:27 -0800 (PST)
Date: Wed, 29 Nov 2023 12:51:06 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+8JhMF9v7HhOgu+j5LmeUnyp713AXkmAoTCIofolqXI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlZzMx3pGGGonpV9d387PqvhcFyHY30cl8eTKds
 G/Zoe8o2QqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZWczMQAKCRAEWL7uWMY5
 RsZ3D/0QtI2KNlAPGhZhDHyFLRMViW9DpyAam3A2OsOjPawOiE/VnYGNwTYSTODJHUSDSDXnh7p
 cU67qdKQRnhTnL1ZC+b5Q3PoHPj0ZNawSTz/z+HY/ezeOAZaX72/PBqz9kbQ6wQCFhMYrqMjG5m
 tr+ftZKl9hQj5lYQ4UMjvqW5uG4H+J9eJGEedMo87vxL3v249UgALSCAZTCiIGMcUmwFHPqKDP7
 skwpUO6zJG/hEULaVfE4FX2NvgUeU2W+/z9lXEvbFz1dg2zXLrJiqt7Hx8sNd4lz55h6Enar//W
 kkCGdfST3lKIXkepjBjv9Ws2zxb0CzTZsaRxIUsRkyGSTKfsXXf9fcVo9Qsh0UFBccz2Aexb/yB
 ohYQwiHggZCbUUWBT3pCDbN0AizxpknjIGREphxjAe48vRXi5YmIJ3YS7Y/9DiQ8laHYeabdE5n
 HxrWyqOUUp3HYC7aDX6qnnBYxg91DxbRGeZGKbTbqcy8y83SF13zARZRIH7njuX2lpFwyXOdQAq
 rOaPUePKp0r8ZXBtCHl+GYl3Mc5HbZ9O0yxloNKv9Ysl6vZo86bIOPQ8CgZS9kcgXtM7Z3RjUzk
 48wUXLr4Bc42MI9GXaLa9cBWSv7YBMuagk6/CjgfsG6Ajnyn4qqeYY1ZFNBbEbUs5wkt4LSkB79 3N75iwGdi3L8lNQ==
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Subject: [PATCH 0/7] File abstractions needed by Rust Binder
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
Cc: Alice Ryhl <aliceryhl@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

This was previously sent as an rfc:
https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (4):
      rust: security: add abstraction for security_secid_to_secctx
      rust: file: add `Kuid` wrapper
      rust: file: add `DeferredFdCloser`
      rust: file: add abstraction for `poll_table`

Wedson Almeida Filho (3):
      rust: file: add Rust abstraction for `struct file`
      rust: cred: add Rust abstraction for `struct cred`
      rust: file: add `FileDescriptorReservation`

 rust/bindings/bindings_helper.h |   9 ++
 rust/bindings/lib.rs            |   1 +
 rust/helpers.c                  |  94 +++++++++++
 rust/kernel/cred.rs             |  73 +++++++++
 rust/kernel/file.rs             | 345 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/file/poll_table.rs  |  97 +++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/security.rs         |  78 +++++++++
 rust/kernel/sync/condvar.rs     |   2 +-
 rust/kernel/task.rs             |  71 ++++++++-
 10 files changed, 771 insertions(+), 2 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231123-alice-file-525b98e8a724

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


