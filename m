Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8670E9586E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfHTHa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 03:30:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfHTHa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yuiBGszRMG8jYGlr5edUN6NqZ7nqR/Q4hrdSdVriY+Y=; b=WBr0CROubugXg9aBfeqbWfLZT
        hceMHl1ObeG2uKnMPYF41qu60CXmPig9ParKGolHg1Ah/ZLhbizntzH+JjHOgJ+G4MMxi/jwTv7yI
        nkCxbv+awYLB0hHnvygi88hQq49hi9k/3vjqxIvnAIdZR4fzse44PEzSL/ZJ2OkXXbf+DsW8tlp48
        gDXrtXqtNuTVDqxK4WqXvktoOq9xB2qUeMdGvhhSMPrnIDQICBDyeKpjdW2ldQSf6eXmj2OS7if/v
        iGfwol1V4J3gWPOosmMs1T5PYGlQgQKTCLS6AB309NjdOVNBB87+hmtyAzGhkJON+UfERPuwKKw3I
        v3Ad9ykKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzyb4-0007rX-N8; Tue, 20 Aug 2019 07:30:26 +0000
Date:   Tue, 20 Aug 2019 00:30:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Damien.LeMoal@wdc.com,
        agruenba@redhat.com
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Message-ID: <20190820073026.GA23347@infradead.org>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
 <20190816065229.GA28744@infradead.org>
 <20190817014633.GE752159@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817014633.GE752159@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 16, 2019 at 06:46:33PM -0700, Darrick J. Wong wrote:
> On Thu, Aug 15, 2019 at 11:52:29PM -0700, Christoph Hellwig wrote:
> > Darrick,
> > 
> > are you going to queue this up?
> 
> Yes, I'll go promote the iomap writeback branch to iomap-for-next.  I
> haven't 100% convinced myself that it's a good idea to hook up xfs to it
> yet, if nothing else because of all the other problems I've had getting
> 5.3 testing to run to completion reliably...

Oh well.  I had some XFS/iomap patches I want to dust off that depend
on it, but I guess they'll have to wait then.

We just need to be very careful the versions don't get out of sync,
which would be a major pain in the butt.
