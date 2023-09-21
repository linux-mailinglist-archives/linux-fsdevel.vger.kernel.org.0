Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C757A9B52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjIUS5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIUS46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:56:58 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 11:51:06 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE18ED50;
        Thu, 21 Sep 2023 11:51:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 1C10D10037D;
        Thu, 21 Sep 2023 17:03:29 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5x_DGjDpQCIv; Thu, 21 Sep 2023 17:03:29 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 13103100265; Thu, 21 Sep 2023 17:03:29 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 02048100073;
        Thu, 21 Sep 2023 17:03:26 +1000 (AEST)
Subject: [PATCH 0/8] autofs - convert to to use mount api
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 21 Sep 2023 15:03:26 +0800
Message-ID: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There was a patch from David Howells to convert autofs to use the mount
api but it was never merged.

I have taken David's patch and refactored it to make the change easier
to review in the hope of having it merged.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (8):
      autofs: refactor autofs_prepare_pipe()
      autofs: add autofs_parse_fd()
      autofs - refactor super block info init
      autofs: reformat 0pt enum declaration
      autofs: refactor parse_options()
      autofs: validate protocol version
      autofs: convert autofs to use the new mount api
      autofs: fix protocol sub version setting


 fs/autofs/autofs_i.h |  15 +-
 fs/autofs/init.c     |   9 +-
 fs/autofs/inode.c    | 423 +++++++++++++++++++++++++------------------
 3 files changed, 266 insertions(+), 181 deletions(-)

--
Ian

