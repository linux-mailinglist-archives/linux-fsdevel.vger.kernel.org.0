Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B98125C9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgICUEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 16:04:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICUEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:04:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 09BAF29AEDC
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/3] Unaligned DIO read error path fix and clean ups
Date:   Thu,  3 Sep 2020 16:04:11 -0400
Message-Id: <20200903200414.673105-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This follows up on my previous submision of "direct-io: defer alignment
check until after the EOF check".  This version applies the suggestions
from Jan Kara (thank you!) and it was tested with xfstests aio group
over f2fs and fio workloads.

Gabriel Krisman Bertazi (3):
  direct-io: clean up error paths of do_blockdev_direct_IO
  direct-io: don't force writeback for reads beyond EOF
  direct-io: defer alignment check until after the EOF check

 fs/direct-io.c | 64 ++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

-- 
2.28.0

