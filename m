Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460164D4ED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiCJQUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbiCJQUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:20:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E170190B7A;
        Thu, 10 Mar 2022 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rK+8Sm7AEx/XwTnwqxVVc4RKTofQynom/qH1kIz4tgY=; b=1b+5SWyzHKApOh+3r4QwSJJRXa
        70eP1vH0och8Pdpa//QhAien+9xt0eXqcYpQPhPjg+Dw2HDge6qZdXgSbLcqpxPLc1qrvrmK/xEi/
        n8PLDjixXbaBl2K/R2MGhA0VhHKd/+2MAgSTEZEYzbC5d8X8VymZs0CyHIFhHi8vNEm1ssBs0klqs
        B2++zM8SlJI7uxuwn56kFOkzaybYWB9MnSZ4WPMk5lm+SP2fZTIpwRwwRCbSG3xJUhZmGS7UvLIqy
        3B2kAqb447wJ8sbmz1z2vl40AYlRvFpeFDVLBRN8j4fp+xSI8hEmuE5EtetjdqopsredUXcChCR5s
        qMD213+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSLUl-00DU5D-5r; Thu, 10 Mar 2022 16:18:31 +0000
Date:   Thu, 10 Mar 2022 08:18:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christoph Hellwig <hch@infradead.org>, cgel.zte@gmail.com,
        axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
Message-ID: <Yiok1xi0Hqmh1fbi@infradead.org>
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
 <Yij9eygSYy5MSIA0@cmpxchg.org>
 <Yime3HdbEqFgRVtO@infradead.org>
 <YiokaQLWeulWpiCx@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiokaQLWeulWpiCx@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:16:41AM -0500, Johannes Weiner wrote:
> The first version did that, but it was sprawling and not well-received:
> 
> https://lkml.org/lkml/2019/7/22/1261

Well, Dave's comments are spot on.  Except that we replaced it with
something even more horrible and not something sensible as he suggested.
