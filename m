Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D47791990
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbjIDOVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbjIDOVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:21:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1ACE5
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 07:21:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4018af1038cso15348665e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693837290; x=1694442090; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OAcjEaQ03QxynV9tKADAkHVqUqNcfebZXOmuLK4FPho=;
        b=mA5gQHqRtgiVwhABT9dJOeX4kqcBHiS8wQCyo+Jt1qL8+/exY9QSpFpiPkeCQ6AEIF
         dLLSPXW3J/SXdrkcJc2wft6Jqjr85eCSrL1tRC8RzaFFyClZ+pL2wIKLL3Kw7nH9l8yh
         NiHBOkDIqrKLbgy/KTUSeeKWElxwbUmMz0v+P8BLyCJJeG0u9nOZaXiiviAIam/u2fAw
         Si+rd+9w2Znks3BhwgrRj0xNlxW1j6/tOXPlV87AGbK8FPbYdsXQnQqF27E9l23xV7JI
         eyesXer5aTnxOkPoYUvZClarAUKh6F89W9flWazhrkaL4AmiN3Yg/CDIv7eveNNyqXSn
         fjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693837290; x=1694442090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAcjEaQ03QxynV9tKADAkHVqUqNcfebZXOmuLK4FPho=;
        b=LbNeZjFQlhsHHm2+nJmVO9uzAl7819RJ3ZwAKpk33d+OywOvwJPzngtrON1EdYghDK
         8mQiQoqkAVNiEVVuK8qdNYuMszjj/5HltbAEOA//hURzknq/v/zjBsOcQgsu6EGufflo
         spH6a2z9Intn4hXMoLuh2x7f6TSe/9jbJkD8Y5Q2Zm+/RgNnYr0meJFCGe2CtCOMH8AJ
         Iu0U1ecZxwwv7uUlyyyZ+HuW/sADkpen4ipisQvj4KdJSPN0V+Ihgxu0nrE3wwz5wFiU
         vPo/3Cm7oWzt+vxJxm4kMmkY9vLGjIkWdBxtVd7EU/4SMnfl38qmXqSNJuxaSJ2AH606
         rQew==
X-Gm-Message-State: AOJu0YzYJI9r+PkbDcfecky644n7abdjuhpCkWAT/fBxBlGmz2gj33fb
        DCWu21Y/VRcBkzgj5zN4twOiXw==
X-Google-Smtp-Source: AGHT+IGtMj48VMQSdt+G1JW9Gh5UCwO9E7RWRmh29Dykg73w4Ek0hjDhbMLkfpZ2GrZ+USx4wbjgfw==
X-Received: by 2002:a5d:6591:0:b0:319:785a:fce5 with SMTP id q17-20020a5d6591000000b00319785afce5mr7510178wru.38.1693837289935;
        Mon, 04 Sep 2023 07:21:29 -0700 (PDT)
Received: from salami.fritz.box ([80.111.96.134])
        by smtp.gmail.com with ESMTPSA id d17-20020a056000115100b00313de682eb3sm14542159wrx.65.2023.09.04.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 07:21:29 -0700 (PDT)
Message-ID: <10e2fc00466d3e5fc8142139ee979a71872292e6.camel@linaro.org>
Subject: Re: [RESEND PATCH] Revert "fuse: Apply flags2 only when userspace
 set the FUSE_INIT_EXT"
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Date:   Mon, 04 Sep 2023 15:21:28 +0100
In-Reply-To: <CAJfpegtSEjO9yi6ccG1KNi+C73xFuECnpo1DQsD9E5QhttwoRA@mail.gmail.com>
References: <20230904133321.104584-1-git@andred.net>
         <CAJfpegtSEjO9yi6ccG1KNi+C73xFuECnpo1DQsD9E5QhttwoRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.49.2-3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-09-04 at 15:41 +0200, Miklos Szeredi wrote:
> On Mon, 4 Sept 2023 at 15:34, Andr=C3=A9 Draszik <git@andred.net> wrote:
> >=20
> > From: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
> >=20
> > This patch breaks all existing userspace by requiring updates as
> > mentioned in the commit message, which is not allowed.
>=20
> It might break something, but you need to tell us what that is, please.

In my case, it's Android.

More generally this breaks all user-spaces that haven't been updated. Not
breaking user-space is one of the top rules the kernel has, if not the topm=
ost.


Cheers,
Andre


