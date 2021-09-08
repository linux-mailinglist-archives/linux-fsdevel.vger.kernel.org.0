Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0E403B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351941AbhIHOa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:29 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41498 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351940AbhIHOa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:28 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004qZ-Ie; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] Coda updates for -next
Date:   Wed,  8 Sep 2021 10:02:59 -0400
Message-Id: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following patch series contains some fixes for the Coda kernel module
I've had sitting around and were tested extensively in a development
version of the Coda kernel module that lives outside of the main kernel.

I finally got around to testing these against a current kernel and they
seem to not break things horribly so far.


Alex Shi (1):
  coda: remove err which no one care

Jan Harkes (6):
  coda: Avoid NULL pointer dereference from a bad inode
  coda: Check for async upcall request using local state
  coda: Avoid flagging NULL inodes
  coda: Avoid hidden code duplication in rename.
  coda: Avoid doing bad things on inode type changes during
    revalidation.
  coda: Bump module version to 7.2

Jing Yangyang (1):
  coda: Use vmemdup_user to replace the open code

Xiyu Yang (1):
  coda: Convert from atomic_t to refcount_t on coda_vm_ops->refcnt

 fs/coda/cnode.c      | 13 +++++++++----
 fs/coda/coda_linux.c | 39 +++++++++++++++++++--------------------
 fs/coda/coda_linux.h |  6 +++++-
 fs/coda/dir.c        | 20 +++++++++++---------
 fs/coda/file.c       | 12 ++++++------
 fs/coda/psdev.c      | 14 +++++---------
 fs/coda/upcall.c     |  3 ++-
 7 files changed, 57 insertions(+), 50 deletions(-)

-- 
2.25.1

