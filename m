Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54160B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfGERjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 13:39:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfGERjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 13:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/uC5M3ierRS+Hhs1DpFJF+UTUe2DRAKcMjsTpsN7uZU=; b=PIZNiJ1WxKKIRw+vM1xmzPDsL
        sos6egHIMaJUiMNPTIuMXWSQ37rv6LOoI+JVLpTJ8X73yb8qeUREX3Ec7OesnOKF0USoCH3iC+LR0
        2w1ENFIGOYQDbVL3vMwOjBlrXLTWp3oKFhTmcv1+O4eQcFIx0zQuGXvJwu05JnBPuZDtvg0MqVG5O
        FfsrPh6pURk8BqtN/JPBvgNNr3g7r/02ag/RkW/R++nWwo2NJF17XXyJPr472WQ/1o5NySoaF15BR
        aT9dpouC9xEof94S20lQs3Qa7jeXW5CqJizZIuoo/jU/Rpqa/Qi6EkxlM0HsnldJ6M/RTdSZ2LQH3
        0Cmlqc4OA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjSAs-0006Q6-3F; Fri, 05 Jul 2019 17:39:06 +0000
Date:   Fri, 5 Jul 2019 10:39:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: Question about ext4 testing: need to produce a high depth extent
 tree to verify mapping code
Message-ID: <20190705173905.GA32320@bombadil.infradead.org>
References: <1562021070.2762.36.camel@HansenPartnership.com>
 <20190702002355.GB3315@mit.edu>
 <1562028814.2762.50.camel@HansenPartnership.com>
 <20190702173301.GA3032@mit.edu>
 <1562095894.3321.52.camel@HansenPartnership.com>
 <20190702203937.GG3032@mit.edu>
 <1562343948.2953.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562343948.2953.8.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:25:48AM -0700, James Bottomley wrote:
> Now the problem: I'd like to do some testing with high depth extent
> trees to make sure I got this right, but the files we load at boot are
> ~20MB in size and I'm having a hard time fragmenting the filesystem
> enough to produce a reasonable extent (I've basically only got to a two
> level tree with two entries at the top).  Is there an easy way of
> producing a high depth extent tree for a 20MB file?

Create a series of 4kB files numbered sequentially, each 4kB in size
until you fill the partition.  Delete the even numbered ones.  Create a
20MB file.
