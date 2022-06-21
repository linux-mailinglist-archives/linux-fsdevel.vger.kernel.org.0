Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418B4552AFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 08:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbiFUGei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiFUGeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:34:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2712D0B;
        Mon, 20 Jun 2022 23:34:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 332BC68AFE; Tue, 21 Jun 2022 08:34:33 +0200 (CEST)
Date:   Tue, 21 Jun 2022 08:34:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2 2/4] fs/ntfs: Drop useless return value of submit_bh
 from ntfs_submit_bh_for_read
Message-ID: <20220621063432.GA826@lst.de>
References: <cover.1655715329.git.ritesh.list@gmail.com> <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:34:35PM +0530, Ritesh Harjani wrote:
> submit_bh always returns 0. This patch drops the useless return value of
> submit_bh from ntfs_submit_bh_for_read(). Once all of submit_bh callers are
> cleaned up, we can make it's return type as void.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

and so sad that a newly merged file systems still does all this buffer head
crap :(
