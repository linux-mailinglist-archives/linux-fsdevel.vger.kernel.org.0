Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8872A178
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFIRmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjFIRmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:42:19 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FA3AAC;
        Fri,  9 Jun 2023 10:42:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bad010e1e50so2058042276.1;
        Fri, 09 Jun 2023 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686332526; x=1688924526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mxlR3AAOCReqszR1ozs5CUDyiaXybkfrT03qSlnN+w=;
        b=mpsTJ8iOKx6DYYGqx9ZkDBj06kPQDTh67xXTMazb7rhKrFD8YA2G3CPhSKyoNqjGK1
         53yD+ftmTb35rqZgv5ME77kElXlD20xRhMpj6JAFr56kWImzq7ZhrQmxofO5GTQhxPIy
         nd3SiIhrGhoiOu4UN63S0ibuU32P+3pkiOBfsV984ZConk9CAMNPo2ZWZzo1OTPS54FG
         oBnBcSgtYEJdhr9+/3ZJie+sZk48L2Q9YB4lmHO53b6KyD67RWHvAs/Pk45R7NeKdKJR
         Qm32L6kihBmd9RE5bQM+gBs8Uc7RSGupoXmhTVkLafO4xlJOIaJChoTYXj5sWTM07WGF
         qYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332526; x=1688924526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mxlR3AAOCReqszR1ozs5CUDyiaXybkfrT03qSlnN+w=;
        b=hhALGyyPxMzNLgLUL7y0Piw1ijK5MrsA3n02ztHDb4DFvwPBBdXf81i+BERypNgOBM
         3PuvYevnAfu+20Oi+1iidaEqzgMWWjj6BYZEKn5TqbXD/+17/58KLHPzbaXlm8pbYTFp
         63exramZUrazBOqNyuGUPb+gJrVTuwwuS7KiPkiHHmd8Ky2NPmGvxSwsLL7cXf8HS9LN
         pWV7p3gWgZaJKvoqWiCT/9vHWrPNORWY9RIHKC7FKuC8v+kInV4rS5dKOSY8ClER9Ta0
         h7vfsqjDr6Pq3GrywWPZLi8hgxqD4fiBtRGP0VqP/rjSU++XemrUL3IYnAwFatXeCEvv
         4f6A==
X-Gm-Message-State: AC+VfDyhoP08kXP/GHfvS4DTXAqq6Co9Scu57uZrovt8mgDnC17Hxka0
        g8IvFTNIBhMoWKvk+FUigSrtmzGevkx/74uylhc=
X-Google-Smtp-Source: ACHHUZ6KExb7dLKBTS9XkE+sBdXLwDqHhvD/sSiitEPOFEBDAlXlierh/9f6nlsBKKiPCy3METv4FE49GtM4Ymc0E38=
X-Received: by 2002:a0d:dd09:0:b0:559:e180:2197 with SMTP id
 g9-20020a0ddd09000000b00559e1802197mr1912661ywe.21.1686332526471; Fri, 09 Jun
 2023 10:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner> <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com> <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Jun 2023 19:41:55 +0200
Message-ID: <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 7:25=E2=80=AFPM Ariel Miculas (amiculas)
<amiculas@cisco.com> wrote:
>
> I could switch to my personal gmail, but last time Miguel Ojeda asked me =
to use my cisco email when I send commits signed off by amiculas@cisco.com.
> If this is not a hard requirement, then I could switch.

For patches, yeah, that is ideal, so that it matches the Git author / `From=
:`.

But for the other emails, you could use your personal address, if that
makes things easier.

Hope that helps!

Cheers,
Miguel
