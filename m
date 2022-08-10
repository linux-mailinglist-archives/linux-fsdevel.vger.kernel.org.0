Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C758F3D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiHJVc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 17:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHJVc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:32:26 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26603193EE;
        Wed, 10 Aug 2022 14:32:25 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x1-20020a056830278100b00636774b0e54so11479345otu.4;
        Wed, 10 Aug 2022 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m7O12mtRE9TkWg6wBbyGMp67dOvzpuyVtE/CzOg3fqw=;
        b=Jk54ci7PSY7tdCzqgeSF9+5dbF3gz0NvJ7ApJm97a2vB99DU4S2dySkCHFIX7h1lUv
         qtLscUGfFOR5J85EiDuL8AEmG3pHGuyaUbZ1TSjBDYFyvYTRzaVnaQefNwzKOeyBlVKv
         y/9OHgIdjhAqIo0YEwSfA/QGcY3kEvwWoNaEwc8ZkNoTw9WE+tjnxEC69AgU1jWZw2iP
         m7VjmGqF3ePAgocQVKL8QJFVVqfCS8AUwzIOuyqtAlSJZXaY6NEx45JsOVac7hZMXMg/
         1LUjz7D1rXJwdYh+rjh/Vgfn31+6bGrISFPiWvNVSCyzZYx0ZWDkQplfDvFe7vkr1Sqg
         evfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m7O12mtRE9TkWg6wBbyGMp67dOvzpuyVtE/CzOg3fqw=;
        b=VE4gYHflJADlDgD9Fr5ew1Y75GfMgtnVXWUhWhnVmcK1J6UEiOHqOlr/yC3BE0jK6d
         0Wuaw016uif55xmpqbSMeQpW/3dY/HgQpXrVcl/RHxMEybAE+IeEY0CeGVR85OJMaX/h
         2R0mkrB8kjLPsFtjkHy3HH0C76wBFEwEu+FSqGtL1R8GT1MLv3qC4CvS8sTpkYzwn0lj
         Yuj8c9xjbwmpfYjWR8rGp5tUtZndJ33AvENvLRYYXy3hFonMEuBXYXrZOCc9tE81uSon
         zTtyhZswHUelIibsh/mn3YCDZYxuzu5LkPiXYCTaEoYrfE9YesvkJIT7tZzLy8M7nMEP
         QWnA==
X-Gm-Message-State: ACgBeo3gycDaVjvlT9X1nSBfP1SPqFV6WGfIMh3BRhKePUGc3ue+hdE1
        2xhZwmaMwtFL9kSyrF8dxpzkgd4QUf0Q5EUBPl4=
X-Google-Smtp-Source: AA6agR5WI4LfxUaJ5EfyY3qi3PgJRxGO7G3AYltcG2S84baL4CCgM+/v/VC+ix3GmYp1IOK0IPYYQDO5aJHqzAN+vDM=
X-Received: by 2002:a05:6830:6388:b0:61c:80a9:d5b6 with SMTP id
 ch8-20020a056830638800b0061c80a9d5b6mr11139969otb.124.1660167144427; Wed, 10
 Aug 2022 14:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220719041311.709250-1-hch@lst.de> <20220728111016.uwbaywprzkzne7ib@quack3>
 <20220729092216.GE3493@suse.de> <20220729141145.GA31605@lst.de>
 <Yufx5jpyJ+zcSJ4e@cmpxchg.org> <YvQYjpDHH5KckCrw@casper.infradead.org>
In-Reply-To: <YvQYjpDHH5KckCrw@casper.infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 10 Aug 2022 23:32:06 +0200
Message-ID: <CAHpGcMLNKrOFxktaH9Wxq0M9O-m+DPrdbB7FQt7qwkzQdm-a-w@mail.gmail.com>
Subject: Re: remove iomap_writepage v2
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 10. Aug. 2022 um 22:57 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> On Mon, Aug 01, 2022 at 11:31:50AM -0400, Johannes Weiner wrote:
> > XFS hasn't had a ->writepage call for a while. After LSF I internally
> > tested dropping btrfs' callback, and the results looked good: no OOM
> > kills with dirty/writeback pages remaining, performance parity. Then I
> > went on vacation and Christoph beat me to the patch :)
>
> To avoid duplicating work with you or Christoph ... it seems like the
> plan is to kill ->writepage entirely soon, so there's no point in me
> doing a sweep of all the filesystems to convert ->writepage to
> ->write_folio, correct?
>
> I assume the plan for filesystems which have a writepage but don't have
> a ->writepages (9p, adfs, affs, bfs, ecryptfs, gfs2, hostfs, jfs, minix,
> nilfs2, ntfs, ocfs2, reiserfs, sysv, ubifs, udf, ufs, vboxsf) is to give
> them a writepages, modelled on iomap_writepages().  Seems that adding
> a block_writepages() might be a useful thing for me to do?

Hmm, gfs2 does have gfs2_writepages() and gfs2_jdata_writepages()
functions, so it should probably be fine.

Thanks,
Andreas
