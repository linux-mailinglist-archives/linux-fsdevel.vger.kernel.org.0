Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4D5917D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 04:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfF1Cqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 22:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfF1Cqm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:46:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14D8CC057E65;
        Fri, 28 Jun 2019 02:46:42 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ECAB1001B16;
        Fri, 28 Jun 2019 02:46:41 +0000 (UTC)
Date:   Fri, 28 Jun 2019 10:52:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Message-ID: <20190628025204.GI30864@dhcp-12-102.nay.redhat.com>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-8-hch@lst.de>
 <20190627182309.GP5171@magnolia>
 <20190627214304.GB30113@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627214304.GB30113@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Jun 2019 02:46:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:43:04PM +0000, Luis Chamberlain wrote:
> On Thu, Jun 27, 2019 at 11:23:09AM -0700, Darrick J. Wong wrote:
> > On Thu, Jun 27, 2019 at 12:48:30PM +0200, Christoph Hellwig wrote:
> > > There is no real problem merging ioends that go beyond i_size into an
> > > ioend that doesn't.  We just need to move the append transaction to the
> > > base ioend.  Also use the opportunity to use a real error code instead
> > > of the magic 1 to cancel the transactions, and write a comment
> > > explaining the scheme.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Reading through this patch, I have a feeling it fixes the crash that
> > Zorro has been seeing occasionally with generic/475...
> > 
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Zorro, can you confirm? If so it would be great to also refer to
> the respective bugzilla entry #203947 [0].

Sure, I'll give it a test. But it's so hard to reproduce, I need long enough
time to prove "the panic's gone".

BTW, should I only merge this single patch to test, or merge your whole patchset
with 13 patches?

Thanks,
Zorro

> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=203947
> 
>   Luis
