Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9BF72B84B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjFLGsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjFLGsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A310C9;
        Sun, 11 Jun 2023 23:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D89261FAA;
        Mon, 12 Jun 2023 06:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50A9C433D2;
        Mon, 12 Jun 2023 06:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686551693;
        bh=d5qd4YuCkqemYilJXPWjSw4j49Eky7gsw8XCU9Cbx6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y85xNxLhiX9XDbjDCK5j1vH/apeR4TvrZ5Go/EQE4JBQerHd8uAMqq8dv4qOZj75Z
         bG151x0ukdlp9xAwjZLLQ2H32fOpfaoJfNM1jaBJ3v9UJQa59Xf1d1p9VVz/a+5jOb
         pWfnHBXBTB/+63YStanczevZrv3D+UsOLjhz+lZqKIBlsGgzZvTsN059ZznYRKzIU3
         WabOmbDNpi84RwPxARlGkkmn62dD72XEhedW/Pz+uka0iWrlnYgCU7LEDK446CAI3X
         Dkg2CZvdA3VC1pSkk6Qyn/TqVgXw1eaSoW0t/pstbyYrcsq60YXBAiuLaPOZ68JaBk
         R8H/ip6zyNDEg==
Date:   Mon, 12 Jun 2023 08:34:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
Subject: Re: [PATCH] fs: Fix comment typo
Message-ID: <20230612-kabarett-vinylplatte-6e3843cd76a3@brauner>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me>
 <87edmhok1h.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edmhok1h.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 01:50:34PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
> >> From: Mao Zhu <zhumao001@208suo.com>
> >> 
> >> Delete duplicated word in comment.
> >
> > On what function?
> 
> Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
> contributors into the ground?  It appears I do.  So:
> 
> Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
> changelog is fine.  We absolutely do not need you playing changelog cop
> and harassing contributors over this kind of thing.

100% agreed.

> 
> >> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> >
> > You're carrying someone else's patch, so besides SoB from original
> > author, you need to also have your own SoB.
> 
> This, instead, is a valid problem that needs to be fixed.

Patch picked up and missing sender SOB added.
