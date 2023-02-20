Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE669D20D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjBTRTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 12:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjBTRTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:19:51 -0500
X-Greylist: delayed 271 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 09:19:38 PST
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CE1EBE7;
        Mon, 20 Feb 2023 09:19:37 -0800 (PST)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:2813:fcf4:8062:a04f])
        by joe.alarsen.net (Postfix) with ESMTPS id 65E47180744;
        Mon, 20 Feb 2023 18:07:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1676912857; bh=T2sQlFBlTIMYe9k7rCqKWiAryzwsGearmcwCGtaYoY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cslByaZ25ANlGFLokwqOd3SNfpPAh5urnc0n2ESOEZPmwGD51IHVgiL/gMfejln8G
         7tjnzg343Gxa3rATIByjTIwYGlrMu5tnqFaTB8xtA1w2gyb/I2ftaEn0+yz44JxYUK
         mbjXnrANcBCVniB5+Pbunc/xeUhS2rybKAcZRiN8=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 5F03627C0364;
        Mon, 20 Feb 2023 18:07:37 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] qnx4: credit contributors in CREDITS
Date:   Mon, 20 Feb 2023 18:07:37 +0100
Message-ID: <2694824.9PvXe5no7K@alarsen.net>
In-Reply-To: <20230220170210.15677-3-lukas.bulwahn@gmail.com>
References: <20230220170210.15677-1-lukas.bulwahn@gmail.com> <20230220170210.15677-3-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday, 2023-02-20 18:02 Lukas Bulwahn wrote:
> Replace the content of the qnx4 README file with the canonical place for
> such information.
> 
> Add the credits of the qnx4 contribution to CREDITS. As there is already a
> QNX4 FILESYSTEM section in MAINTAINERS, it is clear who to contact and send
> patches to.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  CREDITS        | 12 ++++++++++++
>  fs/qnx4/README |  9 ---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>  delete mode 100644 fs/qnx4/README
> 
> diff --git a/CREDITS b/CREDITS
> index 07e871d60cf0..b6c93e0a62c3 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -890,6 +890,10 @@ W: http://jdelvare.nerim.net/
>  D: Several hardware monitoring drivers
>  S: France
>  
> +N: Frank "Jedi/Sector One" Denis
> +E: j@pureftpd.org
> +D: QNX4 filesystem
> +
>  N: Peter Denison
>  E: peterd@pnd-pc.demon.co.uk
>  W: http://www.pnd-pc.demon.co.uk/promise/
> @@ -1263,6 +1267,10 @@ S: USA
>  N: Adam Fritzler
>  E: mid@zigamorph.net
>  
> +N: Richard "Scuba" A. Frowijn
> +E: scuba@wxs.nl
> +D: QNX4 filesystem
> +
>  N: Fernando Fuganti
>  E: fuganti@conectiva.com.br
>  E: fuganti@netbank.com.br
> @@ -2222,6 +2230,10 @@ D: Digiboard PC/Xe and PC/Xi, Digiboard EPCA
>  D: NUMA support, Slab allocators, Page migration
>  D: Scalability, Time subsystem
>  
> +N: Anders Larsen
> +E: al@alarsen.net
> +D: QNX4 filesystem
> +
>  N: Paul Laufer
>  E: paul@laufernet.com
>  D: Soundblaster driver fixes, ISAPnP quirk
> diff --git a/fs/qnx4/README b/fs/qnx4/README
> deleted file mode 100644
> index 1f1e320d91da..000000000000
> --- a/fs/qnx4/README
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -
> -  This is a snapshot of the QNX4 filesystem for Linux.
> -  Please send diffs and remarks to <al@alarsen.net> .
> -  
> -Credits :
> -
> -Richard "Scuba" A. Frowijn     <scuba@wxs.nl>
> -Frank "Jedi/Sector One" Denis  <j@pureftpd.org>
> -Anders Larsen                  <al@alarsen.net> (Maintainer)

Acked-By: Anders Larsen <al@alarsen.net>

Thx
Anders




