Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987BB54D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbfFYK7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:59:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbfFYK7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wwjd99RoXuSnHJKoAHqWgUdarmES3VQyay6SQK/R1Zo=; b=UwU0highZEA/FGERbHhOX+NGj
        wbOEOfYCrykn4i/NMFvP0XQWLaO76P5pTHVLBqJkG76euT9OEwHgRthOqNy2+bpGfoQffYe+VSjUn
        QLbNyICQ73+5wpZ67NnuWDRQEVMjMQ9n+ScMYd+VXjhbz8KGNZJ7arzmVhIfPVZ6AqQzv7e6MuDSa
        aGu3nC2IVp/W+ZNu5JgLyHLadtwk9OKFT74gLui/zAk4qpMo1UK4kcsXrMvY0K5yWKTJkGWyq3w6u
        d68URRrxr9HRoeZ3xU0m2oIIkykZy8SnVCCE4rPDUJESqTKtzeQYumA5/zO5K0UZUKNm4pEvUaMY8
        Hwh6CeXHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfjA7-0000tm-GM; Tue, 25 Jun 2019 10:58:55 +0000
Date:   Tue, 25 Jun 2019 03:58:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] vfs: teach vfs_ioc_fssetxattr_check to check extent
 size hints
Message-ID: <20190625105855.GD26085@infradead.org>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
 <156116140570.1664814.4607468365269898575.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156116140570.1664814.4607468365269898575.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:56:45PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Move the extent size hint checks that aren't xfs-specific to the vfs.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
