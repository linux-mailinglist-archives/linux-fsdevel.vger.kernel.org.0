Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9272B616
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 05:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjFLDaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 23:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjFLDai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:30:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40BF5;
        Sun, 11 Jun 2023 20:30:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB39068BFE; Mon, 12 Jun 2023 05:30:23 +0200 (CEST)
Date:   Mon, 12 Jun 2023 05:30:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, dsterba@suse.com, hch@lst.de,
        konishi.ryusuke@gmail.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Subject: Re: [syzbot] [nilfs?] general protection fault in
 nilfs_clear_dirty_page
Message-ID: <20230612033023.GA16241@lst.de>
References: <000000000000da4f6b05eb9bf593@google.com> <000000000000c0951105fde12435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c0951105fde12435@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 02:18:29PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 4a445b7b6178d88956192c0202463063f52e8667
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sat Aug 13 08:06:53 2022 +0000
> 
>     btrfs: don't merge pages into bio if their page offset is not contiguous

I can't see how that btrfs commit would affect nilfs2..

