Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61E1BDA7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD2LUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2LUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:20:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC15C03C1AD;
        Wed, 29 Apr 2020 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=edQRYOZC7+bGzu4klieEhzueP0ff7UULya+SzfH1TFk=; b=XXorFLsXqdHVXmLrX+9IgfnsxQ
        5VLCAPMu/Ppvt+f7r7KKi+BXdFnbn6eoofTEEHqmnmxyP47UtfKApzzHBpr7xrYb273cYgiK/raqU
        /QI4/Z9+k8Qw7QlNW/XrHrjdxaFsADhn+n5jdUp3fBrZeWrn5gfycmpoTuk7rukv4Nbi6VV44KpAa
        zEvEuRElKH0NUlIXmCdJq0nvHN0IhhErjVVy4+W7KPONRtI+tiullzIrhJtW9w9cpkR7HJ+FJftff
        x7v9M98q5EvMoQC+a8ZnQBxaSsENgO5Q37JM81dCortelI7S3lJsA+nw6wELukZZHb0PObFYU5uFr
        nfJLVJTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTklD-0004CL-B7; Wed, 29 Apr 2020 11:20:15 +0000
Date:   Wed, 29 Apr 2020 04:20:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] blktrace: move blktrace debugfs creation to
 helper function
Message-ID: <20200429112015.GC21892@infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:24AM +0000, Luis Chamberlain wrote:
> Move the work to create the debugfs directory used into a helper.
> It will make further checks easier to read. This commit introduces
> no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
