Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D263F47B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLAPtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLAPtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:49:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81730A6CF1
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 07:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC5862059
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 15:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77987C433D7;
        Thu,  1 Dec 2022 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669909769;
        bh=zCYdTwcN90rbKbvapMi8v0q4w0WwxmVlpCj5TLgSvx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLMEC5I36z3mq9OY4f3XQKoFMm68b5yTuIN/MkVDF6QW4gw3x/+ekPx4GypE4tGsP
         vZ5cTEXs9FYHDCSvT8L9e9od0Qopn93SQvOA0E4H97QlFlgiEShTSbyDgmEk9fuO0h
         K+bgGpJ2Yf6Emny0JBumQRinmEey0+8A3vmggHHA8z7MViWsOq0hV1bkjH2ChR9L3s
         bz2PCUrSV9gCsfOzX/JWYWVh2NygOxwmJXZlm54sVxlR/5S0ZwPRJgdeITPk3gSikz
         E6WF7BabqZVy0gSrkfT/fb0VhhwaGDhljR2dg5ZT1nqHGx1EfO0nMX+KUQlpJqqx9d
         0g6gjB52pz5Ug==
Date:   Thu, 1 Dec 2022 16:49:25 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] selftests: Add missing <sys/syscall.h> to mount_setattr
 test
Message-ID: <20221201154925.bs3nvf6hexufauxz@wittgenstein>
References: <20221201150218.2374366-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221201150218.2374366-1-daan.j.demeyer@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 04:02:18PM +0100, Daan De Meyer wrote:
> Including <sys/syscall.h> is required to define __NR_mount_setattr
> and __NR_open_tree which the mount_setattr test relies on.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---

Thanks for fixing this. Will pick this up now,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
