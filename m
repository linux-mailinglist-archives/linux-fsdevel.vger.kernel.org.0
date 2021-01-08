Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239DA2EF036
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbhAHJzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:55:44 -0500
Received: from verein.lst.de ([213.95.11.211]:43312 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbhAHJzo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:55:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6548567373; Fri,  8 Jan 2021 10:55:00 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:55:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH 02/10] blk: Introduce ->corrupted_range() for block
 device
Message-ID: <20210108095500.GA5647@lst.de>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com> <20201230165601.845024-3-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-3-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It happens on a dax_device.  We should not interwind dax and block_device
even more after a lot of good work has happened to detangle them.
