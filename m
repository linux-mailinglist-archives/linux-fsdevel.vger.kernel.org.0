Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB955C116
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiF1MkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiF1MkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493272F3A2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2F16157E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B72C341CA;
        Tue, 28 Jun 2022 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656420016;
        bh=Pd2aRTsUbiCRDgEa8nKGjVW9R2TJ097Jl7dZ9FMt3LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qmjwv+Pryq1NyXhC8zdgKN+GqW6P2B4mij198HxdrAl2gEMs5+tLyCYiegamYf0GL
         kmXF4+tL3Q8pepZTeDaZ45JOrZLmzK9+QMHi1WOQhgC/lnvRlBDXY5C0nk38K7YMU2
         bMGA7pvNLoW1weXUrSqUhnqPqLeeQpLrUGlp55MKfgc70h0qg//OQhJD20IQZMKqj6
         xIyX81YVVvzH1BHIOY0mARQAHWs4//bLbkxH4ssns7O02FhZ2VSBKR+XO2oqlFI0On
         zIugNzWMM+Yowhzm2m9H3HGm2Jkv7c0zE9Ho7P7vuJgc4ItBPkODd1z9ddfbeew8p3
         Hsm1WulkZiJog==
Date:   Tue, 28 Jun 2022 14:40:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 11/44] iov_iter_bvec_advance(): don't bother with
 bvec_iter
Message-ID: <20220628124011.svyofgveogsmca4f@wittgenstein>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-11-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-11-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:15:19AM +0100, Al Viro wrote:
> do what we do for iovec/kvec; that ends up generating better code,
> AFAICS.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
