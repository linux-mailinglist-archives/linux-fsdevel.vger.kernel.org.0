Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401D276C6AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjHBHXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjHBHWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC211BCC;
        Wed,  2 Aug 2023 00:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F56261826;
        Wed,  2 Aug 2023 07:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AF3C433C8;
        Wed,  2 Aug 2023 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690960964;
        bh=+HtAI5H/Tw7Tii5t667xHJhC8OSgK9bBrERPcfSYVVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YH+JzhNhs9sfDeNTzcs+lz2izUPNPiAeAJR5/+EFKF31dJ4SDoXaqqzIM1ZCGQcxX
         bGrIOIxvTfYuQs0MBde8gp/6aKjRXW2Lpau48F//zjr6XlUB6I6DX8H1jch5Cp0nsA
         Q0o8jf5cO/nSCqS0qu84ZcdKuXcPqXqml3tQerqXgxt3Fq/OI3ckCnWsrxTBPx7slR
         lL0c6qXXgZcM3QI/emUMWq7jy0UEM20w4p+fRZnVajrAAGDSCWbo+ep0ixrinsaQ3u
         VhhhH/1dD1+ml5jGkGJVzxie0WgtrGq3GoTH7c0uPa2QKLZGPviFqbaupJdefzrerG
         tvn/CzjDKyF/w==
Date:   Wed, 2 Aug 2023 09:22:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/6] fs: rename and move block_page_mkwrite_return
Message-ID: <20230802-sirenen-arkaden-e76a392f1842@brauner>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801172201.1923299-3-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:21:57PM +0200, Christoph Hellwig wrote:
> block_page_mkwrite_return is neither block nor mkwrite specific, and
> should not be under CONFIG_BLOCK.  Move it to mm.h and rename it to
> vmf_fs_error.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
