Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C06029E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJRLLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 07:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJRLLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:11:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36377A571F
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 04:11:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a29so21976084lfo.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsmuVvzUGL/tIXDCMMq9mrTS5g/NHatso0iO2PBAdX8=;
        b=hWb9clTWPGU/bF/813AdOTEHipmOUGOlMr2CwDFf3xzqyrXgR/WYXA9gGn2hPgOcWk
         ak4xBbJGG0+EERjIzkWEKFhN6wbpA/RyaosLmxDmfeNFO4te7aoM8V+Vr7g/0g9Mxcia
         bwg4aDc1NuUpXhRtLOHi+OR4aD9ZF4iKQyO6Oy6oOCeLvZd69ykxCxfZqXoTHTgCqrW+
         1KseqYoX7CaDuHWaCRII+oWowWc6dzInR8yfBBRNLUlvNpaq0FXbcMUFix9NfAqr8S2+
         /yBarw4tOK+F1Y7yOz29uRPbK4KJyhjGlV9iMnaSraIvkvFKYW/2tWp8wOlDH/+TTyhk
         rbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsmuVvzUGL/tIXDCMMq9mrTS5g/NHatso0iO2PBAdX8=;
        b=e0xS51+XC7+7jC2GHGSrSM5JH8K11NqaLjiFYlU7VZjQqXQERXazEx/Yw4JGgH07jX
         P1yRHmB3e3inEpuNr04FvYNQsEP/o7afjLCAddXWoOeX0CjxDPXYuwJDtV+c410P2MAZ
         6gnfpvIqFkpdxUpEqoUK4TLN9Opse7z4AVaxK653Nb9D/0IMhvlKilOCbLdeEDBFRlqi
         1MaeE6pqYRLoBhOyhRx252rTfM4tgqRaEyJJqoegzWIOrErO98c8fOkpt7a2yt+x7z+M
         4JbZiRB4WYPUblXTIUL3fHWQ1KspUgg3C/lWC910jJKlZGo8RZsxknT3EJX8V3TCQI0Q
         s1tQ==
X-Gm-Message-State: ACrzQf0vsz1WPHHRqhGtqJ8H3VCzd8pXH0XclAlcxSEr5OwuihBoQHll
        fHOpo7yyABnh5mS8F1DLFPTXOwIQmlaMIcacDkYrTQ==
X-Google-Smtp-Source: AMsMyM5zbA7ZF2jb5PoA/bKYc2t4oy6VFFv73a9+vbUT3G6aSSPbo59D9h1fv/pw7uv73bg6BtTdL1xm1wa4gqam5/w=
X-Received: by 2002:ac2:5445:0:b0:4a4:3c5c:f73 with SMTP id
 d5-20020ac25445000000b004a43c5c0f73mr778245lfn.21.1666091496376; Tue, 18 Oct
 2022 04:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <Y0T2l3HaH2MU8M9m@gmail.com> <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
In-Reply-To: <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 18 Oct 2022 13:11:25 +0200
Message-ID: <CABb0KFGCm=K2X3-O=y3BJN85sT2C-y+XZRtLxnuabuOg+OrHwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Danylo Mocherniuk <mdanylo@google.com>, avagin@gmail.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, corbet@lwn.net, david@redhat.com,
        kernel@collabora.com, krisman@collabora.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peter.enderborg@sony.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, figiel@google.com,
        kyurtsever@google.com, Paul Gofman <pgofman@codeweavers.com>,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Oct 2022 at 12:36, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> I've included the masks which the CRIU developers have specified.
> max_out_page is another new optional variable which is needed to
> terminate the operation without visiting all the pages after finding the
> max_out_page number of desired pages. There is no way to terminate the
> operation without this variable.
>
> How does the interface looks now? Please comment.
>
> /* PAGEMAP IOCTL */
> #define PAGEMAP_GET             _IOWR('f', 16, struct pagemap_sd_args)
> #define PAGEMAP_CLEAR           _IOWR('f', 17, struct pagemap_sd_args)
> #define PAGEMAP_GET_AND_CLEAR   _IOWR('f', 18, struct pagemap_sd_args)

Why are three IOCTLs needed? Could CLEAR be a flag (like the
PAGEMAP_NO_REUSED_REGIONS) or 'cmask' and GET be implied when vec !=3D
NULL?

> /* Bits are set in the bitmap of the page_region and masks in
> pagemap_sd_args */
> #define PAGE_IS_SD      1 << 0
> #define PAGE_IS_FILE    1 << 1
> #define PAGE_IS_PRESENT 1 << 2
> #define PAGE_IS_SWAPED  1 << 3
>
> /**
>   * struct page_region - Page region with bitmap flags
>   * @start:     Start of the region
>   * @len:       Length of the region
>   * bitmap:     Bits sets for the region
>   */
> struct page_region {
>         __u64 start;
>         __u64 len;
>         __u64 bitmap;
> };

Could you explain what units start and len are using? Are they bytes
or pages (what size)?

> /**
>   * struct pagemap_sd_args - Soft-dirty IOCTL argument

Nit: it's not soft-dirty-specific anymore. Maybe "pagemap_scan_args"?

>   * @start:             Starting address
>   * @len:               Length of the region
>   * @vec:               Output page_region struct array
>   * @vec_len:           Length of the page_region struct array
>   * @max_out_page:      Optional max output pages (It must be less than
> vec_len if specified)

Why is it required to be less than vec_len? vec_len effectively
specifies max number of ranges to find, and this new additional field
counts pages, I suppose?
BTW, if we count pages, then what size of them? Maybe using bytes
(matching start/len fields) would be more consistent?

>   * @flags:             Special flags for the IOCTL
>   * @rmask:             Special flags for the IOCTL
>   * @amask:             Special flags for the IOCTL
>   * @emask:             Special flags for the IOCTL
>   * @__reserved:                Reserved member to preserve data alignmen=
t. Must be 0.
>   */
> struct pagemap_sd_args {
>         __u64 __user start;
>         __u64 len;
>         __u64 __user vec; // page_region
>         __u64 vec_len;    // sizeof(page_region)
>         __u32 flags;      // special flags
>         __u32 rmask;
>         __u32 amask;
>         __u32 emask;
>         __u32 max_out_page;
>         __u32 __reserved;
> };
>
> /* Special flags */
> #define PAGEMAP_NO_REUSED_REGIONS       0x1

What does this flag do?

Best Regards
Micha=C5=82 Miros=C5=82aw
