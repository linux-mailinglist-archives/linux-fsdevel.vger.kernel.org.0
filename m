Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB5F13018D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgADJKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 04:10:01 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38930 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbgADJKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 04:10:01 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9109143F45C;
        Sat,  4 Jan 2020 20:09:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1infRT-0001jO-J9; Sat, 04 Jan 2020 20:09:55 +1100
Date:   Sat, 4 Jan 2020 20:09:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM TOPIC] Congestion
Message-ID: <20200104090955.GF23195@dread.disaster.area>
References: <20191231125908.GD6788@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231125908.GD6788@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=yCk7sgB39VCk9DmHSNQA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 31, 2019 at 04:59:08AM -0800, Matthew Wilcox wrote:
> 
> I don't want to present this topic; I merely noticed the problem.
> I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> thread here:
> 
> https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> 
> Summary: Congestion is broken and has been for years, and everybody's
> system is sleeping waiting for congestion that will never clear.

Another symptom: system does not sleep because there is no recorded
congestion so it doesn't back off when it should (the
wait_iff_congested() backoff case).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
