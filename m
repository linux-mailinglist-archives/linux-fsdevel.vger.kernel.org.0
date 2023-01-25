Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1167C0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 00:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAYXhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 18:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjAYXh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:37:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035B5E518;
        Wed, 25 Jan 2023 15:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B367616DD;
        Wed, 25 Jan 2023 23:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53138C433D2;
        Wed, 25 Jan 2023 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674689810;
        bh=qdW7GJEApmAZ3dv73jbkJCPfiH6FFqfAWFb67eqZLg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=spPzlcbA9nU2SSJfH0Wm7RoFovVPbqPlr9EUTDq3WpjqP6+Eamp0HEa9LLMqEWf1b
         z0f6+posc3c5OJtlmxx09xMdn+jHMGKvWj1igwOChNLLhmxU81f+BybI59+3kkUPYJ
         +XTFDhw1y6rXW2fzFJps+BxJ2DHqVeAnSPeDmoKc=
Date:   Wed, 25 Jan 2023 15:36:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: Re: [RFC PATCH v1 2/6] proc: Add allowlist to control access to
 procfs files
Message-Id: <20230125153649.a8524c34b89d6cdbb06bd5a2@linux-foundation.org>
In-Reply-To: <d87edbe023efb28f60ea04a2e694330db44aa868.1674660533.git.legion@kernel.org>
References: <cover.1674660533.git.legion@kernel.org>
        <d87edbe023efb28f60ea04a2e694330db44aa868.1674660533.git.legion@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 25 Jan 2023 16:28:49 +0100 Alexey Gladkov <legion@kernel.org> wrote:

> +config PROC_ALLOW_LIST
> +	bool "/proc/allowlist support"
> +	depends on PROC_FS
> +	default n
> +	help
> +	  Provides a way to restrict access to certain files in procfs. Mounting

I'd say "to restrict presence of files in procfs".

> +	  procfs with subset=allowlist will add the file /proc/allowlist which
> +	  contains a list of files and directories that should be accessed. To

s/accessed/present/

> +	  prevent the list from being changed, the file itself must be excluded.


