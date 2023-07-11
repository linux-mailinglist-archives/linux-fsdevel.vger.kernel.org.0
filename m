Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1274E758
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGKGbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 02:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKGbR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:31:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701A106;
        Mon, 10 Jul 2023 23:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lnokq8DdyPRMmu46JCX5/4McvQ4esjcepLUiQ7Bewn8=; b=lnFgX6wFlTLNfqS5/V8BtwhTjK
        /T4/kD6QlDfQPM8JWz6tHPKXJDmWeWY6kuy5daQVWpFMZPL9jughTKA20Bj60Kqu52PxwuCwZSjHm
        B+GQpjLdArNn9qvQ0GjE4a/Mq+IzJBktBiU/WxOhd0i7QKFMsFyiXqYM8+jT3tzTOZyzfS2Ud7lkM
        UqiJOUTVtuR3YP6DPpH9/MPN9V0UKQIm2VczuYcE2fK4SsiR/uK8XjrErVc+jGVGpBoj/bEdgxDBd
        uO/nv+3fuLH87JavbTD7TPWj0ruY3QsqtzbyShMNa9XW2VxjUYiCmrwVDQOM73RzbRtIYLue+SQ/a
        dBHC549w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ6u4-00DstB-27;
        Tue, 11 Jul 2023 06:31:16 +0000
Date:   Mon, 10 Jul 2023 23:31:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 2/9] iov_iter: Add copy_folio_from_iter_atomic()
Message-ID: <ZKz3NP2/UNysc1+e@infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:46PM +0100, Matthew Wilcox (Oracle) wrote:
> Add a folio wrapper around copy_page_from_iter_atomic().

As mentioned in the previous patch it would probably be a lot more
obvious if the folio version was the based implementation and the
page variant the wrapper.  But I'm not going to delay the series for
it.
