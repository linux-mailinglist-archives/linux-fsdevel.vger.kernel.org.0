Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE28F27753D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgIXP16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXP16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:27:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088FC0613CE;
        Thu, 24 Sep 2020 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XOgqbfKIOIS0zjbdzZyFZMH9nxEgVK9j9uvP0V6wiXY=; b=ckfLqCER/11Hx19TNz7hu7WV2y
        /7otBkCV1hyb/It215b76l1niPMJKldbwO62jBTDPmXgRz0FIEplj2NcC8klmB6fjm76s9X6xalR5
        gNn/RN4rQAAogyPKAVSFKMYat0V2ghA9skJDRn0Fi+/h/+38T9o3vqzd2x24e1QxRvxfn8rfCFCoA
        WmzhJ/CQFFttgECZe2Ipphz8ElgYBSwdRQIhTHMM+7FiDrD5JXCxmeEZG7ahX7mX938WPjsixVuSF
        X8Hef6lLjmwv1D4y2cRsZhUUnncc0FbkyZL9IZxjCvbsn1rQh1fEBJEX/BPTuc0Vekvu0tukmz9kk
        pViWwOPw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLTA3-0001Hb-LW; Thu, 24 Sep 2020 15:27:55 +0000
Date:   Thu, 24 Sep 2020 16:27:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924152755.GY32101@casper.infradead.org>
References: <20200924125608.31231-1-willy@infradead.org>
 <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
 <20200924151538.GW32101@casper.infradead.org>
 <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:21:00PM +0200, Sedat Dilek wrote:
> Great and thanks.
> 
> Can you send out a seperate patch and label it with "PATCH v5.9"?
> I run:
> $ git format-patch -1 --subject-prefix="PATCH v5.9" --signoff
> 
> Normally, I catch patches from any patchwork URL in mbox format.

Maybe wait a few hours for people to decide if they like the approach
taken to fix the bug before diving into producing backports?
