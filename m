Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF47AFB71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjI0Gz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Gz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:55:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902ADD6;
        Tue, 26 Sep 2023 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fPgmb7Y2ktRqB28jO7zMDWDeQGZxV6eU5LfybKEOdDk=; b=Z3OsFh8G5U0QOFnEguEs3Z+DYO
        FSNh1n8QAfeKT528FvYPZAEgrVLfvKaPnG4rn4dgRg8k+CA9y7QL7fIVYSMtAnvHm7WLdYsq1xqaB
        AVjaL1HWZ5jiSB3CCC8F8bsJ3UojF7Sfq9xaU0l/VZ/5MVC433bVSM1L6vmQmbVUlmWwnCfTUjJ1Z
        Gj9UgQAgfqt+JY+ZGW5/n4kDo7iG0iJbJL7I+dIEIFZ3AHwtCF1EGPD2WPfHUdssprjJL+T43Sv6K
        qrOczwK2PuSbhOe/MEdzR0RQcSmiJGd2qpOjm8qg2d/jxulA+/fSJP8U3XVZcT/lpRsitY6MNQ7JJ
        ILRtP2WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlOSC-00CMrm-W5; Wed, 27 Sep 2023 06:55:25 +0000
Date:   Wed, 27 Sep 2023 07:55:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     chenguohua@jari.cn
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Clean up errors in xarray.h
Message-ID: <ZRPR3NZVA6a1rlFz@casper.infradead.org>
References: <4f35bcee.861.18ad5449079.Coremail.chenguohua@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f35bcee.861.18ad5449079.Coremail.chenguohua@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:12:35PM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: "foo * bar" should be "foo *bar"

Checkpatch is wrong.  It's just a stupid script.  Can't you use your
brain to look at the code you're changing and understand why it's laid
out like that?
