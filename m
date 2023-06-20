Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0780C736BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 14:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjFTMTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 08:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjFTMTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:19:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81917128;
        Tue, 20 Jun 2023 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=E5QUUBOujBKv+gztbLya39h7W7rLwvJjpjCrvA62fL4=; b=q8pPW/CMb3NPPRXd2htA4UuS5y
        ORv47SxAac/b008gU7UOTJSUHz6GNsDktaLvZdBjtYGyvQf1qCJHQ1D13KQRyhl3jXXCSnUzSJ9e7
        v/XlVE5EPNMthDD3tNm0b5WO7yFo6hIXfgREbx9redDW9VbbJvohyhFmg7D3DC41P1MjxbyAarlUg
        VcQONfFztZNqUSpyFbQFknU7kCE2bQkLqLVrPdcXgDFBoSpQ/8eH6BxX+7wZCS/HnRMxgmrLz/e26
        pCz16eRyByMQ/btJ6S/6A8A37hD/AVGA/XXhAQL0Z+L3JVXIDMNMiO2b28Pu3tGtTIk46r61tRg79
        9IfM+kZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBaK4-00D489-Np; Tue, 20 Jun 2023 12:19:00 +0000
Date:   Tue, 20 Jun 2023 13:19:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     Bean Huo <beanhuo@iokpp.de>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, akpm@linux-foundation.org, jack@suse.cz,
        jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v2 1/5] fs/buffer: clean up block_commit_write
Message-ID: <ZJGZNGyIhJEeYagR@casper.infradead.org>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
 <20230619211827.707054-2-beanhuo@iokpp.de>
 <ZJE6Nf6XmeHIlFJI@casper.infradead.org>
 <9513017b07522373d9e886478f889867b7cae54d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9513017b07522373d9e886478f889867b7cae54d.camel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:57:11PM +0200, Bean Huo wrote:
> On Tue, 2023-06-20 at 06:33 +0100, Matthew Wilcox wrote:
> > You're going to need to redo these patches, I'm afraid.  A series of
> > patches I wrote just went in that convert __block_commit_write (but
> > not block_commit_write) to take a folio instead of a page.
> 
> Do you know which git repo merged with your patches? 

They're in git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
It's usually easiest to just work against
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next

