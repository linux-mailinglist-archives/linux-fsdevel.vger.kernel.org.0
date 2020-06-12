Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52DB1F7ED7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 00:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgFLWSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 18:18:06 -0400
Received: from nautica.notk.org ([91.121.71.147]:44031 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLWSG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:18:06 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D772FC009; Sat, 13 Jun 2020 00:18:03 +0200 (CEST)
Date:   Sat, 13 Jun 2020 00:17:48 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p update for 5.8
Message-ID: <20200612221748.GA5666@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Another very quiet cycle...

Thanks,

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.8

for you to fetch changes up to 36f9967531da27ff8cc6f005d93760b578baffb9:

  9p/xen: increase XEN_9PFS_RING_ORDER (2020-06-02 08:00:39 +0200)

----------------------------------------------------------------
9p pull request for inclusion in 5.8

Only one commit - increase the size of the ring used for xen transport.

----------------------------------------------------------------
Stefano Stabellini (1):
      9p/xen: increase XEN_9PFS_RING_ORDER

 net/9p/trans_xen.c | 61 ++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

-- 
Dominique
