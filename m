Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8672A2D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFITI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFITI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:08:26 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B13592;
        Fri,  9 Jun 2023 12:08:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565ba53f434so19642567b3.3;
        Fri, 09 Jun 2023 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686337704; x=1688929704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXG0Z5RkAtY5SnT42L4TzGQzc4MRVtlLvaX3vq+ypg4=;
        b=Q9anl58zxSb+oK30masgJA4ABkg0MGZ/E/UBpzNirXKBw1hA7ZMSe/W4JkkTw5QzL+
         UXC/4hi4cE52yfeoYikv6M1vbAVlz3e2VxbCy+vKa0sj+ppNQ8NXrESaSKBoHHqc4VDo
         GferR6Pr3YlhAoOU+Iyp6Qwz6cRs6VQ7OBiSSa6hS+7sVRIDnea0mONm11B9GZq2LXKH
         JNKGc8qyAlo51quk2Wu70eCuDrorcMcxKHB4B7q/e5q11Wtl8MDclHxJM2hVpC9lGpuL
         y9hc9M/QJMVMMiCvlxdKbRK57J4by8G7uJn4pRHZtBByZJ1/UUjWKSxcNPa13kscBStT
         zxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337704; x=1688929704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXG0Z5RkAtY5SnT42L4TzGQzc4MRVtlLvaX3vq+ypg4=;
        b=a60Okp9EwU+BxBwKgyOSRwSj+Z9kSMGYxfJSLGuMFAEdirt3rw8gFXsCsIhJbsBVD2
         fX4ncBQQPLJqxxpCU2NZFODtFWERTo0G6hygg2KIq9NNAI8DXGbJswSLczPHNkhAea7Q
         +husHTB3AbY6XmYU0rsArcy3CfAjDG1sMoIOUifH/gb2+3xfBUIog/JKf/h/8l34V1eV
         A1JR4S+/6AP3Uu7acwKq3Fdya1/yl9KcY+AMGDBNdHoPeQ3KNpmp6+SrR8ZMlkUe0AOh
         xehOcSqLbgvHntndE8ThAk83hCM9W6WMFQKkHlMf11cFgRthLqiafGApmA02AwSx8oYy
         hQrw==
X-Gm-Message-State: AC+VfDyMs9ZqepXDhhxkFuZv7bna0esSt8Kix8qp5/8uQchlNK2FJJ2Q
        caKbYtknzfJtTRKhB0LUjabk0W2FQR16SosZs7I=
X-Google-Smtp-Source: ACHHUZ7Z9g4p0D1wGPUgYNc7OYagccRRevK255Pq+aY/LxiLsXwl/C6FCRbfrAQJMyQbNgvbkt+RjIqkqqEi4a/xmSw=
X-Received: by 2002:a25:9f03:0:b0:ba8:7015:36df with SMTP id
 n3-20020a259f03000000b00ba8701536dfmr1867615ybq.26.1686337704061; Fri, 09 Jun
 2023 12:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner> <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com> <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <CANiq72n2znRm-jeQYP6nd3fHYz5bLNH=iNg9x9Z9HDYmOGnYHQ@mail.gmail.com> <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com>
In-Reply-To: <aa7df191528b07150cd2cb73b450b942af886de7.camel@HansenPartnership.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Jun 2023 21:08:12 +0200
Message-ID: <CANiq72nn6_ZYvOgxJSgngycAtbyT=MnUNgLAyC7-9owRc+Rxhg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
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

On Fri, Jun 9, 2023 at 8:49=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2023-06-09 at 19:41 +0200, Miguel Ojeda wrote:
> > For patches, yeah, that is ideal, so that it matches the Git author /
> > `From:`.
>
> It's still not a requirement, though.  You can send from your gmail
> account and still have

Yeah, that is what I said "ideal". When Ariel sent the first patch, he
didn't use the `From:` tag within the email body, but attributed it to
Cisco, and I had not seen any commit/email from his Cisco address yet,
so I asked him if he could use his corporate address.

Cheers,
Miguel
