Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE25A2233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbiHZHqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245663AbiHZHqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79FD3453;
        Fri, 26 Aug 2022 00:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 467E2B82EFE;
        Fri, 26 Aug 2022 07:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78767C433C1;
        Fri, 26 Aug 2022 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661499959;
        bh=g38Y5zVOh/il7hqwtaaSz78z8RmUQrkXKGXd0+FhOGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvAqGU8Bx4t0ZAeKf44bbBf6+W+TK6SklhHyc4dKqyBu0jugmm2I9+pILc/najKlH
         ViMZY1P7V8lTUYxuZvN0Dvq8bjMGig8EdBdyFYxnV2due4pPii9gQR50wcts24kkQT
         jzmN/T//7lxo470iqBN1Mixja2b9CsX6Uaav4McK6iEldteFcYdIyy4WayzKsK/z7v
         9lrSgoT4MK0M5UtY3SCdbenuj24cPINWmBI+0uzcRbkuVWDxOMJyOhVfKkRhWZDxAg
         dmbTcTRReq8nENlH+qqVEtjWnEG119w//9gpuz0VNtrOTqk0h90tdQQVfi7eGQZCBy
         /rMlFAEtPQzqA==
Date:   Fri, 26 Aug 2022 09:45:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ->getprocattr(): attribute name is const char *,
 TYVM...
Message-ID: <20220826074553.6ykrgybzkj3wmfee@wittgenstein>
References: <Yv2qoNQg48rtymGE@ZenIV>
 <Yv2q6/bVtQgB07k4@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv2q6/bVtQgB07k4@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:58:51AM +0100, Al Viro wrote:
> cast of ->d_name.name to char * is completely wrong - nothing is
> allowed to modify its contents.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
