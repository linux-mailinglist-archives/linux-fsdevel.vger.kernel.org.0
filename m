Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF37520BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjGMMFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjGMMFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:05:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B148A1FDB;
        Thu, 13 Jul 2023 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689249894; bh=aGLwQm19KJpnkJTlw+kKE8HPevg+P4fxiz3TYeRvxpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7iZKfYYouyYRmsTyXvRs2Y0YCgtyjAIlMJoRxnjrdFIjk3GcNgNp4lRCrFOlCWsD
         526LBpg8UMOkXfjdDbBc0PCGh0/SLniy0KN3ayFIoHNQiEsa4AhGnsESA9isvEmSe8
         UuCPBcWV/O1OZ37gr3bw3afMyVm+sWfmnqYCZ9ck=
Date:   Thu, 13 Jul 2023 14:04:52 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <7a0d55f9-1cf9-4e30-bb20-2fee02af1515@t-8ch.de>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
 <20230713-walzwerk-flugaufnahme-680653f18f88@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713-walzwerk-flugaufnahme-680653f18f88@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-13 13:51:39+0200, Christian Brauner wrote:
> On Sun, Jul 09, 2023 at 07:10:58PM +0200, Thomas Weißschuh wrote:
> > Hi Willy,
> > 
> > On 2023-07-09 11:29:47+0200, Willy Tarreau wrote:
> > > On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
> > >> [..]
> > > 
> > > Now queued, thanks!
> > > Willy
> > 
> > Don't we need an Ack from the fs maintainers for the patch to
> > fs/proc/proc_net.c ?
> > 
> > Personally I expected this series to go in via the fs tree because of
> > that patch.
> 
> I don't necessarily see patches I'm not Cced on.

Currently you are not listed explicitly maintainer for
"PROC FILESYSTEM" in MAINTAINERS.
If those should also go to you directly could you add yourself in
MAINTAINERS?
Otherwise get_maintainers.pl will miss your address.

Thomas
