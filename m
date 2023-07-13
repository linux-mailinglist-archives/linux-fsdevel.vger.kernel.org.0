Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029EE752067
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjGMLvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMLvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC500B4;
        Thu, 13 Jul 2023 04:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E89260E88;
        Thu, 13 Jul 2023 11:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2441AC433C7;
        Thu, 13 Jul 2023 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689249103;
        bh=7eNiqnL5o04b/srPhTHOLbn3kMJYAa19AC9efoHty4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAqnYKzyKyNcbNDT5tq4ZHXEuSzk0n3PH8JX8Mi/wnxuH4mJ8TV/uH2p9hw4aqX2u
         eO5b+dUnLY3aDV8fPfZFGtwoqlnAAct5VV4z/aknvixceVz1KPLDk0KTj0w2pcl4iP
         UeP7ZHWfF4l97JPmg9eCzYLPAZ/2167CnESNKrVqY7IZkcHZ2arl002uqEZjVzwJPo
         VWig2DRWfLeRjSadqpHnSgYLzoOwJg2mkYKKwBfmNfBtED5sS7tIow/kur/DoxHKMY
         n4/ew5bLr2iFp4AJnBMrQ6q1j2jJcgQ/0PtsDbL36h5vzlCPadE0Z8hoXFG/gZE1SZ
         m/44XUMqGersw==
Date:   Thu, 13 Jul 2023 13:51:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <20230713-walzwerk-flugaufnahme-680653f18f88@brauner>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

I don't necessarily see patches I'm not Cced on.
