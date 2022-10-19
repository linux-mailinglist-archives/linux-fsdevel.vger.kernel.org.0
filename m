Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F0604426
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJSL7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiJSL6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B4180266;
        Wed, 19 Oct 2022 04:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 481A06066C;
        Wed, 19 Oct 2022 11:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B9C433C1;
        Wed, 19 Oct 2022 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666179323;
        bh=n7vNTP5zyuyxqJmFthkSvw7yT6JUrhOimlpkmNcxnlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1xyFPgYyAnp+F3vS7hBYIoNbSJ6DN+3CKQl4PGuUKQ6Rzjj+mG2WfG/EF3fs02I8
         2NZ9R2Jg8bKfIwrqVJ/X8BXehopAKMTV2teSNR2fwaLWcRSFS9lnLPTipqw9glOjRO
         jdlwO1k0ogHiVCDFywatCWyE5F3net8AE+d+hU5TQgAVxYjCWUYlOJB6y/0o4cf5/h
         6a6knnlr1fgcuZcd3Zd6LFGL0YHosdc74s1PdoJy9pj2GKrGAUMRFR85A1X0RSgmjM
         4rnjwIDDjU/jUIJ2gZFk3sJzoYdttksPQMdVvS6ZeMOq0vHhmI/cMs5pS0dGuQcDyZ
         g1gkhT48IQEhQ==
Date:   Wed, 19 Oct 2022 13:35:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Add comments on check_unsafe_exec() fs counting
Message-ID: <20221019113518.tmbuflcinmcy5uk2@wittgenstein>
References: <20221018071537.never.662-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018071537.never.662-kees@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:17:24AM -0700, Kees Cook wrote:
> Add some comments about what the fs counting is doing in
> check_unsafe_exec() and how it relates to the call graph.
> Specifically, we can't force an unshare of the fs because
> of at least Chrome:
> https://lore.kernel.org/lkml/86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org/
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
