Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D196EEB8DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfJaVWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 17:22:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfJaVWH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xJnS2gKgHjZwKIXoPBsFqoULOP0zn3va2TnZ/oOJ3gw=; b=Zu8aMJLWjIYFVQR1/YLr7B6fX
        nz2eqJ4vQdXty7zLXyepGBMGFvcNRitsdlp9URLiH51b1V2AVOMRexVZAObnKb0VERCBSoP/yak/L
        nhgNS+BRkms5Nd0D2kNFhquds/QSKki19XH/FnjdjolXimiMPpS0k95oMDNbKgCT1giYanPdMoQn4
        im+KO1duNYuP4umtwyFOQISP8/EvZWW8q+UyLoys02aYC+hzv9CPhoFe+kRAJhUZTuFLKQDmMQoc1
        9n0Evz5tGYfWURNL2whZUuScTx1e1ovBq/kOgKzl8ly38rIeawCD3/sMtcqNu13EEF4+YhsXZQz4w
        3qV9r9R6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQHtN-0008MS-T6; Thu, 31 Oct 2019 21:22:05 +0000
Date:   Thu, 31 Oct 2019 14:22:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191031212205.GB6244@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191030172517.GO15222@magnolia>
 <20191030214335.GQ4614@dread.disaster.area>
 <20191031030658.GW15222@magnolia>
 <20191031205049.GS4614@dread.disaster.area>
 <20191031210551.GK15221@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031210551.GK15221@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:05:51PM -0700, Darrick J. Wong wrote:
> Sounds like a reasonable place (to me) to record the fact that we want
> inodes and metadata buffers not to end up concentrating on a single node.
> 
> At least until we start having NUMA systems with a separate "IO node" in
> which to confine all the IO threads and whatnot <shudder>. :P

Wait until someone does a Linux port to the Cray T3E ;-)
