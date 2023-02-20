Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8569D0F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 16:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBTPwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBTPv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:51:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D71F4A3;
        Mon, 20 Feb 2023 07:51:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f13so5871309edz.6;
        Mon, 20 Feb 2023 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VX7Z+JP49ki/XXHixCSnbMxO12bCgio5c7tDpMpJXlA=;
        b=C15M/w+AeA4//jFmq5jOVvzu4aK1JsRH9tXCy2rvNK9bIf2GpjlBdLYGdXbWfMpz5H
         245rhGmHPEXdY2u45sXmMiqH+0117zWtCV6uSo0rjWmifwCJAwot6MMq86jZascP6po2
         UBOI4AIUfsiQJq1We50L0HuNKyCnfwOJEVRGFIqXMAJt2rthxxwdAn/ZemBY8QQ5GQoC
         YJUW0R746GuMesXwQxaHnrc1Fsgg3KxEIlSYZoMT6v7VUlVjTSmhPrQszhnut2S7fZKG
         rSInIGapD5e6jsqvvi6EUZAHIefyY6cQj8XmDqF0FTVwbFXuDPQytb7Y91O3sHIn8Jq7
         wURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX7Z+JP49ki/XXHixCSnbMxO12bCgio5c7tDpMpJXlA=;
        b=wILp9DgCWcgZUM693KtIiIVxig6tP3n6Y1N/5e3j5ZBBvIQi8sCuDN2sGnK/5MLsr+
         67bo8gOF6EDICQqZeEkjeaSBQBjnR+kZsyRlkssWpYI/87vwOJemyvLrDeujwNI42DDI
         ouBuPV2WcGtUoMdmEL0RkeQpPbWulfGKHP517LUZypKQ7rELKJUwaXY39TXaOCUPEJmE
         JcmzWpEVPAk0m5OyeI0F/kRBzUFLGJKhLQxIdIR3ar1eeaj9wXDzaBV+yBbbkKYQgEeW
         PEkgALqL3hCxvFzy6zBxQSMoZGlJs4Zxv895Mk0Uodo8ZxYewX+gZ7QWauLNpse7ILEq
         soYw==
X-Gm-Message-State: AO0yUKXuUw3Ugf1gCOv2G3SXhN238iheSkARC/Y5eyet8GZsCcogrXnj
        hGhRRdkApZg0/ojEhaLmp8XzzV6yPnO972N1sR+cFMRfBKg=
X-Google-Smtp-Source: AK7set9pfuIpHEFs+WKrMdBCAIcfyiQu/VMrOUgeuD0+o+kCYP8zsAHNxlMRmsLh5U5+5QRrx/Q2wWc7AgNdBwlxovA=
X-Received: by 2002:a17:907:7b8a:b0:8af:2ad8:3453 with SMTP id
 ne10-20020a1709077b8a00b008af2ad83453mr4130159ejc.6.1676908312570; Mon, 20
 Feb 2023 07:51:52 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMwWuh2Qtiq+qQBjU1Qpb-qaphob=YoaoNWS2W_GQui_5A@mail.gmail.com>
In-Reply-To: <CAKXUXMwWuh2Qtiq+qQBjU1Qpb-qaphob=YoaoNWS2W_GQui_5A@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 20 Feb 2023 16:51:41 +0100
Message-ID: <CAKXUXMxdPvR4g1J91KOSvReLsW6NBJAg7WT3z5rER4u36J4ang@mail.gmail.com>
Subject: Re: Still a QNX6 filesystem maintainer?
To:     Kai Bankett <chaosman@ontika.net>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Mon, Feb 20, 2023 at 4:42 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Dear Kai,
>
> in the course of clean-up of "lost documentation" in the kernel, I
> intend to remove the file ./fs/qnx6/README in the repository and
> replace it by a section in the CREDITS and MAINTAINERS file, just as
> done with all other contributions to the kernel.
>
> Given that the email address has not been used since around 2012 and
> the time the filesystem was initially submitted, it might be likely
> that this email does not exist anymore.
>
> So, this email is just a quick check if there is still somebody
> responding or not.
>
> If no one responds, I would mark the QNX6 FILESYSTEM as Orphaned. If
> you do respond, I would simply submit a section with you as a
> maintainer.
>
>

Okay, after my email server quickly responded. I could then actually
find out that even the server for ontika.net does not seem to be there
anymore.

The command 'nslookup ontika.net' told me:
** server can't find ontika.net: NXDOMAIN

I assume the email address is dead by now and this filesystem is
orphaned. A patch is to follow.

Lukas
