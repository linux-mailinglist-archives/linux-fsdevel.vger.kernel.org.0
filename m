Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8350E1E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 15:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiDYNgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiDYNgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:36:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202EB91
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:05 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d14so10262943qtw.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JjYBRwrs4ra0cXm7mmj7eBLfaoNO+znwmOBO09Sc1g=;
        b=OTlk+WlmyAPwKLdEq6F+b8MlQyx3rBiv2ZX7tZa2EE3pqO+ot3vmXhGQFYRxvKCGS1
         VKKZ5IjhJv00SEkQCNGwTuV/8kME1CARjA/wJEliaCVZ8HPBBeA3n8XmxxxQlmDYqZ3Y
         LCVuvx0f1dZjx4xwzSBlx98BmDEWMjb9LLba8X7Jz3Rx4XAh3yG1e65Nv0Lhg1EJVU7j
         Mwr8GBYIJHd4+xNnH5PnFGvg4ZO9Hitk7dyoO4QLOtrUd0wfw1kZ0g/zE2T/mfdjKCnJ
         Cu8ewpfTw+fqdXnWDOHWxYacM/ZDDQCKlUGyZYvd6HA/GH81f/dLxk+LXOU0ls7+6cwE
         2gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JjYBRwrs4ra0cXm7mmj7eBLfaoNO+znwmOBO09Sc1g=;
        b=mEEj8iBKiZJV90zW49ztJGlTg9ol/XGx5GTXsqaLLtno9tRqSIeWjVO3erUgHwN/9q
         +3qptHfyHJXqaTozhPYWfmLQEKeBNvAojcYOW6O4m/bwb3yz0v4D1pt15MF64BQnxCL2
         nQGseSIZu19fWjDif36aVutFNwOa18WbvLfL71YYEomq4NMSrx3cbWCBkg0IOzjl5LDh
         009d6m8oAS4VcW01bbboBL3wiWY26QhD2vsBTVDX0eY/nG8nOgSl3gXbU8dHB/PTa2IN
         oLN/ld6PRIdZkYHFfSoq2Du+jPPDToGdMfnHUmabsjZcX0y2nTN2zhXSH0OIBWYQidI8
         dNbg==
X-Gm-Message-State: AOAM5305EkIfrlXUjILhITZYb2ytQhxLCW0aBQCFj9X3/VKiQJVu6eYJ
        bO2MMYPpR2cKn2gH4aOAQSoQZkrygCKnzm7iB90bhxlP5pH3wQ==
X-Google-Smtp-Source: ABdhPJyXnvDyLDJ+nCb6eDrPCUqfTnCPAluNrmQuJ6ssUt7QR0b2Xm+73yECHdOuPTy1Ddx4s5wGKYEM08otjcHZIUg=
X-Received: by 2002:a05:622a:c3:b0:2f3:66ce:251d with SMTP id
 p3-20020a05622a00c300b002f366ce251dmr3723435qtw.157.1650893585131; Mon, 25
 Apr 2022 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120327.3459282-1-amir73il@gmail.com> <20220425125924.qd7qfgjsvgbj7qyg@quack3.lan>
In-Reply-To: <20220425125924.qd7qfgjsvgbj7qyg@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Apr 2022 16:32:53 +0300
Message-ID: <CAOQ4uxgiQ4zTmt6EwLnNrdV7EAvcgM3FfURgeGkZdv-bgG6b5A@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] Evictable fanotify marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
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

On Mon, Apr 25, 2022 at 3:59 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Fri 22-04-22 15:03:11, Amir Goldstein wrote:
> > Following v4 patch set addresses your review comments on v3 [3].
> >
> > I allowed myself to take the clean you requested for
> > fanotify_mark_update_flags() and recalc argument a bit further.
> > I hope you will like the result.
>
> The result looks good. I've merged the patches to my tree.

Sorry I forgot to update the outdated proxy refcount comment.
Thanks for catching this!

Amir.
