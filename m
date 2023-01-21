Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD738676660
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAUNFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjAUNFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:05:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC4457E2;
        Sat, 21 Jan 2023 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZ87iyK2fCKE6lUSEoIxgZ62brcKGXwnNfVm3IcTvPE=; b=mH/kcykm8xfGpdwTLf5BFtcIXH
        VZ5SwMou2cdq0/HRHws+AjAFLpbt52f9V+tFgK7AiFSjmDpesmq2jCOOx0PeYFMEgdoQbEj5gGsVh
        7h7hWGBkxfXNPiSrzKZhH1FoL1EXSrTn2CoA2tMxKHOTuiDSzB/HpGrFrfkLvF5DCCS4S+PVDTglC
        YKlf0PD1DsLJ70vI/RWw54rLdFXiPWeeM6Xhyv3qQXerkD13PgExXQ5MnFe4nqAC0QQOsuoib5Bm9
        cSYFy6lvOdGXkKl4iyBJsSRpbaBCmCNl8IE+bakeJOmqFmO7N/NtNacQubaZvOZV3nW/kHDRk3PlB
        x1Z9YKFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJDYi-00Dsgc-OV; Sat, 21 Jan 2023 13:05:24 +0000
Date:   Sat, 21 Jan 2023 05:05:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 5/8] block: Add BIO_PAGE_PINNED
Message-ID: <Y8vjFB3VhFYM3m+R@infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120175556.3556978-6-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:53PM +0000, David Howells wrote:
> BIO_PAGE_PINNED to indicate that the pages in a bio were pinned (FOLL_PIN)
> and that the pin will need removing.

Just adding the flag without the infrastructure and users is a bit
silly.  See the link to my branch to see what I think is better split.
