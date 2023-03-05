Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6A6AB1D0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 20:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCETHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 14:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCETHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:07:08 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0B010257;
        Sun,  5 Mar 2023 11:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nNcRL6wbEdjCjDMUHc6FZzJnzWIRy6URIKB9K8ugP4s=; b=rHnMk7TLPxmdlG4iBpPu+0O10l
        huTIGEpCvkTd5q3w8k7aeoSL0H2E1UD/kNL/Thw9naqxbJo7gR1WNzvv9Zx7VTNdTQyHxh1+OO0mm
        chEvI2aMK8f7CbaeHF+0RnpCX2VgF1RE/dV/vJu7ndNZLrVTFezIA1cuSKLtvfEywQDcVJxQ4fIIr
        Wzue5HXhta0pwE30dyk3R1U+wl42tRXdIy1Lz1o3DafiPAnOUY3qE74ERPZkONgnK2o1Q7D0Llq6Y
        768S6MhzhLKWuji5i2gU45IYcKiIVe0jLKLBse/X+TwhuZIjQ0By5VUr9TpKbSN210ajqOw/Kmb5E
        A9lYrlOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pYthH-00E9sK-0V;
        Sun, 05 Mar 2023 19:07:03 +0000
Date:   Sun, 5 Mar 2023 19:07:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] add Christian Brauner as co-maintainer
Message-ID: <ZAToVz5v5WlhzskY@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to 3304f18bfcf588df0fe3b703b6a6c1129d80bdc7:

  Adding VFS co-maintainer (2023-03-05 10:31:17 -0500)

----------------------------------------------------------------
Adding Christian Brauner as VFS co-maintainer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      Adding VFS co-maintainer

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)
