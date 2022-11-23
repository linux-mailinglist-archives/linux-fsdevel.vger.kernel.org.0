Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA1634F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiKWFQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 00:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiKWFQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:16:08 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5878ECCCB;
        Tue, 22 Nov 2022 21:16:04 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 2BF61C01B; Wed, 23 Nov 2022 06:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669180569; bh=iPT0LtABgClIL1IGlsba5+6joAsD3/Hw7Ap3XlgNN6I=;
        h=Date:From:To:Cc:Subject:From;
        b=a7xbnafB3H1BP/6ISBXFHlURChsbJeqtBu9pSVEGJEut2Zyj8IFqiWf3qeS01wbVl
         eYBu28PDGl65eMTviJ/4ZWumHt40WYugyHTv3WS6oCAVNhPVv6WgGo+NJaLOOeTwuT
         4GcCV5GG9Fs/onKszzqYO4D3ApCWgFBtGtrx9lyr8brgApJfJZ9vufpyAVVB8WBm6k
         6hSA4VRcdWfteZgeZg9zLsY3JVdPOxU+jlMG5vtws9vBM8KUwO/9OKstLDO2wy+dkm
         xlBpIlRe/IqpTu/C79ApncdK67tOXMCHxIL1f1/O2fRPRGMM7S7VEAg/g9ene6/9wF
         eyIyYC3nirXvw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1A4CAC009;
        Wed, 23 Nov 2022 06:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669180568; bh=iPT0LtABgClIL1IGlsba5+6joAsD3/Hw7Ap3XlgNN6I=;
        h=Date:From:To:Cc:Subject:From;
        b=KTas6DayCTmDcJZ+jvY6SnkEXjUxPMtowIElXhAWh0eD1FI3T7NPjLHOooyTD86PZ
         6V+yNE7B6DQXPotPoI3tWiMU8dtX4weaThSpfqn1xAmoSN0ni0pPebRpkOBhde9Wc/
         A3TfpiPKlkgmvlIyoeafduKBsiG77577wyaYdV2YGy+Em7Hf2nsIo3SmAiP603vzPP
         5YIR43jnjwJbmnCy2l58hbEIjd9PguiJwvFFL31IJEf8NoTND5d3rBgFj6x3UyJwAN
         p8hfUCuNeheNOZgvhsCSR3dTveVDHBpDs84cxJPvOmZNeQ9IBsqXTHmpX+kPW0QC+i
         ToUSjs7GJy63g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 315a764d;
        Wed, 23 Nov 2022 05:15:56 +0000 (UTC)
Date:   Wed, 23 Nov 2022 14:15:41 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p fixes for 6.1-rc7
Message-ID: <Y32sfX54JJbldBIt@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.1-rc7

for you to fetch changes up to 391c18cf776eb4569ecda1f7794f360fe0a45a26:

  9p/xen: check logical size for buffer size (2022-11-23 14:01:27 +0900)

(yes, that's just now -- sorry, I just noticed a whitespace problem as I
prepared this mail, there's no code change with what was tested and in
-next for a few days)

----------------------------------------------------------------
9p-for-6.1-rc7

Two fixes:
 - 9p now uses a variable size for its recv buffer, but every place
hadn't been updated properly to use it and some buffer overflows
have been found and needed fixing.
There's still one place where msize is incorrectly used in a safety
check (p9_check_errors), but all paths leading to it should already
be avoiding overflows and that patch took a bit more time to get
right for zero-copy requests so I'll send it for 6.2
 - yet another race condition in p9_conn_cancel introduced by a
fix of a syzbot report in the same place, maybe at some point
we'll get it right without burning it all down...

----------------------------------------------------------------
Dominique Martinet (1):
      9p/xen: check logical size for buffer size

GUO Zihua (2):
      9p/fd: Fix write overflow in p9_read_work
      9p/fd: Use P9_HDRSZ for header size

Zhengchao Shao (1):
      9p/fd: fix issue of list_del corruption in p9_fd_cancel()

 net/9p/trans_fd.c  | 24 +++++++++++++-----------
 net/9p/trans_xen.c |  9 +++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)
 9 files changed, 254 insertions(+), 28 deletions(-)
--
Dominique
