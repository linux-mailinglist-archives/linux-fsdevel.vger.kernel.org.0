Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C6810EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEAWFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:05:18 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43531 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfEAWFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:05:18 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E77EE43A258;
        Thu,  2 May 2019 08:05:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hLxLn-0004sX-4k; Thu, 02 May 2019 08:05:15 +1000
Date:   Thu, 2 May 2019 08:05:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     darrick.wong@oracle.com, agruenba@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: move iomap_read_inline_data around
Message-ID: <20190501220515.GM1454@dread.disaster.area>
References: <20190501161111.32475-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501161111.32475-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=UJetJGXy c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=JuDxSlhT3OO6blO4plAA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 12:11:11PM -0400, Christoph Hellwig wrote:
> iomap_read_inline_data ended up being placed in the middle of the bio
> based read I/O completion handling, which tends to confuse the heck out
> of me whenever I follow the code.  Move it to a more suitable place.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
