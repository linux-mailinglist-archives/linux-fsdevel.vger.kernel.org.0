Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91AC252350
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHYWF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 18:05:29 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:53878 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgHYWF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:05:29 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 13A45D7D47D;
        Wed, 26 Aug 2020 08:05:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kAh4E-0000RK-Vc; Wed, 26 Aug 2020 08:05:22 +1000
Date:   Wed, 26 Aug 2020 08:05:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200825220522.GO12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
 <20200825002735.GI12131@dread.disaster.area>
 <20200825032603.GL17456@casper.infradead.org>
 <E47B2C68-43F2-496F-AA91-A83EB3D91F28@dilger.ca>
 <20200825042711.GL12131@dread.disaster.area>
 <20200825124024.GN17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825124024.GN17456@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=2U9gKF9mzcrskAPIHE4A:9 a=CjuIK1q_8ugA:10 a=n3xvM8a_0i4A:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:40:24PM +0100, Matthew Wilcox wrote:
> Any objection to leaving this patch as-is with a u64 length?

No objection here - I just wanted to make sure that signed/unsigned
overflow was not going to be an issue...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
