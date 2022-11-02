Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449C615B42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 05:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKBEAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 00:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBEAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527ED27171;
        Tue,  1 Nov 2022 21:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09237B80DA8;
        Wed,  2 Nov 2022 04:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2919BC433D6;
        Wed,  2 Nov 2022 04:00:26 +0000 (UTC)
Date:   Wed, 2 Nov 2022 00:00:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
Message-ID: <20221102000022.36df0cc1@rorschach.local.home>
In-Reply-To: <20221031121912.GY5824@twin.jikos.cz>
References: <20220901074216.1849941-1-hch@lst.de>
        <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
        <20221024144411.GA25172@lst.de>
        <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
        <20221024171042.GF5824@suse.cz>
        <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
        <20221026074145.2be5ca09@gandalf.local.home>
        <20221031121912.GY5824@twin.jikos.cz>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Oct 2022 13:19:12 +0100
David Sterba <dsterba@suse.cz> wrote:

> > The policy is simple. If someone requires a copyright notice for their
> > code, you simply add it, or do not take their code. You can be specific
> > about what that code is that is copyrighted. Perhaps just around the code in
> > question or a description at the top.  
> 
> Let's say it's OK for substantial amount of code. What if somebody
> moves existing code that he did not write to a new file and adds a
> copyright notice? We got stuck there, both sides have different answer.
> I see it at minimum as unfair to the original code authors if not
> completely wrong because it could appear as "stealing" ownership.

Add the commit shas to the copyright, which will explicitly show the
actual code involved. As it's been pointed out in other places, the git
commits itself does not actually state who the copyright owner is.

> 
> > Looking over the thread, I'm still confused at what the issue is. Is it
> > that if you add one copyright notice you must do it for everyone else? Is
> > everyone else asking for it? If not, just add the one and be done with it.  
> 
> My motivation is to be fair to all contributors and stick to the project
> standards (ideally defined in process). Adding a copyright notice after
> several years of not taking them would rightfully raise questions from
> past and current contributors what would deserve to be mentioned as
> copyright holders.

As I stated: "If someone requires a copyright notice for their code,
you simply add it, or do not take their code."

No one is forcing you to add the copyright. You have an alternative.
Don't take the code. If your subsystem's policy is that of not adding
copyright notices, then the submitters should honor it. I see Christoph
as being OK for not accepting his code because of this policy.

Just like I will not submit to projects that require me to hand over my
copyright. It's their right to have that policy. It's my right not to
submit code to them. Or if I do submit, refuse to conform to their
policy, and have my code rejected because of it.

It really comes down to how badly do you want Christoph's code?

-- Steve
