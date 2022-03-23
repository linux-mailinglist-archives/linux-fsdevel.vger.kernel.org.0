Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2B4E53CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiCWOCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiCWOCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:02:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29A76E0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:00:42 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so1126590oti.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu51fP67kdYj15xOoVUTxBLYAZiS00kUydPDhNF2vMA=;
        b=kux+HHx44G/nwv5HPB+s1IgURRutyiFbZKVe+7+FkMR1cBLkzsNdHZcOwdH9Ky3r2C
         yjDRGrJqrfxrv7hxHqlMaGcXpmaYimyf0/7lQWOS+TmS47+1N5b9S0ZwRJvzu7guNY2v
         oEPSI2mTn4xHB2RY9xRksFZg6lURmvSoOIf7rTMCIPD+GzRLrhDkx44l4ucDaCWxDLD4
         Y/vWevxXVeW/EPfUdQHTsOow+ODAFF5adXq6Ve1e9aIFKhIOd571kh+n0HXL2nHIVV0n
         REW6/WZwPVNE1PnndS7cJEfKB1SwsrBXmb+8XvvmAV+0ExEB0yfE8xLK3443SQVrgmbf
         tYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu51fP67kdYj15xOoVUTxBLYAZiS00kUydPDhNF2vMA=;
        b=3Cb/i3JVWyuM8z3yL5QnHOu3ewM0uCl7VUMUSSK/RkTk6f8UyLEt150uzMbMKH+K5Z
         2/5+RnTF/qGWKR5DSPtlf/SF92OqZUa+GTIxQRITMlBQ4Pk8VJuqrE2RoIw6i5rte70A
         CXDiOYudSBe437uxIw0nd6h/Kzd3bkoN7Bu9Ec3AKPOnE6E5iMXN10QpKSKwHJVjmW6J
         EbUwMkCJ6vZq7By1e00lu1ch8Yer78PYd9bX5qMBUzzhOV+WaRG1mG0N5DMdrymJTSAd
         G++w+dJeQUOe9XSObds4i2lgojw7Y0b6vAdoZPqy4OD5cRcTUsufYB+vmmtzDpaI4DHi
         hp+Q==
X-Gm-Message-State: AOAM531Url1NSKqE9+eFrE2r+GyAuy9pJVGlvMjjmf7E0iJGJBbHGaZM
        oTLuwj5+YuBny9yv6bfKUrYi6N+qP4pIRr9n9ZM=
X-Google-Smtp-Source: ABdhPJxRzuW/s7H91TImOhK5lh7wIgkn/tmRp4MMAMNJphfkj1KTin8lQZFNRpiGUUwT+E6fqJ6j2Gkdno1EESGYhvQ=
X-Received: by 2002:a05:6830:40a9:b0:5c9:4a8d:ab1f with SMTP id
 x41-20020a05683040a900b005c94a8dab1fmr12200981ott.288.1648044041741; Wed, 23
 Mar 2022 07:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220319001635.4097742-1-khazhy@google.com> <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan> <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan> <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan> <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan>
In-Reply-To: <20220323134851.px6s4i6iiaj4zlju@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 16:00:30 +0200
Message-ID: <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Well, but reclaim from kswapd is always the main and preferred source of
> memory reclaim. And we will kick kswapd to do work if we are running out of
> memory. Doing direct filesystem slab reclaim from mark allocation is useful
> only to throttle possibly aggressive mark allocations to the speed of
> reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
> big issue but I certainly won't stop you from implementing more fine
> grained GFP mode selection and lockdep annotations if you want to go that
> way :).

Well it was just two lines of code to annotate the fanotify mutex as its own
class, so I just did that:

https://github.com/amir73il/linux/commit/7b4b6e2c0bd1942cd130e9202c4b187a8fb468c6

Thanks,
Amir.
