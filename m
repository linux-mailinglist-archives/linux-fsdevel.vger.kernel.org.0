Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19D76C6A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjHBHVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjHBHVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6130FA;
        Wed,  2 Aug 2023 00:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5631761840;
        Wed,  2 Aug 2023 07:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38CCC433C8;
        Wed,  2 Aug 2023 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690960892;
        bh=Nuc/mkQcFbT+qq6WbVCMS0uOPBaToluNS15lNjlmtbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fX2LDoLkGRTnhIml6tUkMP4MKxondefkuQce3CRrVmCjXjBpHPvfwVJaFXw4O3RKw
         tEGzcuiLmjhICH28WXwB82J1AIuBWcYUM0g9NYbViWbMw2hIEPguMGiGn5yumbczjg
         pfl9DosQicI2RZFaBwvVuBt8BTRqR20b6fNbd8CCIzd8Jnhvm7TXzWbWPhxMTwlxeR
         VV1+5DB7fkhn73pBaXovdpQruDf/WmodPI2WqgEOal+VdDUZA+qAsuE3xx0254MFJN
         djiuc41Cg72bn/yNxQbF/R5Fb/+3lqCf68GRJKF5bFkyAqRToLnhqWcB/KvhGooXNm
         KevpzFzbEvLFw==
Date:   Wed, 2 Aug 2023 09:21:26 +0200
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
Subject: Re: [PATCH 1/6] fs: remove emergency_thaw_bdev
Message-ID: <20230802-rekultivieren-ansatz-fcda568f591a@brauner>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801172201.1923299-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:21:56PM +0200, Christoph Hellwig wrote:
> Fold emergency_thaw_bdev into it's only caller, to prepare for buffer.c
> to be built only when buffer_head support is enabled.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
