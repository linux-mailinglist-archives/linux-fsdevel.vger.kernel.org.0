Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD0615C4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 07:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKBG3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 02:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBG3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:29:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B326112;
        Tue,  1 Nov 2022 23:29:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1A206732D; Wed,  2 Nov 2022 07:29:07 +0100 (CET)
Date:   Wed, 2 Nov 2022 07:29:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@meta.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20221102062907.GA8619@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com> <20221024144411.GA25172@lst.de> <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com> <20221024171042.GF5824@suse.cz> <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com> <20221026074145.2be5ca09@gandalf.local.home> <20221031121912.GY5824@twin.jikos.cz> <20221102000022.36df0cc1@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102000022.36df0cc1@rorschach.local.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:00:22AM -0400, Steven Rostedt wrote:
> It really comes down to how badly do you want Christoph's code?

Well, Dave has made it clear implicily that he doesn't seem to care about
it at all through all this.  The painful part is that I need to come up
with a series to revert all the code that he refused to add the notice
for, which is quite involved and includes various bug fixes.
