Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782F71A7395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405957AbgDNGZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 02:25:34 -0400
Received: from verein.lst.de ([213.95.11.211]:37625 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405926AbgDNGZc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:25:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6489227A81; Tue, 14 Apr 2020 08:25:30 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:25:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 4/9] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200414062530.GD23154@lst.de>
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-5-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:41PM -0700, ira.weiny@intel.com wrote:
> +#define XFS_MOUNT_DAX		(1ULL << 62)
> +#define XFS_MOUNT_NODAX		(1ULL << 63)

Replace this with XFS_MOUNT_DAX_ALWAYS and XFS_MOUNT_DAX_NEVER?
