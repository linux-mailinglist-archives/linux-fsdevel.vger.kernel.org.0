Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5275651C628
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382721AbiEERiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382712AbiEERh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 13:37:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CC54FB2;
        Thu,  5 May 2022 10:34:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x9so3691897qts.6;
        Thu, 05 May 2022 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KUqQF1hYwLVbFgt0lUUk/atcIlDD76wICPoFxoA1sk=;
        b=fmVzt12UYi3gO1EmHrkXXLuqKTTb1ONpD6CjZXnHDx/+PI0UP23KcnMH796cgm1TgC
         PalvAa6gvkldEikr9RpUPKLFvCx7gUDHLc1VrhSfzdbUBrTqFxYV55HhKnZJbwXTe3Hd
         cedB4Q0BHJk8CKnB3H8UWaQ7P81WT/OK9/lo/Hh+17p+yh12pbebeZGHQ9MhL0yORmqf
         0p9Sy8bQbRl0FaJtaXd507TO0ugYAvYJ08NAUM6zKqh0G2F7cilb/Wud8lQggsSbo9ev
         yEh0NNRoY6fvJ6PuKwZuVzVBjJMcvNykLxeS+ia6kFnRSslrD4DzE3IJbQxcc1GfJreb
         /yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KUqQF1hYwLVbFgt0lUUk/atcIlDD76wICPoFxoA1sk=;
        b=N6jhiS7d7DvfdYoyuMnR2gI/kUiyLZvQ7M3MmdqTTurlePgfKtSDVC0OR8fK+luzbx
         B5ZzZ5pgz4E2+FUTrKed8O8GIbarsr6W+o8TFUVmYUzVOX1EjP41YsIz35/xe/ApPXnh
         30f04bhyQzfSgV9J2rMQwtxh1fupjeuBLPMSF21VguseTkJtmtYcMxE1gBHCkReiHKRF
         A52aHVP4/vx/u61oF7/JCwuEgGbYZoErmBuOZpC6gyP+oMC4kE+og87AthP+ttXxDz/h
         h/ylAKQ5CE2PnxDvwUa6GZ2zOsSrAy3C3pum6hKN3+ZCvD/oH3WhIiwpYUnrKhDV2CUb
         2YLA==
X-Gm-Message-State: AOAM533OatgzMH5iiLCKA6CbfrhHTrRc46+9OiQv/gqCYM9elt9Y0kbg
        F4Go9imh7YcOsBEFpJuhhr158TCACOmlXNh5o/a+/J6bVFt5IA==
X-Google-Smtp-Source: ABdhPJylZ0ScI5h5Gjjsg/5c5jIyzmdgEwUGUHa4gdtD1jkOoeduNc4ZcCJIf10BMH/Hk9yGZuowwac78ErigrB8Uzo=
X-Received: by 2002:a05:622a:1052:b0:2f3:c085:6316 with SMTP id
 f18-20020a05622a105200b002f3c0856316mr2476847qte.2.1651772057529; Thu, 05 May
 2022 10:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
 <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com>
 <YnHX74E+COTp7AgY@madcap2.tricolour.ca> <20220505144456.nw6slyqw4pjizl5p@quack3.lan>
In-Reply-To: <20220505144456.nw6slyqw4pjizl5p@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 May 2022 20:34:06 +0300
Message-ID: <CAOQ4uxjkJ37Nzke4YN_se4ztr-yZgm6SK_LhmBQ-ckWutOwWrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fanotify: define struct members to hold response
 decision context
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>
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

> One open question I have is what should the kernel do with 'info_type' in
> response it does not understand (in the future when there are possibly more
> different info types). It could just skip it because this should be just
> additional info for introspection (the only mandatory part is in
> fanotify_response, however it could surprise userspace that passed info is
> just getting ignored. To solve this we would have to somewhere report
> supported info types (maybe in fanotify fdinfo in proc). I guess we'll
> cross that bridge when we get to it.
>
> Amir, what do you think?

Regardless if and how we provide a way to enumerate supported info types,
I would prefer to reject (EINVAL) unknown info types.

We can provide a command FAN_RESPONSE_TEST to write a test response with
FAN_NOFD and some extra info so the program can test if certain info
types are supported.

Thanks,
Amir.
