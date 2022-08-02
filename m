Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0258814A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiHBRqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiHBRq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:46:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EABF44;
        Tue,  2 Aug 2022 10:46:28 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z132so11229406iof.0;
        Tue, 02 Aug 2022 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjAZA+RBJyFCRVs3/+3jiKse67/26F8E/TlaG4k7TyI=;
        b=G1ZC9vkFJ4/eIUWgdyFRStYtBBwbb1Zif38+6Kd6XjFeJpq0EDYF5HEYZANxccxOAb
         HmDVHGEm41eETriohYDDkKfsfhiS1kgVPFbEY4rtweJ1QJ1w8sFeRIN71ItWO6BPmvwR
         8ySNPXjJA7WIgGsGRmXgKwdyXVub6MJulx221Nk9d5iPBQyqj6nT41qN3sjBcMtODkzh
         YVggKsNuk881EIvL8fVF0dABkRzDdp+uzsz7L1RfHwhrgeGxg09GhCRL77vLtcefM4Z1
         g8BDmDPc0IdBGSMtP/pcTI7F8/Li326UqJekszusX2sd2U1KdEOWLdx+003Nps6DRXrj
         M3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjAZA+RBJyFCRVs3/+3jiKse67/26F8E/TlaG4k7TyI=;
        b=60seINrQDXCdijBLG5HC52XF1E2xB/G9/Z6SBaEfaRC1Q4NsklXq+yxUtyOXXA9GC6
         Fyod7MiNhgLD5TZiupDhglBhmi48p0+6spTHDVYvnqVSpNrms/wa0MaMdI9B2EBKNU6M
         N8GmT79dk9084i2Xss+bDNzfzN+12PYq0vHBjUQ5tZ6DPTl5kuxAMrJohjE8uOMsc67q
         W+JG8vyH1XQWhjd7zfGaXsLejMC/U3bV0RTAl+fhT8DW8G6KcwCwtJLwxq3QBveF8Xs3
         lB/IYiO8Rh3CMfHBBQnI5COUeTAoSsZ7h6x2IqLe+zG5aqCTWa3iJ1gcBc8LOP/XN8CL
         tO8Q==
X-Gm-Message-State: AJIora8nPtNAL0sNkUSWJ/DNhbKBPUg2JcHuaVJLQ1JhFtm19vvrHcYB
        sj+mHmWNcOWigORMDxd7UgMe4xNdmDfaJDaonko=
X-Google-Smtp-Source: AGRyM1sTchBu9DJxxSaHL1GJ3B7rxsIGwFJokjusWYxkrpam9ZondCiC/NMBhmRLcxl3wlnfbZ37BaFnTFAFjGKVsvA=
X-Received: by 2002:a05:6638:25cb:b0:341:6546:1534 with SMTP id
 u11-20020a05663825cb00b0034165461534mr8585003jat.308.1659462388257; Tue, 02
 Aug 2022 10:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <YukYByl76DKqa+iD@casper.infradead.org>
 <CANiq72k7JKqq5-8Nqf3Q2r2t_sAffC8g86A+v8yBc=W-1--_Tg@mail.gmail.com>
 <YukuUtuXm/xPUuoP@casper.infradead.org> <CANiq72kgwssTSE7F+4xkRrXBGVgHeWxCyjeZ-NHLUXWnFjMyTg@mail.gmail.com>
In-Reply-To: <CANiq72kgwssTSE7F+4xkRrXBGVgHeWxCyjeZ-NHLUXWnFjMyTg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 19:46:17 +0200
Message-ID: <CANiq72=551t+CeiuCZz-SSx+uDaz238xjDFMRmkTwRuSFNcqmw@mail.gmail.com>
Subject: Re: [PATCH v8 00/31] Rust support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 2, 2022 at 5:09 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yeah, patch 17, exactly (patch 11 is the `alloc` import). I have asked
> Konstantin privately about them.

The patches are showing up now in lore -- not sure if it was just a
delay (which would be consistent with the lack of bounce) or somebody
did something (thank you if so!).

Cheers,
Miguel
