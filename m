Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49B76A101
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGaTTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGaTTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:19:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC7139;
        Mon, 31 Jul 2023 12:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91C02612A5;
        Mon, 31 Jul 2023 19:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5CEC433C9;
        Mon, 31 Jul 2023 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690831143;
        bh=fh8TbbkVRHbmFgZV/bmo1jBtEqVSa0bBVXi9m9Lh7tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dw+qsqzDRycKd/lU74ftZZ+2Ygbte7alWKIbUzMn762auWEkTfA7/kFRvpKflydx/
         zX8b1HjMf5jjk7t5fxEanNb+20s6qMhiqBdFRhLrhHXmONjA1FiFQQd84Rj3VnvLd7
         1xTwX16WPwj0buS9hIIrZvLr3M2UoIzHnmhm2QB4PmVUBFL5oWCCdQq2hTvJgDJKiR
         5HNyA4agPPoyeY9WB7WnUOkNEev3mj/oyQ1LKCHCT4nWjIt3nZmwdZhnmN1b0DHppm
         kMxVwwhJuZvSPxHnjkKwondecI5Nm6jABDxZj88mz1X6PFwzHZ6ldYapkmiN+uBS4h
         tzFVFXOBPBMfw==
Date:   Mon, 31 Jul 2023 21:18:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bill O'Donnell <billodo@redhat.com>,
        Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <20230731-referat-stellen-da6b5fe962a4@brauner>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
 <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
 <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
 <221b9a4a-275f-80a4-bba6-fb13a3beec0a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <221b9a4a-275f-80a4-bba6-fb13a3beec0a@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> that there is another user.

The fact that another non-module user exists is irrelevant to whether or
not this will become an export.
