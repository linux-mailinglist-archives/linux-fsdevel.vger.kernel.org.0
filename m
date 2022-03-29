Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088FE4EAB8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiC2KrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiC2KrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:47:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA42487BA;
        Tue, 29 Mar 2022 03:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30FD2B816A6;
        Tue, 29 Mar 2022 10:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3E2C340ED;
        Tue, 29 Mar 2022 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648550725;
        bh=+YNyKx/L/x3uEnutmIsoVTmComt7A9LE7ougq/mpTmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhbMryAgtln9LuknVRIJQ539cXJ4uITTNJZvmzIl5lq7sCXanwDT74iamovKaJgEq
         5gdLjco6Dyv41W9Ccdjl+8wcmrDRZQKWrz0zysXh4f5CdJxG1KentKUibaHiafy073
         UfGyuPKPWyZYwta7ylHmXLTC4gzZAAobx3gRAAY43ZwBujxaG9PlDqNQEhFUoUC3RZ
         CnGPNUwYyCvD2MLm4yqNgiCsd5bnB45Q4HakYHGCGhFd3QKbX5BcoMm1ukV8y1epZD
         7WKzLm+o3yT0yZ+84ZNpe02e3fGqPQXX9JSPlJyuPI7zeKAQ9SBudkDninxlrMTBf2
         aAcAIJFOJcXZQ==
Date:   Tue, 29 Mar 2022 12:45:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, jlayton@kernel.org
Subject: Re: [PATCH v1 1/3] vfs: Add inode_sgid_strip() api
Message-ID: <20220329104516.luheugjurxsx5fdq@wittgenstein>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 28, 2022 at 05:56:27PM +0800, Yang Xu wrote:
> inode_sgid_strip() function is used to strip S_ISGID mode
> when creat/open/mknod file.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

I would've personally gone for returning umode_t but this work for me
too.
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
