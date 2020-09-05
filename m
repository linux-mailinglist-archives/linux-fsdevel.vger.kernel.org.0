Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7E925E596
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 07:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIEFUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgIEFUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 01:20:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECEC061244
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2020 22:20:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EC4C329B18C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 0/3] Unaligned DIO read error path fix and clean ups
Date:   Sat,  5 Sep 2020 01:20:20 -0400
Message-Id: <20200905052023.3719585-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v3 of Unaligned DIO read error path fix and clean ups.  This
version applies some small fixes to patch 1 suggested by Jan Kara (thank
you!)  and it was tested with xfstests aio group over f2fs and fio
workloads.

Gabriel Krisman Bertazi (3):
  direct-io: clean up error paths of do_blockdev_direct_IO
  direct-io: don't force writeback for reads beyond EOF
  direct-io: defer alignment check until after the EOF check

 fs/direct-io.c | 69 ++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

-- 
2.28.0

