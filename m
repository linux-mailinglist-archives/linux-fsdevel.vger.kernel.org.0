Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC27260C5B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiJYHoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiJYHog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC2B3B32
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 00:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBD3617C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 07:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40166C433D7;
        Tue, 25 Oct 2022 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666683872;
        bh=rHoY/Tl9Qne1p1wNu2ctKbsvImria0CAmbK4GApF91U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg+DIZwOPyhPkDw1t81bsbl1BbOo6vtijUA83mdsdOeOcEiEWxSjubQVNFA4WPIQk
         faDhkuf/Lo0IE3pG1hM+Ca6++Pk3ZhmHCoQd24PbJyFCiWIcYCh9eBH1rtKV0B8oyG
         sGTLY1iPbmTtah1YfOZSt0Qd/znILNaNLiFWNvm7Acz5MCJ0SPB+DOcTP7RYvjpdU3
         0r/vf56z4SZ92IyNzSOMILlvRzj9s/AYGKDLuN8ds6ajuMntW2oOtpAhNlQYhQlsde
         b212HOy8r0ZaaqfE6z8xl8NbFVM6P9oy1NEUiSpZP5A1RNc4HvZ7UtHlsTJRhpwT6J
         OJhaPiewQrw+g==
Date:   Tue, 25 Oct 2022 09:44:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [apparmor] [PATCH 4/8] apparmor: use type safe idmapping helpers
Message-ID: <20221025074427.jjfx4sa2kl7w5ua5@wittgenstein>
References: <20221024111249.477648-1-brauner@kernel.org>
 <20221024111249.477648-5-brauner@kernel.org>
 <5ae36c94-18dd-2f7a-b5f4-3c2122415dc7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ae36c94-18dd-2f7a-b5f4-3c2122415dc7@canonical.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:16:02AM -0700, John Johansen wrote:
> On 10/24/22 04:12, Christian Brauner wrote:
> > We already ported most parts and filesystems over for v6.0 to the new
> > vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
> > places so we can remove all the old helpers.
> > This is a non-functional change.
> > 
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>

Would you mind if I carry this patch together with the other conversion
patches in my tree? This would make the whole conversion a lot simpler
because we're removing a bunch of old helpers at the end.
