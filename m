Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF067B673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjAYP6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYP6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:58:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9A4AA5D;
        Wed, 25 Jan 2023 07:58:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308D960EA4;
        Wed, 25 Jan 2023 15:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CBDC433D2;
        Wed, 25 Jan 2023 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674662314;
        bh=aUkUHwB0Xq0oSmDtb8Ps0uypEki5oRPSjQ+9ZXsbQpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bd/qPBy7SrLfQAuZ9JSfkCuSJNpOuQb2TjGJ+gIWalTOgOFE3uYUzPD/8iFs+30ue
         tXsOJueXU6KgxSRsN29umipxzyFhudNla3UMJeYGzwHbsozsSONQsM8bjN84uHny8r
         IhS3nSt8ST8dR56KmBhyUM8/BdcZxA1Pi08NEfOeOdom3hGZqkmM7Fo9FYdWQT3I0O
         kNXVa6/2CvVk12LePVQIjq1DKkwtGkP68WuJzfo9SCGvyzld6nDLZPL8keFOfYWFEe
         kIulbruoWh1IKa5NicW8ACkm6qixyuSeNpW7RBxkrRzyJx0euXhw98VtLUN/AH48/2
         l5wig70p4uoMQ==
Date:   Wed, 25 Jan 2023 08:58:31 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/7] mm: remove the swap_readpage return value
Message-ID: <Y9FRpwaiee2GaOm+@kbusch-mbp.dhcp.thefacebook.com>
References: <20230125133436.447864-1-hch@lst.de>
 <20230125133436.447864-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125133436.447864-3-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:34:31PM +0100, Christoph Hellwig wrote:
> -static inline int swap_readpage(struct page *page, bool do_poll,
> -				struct swap_iocb **plug)
> +static inline void swap_readpage(struct page *page, bool do_poll,
> +		struct swap_iocb **plug)
>  {
>  	return 0;
>  }

Need to remove the 'return 0'.
