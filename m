Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396A636DDB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbhD1Q6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 12:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:45094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhD1Q6h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:58:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E894DB01E;
        Wed, 28 Apr 2021 16:57:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 24823DA783; Wed, 28 Apr 2021 18:55:28 +0200 (CEST)
Date:   Wed, 28 Apr 2021 18:55:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [git pull] fileattr series from Miklos
Message-ID: <20210428165527.GN7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
References: <YIdByy4WJcXTN7Wy@zeniv-ca.linux.org.uk>
 <CAHk-=whNdEKs-LoF9DKYW8k5Eg2rPjqqWf047TxAY3+v4W=iRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNdEKs-LoF9DKYW8k5Eg2rPjqqWf047TxAY3+v4W=iRQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:31:19AM -0700, Linus Torvalds wrote:
> Btw, unrelated to that, this pull request got a conflict with
> 
>   64708539cd23 ("btrfs: use btrfs_inode_lock/btrfs_inode_unlock inode
> lock helpers")
> 
> which I think I sorted out correctly (the "inode_lock()" is now done
> by the VFS layer for the fileattr things, and the btrfs use of
> "btrfs_inode_lock/btrfs_inode_unlock" ended up being undone). But just
> to be safe I'm cc'ing the btrfs people involved. Please double-check
> that I didn't screw something up.

Checked, it's ok. Thanks.
