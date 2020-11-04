Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFD2A673C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 16:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgKDPQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 10:16:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:45442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgKDPQH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:16:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44500ABA2;
        Wed,  4 Nov 2020 15:16:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0C1FC1E130F; Wed,  4 Nov 2020 16:16:05 +0100 (CET)
Date:   Wed, 4 Nov 2020 16:16:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Qian Cai <cai@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
Message-ID: <20201104151605.GG5600@quack2.suse.cz>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
 <20201022004906.GQ20115@casper.infradead.org>
 <20201026094948.GA29758@quack2.suse.cz>
 <20201026131353.GP20115@casper.infradead.org>
 <d06d3d2a-7032-91da-35fa-a9dee4440a14@kernel.dk>
 <aa3dfe1f9705f02197f9a75b60d4c28cc97ddff4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3dfe1f9705f02197f9a75b60d4c28cc97ddff4.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-10-20 10:26:26, Qian Cai wrote:
> On Mon, 2020-10-26 at 07:55 -0600, Jens Axboe wrote:
> > I've tried to reproduce this as well, to no avail. Qian, could you perhaps
> > detail the setup? What kind of storage, kernel config, compiler, etc.
> > 
> 
> So far I have only been able to reproduce on this Intel platform:
> 
> HPE DL560 gen10
> Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
> 131072 MB memory, 1000 GB disk space (smartpqi nvme)

Did you try running with the debug patch Matthew sent? Any results?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
