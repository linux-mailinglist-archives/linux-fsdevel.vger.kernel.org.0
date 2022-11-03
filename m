Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC30D61790B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 09:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKCItT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKCItO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:49:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD2271C;
        Thu,  3 Nov 2022 01:49:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E521368AA6; Thu,  3 Nov 2022 09:49:09 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:49:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221103084909.GA6448@lst.de>
References: <20221024144411.GA25172@lst.de> <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com> <20221024171042.GF5824@suse.cz> <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com> <20221026074145.2be5ca09@gandalf.local.home> <20221031121912.GY5824@twin.jikos.cz> <20221102000022.36df0cc1@rorschach.local.home> <20221102062907.GA8619@lst.de> <8AAF3B43-BCD3-43B4-BC78-2E9E8E702792@dilger.ca> <5f742ea1-b1c2-5a61-53a7-5f144ca169f7@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f742ea1-b1c2-5a61-53a7-5f144ca169f7@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:07:27PM -0400, Chris Mason wrote:
> We talked about this at the btrfs meeting today and I'm sure it'll get
> resolved soon.

Thanks.  That wasn't my impression so far, but I'm glad I was wrong.
