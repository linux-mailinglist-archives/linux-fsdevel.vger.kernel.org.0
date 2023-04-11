Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAB6DDADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDKMal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDKMaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:30:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB52D6B;
        Tue, 11 Apr 2023 05:30:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 555C468BFE; Tue, 11 Apr 2023 14:30:03 +0200 (CEST)
Date:   Tue, 11 Apr 2023 14:30:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hubcap@omnibond.com, brauner@kernel.org, martin@omnibond.com,
        willy@infradead.org, hch@lst.de, minchan@kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk,
        akpm@linux-foundation.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        mcgrof@kernel.org
Subject: Re: [PATCH v3 2/3] mpage: split submit_bio and bio end_io handler
 for reads and writes
Message-ID: <20230411123002.GA13879@lst.de>
References: <20230411122920.30134-1-p.raghav@samsung.com> <CGME20230411122923eucas1p1dfc182a2c785eeb362b9d670dfe3ba2f@eucas1p1.samsung.com> <20230411122920.30134-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411122920.30134-3-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
