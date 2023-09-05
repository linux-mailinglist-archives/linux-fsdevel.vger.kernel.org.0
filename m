Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFEB7925E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjIEQAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354913AbjIEPx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:53:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84CE6;
        Tue,  5 Sep 2023 08:53:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27D2168BFE; Tue,  5 Sep 2023 17:53:19 +0200 (CEST)
Date:   Tue, 5 Sep 2023 17:53:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in
 iomap_to_bh
Message-ID: <20230905155318.GA28415@lst.de>
References: <20230905124120.325518-1-hch@lst.de> <20230905153953.GG28202@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905153953.GG28202@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:39:53AM -0700, Darrick J. Wong wrote:
> Looks like a good improvement.  Who should this go through, me (iomap)
> or viro/brauner (vfs*) ?

Either way is fine with me - this is pretty iomap specific, but sits
in buffer.c, so things are a bit complicated.
