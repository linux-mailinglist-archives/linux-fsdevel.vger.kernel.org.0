Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC442BDBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJMKte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 06:49:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33544 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhJMKtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:49:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D0952233C;
        Wed, 13 Oct 2021 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634122047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3iVmoGzS1CFC1ZYp5GIospF+GcEKdIrbvLtreROQEfY=;
        b=rXel6gwbSuBhNp51al563AO6FS+XBZGOh/Hjm+BJIWuWOyU/3AT5rJWXw07dBi66Lgwd4D
        ooX5FTPfl/pC0Td0V4J2NhW4+JnUKlh9zrRP1nHxExJjHSCOfj8B/qV2wki4afni9YWLzI
        rwBdjQuKJBSvHiqfDFKdm53Pp8cWtVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634122047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3iVmoGzS1CFC1ZYp5GIospF+GcEKdIrbvLtreROQEfY=;
        b=pxc3ajuVJ6QppWl3+pNc7cHhWSy4VS/lmsQeRbZ/ZEMgrJnYBtPjQ3jjf0R56GrDxVMQsV
        jv2YKpSzp52reSBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 60639A3B81;
        Wed, 13 Oct 2021 10:47:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 41BDE1E11B6; Wed, 13 Oct 2021 12:47:27 +0200 (CEST)
Date:   Wed, 13 Oct 2021 12:47:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 29/29] udf: use sb_bdev_nr_blocks
Message-ID: <20211013104727.GJ19200@quack2.suse.cz>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-30-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-10-21 07:10:42, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
