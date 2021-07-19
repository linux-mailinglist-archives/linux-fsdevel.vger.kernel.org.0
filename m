Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F483CDB51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbhGSOmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 10:42:20 -0400
Received: from verein.lst.de ([213.95.11.211]:50130 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245348AbhGSOia (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:38:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3EC7E67357; Mon, 19 Jul 2021 17:18:59 +0200 (CEST)
Date:   Mon, 19 Jul 2021 17:18:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de
Subject: Re: [PATCH v5 9/9] fs/dax: Remove useless functions
Message-ID: <20210719151857.GB22718@lst.de>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com> <20210628000218.387833-10-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628000218.387833-10-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 08:02:18AM +0800, Shiyang Ruan wrote:
> Since owner tracking is triggerred by pmem device, these functions are
> useless.  So remove them.

What about ext2 and ext4?
