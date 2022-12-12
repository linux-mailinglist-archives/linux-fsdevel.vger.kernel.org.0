Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED280649764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 01:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiLLAgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 19:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLLAgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 19:36:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F2BC84;
        Sun, 11 Dec 2022 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AdN7B0jlh18ORN/MVeIMLXn+O6G1rq6aSz4OhUNS+d4=; b=SHYRtOXj58GMphFH0r44Ic5u37
        57TS7AhGipItJ+XQ9bXV4iJougB6iYK+vyscRGRvCbZv4mRVkzbDObvac/gSwlKmvDvioCLzCU9cz
        9ZolXTRAwRZccxC6gVeD8NIAjd9p1FN9dVtJ6oHd1c0TXAOjQybzMtFFBXyLk3KhbFov7xA4w5V0H
        7nSHvWAh4lBzZVcZdlXzxoijKpPTJjYFwkhnMhAGoOdoH1aOORSqn0Rsy2uGGTyKWuGx60eglYPN+
        MiK+j8IaZ5p0cxIxza1Ipe72vwsZAZtO9FGWZsmA0urHFfxvcwYzN1rwicACStHb+POKoxveJrTXV
        bSQNWTFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4Wnf-00B88o-2q;
        Mon, 12 Dec 2022 00:36:07 +0000
Date:   Mon, 12 Dec 2022 00:36:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git namespace fix
Message-ID: <Y5Z3d+DP8TwJCDr8@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-namespace

for you to fetch changes up to 61d8e42667716f71f2c26e327e66f2940d809f80:

  copy_mnt_ns(): handle a corner case (overmounted mntns bindings) saner (2022-11-24 22:55:57 -0500)

----------------------------------------------------------------
fix of weird corner case in copy_mnt_ns()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      copy_mnt_ns(): handle a corner case (overmounted mntns bindings) saner

 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
