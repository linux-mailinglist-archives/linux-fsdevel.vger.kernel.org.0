Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792E58AD78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiHEPsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHEPqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:46:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9376978;
        Fri,  5 Aug 2022 08:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8666B82987;
        Fri,  5 Aug 2022 15:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D9DC43470;
        Fri,  5 Aug 2022 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714301;
        bh=kDhO2X//rHE1f3NmQ76TBXX4I/1jwdVQI94cz/jmob8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ke9ySX6mIc6wEXAgsCtzhRgiUv0smB4HA07KU/2qHYzRhebPeV9Yewg4i+88YhZKa
         JyKgYKgtdpcrra9GURQh1iBagP8ALKBMZNysGcOEr8CRJGpPfcEwr8qeExo6aKe/0Y
         3G8ZBNs1Lom9U1uboO5qXNcp9C8Yxh9wteFC4voWW+Nhb207WmzZ0w5qu7PQWkM89a
         zkjvgvOffd0Ekcqt8E/tJOi1x+AxtILw46XCnK7e+2940uwygl66E8KiytQFyn0zMq
         v6gdM0NEcMq8JwhmN+OXveaLv+1JhRrXlpPP7dcohug9KgvCVDdBmna6iHG6BfGDPG
         1ey1b7AxmgK/g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v9 27/27] MAINTAINERS: Rust
Date:   Fri,  5 Aug 2022 17:42:12 +0200
Message-Id: <20220805154231.31257-28-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Miguel, Alex and Wedson will be maintaining the Rust support.

Boqun, Gary and Björn will be reviewers.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..263ff9abca0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17477,6 +17477,24 @@ L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
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
2.37.1

