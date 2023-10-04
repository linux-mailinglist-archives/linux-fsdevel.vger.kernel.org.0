Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC787B8EB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjJDVYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJDVYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:24:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F890;
        Wed,  4 Oct 2023 14:24:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6422BC433C8;
        Wed,  4 Oct 2023 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696454654;
        bh=FVWYhbxPfg+NUqYv6k/q0dhpKV2Gxtj/d+mUBUkDx8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DUT7sm5fdUL6LlCc00PPq06Au8x8WuQDckrxoUYP/1Ff7HocvMKxOMYFShvXD2JHV
         uwDjNVRlj4cQevom8Mmq8u+kNLzIPuCNjnxJLZRSl4IZu1s8gyPu8hTZtXBfPA30IZ
         HGpTD1KU2SZJPrulahbKzd2C18sNAPRH7ZXwPSUZSawQ90YXwxFqWKX0NAs6niORLg
         2q8ipQOH89OMS6hsTjhCv5Yak4jsusrXFRtnOf1byLNXfWVK44O66c3M28eR1h5+eJ
         XTDLftwZphfiFtvZEuFxTzTUBf5eDYVO8WgRByhvjYxJuPTOI56KFfSDk1Yz+RP1LT
         04QHfdB8IJXdQ==
Date:   Wed, 4 Oct 2023 14:24:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH 29/29] net: move sockfs_xattr_handlers to .rodata
Message-ID: <20231004142412.153f2993@kernel.org>
In-Reply-To: <20230930050033.41174-30-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
        <20230930050033.41174-30-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 30 Sep 2023 02:00:33 -0300 Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> sockfs_xattr_handlers at runtime.

Acked-by: Jakub Kicinski <kuba@kernel.org>
