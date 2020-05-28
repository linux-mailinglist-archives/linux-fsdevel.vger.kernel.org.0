Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF01E70FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437953AbgE1X6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437807AbgE1X5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:57:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748BC08C5C6;
        Thu, 28 May 2020 16:57:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSPI-00HE5J-Vn; Thu, 28 May 2020 23:57:53 +0000
Date:   Fri, 29 May 2020 00:57:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess __copy_from_user()
Message-ID: <20200528235752.GU23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	A couple of __copy_from_user()-related patches.  That's
the stuff that didn't fit anywhere else.  The end goal is
to kill uses of that thing outside of arch/* and we are not
far from getting there.

	Branch in uaccess.__copy_from_user, based at v5.7-rc1.

Al Viro (2):
      firewire: switch ioctl_queue_iso to use of copy_from_user()
      pstore: switch to copy_from_user()

 drivers/firewire/core-cdev.c | 4 +---
 fs/pstore/ram_core.c         | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)
