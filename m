Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1274C1B4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 11:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGIJhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 05:37:10 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 02:37:09 PDT
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C65A3109
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jul 2023 02:37:09 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3699TlvO019485;
        Sun, 9 Jul 2023 11:29:47 +0200
Date:   Sun, 9 Jul 2023 11:29:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux@weissschuh.net, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <20230709092947.GF9321@1wt.eu>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630140609.263790-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 10:06:09PM +0800, Zhangjin Wu wrote:
> Hi, Thomas
> 
> Just applied your patchset on v6.4, and then:
> 
>   - revert the 1st patch: 'selftests/nolibc: drop test chmod_net' manually
> 
>   - do the 'run' test of nolibc on arm/vexpress-a9
> 
> The 'chmod_net' test of tools/testing/selftests/nolibc/nolibc-test.c
> really failed as expected (and therefore, should be removed):
> 
>     11 chdir_root = 0                                                [OK]
>     12 chdir_dot = 0                                                 [OK]
>     13 chdir_blah = -1 ENOENT                                        [OK]
>     14 chmod_net = -1 EPERM                                         [FAIL]
>     15 chmod_self = -1 EPERM                                         [OK]
>     16 chmod_tmpdir = 0                                              [OK]
>     17 chown_self = -1 EPERM                                         [OK]
> 
> So, If this test result is enough for this patch, here is my:
> 
> Tested-by: Zhangjin Wu <falcon@tinylab.org>

Now queued, thanks!
Willy
