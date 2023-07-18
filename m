Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45C75885C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 00:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGRWTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGRWTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:19:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F2198D
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 15:19:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so18162a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689718768; x=1692310768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTirM6dws8Iol9T3+w/2xeoFNZKbQqSyMExz8yz5g0Y=;
        b=Fezxw57VkKhP2KFZu2Bjypfrr7kMv9q8H6u0ClctPhw9rszbNYM/Tf1Eo+qGSO9Wta
         XWq5M/msose+qnclvfmLYY7pBRqHKRXtMYbVcn+tvLrf6m53kw0MSb7vK/mUWik3FkYN
         QvPC/UE6vigEEuMpFbwiS4fLXAT9FdaRcD6xEJ2iW3VwuNKUxN5Zou2t2a7N0qs9Rz+Z
         8wDCIAVjPDN11+TOhQKLBbwMbaHsg3KlW9F8Kmy+aJB36STzhK9fKwODNT6gdr/JAcOn
         e8txuxnFRDO+kFyyfFrzaRM0E0eKTepjs6eqVvJT0wutU/TBwa6FCOdxeijatwFwNrS9
         WzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718768; x=1692310768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTirM6dws8Iol9T3+w/2xeoFNZKbQqSyMExz8yz5g0Y=;
        b=iVtz8US3NpH1PxVloKcz38IuR9GD/l7E6xEsHZ67K2RNKIPexiTey3iYAp6GoMFTHP
         Yzj3RBNb9THl+j7XuZoOGHeCZfkAMHwtQJ6ZlVQlx03FMVyAnZWpguRVLiS6AMKJvJF1
         YBFr4fTDNFTlBf47x66qBVp9h83RXqf19deafLa21MLwDoea+BOPzL5QpgPeTI0MsGBl
         B8nYkozF1yNOW33cSzv2/VJ9vqJy7a0iBVieB91IjPSRXSa0C00YYKL7iTIqoZWXk8G4
         X9H9+0A28BXKFuwIQaWc3kgo2pF53RFxjIjCMiS2lhxhe+F+ijzuyQEK1RvkQf1Cs0Kd
         xXwA==
X-Gm-Message-State: ABy/qLa5awHRJ4i6gc/1rx4lqV+UdgEZ97QvysQSwXxPFzRJHX83+5AG
        AgJQdlFGMbYBaSqyZYLxCqODatiDVsAmgcXRHrqDbQ==
X-Google-Smtp-Source: APBJJlEXIdjXTngOmMaNnVJdOVTzeg6p3lOGTAIgqMp4hs2zhfhLpFXYo4inKjrvfwO97lDw6wdDXkkcEyBBr1Qig8E=
X-Received: by 2002:a50:bae9:0:b0:51e:27ac:8f9a with SMTP id
 x96-20020a50bae9000000b0051e27ac8f9amr175465ede.1.1689718764750; Tue, 18 Jul
 2023 15:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
In-Reply-To: <ZLcOcr6N+Ty59rBD@redhat.com>
From:   Rob Barnes <robbarnes@google.com>
Date:   Tue, 18 Jul 2023 16:18:47 -0600
Message-ID: <CA+Dqm32sTcJoh-8LmtegWdihWGJWQdwCUDhmrLhru866uwQzyQ@mail.gmail.com>
Subject: Re: [PATCH] fs: export emergency_sync
To:     "Bill O'Donnell" <billodo@redhat.com>
Cc:     bleung@chromium.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My use case is when the EC panics. A hard reset is imminent. In my
testing a regular sync did not always sync all of the logs. See
https://lore.kernel.org/all/20230717232932.1.I361812b405bd07772f66660624188=
339ab158772@changeid

On Tue, Jul 18, 2023 at 4:13=E2=80=AFPM Bill O'Donnell <billodo@redhat.com>=
 wrote:
>
> On Tue, Jul 18, 2023 at 09:45:40PM +0000, Rob Barnes wrote:
> > emergency_sync forces a filesystem sync in emergency situations.
> > Export this function so it can be used by modules.
> >
> > Signed-off-by: Rob Barnes <robbarnes@google.com>
>
> Example of an emergency situation?
> Thanks-
> Bill
>
>
> > ---
> >
> >  fs/sync.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/sync.c b/fs/sync.c
> > index dc725914e1edb..b313db0ebb5ee 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -142,6 +142,7 @@ void emergency_sync(void)
> >               schedule_work(work);
> >       }
> >  }
> > +EXPORT_SYMBOL(emergency_sync);
> >
> >  /*
> >   * sync a single super
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
