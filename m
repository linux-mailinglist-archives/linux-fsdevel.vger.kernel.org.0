Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6F633CC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiKVMql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiKVMqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:46:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F435914A;
        Tue, 22 Nov 2022 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vv6m9biE4Z2OXrFYdjKygGiyDF
        HmEGbtxyodsXFLla2N9vRI5uc1Uc/WwCqA7uLl4zpxWxNFhKZbS+kjbz4xGeVbJK1ryDjSfzzQUHM
        Kyg9tAZvsKvsU9aD0o5nz416qw7GfxOrgtUt3CJJEZChwo7eVgsNqMyFiLvJteqYDT3B+xt6djfff
        JSdw5g5rD87hF8UY130eXlJF2bilwzqHH3Dw5u9EmUJVr0IaV7w5cYtiEgvVrUq3mbgokjQeM7h0f
        0oRS+kpts3rnHiwuas6U0/s8ODEWWO0J3OztuYeOhvUsd0P3F6OjNy9geJ/TT+l3LCsR1jFhVuc66
        9I93fOQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxSfU-009Nkf-C1; Tue, 22 Nov 2022 12:46:28 +0000
Date:   Tue, 22 Nov 2022 04:46:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] mm: Move FOLL_* defs to mm_types.h
Message-ID: <Y3zEpABh/+jui71a@infradead.org>
References: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
 <166869688542.3723671.10243929000823258622.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166869688542.3723671.10243929000823258622.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
