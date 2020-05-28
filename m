Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC61E70B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437734AbgE1Xrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 19:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437727AbgE1Xrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 19:47:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E6C008632;
        Thu, 28 May 2020 16:40:27 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeS8P-00HDQd-Q4; Thu, 28 May 2020 23:40:25 +0000
Date:   Fri, 29 May 2020 00:40:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess base
Message-ID: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Base of uaccess pile - series from Christophe Leroy adding
user_{read,write}_access_begin().  Sat in ppc tree all along,
in vfs.git it's #uaccess.base.  No changes since the last time
it got posted, repeated for reference, based at v5.7-rc1

Christophe Leroy (3):
      uaccess: Add user_read_access_begin/end and user_write_access_begin/end
      uaccess: Selectively open read or write user access
      drm/i915/gem: Replace user_access_begin by user_write_access_begin

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |  5 +++--
 fs/readdir.c                                   | 12 ++++++------
 include/linux/uaccess.h                        |  8 ++++++++
 kernel/compat.c                                | 12 ++++++------
 kernel/exit.c                                  | 12 ++++++------
 lib/strncpy_from_user.c                        |  4 ++--
 lib/strnlen_user.c                             |  4 ++--
 lib/usercopy.c                                 |  6 +++---
 8 files changed, 36 insertions(+), 27 deletions(-)

