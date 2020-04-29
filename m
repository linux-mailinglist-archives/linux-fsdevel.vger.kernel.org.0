Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0321BDA74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgD2LPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2LPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E016BC03C1AD;
        Wed, 29 Apr 2020 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZiL+C64pEB0gGtZIjbEgTMKcXAg4VXf1yvXjFv+qDw=; b=YcSAHSw6S3qB0Tg7W4OVOCRBTL
        YXvpVMydg9K6WrN4eq5xtf4hAH0jgIntPTDWsKB/3Sq2bhdePBNC1pFzKafwOy382NH0IcyH7zVDO
        3LXJ0fPUAG+PZJZJs6jozz957nBUeO3eg0nHBVVy5ays3f9nYB3PLLuQewq6wseOK+SosyaWHV5Ih
        KcxmFTBVX1pQ0wpPJolRTsiDJMs5+FfP82eYLaC1yGOWtf9k/ruEN2TLAgMrAaUBHuueAq7cCyxeL
        tTPDl3mModtoVgLYgenjyIN3UcM8x6+gvx0w/msMwPZg8ejNKfY+mjnsp98NZi19hH/H+KybTisdz
        /o4NOevQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTkgU-00013v-I5; Wed, 29 Apr 2020 11:15:22 +0000
Date:   Wed, 29 Apr 2020 04:15:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 2/6] block: move main block debugfs initialization to
 its own file
Message-ID: <20200429111522.GB21892@infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-3-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:23AM +0000, Luis Chamberlain wrote:
> make_request-based drivers and and request-based drivers share some
> debugfs code. By moving this into its own file it makes it easier
> to expand and audit this shared code.
> 
> This patch contains no functional changes.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: yu kuai <yukuai3@huawei.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
