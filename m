Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E742A74C6ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGISEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGISEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 14:04:47 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53A26107;
        Sun,  9 Jul 2023 11:04:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 369I4WlW022688;
        Sun, 9 Jul 2023 20:04:32 +0200
Date:   Sun, 9 Jul 2023 20:04:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <20230709180432.GA22685@1wt.eu>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
 <20230709172753.GA22287@1wt.eu>
 <df91b1d3-2c66-4a6b-9a8a-544679bc09a8@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df91b1d3-2c66-4a6b-9a8a-544679bc09a8@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 09, 2023 at 07:57:27PM +0200, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2023-07-09 19:27:53+0200, Willy Tarreau wrote:
> > On Sun, Jul 09, 2023 at 07:10:58PM +0200, Thomas Weißschuh wrote:
> > > On 2023-07-09 11:29:47+0200, Willy Tarreau wrote:
> > > > On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
> > > >> [..]
> > > > 
> > > > Now queued, thanks!
> > > > Willy
> > > 
> > > Don't we need an Ack from the fs maintainers for the patch to
> > > fs/proc/proc_net.c ?
> > > 
> > > Personally I expected this series to go in via the fs tree because of
> > > that patch.
> > 
> > Gasp! You're totally right, I confused it with a test only changing
> > the nolibc-test file, as the chmod_net test appeared as a dependency!
> > Let me drop it from the series and push again.
> 
> I think if this patch now also goes in via both the nolibc/rcu trees and
> the fs tree it would not be great.
>
> The best way forward would probably for you to rebase your tree on top
> of mainline after the fs tree has introduced both patches of the series
> into Linus' tree and then you can drop your copy of the test removal.

Yeah I agree.

> I want to keep both patches together because I expect the fs change to
> be backported and if it is backported on its own it will break
> nolibc-test in those trees.

OK but we can also fix the test regardless, and mark it for backport, no ?

> But maybe I'm overthinking it, nobody is running nolibc-test on
> non-mainline kernels anyways and both patches can be split.

I agree that we shouldn't grant too much importance to this test ;-)
I'm regularly seeing Sasha propose them for backports and am thinking
"ok it cannot hurt but I'm not convinced anyone will notice the fix".

> If they are to be kept together and go via fs an Ack on the nolibc-test
> patch is probably needed, too.

OK. Let's first see if someone from FS agrees on the change.

Thanks for the clarification,
Willy
