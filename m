Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF257A2A6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 00:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbjIOW06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 18:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbjIOW0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:26:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1E83;
        Fri, 15 Sep 2023 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3m9qKU8v8W/6eLBMQw+/ErP3QLnjCxMnFx4HwWmgbtM=; b=P1zEiqNoOJDZW4Zn8iLOdpq/EX
        EwViN7q7yUXxx+FvL7jzIuz5QzhuVHuC65u2qptCQ4MNdOaeZv6FH249hBipfGjOo15yCzdzVky7X
        xlzza5bm3hDb0xp469qmVxQvkn3z8cAHiElgbVPTa/LyejMKKlu19ZwFoNJpdoIdXwJnCQsOVlQw+
        WJNTJ2ymWbE1+IMecYh6gFMyXFeYrKDdzLlDQHjyo/soJX2vzE8oCtlYp+43W8CY48/fgagyJboDn
        bYfnXaPtVwD8XaYEAVQ6vDYx5M3OF5kXy2WbXGDpW7hBKtDK55lAmOxiBvOlG0goFBflvXhQcNEns
        z+MMY9cw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhHGg-00BUBR-18;
        Fri, 15 Sep 2023 22:26:30 +0000
Date:   Fri, 15 Sep 2023 15:26:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        brauner@kernel.org, hare@suse.de, ritesh.list@gmail.com,
        rgoldwyn@suse.com, jack@suse.cz, ziy@nvidia.com,
        ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Message-ID: <ZQTaFqL3f5i3sVR6@bombadil.infradead.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQTR0NorkxJlcNBW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQTR0NorkxJlcNBW@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:51:12PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
> > However, an issue is that disabling CONFIG_BUFFER_HEAD in practice is not viable
> > for many Linux distributions since it also means disabling support for most
> > filesystems other than btrfs and XFS. So we either support larger order folios
> > on buffer-heads, or we draw up a solution to enable co-existence. Since at LSFMM
> > 2023 it was decided we would not support larger order folios on buffer-heads,
> 
> Um, I didn't agree to that.  If block size is equal to folio size, there
> are no problems supporting one buffer head per folio.  In fact, we could
> probably go up to 8 buffer heads per folio without any trouble (but I'm
> not signing up to do that work).

Patches welcomed for buffer-head larger order folio support :)

But in the meantime...

  Luis
