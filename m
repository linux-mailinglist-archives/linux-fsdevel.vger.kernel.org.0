Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D880A5F0F44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 17:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiI3PwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiI3Pv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA50104612;
        Fri, 30 Sep 2022 08:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76F1AB82954;
        Fri, 30 Sep 2022 15:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3284CC43141;
        Fri, 30 Sep 2022 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664553112;
        bh=+eWM1THqIFbDHvQBPZTD+XciSZi/CQ/ZVgSibLCd7ko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=so45NCRMIE4QgV4ZCL4L4VlMEGerkP4QbeRWVX5KOOGMGXBq1A+4EszKbB2VmuVfK
         GeJkKjEoTedBnESqkYloFdauwJJoolLNwntjO8k/xSX/m9bm6H6Zog16AHMbeBtBAZ
         ah4S7DGCs9rEWaenV/whcxtMmGiYpNhdEtWHogstDSYZHajrJWXBmxAQurl7gfUAZn
         AMf8HieAJSWbv5bnDoPLZtdYBuHk/nHK6RmALsowJgHcbiZumj+2X0mSbLybJJsFnW
         28sULD+YMapqS+rVb2Zuh6NnGH5KR/WUqpb1DgloE76lhzESNrQ2yDcxgAuaHmcmZa
         P2KXb3mQ68bww==
Received: by mail-lf1-f51.google.com with SMTP id 10so7528492lfy.5;
        Fri, 30 Sep 2022 08:51:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf2XPwwPLf0ssuz63K9Sr2/J4gAwbYPyjDnk9+lY55fAwurWPNaV
        ED75SN8UkigiZpyltRa8quBGSlIT9hE91qwjRoY=
X-Google-Smtp-Source: AMsMyM4SRDdFD24WhA+SrN055GBOZGydhG6rT6py5SeVyiHZPpLiTS4D8qNvENQaXOpsAsr9k6rT9RsYZvqUl0zi1x4=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr3382854lfb.583.1664553110088; Fri, 30
 Sep 2022 08:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220929215515.276486-1-gpiccoli@igalia.com> <202209291951.134BE2409@keescook>
 <56d85c70-80f6-aa73-ab10-20474244c7d7@igalia.com>
In-Reply-To: <56d85c70-80f6-aa73-ab10-20474244c7d7@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 30 Sep 2022 17:51:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com>
Message-ID: <CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com>
Subject: Re: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp interface"
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sept 2022 at 14:39, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 30/09/2022 00:29, Kees Cook wrote:
> > [...]
> >
> > Hi!
> >
> > Thanks for looking at this. I wasn't able to reproduce the problem,
> > initially. Booting with pstore.backend=ramoops pstore.compress=zstd and
> > writing to /dev/pmsg0, after a reboot I'm able to read it back.
> >
>
> Hi Kees, thanks a lot for your attention!
> IIUC, compression applies to dmesg only, correct?
>
>
> > [...]
> > What's your setup for this? I'm using emulated NVDIMM through qemu for
> > a ramoops backend. But trying this with the EFI backend (booting
> > undef EFI with pstore.backend=efi), I _do_ see the problem. That's
> > weird... I suspect there's some back interaction with buffer size
> > differences between ramoops and EFI & deflate and zstd.
> >
> > And I can confirm EFI+zstd with the acomp change reverted fixes it.
> >
>
> I'm using qemu but was able to use real HW (Steam Deck). In both cases,
> kernel is not using the entire RAM ("mem=" parameter, for example) so we
> can use a bit for ramoops. Also, both setups are UEFI, hence I can also
> use efi_pstore.
>

Does this help?

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b2fd3c20e7c2..c0b609d7d04e 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -292,7 +292,7 @@ static int pstore_compress(const void *in, void *out,
                return ret;
        }

-       return outlen;
+       return creq->dlen;
 }

 static void allocate_buf_for_compression(void)


>
> > [...]
> > Hm, it's possible this was just sent directly to me? If that's true, I
> > apologize for not re-posting it to lkml. I suspect I didn't notice at
> > the time that it wasn't CCed to a list.
>
> No need for apologies, thanks for the clarification! How about if we add
> a mailing list in the pstore entry on MAINTAINERS file, since it's just
> composed for you and 3 other people now? I mean, "officially" speaking,
> it should be enough to send a patch for the 4 maintainers with no list
> in CC, and that's bad for achieving purposes. What list should be the
> best, fsdevel? Lkml?
>

Makes sense

>
> >
> > No worries! Whatever the case, there's always -stable updates. :)
>
> Heheh you're right! But for something like this (pstore/dmesg
> compression broke for the most backends), I'd be glad if we could fix it
> before the release.

Yeah better to revert - this was not a critical change anyway. But I
think the tweak above should fix things (it works for me here)
