Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8512F4000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436872AbhALWnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:43:50 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:43782 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbhALWnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:43:50 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id E92AC11733B;
        Wed, 13 Jan 2021 09:43:07 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzSNF-005ps2-LF; Wed, 13 Jan 2021 09:42:49 +1100
Date:   Wed, 13 Jan 2021 09:42:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 02/10] xfs: make xfs_file_aio_write_checks
 IOCB_NOWAIT-aware
Message-ID: <20210112224249.GX331610@dread.disaster.area>
References: <20210112162616.2003366-1-hch@lst.de>
 <20210112162616.2003366-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112162616.2003366-3-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=-CHAj0AIzeXgiPsY6zMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 05:26:08PM +0100, Christoph Hellwig wrote:
> Ensure we don't block on the iolock, or waiting for I/O in
> xfs_file_aio_write_checks if the caller asked to avoid that.
> 
> Fixes: 29a5d29ec181 ("xfs: nowait aio support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

LGTM

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
