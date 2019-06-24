Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69B351F43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 01:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfFXXub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 19:50:31 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47308 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727699AbfFXXub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:50:31 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 47B1D14A8C6;
        Tue, 25 Jun 2019 09:50:28 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hfYi9-0000mk-4I; Tue, 25 Jun 2019 09:49:21 +1000
Date:   Tue, 25 Jun 2019 09:49:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: add tracing for the address space operations
Message-ID: <20190624234921.GE7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-13-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=ZhRtIkhqOmk6FrnBfpAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:53AM +0200, Christoph Hellwig wrote:
> Lift the xfs code for tracing address space operations to the iomap
> layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

....

> diff --git a/include/trace/events/iomap.h b/include/trace/events/iomap.h
> new file mode 100644
> index 000000000000..da50ece663f8
> --- /dev/null
> +++ b/include/trace/events/iomap.h
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2009-2019, Christoph Hellwig
> + * All Rights Reserved.
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM iomap

Can you add a comment somewhere here that says these tracepoints are
volatile and we reserve the right to change them at any time so they
don't form any sort of persistent UAPI that we have to maintain?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
