Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DC6D755B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 09:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbjDEH30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjDEH3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:29:25 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56530C4;
        Wed,  5 Apr 2023 00:29:24 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h27so30674937vsa.1;
        Wed, 05 Apr 2023 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680679763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25HHFCiyLUhnvNMN3ZGEFvQUg+RwTQV/ivTMt6xC9Mg=;
        b=iqCKZDcoYFpA0M+eqC4XRZzZ6WPdE8TtgaPWpTccIw+s7B6t+avQvksnYHpSD/gRsK
         /7l+pDyxGAUSloyhDbseKVfrI1ZE1SXBpS3Hbu9fCfdj4rIil2WgyvfYEUVhcHaRV66w
         FhFVZSslPBXVonWr4d/XOa4As8dMb18EesozRsplMFeD0s4yYy6uvdYcDpyfv0l0U+r3
         TLh6aj4jtblYotDtMEAyBxuBSIl+ddMJcP+VZF2A72fZEi9STDJvuAyhnt8uiMZSJsaA
         W6u6fzNVSOTHJ2lQABwt7klWqyCNijm+pzccndrUq4DQQm+Te2FPNHktr/UU7hAaqJuA
         Dnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25HHFCiyLUhnvNMN3ZGEFvQUg+RwTQV/ivTMt6xC9Mg=;
        b=JHxZirsd+V6SRuZ0oLJSAB7G/WjB+lg3kV8ZtVgsxe2bIrgsj0WMLvZr6/ZKCGoQzD
         hhuYnVPXmXy/ev5pNRcXMBWEQzI+yT+mANIIpf8tCAMWtlhEgxg7Nrjbca2FpMalZAGx
         dsfsMXY52ktNfF1vjehb0YUFll4Z9Z+PnCHnfONc6RvI4WluzByOVvTJRao6oWvQwWjj
         ICw8l8VRIkTvXLsZdd7/NvmOgXrGNfujXzvntiw0w6G4IJE0sTXC7HPK/lvXhoHxQ/0j
         KiH4eu8zudhTs49UsVDx7zZuu0LlbhSSqRBpYqRzwVaNa1bZ5xcYRduq0TNnU8U+F0aN
         DEVw==
X-Gm-Message-State: AAQBX9fotVbzNCItzOjIBOKp+waQ4JebYQkkVORxPediKqZKRgbO5ir3
        QPVBB7FX0mKv8u1vX1/lXsJd38Gq8YxcxFtVW9pFFvUZ7s0=
X-Google-Smtp-Source: AKy350bXH8QvLNZF4r+a/oDr6AAoG6Bbj35a28iKXBV9tze5OixcVb7xkj9sCB1qEVF8gsQeHosQobA+qN++uU4lR8w=
X-Received: by 2002:a67:c38f:0:b0:426:7730:1e6e with SMTP id
 s15-20020a67c38f000000b0042677301e6emr4402762vsj.0.1680679763707; Wed, 05 Apr
 2023 00:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230404171411.699655-1-zlang@kernel.org> <20230404171411.699655-5-zlang@kernel.org>
In-Reply-To: <20230404171411.699655-5-zlang@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 Apr 2023 10:29:12 +0300
Message-ID: <CAOQ4uxiO+m3xw4wwz-TMLsiaZh5z_+K=94bToKEoH1JVdkv1uw@mail.gmail.com>
Subject: Re: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 4, 2023 at 8:14=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrote:
>
> Some people contribute to someone specific fs testing mostly, record
> some of them as Reviewer.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>
> If someone doesn't want to be in cc list of related fstests patch, please
> reply this email, I'll remove that reviewer line.
>
> Or if someone else (who contribute to fstests very much) would like to a
> specific reviewer, nominate yourself to get a review.
>
> Thanks,
> Zorro
>
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 620368cb..0ad12a38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -108,6 +108,7 @@ Maintainers List
>           or reviewer or co-maintainer can be in cc list.
>

>
>  OVERLAYFS
> +R:     Amir Goldstein <amir73il@gmail.com>
>  L:     linux-unionfs@vger.kernel.org
>  S:     Supported
>  F:     tests/overlay

For overlayfs
Acked-by: Amir Goldstein <amir73il@gmail.com>
