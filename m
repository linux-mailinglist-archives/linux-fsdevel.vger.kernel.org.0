Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9051287195
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgJHJcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 05:32:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHJcO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9D9AACE6;
        Thu,  8 Oct 2020 09:32:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 834F81E1305; Thu,  8 Oct 2020 11:32:13 +0200 (CEST)
Date:   Thu, 8 Oct 2020 11:32:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RESEND^2 PATCH v3 0/3] Clean up and fix error handling in DIO
Message-ID: <20201008093213.GB3486@quack2.suse.cz>
References: <20201008062620.2928326-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008062620.2928326-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-10-20 02:26:17, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> Given the proximity of the merge window and since I haven't seen it pop
> up in any of the trees, and considering it is reviewed and fixes a bug
> for us, I'm trying another resend for this so it can get picked up in
> time for 5.10.
> 
> Jan, thanks again for the review and sorry for the noise but is there
> any one else that should be looking at this?

If you can't catch attention of Al Viro, then Jens Axboe is sometimes
merging direct IO fixes as well through his tree. Added to CC. If that
doesn't work out, I can also take the changes through my tree and send them
to Linus in a separate pull request...

								Honza

> Original cover letter:
> 
> This is v3 of Unaligned DIO read error path fix and clean ups.  This
> version applies some small fixes to patch 1 suggested by Jan Kara (thank
> you!)  and it was tested with xfstests aio group over f2fs and fio
> workloads.
> 
> Archive:
>   v1: https://lkml.org/lkml/2020/9/14/915
>   v2: https://www.spinics.net/lists/linux-fsdevel/msg177220.html
>   v3: https://www.spinics.net/lists/linux-fsdevel/msg177310.html
> 
> Gabriel Krisman Bertazi (3):
>   direct-io: clean up error paths of do_blockdev_direct_IO
>   direct-io: don't force writeback for reads beyond EOF
>   direct-io: defer alignment check until after the EOF check
> 
>  fs/direct-io.c | 69 ++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 39 deletions(-)
> 
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
