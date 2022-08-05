Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3558AD59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiHEPqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbiHEPpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6DE6D546;
        Fri,  5 Aug 2022 08:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3672D61617;
        Fri,  5 Aug 2022 15:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C25C4347C;
        Fri,  5 Aug 2022 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714269;
        bh=3gRZSTvU40pIskA+5EvDq4iUm3E1NXmF+4YZd9bq1Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaLUoQoFEWLF5LlI43chW2UfBV4B3lnML2JMXtUH0ChcBSbDQWQKVu7HLU+WRLgnM
         68uOqurgeJNSd5FHbG9jAOoGuSzJq4ocsYcom3qgcr8wDlRROibcvchiTlTOBUiN4Z
         OSd1OxjU2Ov49f2mIBwZznVJcAeSPF5DGnyApxK++qaUx3nikrrdeFvzKL/z7E2GuR
         gp+SLGvOG9YbLZu6Ei5TkDJxkPJU/O48fITX9AQPwuLRpdBrFH+3rRWyBXub23e5Yl
         5bCY1NF8xpGeJbFXcwCIDPypm04ZztddEg+1qoDpPT0TS/qH4GJmBnJEPLRH2jlI/d
         z9HnhSuGtP0iA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v9 22/27] rust: add `.rustfmt.toml`
Date:   Fri,  5 Aug 2022 17:42:07 +0200
Message-Id: <20220805154231.31257-23-ojeda@kernel.org>
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

This is the configuration file for the `rustfmt` tool.

`rustfmt` is a tool for formatting Rust code according to style guidelines.
It is very commonly used across Rust projects.

The default configuration options are used.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 .gitignore    |  1 +
 .rustfmt.toml | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 .rustfmt.toml

diff --git a/.gitignore b/.gitignore
index 80989914c97d..97e085d613a2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -97,6 +97,7 @@ modules.order
 !.gitattributes
 !.gitignore
 !.mailmap
+!.rustfmt.toml
 
 #
 # Generated include files
diff --git a/.rustfmt.toml b/.rustfmt.toml
new file mode 100644
index 000000000000..3de5cc497465
--- /dev/null
+++ b/.rustfmt.toml
@@ -0,0 +1,12 @@
+edition = "2021"
+newline_style = "Unix"
+
+# Unstable options that help catching some mistakes in formatting and that we may want to enable
+# when they become stable.
+#
+# They are kept here since they are useful to run from time to time.
+#format_code_in_doc_comments = true
+#reorder_impl_items = true
+#comment_width = 100
+#wrap_comments = true
+#normalize_comments = true
-- 
2.37.1

