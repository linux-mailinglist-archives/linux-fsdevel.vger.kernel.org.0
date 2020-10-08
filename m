Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89F9286EAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJHG0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHG0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:26:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A9C061755
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2020 23:26:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D49BF29615E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [RESEND^2 PATCH v3 0/3] Clean up and fix error handling in DIO
Date:   Thu,  8 Oct 2020 02:26:17 -0400
Message-Id: <20201008062620.2928326-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Given the proximity of the merge window and since I haven't seen it pop
up in any of the trees, and considering it is reviewed and fixes a bug
for us, I'm trying another resend for this so it can get picked up in
time for 5.10.

Jan, thanks again for the review and sorry for the noise but is there
any one else that should be looking at this?

Original cover letter:

This is v3 of Unaligned DIO read error path fix and clean ups.  This
version applies some small fixes to patch 1 suggested by Jan Kara (thank
you!)  and it was tested with xfstests aio group over f2fs and fio
workloads.

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

