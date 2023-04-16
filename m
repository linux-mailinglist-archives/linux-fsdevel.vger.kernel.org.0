Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DE6E354C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 07:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDPF7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPF7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:59:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B42681;
        Sat, 15 Apr 2023 22:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EPI47pBNi9+7DDv7GlwBi+14OMa6+rQMZpCzcXcuMEY=; b=WY+jQeUbVx9nbMkXAEyUA1hCge
        +o6WlG+lm224ZbfRovTuYtF8KWVSD55N9WRXp0M/9tCjbuEPQw5uG6otRc5YfUIjgaIQ57E4Ur7Ii
        r8HgrykqqzfMe4aYAN2Ac83fx7huS2m3n7pHySK/M8np6ASd0M4zqyzmKbc+SAOsyLrloFrggMj5s
        ToR33i47o4CWkotmQM1mvT1aeGhF3j9mM8VqyRwvn5VGeK3IvVgIyr20m15O/ZaIBNfOM3bq3VOfG
        LITTbSGAKV9e4IvWPCZ9IQhOflgsslsUgUBCO+mqO6BdCwAGI+BzA+7Yzqkwvf+Dz0SxK+vr57nBQ
        NldT7fkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvPy-00DCE6-0B;
        Sun, 16 Apr 2023 05:59:18 +0000
Date:   Sat, 15 Apr 2023 22:59:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv4 9/9] iomap: Add couple of DIO tracepoints
Message-ID: <ZDuOtt6w+ZOcVv9w@infradead.org>
References: <cover.1681544352.git.ritesh.list@gmail.com>
 <793d0cc2d49ef472038fca2cbe638e18be40cb0c.1681544352.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793d0cc2d49ef472038fca2cbe638e18be40cb0c.1681544352.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 01:14:30PM +0530, Ritesh Harjani (IBM) wrote:
> Add iomap_dio_rw_queued and iomap_dio_complete tracepoint.
> iomap_dio_rw_queued is mostly only to know that the request was queued
> and -EIOCBQUEUED was returned. It is mostly iomap_dio_complete which has
> all the details.

Everything that is here looks good to me.  But it seems like we lost
the _begin tracepoint?
