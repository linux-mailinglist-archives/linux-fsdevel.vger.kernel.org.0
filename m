Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8B300017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbhAVKVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 05:21:53 -0500
Received: from verein.lst.de ([213.95.11.211]:35935 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbhAVKV3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:21:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F87368AFE; Fri, 22 Jan 2021 11:20:45 +0100 (CET)
Date:   Fri, 22 Jan 2021 11:20:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/11] xfs: reduce exclusive locking on unaligned dio
Message-ID: <20210122102045.GA22568@lst.de>
References: <20210121085906.322712-1-hch@lst.de> <20210121085906.322712-12-hch@lst.de> <20210121093549.GC4662@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210121093549.GC4662@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:35:49PM +1100, Dave Chinner wrote:
> Why not use the ((offset | length) & mp->blockmask) form of
> alignment checking here?

Sure. I'ĺl switch to that.

> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Given that the original patch and thus credit is yours this doesn't
make sense to add, though.
