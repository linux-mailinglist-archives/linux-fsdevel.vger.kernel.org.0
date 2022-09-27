Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA945EC453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiI0NXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiI0NWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E58D1B2607;
        Tue, 27 Sep 2022 06:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47EDA61962;
        Tue, 27 Sep 2022 13:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F29DC433C1;
        Tue, 27 Sep 2022 13:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284685;
        bh=zona/J620H/azH9R6pDemYihj4+MqISRjwIzOUwRNmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mADTHuJmowLuLXiw4N5toincm397DhXCWCH0UhkZVifL845n7c8slJU3bkxA3ZmEu
         oDZHP5i5ttEzagR3Qc67hCD6caGO1O3xtZbyzUPp3lF5FHuWwUqWmFoq3LMdozRVtd
         N5V8cDXIVxRZnD/eK+zc+E1w4k+jLl6nDT3ZXBpKtBLTtM2qu87Hh49Libdeh3oh2K
         VU6ByYFjcDKIwevZkO1UfVFpdWz4Bm59RLmaZc3zBQhPHAXlIOOssqMZfnhEQYM6V9
         rS6dpzfOjmYJjBEWbU1fsqymM3OTZgSVAcJc3fypOR4t7S6/xqXjbLF0hQWMkPd5it
         gho8EHjp2SuAg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v10 27/27] MAINTAINERS: Rust
Date:   Tue, 27 Sep 2022 15:14:58 +0200
Message-Id: <20220927131518.30000-28-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miguel, Alex and Wedson will be maintaining the Rust support.

Boqun, Gary and Björn will be reviewers.

Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..944dc265b64d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17758,6 +17758,24 @@ F:	include/rv/
 F:	kernel/trace/rv/
 F:	tools/verification/
 
+RUST
+M:	Miguel Ojeda <ojeda@kernel.org>
+M:	Alex Gaynor <alex.gaynor@gmail.com>
+M:	Wedson Almeida Filho <wedsonaf@google.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Gary Guo <gary@garyguo.net>
+R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://github.com/Rust-for-Linux/linux
+B:	https://github.com/Rust-for-Linux/linux/issues
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	Documentation/rust/
+F:	rust/
+F:	samples/rust/
+F:	scripts/*rust*
+K:	\b(?i:rust)\b
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.37.3

