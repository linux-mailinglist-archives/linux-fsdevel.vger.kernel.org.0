Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66C650339B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiDPFou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Apr 2022 01:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiDPFot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:44:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2DAC916;
        Fri, 15 Apr 2022 22:42:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4256768AFE; Sat, 16 Apr 2022 07:42:15 +0200 (CEST)
Date:   Sat, 16 Apr 2022 07:42:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] fs-writeback: Flush plug before next iteration in
 wb_writeback()
Message-ID: <20220416054214.GA7386@lst.de>
References: <20220415013735.1610091-1-chengzhihao1@huawei.com> <20220415063920.GB24262@lst.de> <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I think the root cause is fsync gets buffer head's lock without locking 
> corresponding page, fixing 'progess' and flushing plug are both 
> workarounds.

So let's fix that.
