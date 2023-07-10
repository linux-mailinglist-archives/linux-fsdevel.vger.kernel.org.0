Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECC74CA9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 05:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGJDhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 23:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGJDhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:37:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C3EB5;
        Sun,  9 Jul 2023 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2OThL4zoENi2NWZu2dF9b0AgDDcQAEonJGRbw7IoxHI=; b=rCzk43epa/CXGfLmPtDghCJIxV
        gte+V8Xf1igWkOlTwIeGFEdi26oOOB72nT1VBRidryscixqv2jh8go6cu5py/dd2kht0Kv/F3Ez0H
        p0oNK8Y53Q4MmqvbSLtA4vQG+eybqiLD9JlVZ0cg0TbsEfGOz7oboN/0yZQC+lJ+HwL0BtDt0pZiO
        hK77haAT5/Ooy9AkQCa2pS0CuvySk25vxEPDMD8JxLTNNLPoj+z7YCWOWHluvI4AkK0AxtfQ+UMOX
        lEXd/Tl5Djy9WVrc9MdSidHBxYfww4sg9/7ydqb5g3n1/3P85uxXma7nnWQeWP9l6tTp7SS1jUTjC
        1uSHdtsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIhhn-00EF1g-OJ; Mon, 10 Jul 2023 03:36:55 +0000
Date:   Mon, 10 Jul 2023 04:36:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 1/8] iov_iter: Handle compound highmem pages in
 copy_page_from_iter_atomic()
Message-ID: <ZKt81ybmVYn7h31S@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-2-willy@infradead.org>
 <ZIf2JGDz0LUQtvUR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIf2JGDz0LUQtvUR@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:52:52PM -0700, Christoph Hellwig wrote:
> Looks good:
> 

I'm assuming this was intended to have
Reviewed-by: Christoph Hellwig <hch@lst.de>

after it, so I'm taking the liverty of adding that.
