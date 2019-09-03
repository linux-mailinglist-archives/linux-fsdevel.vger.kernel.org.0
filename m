Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073F6A613B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 08:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfICGVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 02:21:04 -0400
Received: from verein.lst.de ([213.95.11.211]:55483 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfICGVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:21:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 106EB227A8A; Tue,  3 Sep 2019 08:21:01 +0200 (CEST)
Date:   Tue, 3 Sep 2019 08:21:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, david@fromorbit.com, riteshh@linux.ibm.com
Subject: Re: [PATCH v3 0/15] Btrfs iomap
Message-ID: <20190903062100.GA16612@lst.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de> <20190902164331.GE6263@lst.de> <4d039e8e-dc35-8092-4ee0-4a2e0f43f233@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d039e8e-dc35-8092-4ee0-4a2e0f43f233@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:51:24AM +0800, Shiyang Ruan wrote:
> The XFS part of dax CoW support has been implementing recently.  Please 
> review this[1] if necessary.  It's based on this iomap patchset(the 1st 
> version), and uses the new srcmap.
>
> [1]: https://lkml.org/lkml/2019/7/31/449

For the initial stage I'm not interested in DAX reflink support yet
(although that is also very interesting), just to make sure the
two iomap support is also used by the buffer write path for XFS,
removing the current hack where iomap_begin reports the data fork
mapping only and relies in ->writepage to handle that case.
