Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68019596342
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiHPTj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbiHPTjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:39:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D556FA10
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:39:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so20833681ejc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eXUe1BR8Hzx0AlRA4j5CpVPQMTfvDQtF6ML2yHdSAeY=;
        b=rMOmYOZth9TGM6U9CFCVe2uEHgHLhSuKgacv0A6uzAojEQ4P/bQ8XDpipAheGmbVMq
         iVgttWfO8wGiEAZH/VfCvqW5m6RqZ96PdhdVMRgtCd3U4doFDcJ6e3BpHq7mSE2AYtEB
         1ogpT76XO0Ed+zAjOtIYinnooim4uhUJKE1Q7+Weh3VnYgyvosI7T6+rFciOU2EGHWCO
         W3w7ngg7yOIxhDlvOEcws/0RAT7Y2H4Bs1dCN6Mvv3Wn+I7z6kY0ci5TUIZJUL9jueLz
         Mv853rS1rCwGicV+237WKJmoeM8YMjDmb6/1CX6Mv2V8pKv74wJ/4Tk4kd5He7mMnI/x
         FNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eXUe1BR8Hzx0AlRA4j5CpVPQMTfvDQtF6ML2yHdSAeY=;
        b=ju59sEGYknuGYuRDNWwi1caRYwQggn/oBlJF7jezam1QAAqbp61zwVicuKCWhH3OH7
         +Cc8QA290p3LuB/azVBKdn1CJUQ5W8UuGPv4g3IME3IM/fdj0wT2yGBIq88RLWlhqNjN
         w1AFSEWo+FawV5IHV1fFu6xV+DcEcDjflntbrEQkMj0Tg/sQrXWkg1gY+G2Q/5DeKkkV
         n+NpTDE/HZkDqp/ZhNVnp44kbNM0SSMeMUtMp1Rlmi1UszIyUNkwyvWu0naNgDW7A1cF
         daSUh/sbv3kP/Ti90gjKxFLg5kOSN/rmW+nhzzbkjrO8web7U5d00G32f3glMceVzeoX
         9nrA==
X-Gm-Message-State: ACgBeo1eW3helgGKT3R/mymnCIDu3fgOHJ/MZNy9/TrUaYesQ9Zi7dt9
        Uq2e8whw/70VCwA7yJ7DzuxM8HRBgnw+NtmEYLYG+A==
X-Google-Smtp-Source: AA6agR4mgTRNv+qUiCgrq4Ja1fqwFU7qU+XNa2wihjDKL4vHouD+3kpv8h1DZQapKvmYLeYuftltsKJ3ZtBDQwfk7t8=
X-Received: by 2002:a17:906:228a:b0:731:3a33:326 with SMTP id
 p10-20020a170906228a00b007313a330326mr14235549eja.253.1660678791658; Tue, 16
 Aug 2022 12:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
 <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Aug 2022 01:09:40 +0530
Message-ID: <CA+G9fYuLvTmVbyEpU3vrw58QaWfN=Eg8VdrdRei_jmu2Y2OzOg@mail.gmail.com>
Subject: Re: [next] arm64: kernel BUG at fs/inode.c:622 - Internal error: Oops
 - BUG: 0 - pc : clear_inode
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 17 Aug 2022 at 00:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 16, 2022 at 12:00 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Following kernel BUG found while booting arm64 Qcom dragonboard 410c with
> > Linux next-20220816 kernel Image.
>
> What kind of environment is this?
>
> Havign that inode list corruption makes it smell a *bit* like the
> crazy memory corruption that we saw with the google cloud instances,
> but that would only happen wif you actually use VIRTIO for your
> environment?

This is a physical hardware db410c device.
Following VIRTIO configs enabled.

CONFIG_BLK_MQ_VIRTIO=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_VIRTIO_BLK=y
CONFIG_SCSI_VIRTIO=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
CONFIG_CRYPTO_DEV_VIRTIO=y


>
> Do you see the same issue with plain v6.0-rc1?

Nope. I do not notice reported BUG on v6.0-rc1.

- Naresh
