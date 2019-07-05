Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4460B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGEStF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 14:49:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58608 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbfGEStE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:49:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 370348EE1F7;
        Fri,  5 Jul 2019 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562352544;
        bh=pRKHY8qZ/7aIRatoNEiEEL+ERx8f+mdPdRR1Tdm7ndw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W6E4PtOyGc789JxSB/eoi9v4cD20Yg0krCULsLgDG/aU3PXOmSzpDmZ8ebxZXrfsK
         QJ/DN0shjYfv3Cx9gZQ19T2yDvPCgu6iGOfEpPp72liXqFL/TuLyhKHf8oq5UGD8Pr
         BVz8jdF48GEO7bqVTHfEqKETAwZjy9OCGWW1+Lo4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yJ5aKR7xYlEs; Fri,  5 Jul 2019 11:49:04 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A5FD48EE0CF;
        Fri,  5 Jul 2019 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562352543;
        bh=pRKHY8qZ/7aIRatoNEiEEL+ERx8f+mdPdRR1Tdm7ndw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wzs/V+kl3Zh2xJYA0ChAOFiJ+ATqWXbNodPwz5Htmz7e1kfPakjgXBPuUq15aSCzA
         ur5OK488sRWWl4iCokcNfAbkdg7gmg7eE2UJU+clTQihZk9l5WA659g5vwXbxvTCqe
         PQQwwJfVTh1+gDM0eEEsba8S70cf8xFMGcqJqXsc=
Message-ID: <1562352542.2953.10.camel@HansenPartnership.com>
Subject: Re: Question about ext4 testing: need to produce a high depth
 extent tree to verify mapping code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 11:49:02 -0700
In-Reply-To: <20190705173905.GA32320@bombadil.infradead.org>
References: <1562021070.2762.36.camel@HansenPartnership.com>
         <20190702002355.GB3315@mit.edu>
         <1562028814.2762.50.camel@HansenPartnership.com>
         <20190702173301.GA3032@mit.edu>
         <1562095894.3321.52.camel@HansenPartnership.com>
         <20190702203937.GG3032@mit.edu>
         <1562343948.2953.8.camel@HansenPartnership.com>
         <20190705173905.GA32320@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-07-05 at 10:39 -0700, Matthew Wilcox wrote:
> On Fri, Jul 05, 2019 at 09:25:48AM -0700, James Bottomley wrote:
> > Now the problem: I'd like to do some testing with high depth extent
> > trees to make sure I got this right, but the files we load at boot
> > are ~20MB in size and I'm having a hard time fragmenting the
> > filesystem enough to produce a reasonable extent (I've basically
> > only got to a two level tree with two entries at the top).  Is
> > there an easy way of producing a high depth extent tree for a 20MB
> > file?
> 
> Create a series of 4kB files numbered sequentially, each 4kB in size
> until you fill the partition.  Delete the even numbered ones.  Create
> a 20MB file.

Well, I know *how* to do it ... I was just hoping, in the interests of
creative laziness, that someone else had produced a script for this
before I had to ... particularly one which leaves more randomized gaps.

James

