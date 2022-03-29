Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3534EB5BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiC2WR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 18:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiC2WR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:17:28 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8220186FA6;
        Tue, 29 Mar 2022 15:15:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1E99910E52D8;
        Wed, 30 Mar 2022 09:15:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nZK7o-00BSP1-D2; Wed, 30 Mar 2022 09:15:40 +1100
Date:   Wed, 30 Mar 2022 09:15:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jlayton@kernel.org
Subject: Re: [PATCH v1 1/3] vfs: Add inode_sgid_strip() api
Message-ID: <20220329221540.GO1609613@dread.disaster.area>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220329104516.luheugjurxsx5fdq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329104516.luheugjurxsx5fdq@wittgenstein>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6243850e
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8 a=omOdbC7AAAAA:8
        a=BM52z6NN7yLWZOA6Q0AA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 12:45:16PM +0200, Christian Brauner wrote:
> On Mon, Mar 28, 2022 at 05:56:27PM +0800, Yang Xu wrote:
> > inode_sgid_strip() function is used to strip S_ISGID mode
> > when creat/open/mknod file.
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> 
> I would've personally gone for returning umode_t but this work for me
> too.

Agreed, that's a much nicer API for this function - it makes it
clear that it can modifying the mode that is passed in.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
