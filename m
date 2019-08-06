Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F482B48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfHFFwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:52:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFFwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iZC/LxWLoozeZ5gTwVtLdiR4/XxQSz/euJz+TZ/eCnw=; b=q4fdESRb6K3x66Fw7txqEcKK5
        4KlVi6yIEoU7IvWdoy9lZ6LSDjSRpCegCickw8Trb/Haj10d8zo2wciqzZ6s9G9DczOJhnIObH/TH
        wYOxI58cGZXCii9uduwIFPZDFo8r61nR9BiczF4vm13RE9hiAGOE3MeK4LGa/WwEABECUcOtqpsEu
        s6kYqRzozSPGGJ5z50LuBMxFjeW5CrWOidhdOTTy4QCimsu6DoRb/mi/rPSeo6rZxITF9BYMzS04c
        NNHfGBn8IsfKmDXkiArhcjJW2V7TIY5fOvthXcFsyOwVVYRcMF2SlByBldUA+uRdrNKtjz7gZdhby
        Stz3sgd0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1husOv-00085U-Uz; Tue, 06 Aug 2019 05:52:49 +0000
Date:   Mon, 5 Aug 2019 22:52:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/24] xfs: correctly acount for reclaimable slabs
Message-ID: <20190806055249.GB25736@infradead.org>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-13-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-13-david@fromorbit.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:40PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The XFS inode item slab actually reclaimed by inode shrinker
> callbacks from the memory reclaim subsystem. These should be marked
> as reclaimable so the mm subsystem has the full picture of how much
> memory it can actually reclaim from the XFS slab caches.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, I wonder if we should just kill off our KM_ZONE_* defined.  They
just make it a little harder to figure out what is actually going on
without a real benefit.
