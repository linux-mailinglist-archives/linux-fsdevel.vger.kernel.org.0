Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC5751106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGLTMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGLTMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:12:23 -0400
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295FA199E;
        Wed, 12 Jul 2023 12:12:21 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:964:4b04:3697:f6ff:fe5d:314])
        (authenticated bits=0)
        by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 36CJC4sB582186
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 20:12:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1689189119; bh=bAuupQqEj0rLd6YFhbA1xsWbLkHvKMPgSN/mA/Dnmbg=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=LWOE7r2s2p+WKjdWpcXHmtG8608u2duj7xx2SmOOArmvae5/9nitz75cEHWvEqLa0
         2ur751xWyR9lEcSU4vIEzYKA37YQZWWKJX7fvzfQvClrFLcsB+y5QkLYdr6tH/99OD
         n62xiCHH5iEpAkwx9NyQfxgd2si6uc8bTiPMHG+Y=
Received: from miraculix.mork.no ([IPv6:2a01:799:964:4b0a:9af7:269:d286:bcf0])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 36CJBxHN2295209
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 21:11:59 +0200
Received: (nullmailer pid 603544 invoked by uid 1000);
        Wed, 12 Jul 2023 19:11:59 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, ezequiel@collabora.com,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: MTD: Lots of mtdblock warnings on bootup logs
Organization: m
References: <CAOuPNLizjBp_8ceKq=RLznXdsHD-+N55RoPh_D7_Mpkg7M-BwQ@mail.gmail.com>
        <877cr5yzjc.fsf@miraculix.mork.no>
        <CAOuPNLhUtVtrOQQ1Z_rA0NAerG5PSfA26=hoenuCtCBDvz1CJA@mail.gmail.com>
Date:   Wed, 12 Jul 2023 21:11:59 +0200
In-Reply-To: <CAOuPNLhUtVtrOQQ1Z_rA0NAerG5PSfA26=hoenuCtCBDvz1CJA@mail.gmail.com>
        (Pintu Agarwal's message of "Wed, 12 Jul 2023 23:55:41 +0530")
Message-ID: <87sf9tx7uo.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.1 at canardo
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pintu Agarwal <pintu.ping@gmail.com> writes:

> You mean, if someone is using "mount .. /dev/mtdblock*" then only we
> get these warnings ?
> Or, if someone is trying to access the node using open("/dev/mtdblock*") .

open() will cause a warning.

> But in this case, there should be only 1,2,3 entries but here I am
> seeing for all the NAND partitions.
> Or, is it possible that systemd-udevd is trying to access these nodes ?

Maybe?  Something trying to figure out the contents of all block devices
perhaps?=20

> Can we use ubiblock for mount ubifs (rw) volumes, or here we have to
> use mtdblock ?
> We have a mixture of squashfs (ro) and ubifs (rw) ubi volumes.
> Currently, we are using the ubiblock way of mounting for squashfs but
> mtdblock mounting for ubifs.

I don't think it's safe to use mtdblock on NAND.  WHich is what the
warning is about.


Bj=C3=B8rn
