Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DFFB39F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfIPMGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 08:06:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbfIPMGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XSL6Bl9hJ55gtSPqYwN0+CzMifMcYDXzcyu9qPjx0g8=; b=m4bkG/dJ6IPt2DdgvnxhTcb1W
        ucMj8d/IESwVkNRT7PJCUMhlz1Z9FILucsSV8elbNd9sN84srFZTcu31FBiGBY5V/h+c1O+7I2HuF
        Bm51zi9bKarUmyVW6UkwvRDnXV7w28cxYd114bfuZmHO2KFGpvoGeya2ssp6voj94uVOA319qLSMP
        weo9l6aEQpZ4ez+Cdw7SDICwnPv3VsIYCO4w7+k3RDDxwyhmKyp/FYmFXHhNwP+Q8q8XCZFLv7DD8
        3xzPl3vpyOivVq0Gbd1cX/xKhIgp+lrWFzONTMsvfP4OFg/qKNvx2TA1G5T1SR5Q4gXghoYLl02pB
        1U47CvDeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9pm4-0004jl-9q; Mon, 16 Sep 2019 12:06:32 +0000
Date:   Mon, 16 Sep 2019 05:06:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 6/6] ext4: cleanup legacy buffer_head direct IO code
Message-ID: <20190916120632.GC4005@infradead.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <1d83ac7f8088837064b90cfb3182a37b46356239.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d83ac7f8088837064b90cfb3182a37b46356239.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 09:05:03PM +1000, Matthew Bobrowski wrote:
> Remove buffer_head direct IO code that is now redundant as a result of
> porting across the read/write paths to use iomap infrastructure.

I still think moving the removal of the not required code into the
actual patches that make the code obsolete is a better idea.  That
makes it very clear what is added to remove what kind and amount of
old code.
