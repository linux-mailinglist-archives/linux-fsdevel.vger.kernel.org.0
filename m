Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA460EDAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 03:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiJ0B6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 21:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0B6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:58:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB49FC696C;
        Wed, 26 Oct 2022 18:58:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d6so32633878lfs.10;
        Wed, 26 Oct 2022 18:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YUBvSu1EPKGGj8YAJE8gLQSl9rqE7fM4DdBH8Q7Bw7Q=;
        b=pvME4I84cn1XJQ5p6l7SJJEf0uPYiW83t0IVH3kbWOaz+gAexqa0X2WCk1mZ5oNHTU
         cyO5/zGi7j5s1E6md6jKVkpQRjibwxztTjUwJsgmjyPSeLAa/IphID+dr18V+KbR7ykT
         JvWKxHSktlxo438oZAGWcvskgMpHH6LsTZJq7sHBzI1xMQ1SZSkrLKamHTdE0oj842yW
         nRZW+ZZwquawCZ6fVJf/UJSuFaJJ36q65HXr3DZ9YumGFM43dHvmbB7V7SWmNiwD/dtj
         E4kwKXHH51zCqQcX+7di78JU2eB+P7ijAP/uXdvd/MoA27jukTaQaCU563bvyVajF04R
         jwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUBvSu1EPKGGj8YAJE8gLQSl9rqE7fM4DdBH8Q7Bw7Q=;
        b=V3PJEtRbcyoYioGbT0YiABA9S0/WRzfRy2OkUGKE8hl9vyG5TdivQGSAOcojvJcjv1
         k9o+8pW8LrWj8pQNGwgvbjoTRvDrQyJdT7BXHUEUBj90mkqfmFekHzCRtk25x8BEYpwr
         YkHCh493nT/G7Mjj+kNV+UKulkvxnvV6vz943u0iSYgm9bpbypNsYT2VKylN4mj5eXqn
         l4REExaJa7gQnGd2u4Jw8EWqnvamk/NAHIBH+CWdwRqR6ytaORAdWfxY1WBI7NL1ez4l
         1l68LBvOClXZFsNXFxPwmP5azoe109haKtDlcGhbulpRAosW3Swc7Dx7g11maM+V7uMl
         G87Q==
X-Gm-Message-State: ACrzQf3eThwn+NbSV7/DoUYiXKLZvJL6cxk7bBSxjJabnuX6iyEFazru
        Qzof7fYUGcrZsEj7RGquAq9iV+cXFuve6dcovXYeqgpX
X-Google-Smtp-Source: AMsMyM6MFLtSG/ts72VF60PMQt/hu/SbxM21N/wzV+hea1yL8LYpVM7gYMOxEJ6T8V4MaKVqB0HaLr0jHkVmWbfr85Y=
X-Received: by 2002:a19:660a:0:b0:4aa:9a70:bcca with SMTP id
 a10-20020a19660a000000b004aa9a70bccamr7654347lfc.520.1666835901152; Wed, 26
 Oct 2022 18:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org> <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org> <20221018223042.GJ2703033@dread.disaster.area>
 <20221019011636.GM2703033@dread.disaster.area> <20221019044734.GN2703033@dread.disaster.area>
 <CAGWkznEGMg293S7jOmZ7G-UhEBg6rQZhTd6ffhjoDgoFGvhFNw@mail.gmail.com> <Y1mPPq6mc/C7pNhM@casper.infradead.org>
In-Reply-To: <Y1mPPq6mc/C7pNhM@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 27 Oct 2022 09:57:52 +0800
Message-ID: <CAGWkznFknrZZok96EvR72UUZq3Tjb-tKvezU4GwK4D2uc0K+kA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
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

On Thu, Oct 27, 2022 at 3:49 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 19, 2022 at 01:48:37PM +0800, Zhaoyang Huang wrote:
> > hint from my side. The original problem I raised is under v5.15 where
> > there is no folio yet.
>
> I really wish you'd stop dropping hints and give all of the information
> you have so I can try to figure this out withouot sending individual
> emails for every little piece.
>
> Do you have CONFIG_READ_ONLY_THP_FOR_FS=y in your .config?
No, it is not configured. f2fs only use 4KB pages and blocks
>
