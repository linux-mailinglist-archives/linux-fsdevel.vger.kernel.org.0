Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73053758D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGSGO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 02:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGSGOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695F210E;
        Tue, 18 Jul 2023 23:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E1F6130C;
        Wed, 19 Jul 2023 06:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3692BC433C7;
        Wed, 19 Jul 2023 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689747269;
        bh=sZQkvNAe+cKlQGESbDXtNvF8HUMzBcpwrjNToTovqK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTN8KHPHo0i1PASz4Zts/1aGDM34Xqb7nh2Jf/NDIt8YOIJs9sIDeobDBwO9+Ye2A
         o1Xa3ybK1cKlaZ3dRnoSMWGuup4EeRKIXatORDVD+UWIu05+pgNPuxwLREMiCD2ikV
         FWpOEeTD4One0yZ7355tqzEk5pbcTjCxpskXHsKdidYQPQz3IFd6VZwPyKGygFPTBm
         UElMAKIywlOF0sxMO6IeMlFNz5bAN0O4xI2liOOrV6XNUDw/dehDb5nuJONkHZfNMI
         EWmCDYlR+WeWXI/Rgr0ogE9JuJl5OVR6ucyyBJr2GM+NiNauEWC8QcIVci0JQjc2ST
         1bDmFpeQqiekw==
Date:   Wed, 19 Jul 2023 08:14:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     wuyonggang001@208suo.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/filesystems.c: ERROR: "(foo*)" should be "(foo *)"
Message-ID: <20230719-kassen-delegation-acf0a25adf3f@brauner>
References: <20230717070500.38410-1-zhanglibing@cdjrlc.com>
 <a456720721d2f8fc33bb0befbe2ad115@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a456720721d2f8fc33bb0befbe2ad115@208suo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:07:11PM +0800, wuyonggang001@208suo.com wrote:
> Fix five occurrences of the checkpatch.pl error:
> ERROR: "(foo*)" should be "(foo *)"
> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---

Patch is corrupt; doesn't even apply.
