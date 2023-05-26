Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AEE71220E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjEZIUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbjEZIU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA619A;
        Fri, 26 May 2023 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0KbVHtLWzypQwk+AwZxRS0QdYzT+F7q/5Piz32xg/x8=; b=oRl19PBV9T5B9yEeGSQqipatMr
        PRxWWS4jGFgwZvrv2rWRlSzwLJe6REI6Iw0aokgq/vH/EAL6v9jQygHGuYq7IAnF5QH08o4NT968K
        2WA9NTHPmS0lkiCxEhYUlBxjFUW27zaMXt3/ooiriD0jmANXQzCRL/BsOujZeq4aKiOSQaOy+7lxa
        jfR8o0+4WFcujnWQe2iUrlHP5sbYbKQBGwHU7QU5YboV9aepiIdevTotLwapoePOafMrs17+7eYGn
        w7Sf9No/xGOC0HbZ6NCPNE4vV9O70l1asn9Tfmev+S2rMJKGCyyyyVAIKnLeQELhIup8qahAdq2Xn
        VMm3c4UQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SgK-001aII-1S;
        Fri, 26 May 2023 08:20:16 +0000
Date:   Fri, 26 May 2023 01:20:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, djwong@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, kbusch@kernel.org
Subject: Re: [PATCH v2 1/5] block: annotate bdev_disk_changed() deprecation
 with a symbol namespace
Message-ID: <ZHBrwFk0d80IiOfV@bombadil.infradead.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
 <20230526073336.344543-2-mcgrof@kernel.org>
 <ZHBqGosY0tWkNdIR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBqGosY0tWkNdIR@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 01:13:14AM -0700, Christoph Hellwig wrote:
> On Fri, May 26, 2023 at 12:33:32AM -0700, Luis Chamberlain wrote:
> > This ensures no other users pop up by mistake easily and provides
> > us a with an easy vehicle to do the same with other routines should
> > we need it later.
> 
> I don't see how this is related to the rest of the seris.

Jessh, sorry it is too late here and that was a typo that the commit
went into the series. I'll go sleep now. This I just had queued
as a reminder for the new annotation for deprecated symbols to be
used in some situations.

Please ignore this patch.

  Luis
