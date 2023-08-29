Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9378BCB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 04:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjH2CNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 22:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjH2CNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:13:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D17110;
        Mon, 28 Aug 2023 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WSpE78AlAGSFYIPZmWk0Cvmp1sPO7AW6n90ce46uOYM=; b=PAFIQnX8h2mZe312CRFxBUGRhR
        yewAkg9miKRYD9Vz8UTH7Z+ppmL39kw4LeosjxsuhpA3gEBVXHTXUZpGvPRRdiqX7EnVQ4cRARMqU
        MgrwPXK7cJThHqvEsRmbUeqg1ngZt/qSYMxI+i0SGVsWv1wEmes8gW8EHhSOD+X/V9nRdb0NqNfte
        z3xmoKxbu81NegjTRuzZ/0wz66egxTQrE0xlU5sUuFZNGZqNBQ2VuSPK0H83+YYCMcQvFrOhEzk2d
        eQ8a5o9d3oxteEGOvuq9kuMxWmsfOjRHfytiNSlkG2eL5lsIt+/1a1CPSzZhlEodHA0F/M4yqR0Ly
        ps7rt9eg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaoEb-001i6r-0D;
        Tue, 29 Aug 2023 02:13:37 +0000
Date:   Tue, 29 Aug 2023 03:13:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 4/6] block: stop setting ->direct_IO
Message-ID: <20230829021337.GC325446@ZenIV>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801172201.1923299-5-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:21:59PM +0200, Christoph Hellwig wrote:
> Direct I/O on block devices now nevers goes through aops->direct_IO.
> Stop setting it and set the FMODE_CAN_ODIRECT in ->open instead.

s/nevers/never/
