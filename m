Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1167913AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjIDInR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352619AbjIDIeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4D94;
        Mon,  4 Sep 2023 01:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49D660EA4;
        Mon,  4 Sep 2023 08:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50BCC433C7;
        Mon,  4 Sep 2023 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693816445;
        bh=uaPPl+ksLwIWQRb0KWgIIW5aKnRw+6lfzmGHeLbTp/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCCS34hGtPp21zwMQwW54Cmjd1Sf5SK7eFNXmbiNbIVpYUtC3c+OTQBf0eAnqUmyB
         3rTi9fDvc9tIzkX0+y79suLfzKNCV8oCcsmEDSrx8dKG8kNvb48fEutnrdXra2h5j1
         I50RdxqWoYlf4edj1/x9qFJ3osXh7b+IW4CVymaFk2DuXL631WnaV2oIlbza6O2AxU
         uFfMPzy4USQydAqtO4yxOGIhqUoUa4VleJwrdYO7rgFlzIW9FLYtp85qwmAl6Q0U9T
         S2msGy+PQGJHlFT31m0xuR9nyA8h04pGyCM81KhkJDPx0HJ2b/YomZgVenKviCk7jo
         72bZ31U3AkAhA==
Date:   Mon, 4 Sep 2023 10:34:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@poochiereds.net>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] name_to_handle_at.2,fanotify_mark.2: Document the
 AT_HANDLE_FID flag
Message-ID: <20230904-hirnzellen-pulle-599a7954b157@brauner>
References: <20230903120433.2605027-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230903120433.2605027-1-amir73il@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 03, 2023 at 03:04:33PM +0300, Amir Goldstein wrote:
> A flag to indicate that the requested file_handle is not intended
> to be used for open_by_handle_at(2) and may be needed to identify
> filesystem objects reported in fanotify events.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

For the content,
Acked-by: Christian Brauner <brauner@kernel.org>
