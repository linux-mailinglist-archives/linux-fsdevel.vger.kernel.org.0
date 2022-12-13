Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19D64BBCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 19:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiLMSTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 13:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiLMSTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:19:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE4210;
        Tue, 13 Dec 2022 10:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A62B815B3;
        Tue, 13 Dec 2022 18:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7E0C433EF;
        Tue, 13 Dec 2022 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955557;
        bh=U7KEGHmRR40NvE6yDpb7nHyAevMxF/ypv1NEplKQMy8=;
        h=Date:From:To:Cc:Subject:From;
        b=G9NS5vyTldRekqD9Ia6bPmP3Nye0ujnvkL+hd9pzy/aXABKXeOLQIJOYo6Ut4Xq1A
         n+JkVNfkB/jU+OrtxDc9xcVpHvwCwHTBmROlmH5XkgL21c5azDQCQm+oLM/S7XYjGL
         bgcI35ePNXcwVB8FIjepUbiU4y6O3GvZ4Bb6iVThklUdZr3bNkZdWzsSzFHIxIq8kC
         Y/GtxSwlT9xAnrL/oDTVChr3qVBift99UodHEInbNC86molsP1r2x3DjkVa7OMjWbz
         xuvhAnIgK7qcZ0x3HXsmIj1wNmKscaKHpxZ+hjEcwUq4i55bxltsRbYqUVoQyn8FTY
         H78ZA+obQXENw==
Date:   Tue, 13 Dec 2022 10:19:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [GIT PULL] vfs: new code for 6.2
Message-ID: <167095549511.1666109.751880057026708836.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for vfs for 6.2-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-6.2-merge-1

for you to fetch changes up to a79168a0c00d710420c1758f6c38df89e12f0763:

fs/remap_range: avoid spurious writeback on zero length request (2022-11-30 08:41:01 -0800)

----------------------------------------------------------------
New VFS code for 6.2:

- Make some minor adjustments to the remap range preparation function to
skip file updates when the request length is adjusted downwards to
zero.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Brian Foster (1):
fs/remap_range: avoid spurious writeback on zero length request

fs/remap_range.c | 7 ++-----
1 file changed, 2 insertions(+), 5 deletions(-)

