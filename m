Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFED91FA422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 01:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgFOXc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 19:32:56 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:45906 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgFOXcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:32:55 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 02A161A8A35;
        Tue, 16 Jun 2020 09:32:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jkyal-0001Ag-AO; Tue, 16 Jun 2020 09:32:39 +1000
Date:   Tue, 16 Jun 2020 09:32:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200615233239.GY2040@dread.disaster.area>
References: <20200615160244.741244-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615160244.741244-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=f-r3AIvpdvzm66fx2AsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:02:44PM +0200, Andreas Gruenbacher wrote:
> Make sure iomap_end is always called when iomap_begin succeeds: the
> filesystem may take locks in iomap_begin and release them in iomap_end,
> for example.

Ok, i get that from the patch, but I don't know anything else about
this problem, and nor will anyone else trying to determine if this
is a fix they need to backport to other kernels. Can you add some
more information to the commit message, such as how was this found
and what filesystems it affects? It would also be good to know what
commit introduced this issue and whether it need stable back ports
(i.e. a Fixes tag).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
