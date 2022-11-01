Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691461516B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKASUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKASUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:20:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CED310FDC;
        Tue,  1 Nov 2022 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LX6gsPltQfh9UOXXk+OKvdZUK2upicvje5NwAETssts=; b=AlRYqUgpSP0G5gTwzpcNZJsq3x
        6iAsALgRQOWEQitw99KcAo09xvhOWdxVEs3mQAxX09Pf19wuoyc8VNW45yPmstNTQys9Ve5/stfht
        CV0vHdN5WTAZ+BGB3xDPcnNykTVQwEEo7YtiL+MPaBUn8i+MtGI7RZJbO9Ju/LUmLjlxldKitV5Kt
        xsd9rY5XOKVrTcQN7/pgTJaovB74XmI6H+KI+1OurkRwT36VlzFjeuPQgvDp22FDVqw/MCvLZTGuM
        OyTwDi3tytsBo8VRHcrJdmG4M12xqRI4XffOy3VZIICjXERG/gRIhxwnr5xsZyc7U0gUADgL3hb8p
        icF4Coxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opvru-004pOr-4k; Tue, 01 Nov 2022 18:20:10 +0000
Date:   Tue, 1 Nov 2022 18:20:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        miklos@szeredi.hu
Subject: Re: [PATCH 1/5] filemap: Convert replace_page_cache_page() to
 replace_page_cache_folio()
Message-ID: <Y2FjWvDXEWQg8u+9@casper.infradead.org>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101175326.13265-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:22AM -0700, Vishal Moola (Oracle) wrote:
> Eliminates 7 calls to compound_head().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
