Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18481615199
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 19:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKASdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 14:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKASdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:33:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FE1BCB3;
        Tue,  1 Nov 2022 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+xgFDuRmYfCUWspcRNTSklWdAxZNiQmusmQwsl6fwS4=; b=PaPr4hZPjnleqVXjmrcjpfeyqe
        i6tJkIG3omVgglUVxLyOBv1lZmkeDqlINQ+BJdAVbIZGeWnbkdZraG6zH0/IevdXbxuQwpYAMP/rt
        TWvgTEYYGp9vnUMybzpSmhAOyE0NvHibPHmMqzKktE1lBL7EqweXgwBkxrHEO829CFKIQewcTYzcC
        EHzPIcleycJbu/QeEdMFX1TkrpR07Wm6PPXkAH7dZQ1EWNxZwXPfcOBT+GwhYd18vunmiu3x+qby7
        mHmGeAmJuVzTQzX6zch1nSTGoSzJ7nrtAq/2u/O+KN+UWS7u+1FPbhD72Z6uiJvAfx5sfxH1pFU6I
        NN9allFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opw4x-004q1e-ML; Tue, 01 Nov 2022 18:33:39 +0000
Date:   Tue, 1 Nov 2022 18:33:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        miklos@szeredi.hu
Subject: Re: [PATCH 5/5] folio-compat: Remove lru_cache_add()
Message-ID: <Y2Fmg6d5jyEK8r0q@casper.infradead.org>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-6-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101175326.13265-6-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:26AM -0700, Vishal Moola (Oracle) wrote:
> There are no longer any callers of lru_cache_add(), so remove it. This
> saves 107 bytes of kernel text. Also cleanup some comments such that
> they reference the new folio_add_lru() instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
