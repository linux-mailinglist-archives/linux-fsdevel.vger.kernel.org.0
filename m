Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6533AEC4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUP21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFUP20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:28:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE581C061574;
        Mon, 21 Jun 2021 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RaL9pjrf6kBrAUekPT/7a9K4DvP40sey65kcV5mPsCo=; b=VYdbV0RgzLNF8yQAFKh5puPdWl
        /6+0z33lQXYykpsZ1/Fhqb1asNR3TXnoLENhRi+3QkvlaEznl9CuYNalsfLY48Loye50nOe0DNPY9
        46BdW1S+CG/8s2Ar27y0m91EL+UGwyoEiw5Mj/fr/mYFW2bbn2EVYra5Ie39Tk1gd/4eEbox60nli
        VgEskBzcKWWl+JuhhrQhKxEJQHNsctyRZ72+guJOqnXPIjNebkWmbCjMGjD7cc7UnTyhlsgsSn4IC
        soSikO/TTcM2sCCSvkyHYSLfGlXvNmINNdTNtakX/A/HXcidlSpXZaokphBNKA3f5R6FGjdfHGYA4
        MpjzTkjA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLnV-00DEJ4-9N; Mon, 21 Jun 2021 15:25:18 +0000
Date:   Mon, 21 Jun 2021 16:25:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        david@fromorbit.com, hch@infradead.org
Subject: Re: [RFC PATCH v4 0/8] ext4, jbd2: fix 3 issues about
 bdev_try_to_free_page()
Message-ID: <YNCvWfPkauVIz2eP@infradead.org>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <YMsagbQqxJo4y2FR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsagbQqxJo4y2FR@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:48:49AM +0100, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Just curious: does anyone plan to pick this up for 5.14?  Getting rid
of the layering violation on the block device mapping would really help
with some changes I am working on.
