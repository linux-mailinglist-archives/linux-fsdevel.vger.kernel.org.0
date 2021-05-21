Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC09F38C1F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhEUIiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:38:00 -0400
Received: from verein.lst.de ([213.95.11.211]:46990 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhEUIiA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:38:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E24C6736F; Fri, 21 May 2021 10:36:35 +0200 (CEST)
Date:   Fri, 21 May 2021 10:36:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <20210521083635.GA15311@lst.de>
References: <YKcouuVR/y/L4T58@T590> <20210521071727.GA11473@lst.de> <YKdhuUZBtKMxDpsr@T590> <20210521073547.GA11955@lst.de> <YKdwtzp+WWQ3krhI@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdwtzp+WWQ3krhI@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 04:35:03PM +0800, Ming Lei wrote:
> Just wondering why the ioend isn't submitted out after it becomes full?

block layer plugging?  Although failing bio allocations will kick that,
so that is not a deadlock risk.
