Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B574C6B9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGIR2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIR2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:28:22 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 134EC8E;
        Sun,  9 Jul 2023 10:28:19 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 369HRrq1022299;
        Sun, 9 Jul 2023 19:27:53 +0200
Date:   Sun, 9 Jul 2023 19:27:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <20230709172753.GA22287@1wt.eu>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Thomas,

On Sun, Jul 09, 2023 at 07:10:58PM +0200, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2023-07-09 11:29:47+0200, Willy Tarreau wrote:
> > On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
> >> [..]
> > 
> > Now queued, thanks!
> > Willy
> 
> Don't we need an Ack from the fs maintainers for the patch to
> fs/proc/proc_net.c ?
> 
> Personally I expected this series to go in via the fs tree because of
> that patch.

Gasp! You're totally right, I confused it with a test only changing
the nolibc-test file, as the chmod_net test appeared as a dependency!
Let me drop it from the series and push again.

Thanks a lot for notifying me!
Willy
