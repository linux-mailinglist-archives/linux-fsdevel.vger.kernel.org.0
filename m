Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F922CF20C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgLDQkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 11:40:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgLDQkw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:40:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C281EACC1;
        Fri,  4 Dec 2020 16:40:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 406A91E1327; Fri,  4 Dec 2020 17:40:09 +0100 (CET)
Date:   Fri, 4 Dec 2020 17:40:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos <miklos@szeredi.hu>, jack <jack@suse.cz>,
        amir73il <amir73il@gmail.com>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOltSRg==?= =?utf-8?Q?C?= PATCH v4 0/9]
 implement containerized syncfs for overlayfs
Message-ID: <20201204164009.GA1389@quack2.suse.cz>
References: <20201113065555.147276-1-cgxu519@mykernel.net>
 <1762e3a7bce.e28cb82145070.9060345012556073676@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1762e3a7bce.e28cb82145070.9060345012556073676@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 04-12-20 22:49:13, Chengguang Xu wrote:
>  ---- 在 星期五, 2020-11-13 14:55:46 Chengguang Xu <cgxu519@mykernel.net> 撰写 ----
>  > Current syncfs(2) syscall on overlayfs just calls sync_filesystem()
>  > on upper_sb to synchronize whole dirty inodes in upper filesystem
>  > regardless of the overlay ownership of the inode. In the use case of
>  > container, when multiple containers using the same underlying upper
>  > filesystem, it has some shortcomings as below.
>  > 
>  > (1) Performance
>  > Synchronization is probably heavy because it actually syncs unnecessary
>  > inodes for target overlayfs.
>  > 
>  > (2) Interference
>  > Unplanned synchronization will probably impact IO performance of
>  > unrelated container processes on the other overlayfs.
>  > 
>  > This series try to implement containerized syncfs for overlayfs so that
>  > only sync target dirty upper inodes which are belong to specific overlayfs
>  > instance. By doing this, it is able to reduce cost of synchronization and
>  > will not seriously impact IO performance of unrelated processes.
>  
> Hi Miklos,
> 
> I think this version has addressed all previous issues and comments from Jack
> and Amir.  Have you got time to review this patch series?

Yes, the patches now look good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
