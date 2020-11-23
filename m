Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA342C11AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 18:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbgKWRLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 12:11:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:47056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390220AbgKWRLq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:11:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7B28AEC3;
        Mon, 23 Nov 2020 17:11:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA443DA818; Mon, 23 Nov 2020 18:09:56 +0100 (CET)
Date:   Mon, 23 Nov 2020 18:09:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 05/11] btrfs: fix check_data_csum() error message for
 direct I/O
Message-ID: <20201123170956.GI8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605723568.git.osandov@fb.com>
 <e33db7a6a4f56d0caedfe6a1aad131edca56b340.1605723568.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33db7a6a4f56d0caedfe6a1aad131edca56b340.1605723568.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:18:12AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
> check_data_csum()") replaced the start parameter to check_data_csum()
> with page_offset(), but page_offset() is not meaningful for direct I/O
> pages. Bring back the start parameter.
> 
> Fixes: 1dae796aabf6 ("btrfs: inode: sink parameter start and len to check_data_csum()")

This is part of the subpage preparatory patches still in misc-next , I
can drop the part that removes the start parameter if you're going to
use it.
