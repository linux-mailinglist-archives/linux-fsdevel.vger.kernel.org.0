Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262721141C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 14:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfLENm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 08:42:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:32800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbfLENm2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:42:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 880E7B1A3;
        Thu,  5 Dec 2019 13:42:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A1255DA733; Thu,  5 Dec 2019 14:42:20 +0100 (CET)
Date:   Thu, 5 Dec 2019 14:42:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, viro@zeniv.linux.org.uk,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: Use inode_lock/unlock class of provided APIs in
 filesystems
Message-ID: <20191205134220.GM2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ritesh Harjani <riteshh@linux.ibm.com>,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, viro@zeniv.linux.org.uk,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org
References: <20191205103902.23618-1-riteshh@linux.ibm.com>
 <20191205103902.23618-2-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205103902.23618-2-riteshh@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 04:09:02PM +0530, Ritesh Harjani wrote:
> This defines 4 more APIs which some of the filesystem needs
> and reduces the direct use of i_rwsem in filesystem drivers.
> Instead those are replaced with inode_lock/unlock_** APIs.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---

For the btrfs part

>  fs/btrfs/delayed-inode.c |  2 +-
>  fs/btrfs/ioctl.c         |  4 ++--

Acked-by: David Sterba <dsterba@suse.com>
