Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76C750B2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 16:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGLOkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGLOkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:40:07 -0400
X-Greylist: delayed 655 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 07:40:05 PDT
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AEF19B;
        Wed, 12 Jul 2023 07:40:05 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:964:4b04:3697:f6ff:fe5d:314])
        (authenticated bits=0)
        by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 36CESiBO564786
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:28:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1689172119; bh=sk+FPXXnrjQY//r/C0seGC8cejqHanoKfLCIbFRF9IQ=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Yy4uQ1YAqHcj2pchhpLv0u4XG6Zm8/rVCIRaMFjPxsHU+imwdk5Cr5LQFT+gfzT6Q
         Tey9PR5rte1qmKegvGpOFBGGL1gnAOENBA0Y8vBywk2/LK8LhkERm1Oh1lUgYKgJlZ
         U+RdMqYCK1EgrACfgBJQe3dJg7oEI828QcsuWNnk=
Received: from miraculix.mork.no ([IPv6:2a01:799:964:4b0a:9af7:269:d286:bcf0])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 36CESduU2250823
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 16:28:39 +0200
Received: (nullmailer pid 588999 invoked by uid 1000);
        Wed, 12 Jul 2023 14:28:39 -0000
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
Date:   Wed, 12 Jul 2023 16:28:39 +0200
In-Reply-To: <CAOuPNLizjBp_8ceKq=RLznXdsHD-+N55RoPh_D7_Mpkg7M-BwQ@mail.gmail.com>
        (Pintu Agarwal's message of "Wed, 12 Jul 2023 19:29:39 +0530")
Message-ID: <877cr5yzjc.fsf@miraculix.mork.no>
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

> Kernel: 5.15 ; arm64 ; NAND + ubi + squashfs
> We have some RAW partitions and one UBI partition (with ubifs/squashfs vo=
lumes).
>
> We are seeing large numbers of these logs on the serial console that
> impact the boot time.
> [....]
> [    9.667240][    T9] Creating 58 MTD partitions on "1c98000.nand":
> [....]
> [   39.975707][  T519] mtdblock: MTD device 'uefi_a' is NAND, please
> consider using UBI block devices instead.
> [   39.975707][  T519] mtdblock: MTD device 'uefi_b' is NAND, please
> consider using UBI block devices instead.
> [....]
>
> This was added as part of this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/mtd/mtdblock.c?h=3Dv5.15.120&id=3Df41c9418c5898c01634675150696da290f=
b86796
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/mtd/mtdblock.c?h=3Dv5.15.120&id=3De07403a8c6be01857ff75060b2df9a1aa8=
320fe5

You have 5.15.what exactly?  commit f41c9418c5898 was added in v5.15.46.
Your log looks like it is missing.

FWIW, commit f41c9418c5898 was supposed to fix exactly that problem with
commit e07403a8c6be01.

But to catch actual mounts it will still warn if the mtdblock device is
opened.  This can obviously cause false positives if you e.g have some
script reading from the mtdblock devices.  If you are running v5.15.46 or
later then there *is* something accessing those devices. You'll have to
figure out what it is and stop it to avoid the warning.


Bj=C3=B8rn
