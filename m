Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFD58AD77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiHEPsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiHEPqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EAC7644F;
        Fri,  5 Aug 2022 08:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DB96163C;
        Fri,  5 Aug 2022 15:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A176C433D6;
        Fri,  5 Aug 2022 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714298;
        bh=2O7rDzGknHUONz5jDr4WiG2pJk6ft5qCpRVES6Cny8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6BofthD7nPdtoU4kjWX2RS2mCKIW68Uqeshywrg2McNTNNL/+21AT30ah6eFitZz
         etmAlYQwj3YXrSalTsy/RnM27VNTbqtwNCLr+6XL3Klt3sQydr7d/VBdD5zjv31TUU
         LOtKJunfPtvBBWH5oMkT10pSS1dUh15ursCYRbkLdTUfc/8U4Tqdnmmm3+k/3TgRxt
         IeTM81xnZRr0FRYW4PqqrZM/czhw3HOZ7wj9N/Xw93VEmGovSVVtB6wBUuiFrireJf
         gWUTEvPAwNKFIDh1whfrWq3y+gDSbr7rzhooaoM0aYoOcDdmV3lzmnLDHKmwAoMye9
         63FrBfNtvBT2w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Milan Landaverde <milan@mdaverde.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 26/27] samples: add first Rust examples
Date:   Fri,  5 Aug 2022 17:42:11 +0200
Message-Id: <20220805154231.31257-27-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The beginning of a set of Rust modules that showcase how Rust
modules look like and how to use the abstracted kernel features.

It also includes an example of a Rust host program with
several modules.

These samples also double as tests in the CI.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 samples/Kconfig                   |  2 ++
 samples/Makefile                  |  1 +
 samples/rust/Kconfig              | 30 ++++++++++++++++++++++++
 samples/rust/Makefile             |  5 ++++
 samples/rust/hostprogs/.gitignore |  3 +++
 samples/rust/hostprogs/Makefile   |  5 ++++
 samples/rust/hostprogs/a.rs       |  7 ++++++
 samples/rust/hostprogs/b.rs       |  5 ++++
 samples/rust/hostprogs/single.rs  | 12 ++++++++++
 samples/rust/rust_minimal.rs      | 38 +++++++++++++++++++++++++++++++
 10 files changed, 108 insertions(+)
 create mode 100644 samples/rust/Kconfig
 create mode 100644 samples/rust/Makefile
 create mode 100644 samples/rust/hostprogs/.gitignore
 create mode 100644 samples/rust/hostprogs/Makefile
 create mode 100644 samples/rust/hostprogs/a.rs
 create mode 100644 samples/rust/hostprogs/b.rs
 create mode 100644 samples/rust/hostprogs/single.rs
 create mode 100644 samples/rust/rust_minimal.rs

diff --git a/samples/Kconfig b/samples/Kconfig
index 470ee3baf2e1..0d81c00289ee 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -263,6 +263,8 @@ config SAMPLE_CORESIGHT_SYSCFG
 	  This demonstrates how a user may create their own CoreSight
 	  configurations and easily load them into the system at runtime.
 
+source "samples/rust/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 701e912ab5af..9832ef3f8fcb 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -35,3 +35,4 @@ subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
+obj-$(CONFIG_SAMPLES_RUST)		+= rust/
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
new file mode 100644
index 000000000000..841e0906e943
--- /dev/null
+++ b/samples/rust/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig SAMPLES_RUST
+	bool "Rust samples"
+	depends on RUST
+	help
+	  You can build sample Rust kernel code here.
+
+	  If unsure, say N.
+
+if SAMPLES_RUST
+
+config SAMPLE_RUST_MINIMAL
+	tristate "Minimal"
+	help
+	  This option builds the Rust minimal module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_minimal.
+
+	  If unsure, say N.
+
+config SAMPLE_RUST_HOSTPROGS
+	bool "Host programs"
+	help
+	  This option builds the Rust host program samples.
+
+	  If unsure, say N.
+
+endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
new file mode 100644
index 000000000000..1daba5f8658a
--- /dev/null
+++ b/samples/rust/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
+
+subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/hostprogs/.gitignore b/samples/rust/hostprogs/.gitignore
new file mode 100644
index 000000000000..a6c173da5048
--- /dev/null
+++ b/samples/rust/hostprogs/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+single
diff --git a/samples/rust/hostprogs/Makefile b/samples/rust/hostprogs/Makefile
new file mode 100644
index 000000000000..8ddcbd7416db
--- /dev/null
+++ b/samples/rust/hostprogs/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+hostprogs-always-y := single
+
+single-rust := y
diff --git a/samples/rust/hostprogs/a.rs b/samples/rust/hostprogs/a.rs
new file mode 100644
index 000000000000..f7a4a3d0f4e0
--- /dev/null
+++ b/samples/rust/hostprogs/a.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust single host program sample: module `a`.
+
+pub(crate) fn f(x: i32) {
+    println!("The number is {}.", x);
+}
diff --git a/samples/rust/hostprogs/b.rs b/samples/rust/hostprogs/b.rs
new file mode 100644
index 000000000000..c1675890648f
--- /dev/null
+++ b/samples/rust/hostprogs/b.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust single host program sample: module `b`.
+
+pub(crate) const CONSTANT: i32 = 42;
diff --git a/samples/rust/hostprogs/single.rs b/samples/rust/hostprogs/single.rs
new file mode 100644
index 000000000000..8c48a119339a
--- /dev/null
+++ b/samples/rust/hostprogs/single.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust single host program sample.
+
+mod a;
+mod b;
+
+fn main() {
+    println!("Hello world!");
+
+    a::f(b::CONSTANT);
+}
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
new file mode 100644
index 000000000000..54ad17685742
--- /dev/null
+++ b/samples/rust/rust_minimal.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust minimal sample.
+
+use kernel::prelude::*;
+
+module! {
+    type: RustMinimal,
+    name: b"rust_minimal",
+    author: b"Rust for Linux Contributors",
+    description: b"Rust minimal sample",
+    license: b"GPL",
+}
+
+struct RustMinimal {
+    numbers: Vec<i32>,
+}
+
+impl kernel::Module for RustMinimal {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust minimal sample (init)\n");
+        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
+
+        let mut numbers = Vec::new();
+        numbers.try_push(72)?;
+        numbers.try_push(108)?;
+        numbers.try_push(200)?;
+
+        Ok(RustMinimal { numbers })
+    }
+}
+
+impl Drop for RustMinimal {
+    fn drop(&mut self) {
+        pr_info!("My numbers are {:?}\n", self.numbers);
+        pr_info!("Rust minimal sample (exit)\n");
+    }
+}
-- 
2.37.1

