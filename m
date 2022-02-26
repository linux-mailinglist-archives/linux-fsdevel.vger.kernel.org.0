Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEBE4C583A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiBZVBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 16:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiBZVBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:01:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB61DED4B;
        Sat, 26 Feb 2022 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=msxU2UfcVFrwCj3eU5XFZoVOe7HH+NdjfV+cwoL/Fik=; b=yfQKckeHAJUkzcec9GpbN5u7v5
        tt7t+WkvONdXeNDMT9gecLftrxF7SgByNdnwaiPKnHsbsvgxjdYak+WeNFloAOLrGcpUe8nuaz/Ur
        eo3Kc2A3i15qlSLEByZ6uW5+OWy0H2QqMgWJNLJ6D5glFLloHSGkYDrW2aVBDXKZC9CSYpNmqIyjB
        JrKzp6SQtMgaDnGLjrD6AMIRjbWqxTpOIyNeMsvLMviz+OI9FF7FgfO/PWimm1Ezng3aWoUBxsmtG
        rRABOwL3FQU/4IS8uQ24Lbj8rpoL6y4m9BrG9jwGRmqgs5JdBRQSDAa6IjGfGKR4K3tZL4vNov1Sx
        XQPBj4gw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO4BR-008Xjj-IV; Sat, 26 Feb 2022 21:00:53 +0000
Date:   Sat, 26 Feb 2022 13:00:53 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com, sujiaxun@uniontech.com
Subject: Re: [PATCH 10/11] fs/drop_caches: move drop_caches sysctls to its
 own file
Message-ID: <YhqVBcHRdctU65S/@bombadil.infradead.org>
References: <20220220060626.15885-1-tangmeng@uniontech.com>
 <YhIokWPShGOYh9LK@casper.infradead.org>
 <cbc60b32-d69c-d848-ca4c-650016da65d3@uniontech.com>
 <YhWCOBqKc8xIylmT@bombadil.infradead.org>
 <8940d534-d6e5-0642-f145-67a323eb8092@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8940d534-d6e5-0642-f145-67a323eb8092@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 05:51:33PM +0800, tangmeng wrote:
> On 2022/2/23 08:39, Luis Chamberlain wrote:
> > 
> > Since you are following up on more changes, can you work on this?
> > Brownie points if you show size results to refelct no size difference
> > based on a new build with an example new user.
> > 
> 
> I'm going work on this, but I think it may take some times to get it done.

Thanks and good stuff! Can you please then make that the focus of your
first set of patches, and then respin this series by collecting all
ACKs, Reviwed-bys? Yes please send a new v3 series for it. While at it
please Cc the other folks doing sysctls changes so they are aware of
this.

Thanks!

  Luis
