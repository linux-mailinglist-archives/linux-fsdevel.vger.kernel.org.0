Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7B504C15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 07:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiDRFC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 01:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRFCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:02:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A086DED6;
        Sun, 17 Apr 2022 22:00:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E8D5068AA6; Mon, 18 Apr 2022 07:00:13 +0200 (CEST)
Date:   Mon, 18 Apr 2022 07:00:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] fs-writeback: Flush plug before next iteration in
 wb_writeback()
Message-ID: <20220418050013.GA3372@lst.de>
References: <20220415013735.1610091-1-chengzhihao1@huawei.com> <20220415063920.GB24262@lst.de> <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com> <20220416054214.GA7386@lst.de> <71acc295-3a5b-176d-a58e-2aa3ba7627d6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71acc295-3a5b-176d-a58e-2aa3ba7627d6@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 16, 2022 at 04:41:35PM +0800, Zhihao Cheng wrote:
> So, how about applying the safe and simple method(flush plug) for the time 
> being?

As said before - if you flush everytime here the plug is basically
useless and we could remove it.  But it was added for a reason.  So let's
at least improve the accounting for the skipped writeback as suggested in
your last mail.
