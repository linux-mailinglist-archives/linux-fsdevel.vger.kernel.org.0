Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4280523AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbiEKQ5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbiEKQ47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 12:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76E46667;
        Wed, 11 May 2022 09:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDAD861C65;
        Wed, 11 May 2022 16:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E9EC340EE;
        Wed, 11 May 2022 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652288214;
        bh=Z0y8ib0m/7OdpsDBN6QEDzAOmbEzZpE52Tq2/Fw80wc=;
        h=Date:From:To:Subject:From;
        b=VkkT8w4CuGnSb9OCTisGQvod7axt8Pj4TO67gUqWKKjzoiKTgnK6bPAS4XaJRz+b/
         KXH+uW8Zjk3Uvr3KCRV/FdIWt+b6TsWcnPvbvJf543rJegBH1zInAJH1reqdpa8PR7
         gmJOeJI+GQ7FxxfBA1SA/9AzSUwWcppfJQtvbtentFo4c06GxAs2hvyXBztwUSJ8qq
         oop4tKu1ss11vWltcPXnwwq9MKTFnmSmQdl56OjwrfrefUhIdUlGqOSppqkDyq9F7r
         wUQ4K4bqC/48oLBScRkkm2UXjkcaoH7bg1q6dOWH/kUmDM0ntWiH28iuuWVbt6ffYp
         5KBYQOVlSb/tw==
Date:   Wed, 11 May 2022 09:56:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to d74999c8c060
Message-ID: <20220511165653.GG27195@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Now that 5.18 has finally stabilized enough for fstests to pass again,
I'm finally ready to push the 5.19 iomap stuff.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  The iomap changes for supporting biosets for directio
will be landing through the btrfs tree, which leaves only these two bug
fixes that Andreas sent earlier.

The new head of the iomap-for-next branch is commit:

d74999c8c060 iomap: iomap_write_end cleanup

2 new commits:

Andreas Gruenbacher (2):
      [b71450e2cc4b] iomap: iomap_write_failed fix
      [d74999c8c060] iomap: iomap_write_end cleanup

Code Diffstat:

 fs/iomap/buffered-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
