Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E729FDED75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfJUNXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:23:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbfJUNXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC95BB47D;
        Mon, 21 Oct 2019 13:23:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0FDB51E4AA0; Mon, 21 Oct 2019 15:23:47 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:23:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 01/12] ext4: move set iomap routines into separate
 helper ext4_set_iomap()
Message-ID: <20191021132347.GA25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <7dd1a1a895fd7e55c659b10bba16976faab4cd85.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd1a1a895fd7e55c659b10bba16976faab4cd85.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:17:31, Matthew Bobrowski wrote:
> Separate the iomap field population chunk of code that is currently
> within ext4_iomap_begin() into a new helper called
> ext4_set_iomap(). The intent of this function is self explanatory,
> however the rationale behind doing so is to also reduce the overall
> clutter that we currently have within the ext4_iomap_begin() callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  fs/ext4/inode.c | 59 +++++++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 26 deletions(-)

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
