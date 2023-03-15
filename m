Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6398D6BB678
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCOOst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjCOOsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:48:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A043A864;
        Wed, 15 Mar 2023 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aBJv3bZWAIteuTnVQBV/ta0ETvGznGO6l4CqrZpNDtQ=; b=wv2tOx7mT41rtS1K+FKiINwZZG
        oZxclyg6wPDRYMINJZ+fqLpACIbcXlz6Yrh5wdd7zUZE516HFoaYqbe+zbaO3Dc2SNsM+9vJNOEn4
        +poboqnavl1bWq9jiXhMvtdEzxad6ux+vRyBQgZ/fVT2VT0Ef0Fp1MZmcWh0GEnCmK9rXp0UgZiCq
        9ukuppVE0fg433M9/Ejz7fz0a/el2iPcuNGtlRY3r/ep7uv7IoiT/mtyBnvWo4sD2We4BJK8LVwhI
        +kcmR5AAssD4JVThmpZgrcn/7/1o9UcEIpwTt1Q2A5Te9nBXAfY5lEqdUtFzfe1B49R6YiCUVrK2s
        2jIfO8Bw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSQe-00Degz-3D;
        Wed, 15 Mar 2023 14:48:37 +0000
Date:   Wed, 15 Mar 2023 07:48:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, devel@lists.orangefs.org
Subject: Re: [RFC PATCH 3/3] orangefs: use folio in orangefs_readahead()
Message-ID: <ZBHaxIDlap0R5CXx@bombadil.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123236eucas1p1116e1b8537191310bd03dd267b9f8eb8@eucas1p1.samsung.com>
 <20230315123233.121593-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315123233.121593-4-p.raghav@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:32:33PM +0100, Pankaj Raghav wrote:
> Use folio and its corresponding function in orangefs_readahead() so that
> folios can be directly passed to the folio_endio().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
