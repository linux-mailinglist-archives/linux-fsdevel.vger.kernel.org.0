Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D22718A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 01:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgITXtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 19:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgITXtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:49:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130FC061755
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2020 16:49:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E73472852CD
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RESEND v3 0/3] direct-io: clean up error paths of do_blockdev_direct_IO
Date:   Sun, 20 Sep 2020 19:48:51 -0400
Message-Id: <20200920234854.4175918-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

This might have felt through the cracks, as I haven't seen it popup in
any trees, so I'm resending it.  No changes from the original
submission, apart from picking up the reviewed-bys.

Would you kindly consider pulling it for the next merge window?

Thanks,

Archive:
  v1: https://lkml.org/lkml/2020/9/14/915
  v2: https://www.spinics.net/lists/linux-fsdevel/msg177220.html
  v3: https://www.spinics.net/lists/linux-fsdevel/msg177310.html


Gabriel Krisman Bertazi (3):
  direct-io: clean up error paths of do_blockdev_direct_IO
  direct-io: don't force writeback for reads beyond EOF
  direct-io: defer alignment check until after the EOF check

 fs/direct-io.c | 69 ++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

-- 
2.28.0

