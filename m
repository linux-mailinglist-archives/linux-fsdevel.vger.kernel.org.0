Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4EA7437E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjF3JHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3JHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B510C;
        Fri, 30 Jun 2023 02:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4358461703;
        Fri, 30 Jun 2023 09:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48733C433C8;
        Fri, 30 Jun 2023 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688116029;
        bh=C+tUX9gfoFQb7OopzcGYBk3yW5e3tfFfCz9w7wqq7SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCK5SkuSB37sZIRSyEYPpK5nZNM954DnbX6W7/bfjbYpDPFi/XUkr/Kt5CEoYTX3F
         8D5a8hRdFGNtHHvkpkfJ3IAKegqJ8ikveCqdOE35cT3/vf/s1uwCfO49EGAANusLAS
         Psg3hyrz7ePW1R+WyjtS10WK1hO0d7OuJMF6QHsOdJ59Fbya7LBIXb9WzH9VrWEfS7
         C3iqTRBDaciO4EfIw4YKvyRn9LhZPwJQBgWOBBDYoBEPEIi0AcPFn9yk+W4gmmksJD
         wVjwoy6Xq2bhguKEGF8J1ksGfAlWWU1qA7LTP09EBnNdnaZ0IXvMBBYxvWEvhReAjr
         VZLAve/esK79Q==
Date:   Fri, 30 Jun 2023 11:06:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Norbert Lange <nolange79@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, jan.kiszka@siemens.com,
        jannh@google.com, avagin@gmail.com, dima@arista.com,
        James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <20230630-hufen-herzallerliebst-fde8e7aecba0@brauner>
References: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
 <20230630083852.3988-1-norbert.lange@andritz.com>
 <e8161622-beb0-d8d5-6501-f0bee76a372d@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8161622-beb0-d8d5-6501-f0bee76a372d@vivier.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:52:22AM +0200, Laurent Vivier wrote:
> Hi Norbert,
> 
> Le 30/06/2023 à 10:38, Norbert Lange a écrit :
> > Any news on this? What remains to be done, who needs to be harrassed?
> > 
> > Regards, Norbert
> 
> Christian was working on a new version but there is no update for 1 year.
> 
> [PATCH v2 1/2] binfmt_misc: cleanup on filesystem umount
> https://lkml.org/lkml/2021/12/16/406
> [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
> https://lkml.org/lkml/2021/12/16/407
> 
> And personally I don't have the time to work on this.

I've actually rebased this a few weeks ago:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.binfmt_misc
It has Acks, it's done. The only thing back then was Kees had wanted to
take this but never did. I'll ping him.
