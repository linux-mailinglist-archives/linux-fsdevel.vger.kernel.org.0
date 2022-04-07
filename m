Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAA4F80E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiDGNp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 09:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiDGNp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6499108BF2;
        Thu,  7 Apr 2022 06:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2458261B20;
        Thu,  7 Apr 2022 13:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA35C385A4;
        Thu,  7 Apr 2022 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649339034;
        bh=lW1wqEe3jYDI4Ih14Ev3zG5/C5cIXC6Adr8A/ThZjO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/UzVKboKZZzhLM8q4RJ5N4wZWkpjGMwP//EmIMfpPYy0bvq7Rv9Dh29tuKzEYngH
         ZIqvHviR4jwRMmE2E5S71S2sQhV0RwcuYHSDXLRLNamLa4aylQEiZTl6xbPI4hbAtM
         TnYYH+H7PVH+weD3DoL3RqAj4WI4aBDpyodvSnvsJyGyHzGM6Qk6LfmPKfesN50Cf2
         GI66ehRJ5Nj+gPgxbuP56S8J96rlFbQt8mq0Mytv+6ZtqCIJMT/epShl82FBcV528t
         UivcY5GO5K4jHoZrZLDdbncHqgk/nL9OSF43rQTT7Ym4ROCLBWsJU/uZWT83pbmmAq
         zEF/mu8bdwNZA==
Date:   Thu, 7 Apr 2022 15:43:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 6/6] idmapped-mounts: Add open with O_TMPFILE
 operation in setgid test
Message-ID: <20220407134350.yka57n27iqq5pujx@wittgenstein>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-6-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649333375-2599-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:09:35PM +0800, Yang Xu wrote:
> Since we can create temp file by using O_TMPFILE flag and filesystem driver also
> has this api, we should also check this operation whether strip S_ISGID.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

This is a great addition, thanks!
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
