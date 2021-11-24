Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49B45CC41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbhKXSmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 13:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243530AbhKXSmQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:42:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE6B60C3F;
        Wed, 24 Nov 2021 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637779146;
        bh=6vyNYL/M+dMyt65D1qDQo5alJ6oQJeQ9FbdiheTxjIU=;
        h=Date:From:To:Cc:Subject:From;
        b=H8DYBu2NgIaUXJQGibrAyel4C8YUNU3R5ElvMlsP7kLF6cqmkkso4+2es54Gqmxne
         kZUumhstyONSlqMfSjXMkSTpWD28Crp9pwgXH2XI4pbBImt6fx45zjvbB0wTk+9obK
         y1MF0ysr6XFLa/UnqkOc43H69NXy4+FCIv0vtnAiNMJ8XQYSEA1jKnTb5OSbAgT6Vw
         UgWWATqw7diaeR1aBT00fva1YfBhWHZ48UJiVwcdeCFW3/cMkwi90vxMkhdmNwjsuY
         fh2F/nuqIGjbeNylGWJnY5z8LAOOn1j23vqN5u5w5lVs6pCTV8XN7Oxh0gj4hjlsCf
         J7LYeJnhneDaQ==
Date:   Wed, 24 Nov 2021 10:39:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        agruenba@redhat.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 5ad448ce2976
Message-ID: <20211124183905.GE266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-for-next branch is commit:

5ad448ce2976 iomap: iomap_read_inline_data cleanup

New Commits:

Andreas Gruenbacher (2):
      [d8af404ffce7] iomap: Fix inline extent handling in iomap_readpage
      [5ad448ce2976] iomap: iomap_read_inline_data cleanup


Code Diffstat:

 fs/iomap/buffered-io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)
