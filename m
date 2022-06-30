Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD056211B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiF3RSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 13:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiF3RSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:18:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB01835C;
        Thu, 30 Jun 2022 10:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6223AB82CC1;
        Thu, 30 Jun 2022 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05878C34115;
        Thu, 30 Jun 2022 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656609515;
        bh=bE9PTj841O4zY6n55GbA8GgKOJcUfgCgX7zk5pThn/o=;
        h=Date:From:To:Subject:From;
        b=EamtR+SPcglkTZ1WM2op9JIu/V08bJIK3//GoEMqqRpLv9wu7EA8rCqZh9iXBrlNA
         dCVaBxts4YL6PqtIck3lHq1c/A1J4zHagJAGqdw29bUEJTIPoCvZzC9u/rylwWz547
         QOOVYHYoEzyO8ek2+Vp1yKIF9v6qg3u8aSyeyDkghurX9LfDM1jgcXNewvzrAJNs13
         5YPJSrNGSb5sQVinYxDnu7DQkHk8zSL2CM32ufumpLYyQ5yjpvjxme7p5xzRxmmx+w
         txwqVRPCcvjB50R5OVzNNdLDJb5PaPqZnggTfcb3oxxlMfpx1CmegrJQck8gpioIs9
         LUbqU++V5m36w==
Date:   Thu, 30 Jun 2022 10:18:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.20-merge updated to f8189d5d5fbf
Message-ID: <Yr3a6oLHteMZ2mGL@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.20-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  These three patches are, as far as I know, the only
lone patches that have been sent in for 5.20.  I've been out on vacation
for a lot of June, so if I've missed anything, please send them now.

(NOTE: These are not the only iomap changes for 5.20 -- I can think of
at least: (1) async buffered writes; (2) willy's folio updates.)

The new head of the iomap-5.20-merge branch is commit:

f8189d5d5fbf dax: set did_zero to true when zeroing successfully

3 new commits:

Chris Mason (1):
      [d58562ca6c99] iomap: skip pages past eof in iomap_do_writepage()

Kaixu Xia (2):
      [98eb8d95025b] iomap: set did_zero to true when zeroing successfully
      [f8189d5d5fbf] dax: set did_zero to true when zeroing successfully

Code Diffstat:

 fs/dax.c               |  4 ++--
 fs/iomap/buffered-io.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)
