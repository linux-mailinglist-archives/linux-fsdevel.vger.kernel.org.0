Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C43D07D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 09:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJIHHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 03:07:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIHHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MGvQWs9rgoPYdPU6u7T0lBa25VmxpsDkrkmLedqYBZM=; b=pBe3nj0V/WHm0xTjsyzrDfHdr
        Fwxf0Y8tp7TGOeb5lsuIEGSQeuICm2vJMYWW6mbLL7P9MUBQDVj+1Iv9xvEuLeG5YRnK7gQzjwHxi
        6DnsxgE33R0bH/vJsZyWSUTdyYpxDPB5AkWaENjMY8mJFT6SuXkOdeu3h7Jzv+6m/xzH35wo410YU
        Q4kvQZeRWN+u0ErHsd/AuVVP0LeJIaAzWROa0r8FSblngRywv+Ha96Vk5k9Mvy+BCV/2ra8Hwxx65
        q7EkVZ0arGkUpPYIgeiCSn7oAicJvDrJEZvflEIQ8VWx+OedvhFuO0E+IzBZ23pSsT4L3LFBkZHMq
        zd6LMCZvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iI64X-0000RW-3t; Wed, 09 Oct 2019 07:07:45 +0000
Date:   Wed, 9 Oct 2019 00:07:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191009070745.GA32281@infradead.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009060255.8055742049@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009060255.8055742049@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:32:54AM +0530, Ritesh Harjani wrote:
> We can also get rid of "first_block" argument here.

That would just duplicate filling it out in all callers, so why?
