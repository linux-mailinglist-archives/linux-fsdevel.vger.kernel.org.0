Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9BD3D64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJKKbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:31:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LyKGAyW3gfj+dtXeOfhSEREW8br0SHPpId6OAsWbrD4=; b=ckoCWi34ERh6iwSu1YuSkl4/Z
        yhhrjWZj0c1VYc4sWd7Lcy/DVekSkQy7iIuanQttNWqelMClrN4dveT6Pt1Ud7JbEDUUf9bRpikad
        1BT3+TjbmfZTjExIRdPmZ/5cFHGy1ZRokBKmlQmRHpJrXnXx4qC4VAPW0M5+tGRbBoPM8lyMKYIOA
        w10ny9XvLLnuTIsa8HfMw7QzfPezMbYDPePvZzUeu2ZWHJOBsvGB8SlL5emePxEgHqziXibIp/PPR
        fC36pjWZ0xobn2uu/D1VoTqTlJ0BQLzjBf5p8+MYH78Xc0aqTlKFZjJN3RMXS0BVyAk0wYOaTVQN5
        c8D9/GWAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsCg-0000RH-PG; Fri, 11 Oct 2019 10:31:22 +0000
Date:   Fri, 11 Oct 2019 03:31:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/26] xfs: kill background reclaim work
Message-ID: <20191011103122.GB12811@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-20-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-20-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:17PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> This function is now entirely done by kswapd, so we don't need the
> worker thread to do async reclaim anymore.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
