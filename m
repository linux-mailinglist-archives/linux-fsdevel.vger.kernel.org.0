Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C2D60442F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiJSL7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiJSL7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319A291840;
        Wed, 19 Oct 2022 04:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAB2E603F5;
        Wed, 19 Oct 2022 11:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35FEC433D6;
        Wed, 19 Oct 2022 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666179347;
        bh=N2vQhy7f95uDTJipP16fwvUPJN51nfdW0wtU0agrnbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjUOSOs6ZjqK3ZG+HQJPitJrARfoYC3z90DPX0fwG0XiGGBOtjOJYvOPOn3AinwrH
         O4cZvooYWRVWuYeWnhSqZmScmt3hJoyfhVsihHg14ie0J1abOXG0sCaURs4Ayc+LHJ
         wPZree2ffx2UDkw9vALKwm+SUBCAvLjo/05CHp9AdbEuHWSMXDGjDWi0UeyqXMnGKK
         J6lmY9+q6EcBt+eJhSG1oOE+boLhvbaBwe2KqtYn+7p76wBH7D9LC0gRZ7tZJNXcl/
         NcTP4I0PHxAW/omNTbL+ayjbovSI1zvwlv+m0XBke29jGn2/7A3p36/cM/cHGY69Qc
         gpGtsdFXTSm4g==
Date:   Wed, 19 Oct 2022 13:35:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt: Fix whitespace issues
Message-ID: <20221019113543.pi6xys2sqt2encxx@wittgenstein>
References: <20221018071350.never.230-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018071350.never.230-kees@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:14:20AM -0700, Kees Cook wrote:
> Fix the annoying whitespace issues that have been following these files
> around for years.
> 
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
