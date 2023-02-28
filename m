Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630FD6A5038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 01:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB1Ao1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 19:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB1Ao0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:44:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65AF1E2A8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 16:44:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee7so33402796edb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677545064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VmmBrX2p1inGbF8ku+z06Eh1CWxuqZx/wcts3IMRaQ=;
        b=JPbT/JW7R7IuAPmpByrn1qMuS6U+Vk/gyFK56mN4IR0SGz3O+fVGM/OeyV3tbiwvZF
         hekWwKM00q9t7VTsqEVSGNwXfdAFyGac9py5IvNAl7dsE0kVpdNiX62HZF43R/LuYnpb
         8Z2H/bsir3IkfbXxqDcN5Reh+7zPqnLG6hh+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677545064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VmmBrX2p1inGbF8ku+z06Eh1CWxuqZx/wcts3IMRaQ=;
        b=PuxoQBEVcxbbZwR3PqM36mf/EGCUoZ9nkAPHfahO6zvKyrUcUR774F2wRw8B/Qpr+b
         3tsGW9thZKC12+wv0hV5+/7G7L18z6Qw9Kww9cVNSAipFedmPmfz0jfEifYP6QhXXc8+
         3nSAk7fGYEr9IyTRbPO4+LpJ+clvfeGEXqLvxv+LzfimboE07LXnHngAtarh6y4lYIy4
         d9TQbxMVpQ4iv3Du+y9gpI5f9RJiKW9U72mopI+DSkEmnBjkdGXXSaHuXXw5rvssUIeg
         1nR0lNep8ywmFKuladwka3eUe0eCxYJNqwB3a/U1J62QJYbS/xHwmtfdGNR2JlxCEe6W
         wvtw==
X-Gm-Message-State: AO0yUKX6PsJHx5sd9gyqLW3+KuXbg9Pen36t21nDYEJJ5+m8AbRxXlyz
        4hsU106bkGmZ9uLxPTBRXidFDqaexaS0HqBVEsc=
X-Google-Smtp-Source: AK7set8G0t3BlXQeRx8BticVCVc4+WNECaTsqY5RMY8X6P2IXy0EVn1Bqd6wAggYFhhZhsGKcD7oPA==
X-Received: by 2002:aa7:d4ce:0:b0:4ad:738a:a5db with SMTP id t14-20020aa7d4ce000000b004ad738aa5dbmr1639941edr.0.1677545063928;
        Mon, 27 Feb 2023 16:44:23 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id sb11-20020a170906edcb00b008d2d2990c9fsm3864183ejb.93.2023.02.27.16.44.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:44:23 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id i34so33276192eda.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 16:44:23 -0800 (PST)
X-Received: by 2002:a50:bb41:0:b0:4ac:b616:4ba9 with SMTP id
 y59-20020a50bb41000000b004acb6164ba9mr736894ede.5.1677545062838; Mon, 27 Feb
 2023 16:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
In-Reply-To: <20230125155557.37816-2-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 16:44:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
Message-ID: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 7:56=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Turns out for typical consumers the resulting creds would be identical
> and this can be checked upfront, avoiding the hard work.

I've applied this v3 of the two patches.

Normally it would go through Al, but he's clearly been under the
weather and is drowning in email. Besides, I'm comfortable with this
particular set of patches anyway as I was involved in the previous
round of access() overhead avoidance with the whole RCU grace period
thing.

So I think we're all better off having Al look at any iov_iter issues.

Anybody holler if there are issues,

             Linus
