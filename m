Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A25FE327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfKOQrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:47:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfKOQrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=14KN1oHpJ3AEVWGMOw/mGDQmK2S21spCgWOwY5U55Y8=; b=jLLwqBA0YLhNUwDf483NT5M9l
        rAWKfL+4lnOrzYIv3E7D0TvAC+P4+BnE48hhEm+pF6adRoNG5xPOzcCxuRTB0SQT12SfswLg5xkCq
        LMYkjiSpDKgsLExk0en2dJ+90Gw01IerC7fI660QSO1FuYgrTGUG50t0K6X647zmaX+0ixp8Gw2Rx
        IOxvzT4NMiBS1sgmT6xhN6P/SP65bSuD09IaO2kFo0Sp34hq4LgbbG/fUasWS+uRbnphyJ86WV2m0
        XPqlkQamChzfopz+1DG6MQez5zzodSJKAF/GsBQY7KuZsPNUi3gfkwD4bIWGM1zUdwvr6iB7LSH3V
        UCdUqjugQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVel2-0008Th-BQ; Fri, 15 Nov 2019 16:47:40 +0000
Date:   Fri, 15 Nov 2019 08:47:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 5/7] btrfs: Use iomap_dio_ops.submit_io()
Message-ID: <20191115164740.GC26016@infradead.org>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-6-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161700.12305-6-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:16:58AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Use iomap_dio_ops.submit_io() to submit the bio for btrfs.

Doesn't this belong into the previous patch?
