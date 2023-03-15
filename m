Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993E26BB672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 15:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjCOOsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjCOOsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:48:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED9EFB8;
        Wed, 15 Mar 2023 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wONizAybFB/ytYvJxzw0zJzdZ/HbW8CWou16x2NZy6c=; b=4tU7B9IDG0aLalJhNuI8Fof5/Y
        JoHitGTyq2ky4jt0X53J69/7Yw44/lbRLdQN+Gbhco1KqjL0NFjEgWHmyqODStFs5lWHEdEYcbSru
        v0FS7yLvf7vHVROll2J0zCr/mQ2b83MLDo6kf0RvJeBajvFm3nQbOYl0K4H9qF6a1ZtxHLg/vvHZu
        /QmYp1qUSaKgcguCO2tLVz8SVzAzv3YCbcF49gXraoaoYBhAsiYjnbvoREJaGEjgkivxpccLxuZIx
        KETeMXbe2hzQs2hXnkG5Qi8yZSWq/xDWE07uyORy8MyvbVDOHp00xnYGhX2Qu2wTiM/XN2JonZ8D+
        +YsBshxQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSPz-00DeXm-1W;
        Wed, 15 Mar 2023 14:47:55 +0000
Date:   Wed, 15 Mar 2023 07:47:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hubcap@omnibond.com, senozhatsky@chromium.org, martin@omnibond.com,
        willy@infradead.org, minchan@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, devel@lists.orangefs.org
Subject: Re: [RFC PATCH 2/3] mpage: use bio_for_each_folio_all in
 mpage_end_io()
Message-ID: <ZBHam7aiY6oVLT8r@bombadil.infradead.org>
References: <20230315123233.121593-1-p.raghav@samsung.com>
 <CGME20230315123235eucas1p1bd62cb2aab435727880769f2e57624fd@eucas1p1.samsung.com>
 <20230315123233.121593-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315123233.121593-3-p.raghav@samsung.com>
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

On Wed, Mar 15, 2023 at 01:32:32PM +0100, Pankaj Raghav wrote:
> Use bio_for_each_folio_all to iterate through folios in a bio so that
> the folios can be directly passed to the folio_endio() function.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
