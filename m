Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E307A6FC7FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 15:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjEINfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjEINfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 09:35:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2073E61;
        Tue,  9 May 2023 06:35:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2C446732A; Tue,  9 May 2023 15:35:44 +0200 (CEST)
Date:   Tue, 9 May 2023 15:35:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/9] block: consolidate the shutdown logic in
 blk_mark_disk_dead and del_gendisk
Message-ID: <20230509133544.GE841@lst.de>
References: <20230505175132.2236632-1-hch@lst.de> <20230505175132.2236632-2-hch@lst.de> <20230507190811.qbll5r3jsx35curi@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507190811.qbll5r3jsx35curi@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 09:08:11PM +0200, Jan Kara wrote:
> I'm somewhat wondering about the lost notification from
> blk_mark_disk_dead(). E.g. DM uses blk_mark_disk_dead() so if some udev
> script depends on the event when DM device gets destroyed, we would break
> it?

Maybe.  We'll probably find out..

