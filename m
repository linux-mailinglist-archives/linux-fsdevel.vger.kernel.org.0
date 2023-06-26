Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253973DEF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjFZMXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFZMXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:23:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEA835A5;
        Mon, 26 Jun 2023 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsSJMAZtVZXkWomlSrdllY9FMvN+dViDBTPbQidYo/8=; b=aWgYj0EptSZlfXLuEr483t+nU+
        q8UEuBBhZLAzD0uNIL1JvRlmKknboUmTrQZo88tKIbVAtmLlOIVej5LP5OhvOY9LMzyJu53XAxFp+
        UOlravYeXRzFTBtKsApaa7IASSoeS0c1MLmx2PcK211ACZRQZwCKruz7n+knj1LwRYzGMqyI/4kQB
        K/JGjwnUki/32tsMPJh2LrnxjrGnA0IigXWv9l1s50SB15bTh0jzi44yxTP20c1Kb0P/poghgI39l
        IqXo7IQ76qkGkF/3w6uVzL3jADP8FwgeGHiaBU5gkJZ057UYX4KEd7HEmTRny1ITai+3m2LjsM6Xn
        6eQcyuUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDlDV-001heE-V9; Mon, 26 Jun 2023 12:21:13 +0000
Date:   Mon, 26 Jun 2023 13:21:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [RESEND PATCH v3 1/2] fs/buffer: clean up block_commit_write
Message-ID: <ZJmCuQFaaPHpgFuN@casper.infradead.org>
References: <20230626055518.842392-1-beanhuo@iokpp.de>
 <20230626055518.842392-2-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626055518.842392-2-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:55:17AM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Originally inode is used to get blksize, after commit 45bce8f3e343
> ("fs/buffer.c: make block-size be per-page and protected by the page lock"),
> __block_commit_write no longer uses this parameter inode.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'm expecting that Andrew will pick up these patches.  Unfortunately,
you've sent them right at the beginning of the merge window, so I
wouldn't expect that they'll be picked up for two weeks.
