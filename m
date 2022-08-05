Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5B58AD71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiHEPrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241049AbiHEPpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:45:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C056C72ECC;
        Fri,  5 Aug 2022 08:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C999B82984;
        Fri,  5 Aug 2022 15:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05858C433D6;
        Fri,  5 Aug 2022 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714246;
        bh=Xhoz/HriTf7Mix6x5COkG2so3swkdjDhA9Nt4WJUA3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vh1PYV+BmSsfMGJFm8XrKX7aQ9EWEC4qYH/Kj5zX9KSwTpdcTXBbUDTpKNhvUgSrF
         pDyTwsrtd4Ior5+1Z2AwGAeHYC0BOl3NsS+lptJdYhyaH7Ncsf7olf5u0dlA1IqiyR
         GtEk0D8DDS4OuKSmdBwFOtBm67aQp83XHarxnXwx26Y5LHcWo5nHnnDsUHsTFeC2Fh
         fD7dHKDhl9yEbcwKKQDrF/aGFVSpwyuDtR34aKWtgFv9Dv1WyXdjNC4rE5Th7UJa1a
         zVjSrUBS06QDqPkPk+isGHY9pWML3hFMFZ5ABmb0GwoXi8+8aoui0jFzIWbOcnEgzq
         hSvGST46e/uYA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v9 16/27] scripts: checkpatch: enable language-independent checks for Rust
Date:   Fri,  5 Aug 2022 17:42:01 +0200
Message-Id: <20220805154231.31257-17-ojeda@kernel.org>
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

Include Rust in the "source code files" category, so that
the language-independent tests are checked for Rust too,
and teach `checkpatch` about the comment style for Rust files.

This enables the malformed SPDX check, the misplaced SPDX license
tag check, the long line checks, the lines without a newline check
and the embedded filename check.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23799e8013b3..bd0025d77bcf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3615,7 +3615,7 @@ sub process {
 				my $comment = "";
 				if ($realfile =~ /\.(h|s|S)$/) {
 					$comment = '/*';
-				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
+				} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
 					$comment = '//';
 				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc|yaml)$/) {
 					$comment = '#';
@@ -3663,7 +3663,7 @@ sub process {
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
+		next if ($realfile !~ /\.(h|c|rs|s|S|sh|dtsi|dts)$/);
 
 # check for using SPDX-License-Identifier on the wrong line number
 		if ($realline != $checklicenseline &&
-- 
2.37.1

