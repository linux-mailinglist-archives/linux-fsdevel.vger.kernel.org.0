Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1064616471
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 15:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiKBOHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiKBOHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:07:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192DF00C;
        Wed,  2 Nov 2022 07:06:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52C9968AA6; Wed,  2 Nov 2022 15:06:50 +0100 (CET)
Date:   Wed, 2 Nov 2022 15:06:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@meta.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <20221102140650.GA3995@lst.de>
References: <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com> <20221024144411.GA25172@lst.de> <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com> <20221024171042.GF5824@suse.cz> <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com> <20221026074145.2be5ca09@gandalf.local.home> <20221031121912.GY5824@twin.jikos.cz> <20221102000022.36df0cc1@rorschach.local.home> <20221102062907.GA8619@lst.de> <Y2J5HfQn+XU74ECJ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2J5HfQn+XU74ECJ@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:05:17AM -0400, Josef Bacik wrote:
> Except he hasn't, he's clearly been trying to figure out what the best path
> forward is by asking other people and pulling in the TAB.  I don't understand
> why you're being so hostile still, clearly we're all trying to work on a
> solution so we don't have to have this discussion in the future.  If you don't
> want to contribute anymore then that's your choice, but Dave is clearly trying
> to work towards a solution that works for everybody, and that includes taking
> your copyright notices for your pending contributions.  Thanks,

Because that is no my impression.  To me it very much looks like he is
looking for more and more escapes to say no after the initial one did
not work out.  Which is really frustrating as btrfs has been making up
completly random rules with no precedence at all and then keeps going.
