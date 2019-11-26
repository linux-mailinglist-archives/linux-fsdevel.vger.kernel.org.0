Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A937010A0FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfKZPMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 10:12:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfKZPMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qlHMGMW/mER/ug0FVdMjPHGf7gqNNs79oj6hmUgpqe4=; b=HRYoQzdRi8MtTqcped00ddh/p
        fKt4WGGRVtOtbj1mKwLNArdn1roSySJ1XldB97OfClfOV0xcJ6OAzvtlUHzZLeVlVIp1iDg5n5Cdp
        htG0qfii7XfaEIcQIjgu08I+9SJLYRvvIZwshTXlHl9nxpsv4v9gW7ZKQLGmQftsbPwdvsdavQeZ/
        +zfHPeL91WMiYo3ImcMjPcIhpg4yi4sDMA69B0hprhLI3kUkKOFc8PWGRplHd6DPvtSvLJFBO2xVA
        JLTJz3Txths2/HRvG4DHomqowRuBP1sY67TpVV50Pr5unIexL3uZRPRm6FNOPFJRPrLLSEoapS4zt
        /gUyT+ECQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZcVk-0000bD-GK; Tue, 26 Nov 2019 15:12:16 +0000
Date:   Tue, 26 Nov 2019 07:12:16 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Message-ID: <20191126151216.GD20752@bombadil.infradead.org>
References: <20191125083930.11854-1-jack@suse.cz>
 <20191125111901.11910-1-jack@suse.cz>
 <20191125211149.GC3748@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125211149.GC3748@bobrowski>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 08:11:50AM +1100, Matthew Bobrowski wrote:
> > +	 * are operating on right now.  The iter will be re-expanded once
>   	       		    	      ^^
> 				      Extra whitespace here.

That's controversial, not wrong.  We don't normally enforce a style there.
https://www.theatlantic.com/science/archive/2018/05/two-spaces-after-a-period/559304/
(for example.  you can find many many many pieces extolling one or
two spaces).
