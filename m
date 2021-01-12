Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B992F3FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbhALW4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:56:55 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:58001 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730309AbhALW4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:56:55 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 761FB825B5E;
        Wed, 13 Jan 2021 09:56:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzSaC-005q7P-VF; Wed, 13 Jan 2021 09:56:12 +1100
Date:   Wed, 13 Jan 2021 09:56:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 06/10] xfs: improve the reflink_bounce_dio_write
 tracepoint
Message-ID: <20210112225612.GB331610@dread.disaster.area>
References: <20210112162616.2003366-1-hch@lst.de>
 <20210112162616.2003366-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112162616.2003366-7-hch@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=LWRw3s_uomCoa4QlczwA:9 a=CjuIK1q_8ugA:10 a=DBeEp3iAzaEA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 05:26:12PM +0100, Christoph Hellwig wrote:
> Use a more suitable event class.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c  | 2 +-
>  fs/xfs/xfs_trace.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
