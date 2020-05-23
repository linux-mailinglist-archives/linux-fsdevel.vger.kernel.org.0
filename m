Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C21DF81A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgEWPwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgEWPwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 11:52:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDBDC061A0E;
        Sat, 23 May 2020 08:52:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jcWRc-00E8oV-Lz; Sat, 23 May 2020 15:52:16 +0000
Date:   Sat, 23 May 2020 16:52:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: fiemap cleanups v4
Message-ID: <20200523155216.GZ23230@ZenIV.linux.org.uk>
References: <20200523073016.2944131-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523073016.2944131-1-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 23, 2020 at 09:30:07AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> This series cleans up the fiemap support in ext4 and in general.
> 
> Ted or Al, can one of you pick this up?  It touches both ext4 and core
> code, so either tree could work.
> 
> 
> Changes since v3:
>  - dropped the fixes that have been merged int mainline
> 
> Changes since v2:
>  - commit message typo
>  - doc updates
>  - use d_inode in cifs
>  - add a missing return statement in cifs
>  - remove the filemap_write_and_wait call from ext4_ioctl_get_es_cache
> 
> Changes since v1:
>  - rename fiemap_validate to fiemap_prep
>  - lift FIEMAP_FLAG_SYNC handling to common code
>  - add a new linux/fiemap.h header
>  - remove __generic_block_fiemap
>  - remove access_ok calls from fiemap and ext4

Hmmm...  I can do an immutable shared branch, no problem.  What would
you prefer for a branchpoint for that one?
