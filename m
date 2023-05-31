Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1DB717666
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 07:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEaFyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 01:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjEaFyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 01:54:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4AEE;
        Tue, 30 May 2023 22:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Lc8TaQJiVN2Um7bZC3OIaEg3I1h3vBeK9kWP0rIuic=; b=s90tz64qhHPhXufd2KQd2/FVWU
        i8bx/ckYepGxC5ZZrykZr1TjdyV/S5kMxaaupegN0pBsRGXkB8UfrM2XjKdW4zYWSzpCuGNLE+6Xj
        6QlQ6NYfSUqX8MBkB90xhgCjuCVOHeTC8RHAUm4Xc7p3KasDsoa9O2ga5rLJ1uUFCpb922Zj8ciJp
        cv0C32gSjK29+YkSLEHm4kGgGp73WCXHEQPV6nVI/LqzfJECvJ+4CzMTbAI+IS7YS4lwL9UtqzI9w
        AK2yxwHm7YOWE9dvfEq9Z/khmyW+fyrxvpr6P0mg8z7HRhYfhd1uL9vLpkDvaQlm5l1bBf0bbr80o
        8OP9CrSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Emu-00GDzj-1K;
        Wed, 31 May 2023 05:54:24 +0000
Date:   Tue, 30 May 2023 22:54:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Loic Poulain <loic.poulain@linaro.org>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] init: Add support for rootwait timeout parameter
Message-ID: <ZHbhEMxW2XjvAAju@infradead.org>
References: <20230526130716.2932507-1-loic.poulain@linaro.org>
 <ZHYOucvIYTBwnzOb@infradead.org>
 <20230530-angepackt-zahnpasta-3e24954150fc@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530-angepackt-zahnpasta-3e24954150fc@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 05:43:53PM +0200, Christian Brauner wrote:
> On Tue, May 30, 2023 at 07:56:57AM -0700, Christoph Hellwig wrote:
> > This clashes a bit with my big rework in this area in the
> > "fix the name_to_dev_t mess" series. I need to resend that series
> > anyway, should I just include a rebased version of this patch?
> 
> Sure, if this makes things easier for you then definitely.

I have missed you had more comments that need a respin.  So maybe
Loic can just do the rebase and send it out with a note for the
baseline?  I plan to resend my series later today.
