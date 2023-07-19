Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748E7591A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGSJaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGSJaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:30:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43681BFC;
        Wed, 19 Jul 2023 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7CficctBvH0/f/2WnPWvQCjSoDFtYP+3xEUu6sJSHYU=; b=AwEHjXzgMNux6iIaljsrFXLYj0
        CyuYr3l+n07xWFw7eEzaELQ2hwsHlUN1pdAApoNylg5AxMIA0xPWctyN+gqMMen348MGvM083EcyI
        rjQPk6Ae+qe5s2UighPxHub7n/OOopo8UO5+OMsTG6QOP9JWergddJvNZSHEHAZn6K4y7qXOVNbGd
        ++MoXGpDmYWZp0ky2JPke07ZWlo5rI6Rs+3mb58qVd/iP8k3uSX01ISjnFDn3y3ot6oNhNX8fwa1E
        KNmLhqHETpG5SCQHBwTg1cbsfEPiv7HBxi6M9w2NHOShu29hsbwH9kR4aYlCe/DkNUR+6YNc83Hfu
        wS6xoKcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qM3Uj-005uqN-NS; Wed, 19 Jul 2023 09:29:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32C053008AC;
        Wed, 19 Jul 2023 11:29:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E5DE2137288F; Wed, 19 Jul 2023 11:29:15 +0200 (CEST)
Date:   Wed, 19 Jul 2023 11:29:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 4/4] perf/core: use vma_is_initial_stack() and
 vma_is_initial_heap()
Message-ID: <20230719092915.GA3529602@hirez.programming.kicks-ass.net>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719075127.47736-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:51:14PM +0800, Kefeng Wang wrote:
> Use the helpers to simplify code, also kill unneeded goto cpy_name.

Grrr.. why am I only getting 4/4 ?

I'm going to write a bot that auto NAKs all partial series :/
