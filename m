Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001AD14FDBE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBPTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 10:19:41 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:20784 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBBPTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:19:41 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 489ZPk12h2zKmVh;
        Sun,  2 Feb 2020 16:19:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id LvqAQQwTW8vU; Sun,  2 Feb 2020 16:19:33 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH man-pages v2 0/2] document openat2(2)
Date:   Mon,  3 Feb 2020 02:19:05 +1100
Message-Id: <20200202151907.23587-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Patch changelog:
  v2:
    * Updated based on the new (now-merged) structure layout and semantics.
  v1: <https://lore.kernel.org/linux-man/20191206142931.28138-1-cyphar@cyphar.com/>
    * Updated based on Kerrisk's review.
 RFC: <https://lore.kernel.org/linux-man/20191003145542.17490-1-cyphar@cyphar.com/>

Now that openat2(2) has landed in Linus's tree[1], here is the
associated man-page changes to document it.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b55eef872a96738ea9cb35774db5ce9a7d3a648f

Aleksa Sarai (2):
  path_resolution.7: update to mention openat2(2) features
  openat2.2: document new openat2(2) syscall

 man2/open.2            |  17 ++
 man2/openat2.2         | 471 +++++++++++++++++++++++++++++++++++++++++
 man7/path_resolution.7 |  56 +++--
 3 files changed, 526 insertions(+), 18 deletions(-)
 create mode 100644 man2/openat2.2

-- 
2.25.0

