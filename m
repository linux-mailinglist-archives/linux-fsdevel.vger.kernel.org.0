Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0C634920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiKVVXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 16:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiKVVXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:23:22 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF2723BD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 13:23:21 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p141so11907393iod.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=io661+dNfxoEO20qUW/6J+6nYl2fudHXUp0XJ6CzRak=;
        b=rcn5Ssf6R9mCT4CzmKOXenY+pbjaS92fqt2NvtqqkmlAadHSvRkAMAYdSrfUfIwK5/
         vvFdgrWUY/TpsHqBTVKNHJgbrtVOqGVhEsrW202OSXK0WzyfFil/cA7+XwW7MO5F57CP
         b0SopjqTUfk16jHO7iUpcUOyy5+k3AFma6MGzbjbNuJ7UJ1/UrQpi6dO/J2dHCrLOr+V
         cOA1GbZ+WjVAMBeKONYIaL1nzqGJ+HFoGjlixnLpeo05BVGBnfI8tTzIWCugDwDv+xWW
         gCM/OeN4tP0JUbqUwD7K7yBbDnrOu5Kt7ZhHoT3JtRZcx92Clbcnamf6wgiC8DaGMlnE
         rHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=io661+dNfxoEO20qUW/6J+6nYl2fudHXUp0XJ6CzRak=;
        b=ebffzTBl9iI2we8p8JtNm1+QKa2pJpS1E/SqPvWGBymwTWEh/RdearPEqV7Hpaf86X
         4p5iKSd8kCrA3cEQFqgt3RD8tvEPQst912oDa0qY7zCJsvuKAJK0mdKCdVn379Cte+gZ
         oA6yS18zcY3c/vU5W7I26vFGdcgMgZaFRnXv2j5SL1AN8o7zz5NpxkFw6SATZWWZAcvu
         FCm5buBFlN3TuPmSQYvVj07AlA23lBwEZOv/Ku3SLNigcQnAK2Z83nmPvxPHIli6oeew
         qpxLb20AMzZVbzNZM1nQRmj8NHf8j80VE8mNAkBzCGMytWid8KQNPpgUM03ucMmgpbC0
         n1HA==
X-Gm-Message-State: ANoB5pm+WSk/HWNNiytcTq04T+SqWEzqi1d/u8LHfMAN/XFAnDicGQRT
        w33UiuwHG6JAsAsuSjrQfS6Kdf0iVRbmIsDfMmQgVACLD0w=
X-Google-Smtp-Source: AA0mqf6j27rtk5QqfpU1n2G7f0HKRuEXryQzebEWQwgQKaNiSIdYcrTiMD+WuvwIC+GwzdJAlIKU/J1aJVvLyUVGoyQ=
X-Received: by 2002:a02:7115:0:b0:36f:a831:4497 with SMTP id
 n21-20020a027115000000b0036fa8314497mr11958860jac.209.1669152201047; Tue, 22
 Nov 2022 13:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20221122021536.1629178-1-drosen@google.com> <20221122021536.1629178-5-drosen@google.com>
 <CAOQ4uxiVqR_HxCytweO_uKR=gdRHTjGG9SgHaNTFb1+5b6ucGQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiVqR_HxCytweO_uKR=gdRHTjGG9SgHaNTFb1+5b6ucGQ@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 22 Nov 2022 13:23:09 -0800
Message-ID: <CA+PiJmR4rtSHveW_wntt5X2g6zOwarSg3mseRUyo9mSD8ZfyRg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/21] fuse: Add fuse-bpf, a stacked fs extension
 for FUSE
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Nov 22, 2022 at 2:19 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> I hope there is a better way than this macro...
> Haven't studied the patches enough to be able to suggest one.
>
> Thanks,
> Amir.

I'm certainly open to suggestions there. Currently the main thing
stopping us from moving away from that macro are the four
functions/var args we pass in. We've thought about alternatives there,
but we haven't found one we like so far. Since we've refactored all
the uses of the macro into function calls, we can avoid most of it
now. The ugliest bit would be moving the var args into a struct and
passing it in as a void*. Then we could have all the function
signatures match and pass them as function pointers. The remaining
things we use the macro for could either be pushed into the struct, or
extra boilerplate around the function call.
