Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227601E7123
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438042AbgE2AKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437671AbgE2AKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:10:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27BC08C5C6;
        Thu, 28 May 2020 17:10:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSaz-00HEXR-Gd; Fri, 29 May 2020 00:09:57 +0000
Date:   Fri, 29 May 2020 01:09:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCHES] uaccess __put_user()
Message-ID: <20200529000957.GW23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Similar misc patches dealing with __put_user()
eliminations not fitting into other series (e.g. quite
a bit went into net-next already, then there's readdir
series and comedi one - the last one is the single
biggest pile of __put_user() outside of arch/*, etc.).

	Branch in #uaccess.__put_user, based at v5.7-rc1

Al Viro (3):
      compat sysinfo(2): don't bother with field-by-field copyout
      scsi_ioctl.c: switch SCSI_IOCTL_GET_IDLUN to copy_to_user()
      pcm_native: result of put_user() needs to be checked

 drivers/scsi/scsi_ioctl.c | 20 ++++++++++----------
 kernel/sys.c              | 33 +++++++++++++++++----------------
 sound/core/pcm_native.c   | 12 ++++++++----
 3 files changed, 35 insertions(+), 30 deletions(-)

