Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B812E72990A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjFIMHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjFIMHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:07:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E0358B;
        Fri,  9 Jun 2023 05:07:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bad010e1e50so1707335276.1;
        Fri, 09 Jun 2023 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686312462; x=1688904462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae0vx5+VWej1LDLtu70qOzk1nNYyTCU+FuqCyI6C4ho=;
        b=PeR25UZMoflFqpnW+snVXjD6Vmh7P/8ou1j7ra5t+15Alakq2LJD3DXKwDSQ8sfzkd
         dQ6BwLQcAh4xmplCm7SJkr8v3CW2fY+TUX5MNVIjmMbwfAUZXoS+k80nUnmDXcaV0VH+
         NB19n83p8VX/CDJEssx5DbqximF48b3qdq05x+DVQ3EN1ECLupMfWwa4kJx3nnsKzy3k
         Jhynm+GGVKSxDrTvONg+m0nbjGjqviXYTkz92Vo+t456pDhoDptenucFfeljCnPwJ1b5
         y2K4Rq+QPFUZ9qdKYcj2rja+U2S8Cxmax645dYlppmicVMQX5VgadKVxBDTkD3IuA5xB
         NywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312462; x=1688904462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ae0vx5+VWej1LDLtu70qOzk1nNYyTCU+FuqCyI6C4ho=;
        b=GSz6SOZZkxQG303Hyvk1RseiKtC8u71TnOSlhx+YOnrR6U9qs1lx6YZy+37KRe3YJr
         8Kf3+sNbfB0smtGMgyz8N0uOCTIufu4Oa+jDuYa2wKd7X3LwiIy15nl8N4MdctvDj9iB
         0/MjP145q4WAUYcZR0S46CrMKWWGsuZVghQjcv28Bpk73WYaaIXjnOwL8UqUhRPoHBVD
         tvF7mSn3BlZFAP+EtfXaMsq/W5sbY/7oimf7CfAukUT50WUWejEwWMBwqZxJg+NzkDNn
         KPcCEpiYkCpGkq3wzDfe4szjMn2KBPk6a7PhjyKjLcn0QFV/qvky7hI6b3ilO49hcj/n
         Ox6w==
X-Gm-Message-State: AC+VfDxkf7+jxXSrOgu7zX3amfEeog+WdYW+l2YUr2rfEAie9Wkrs0pq
        W3zMpLH119VmK+hLMnTG8sSz7lqDKXRd2wkOkCA=
X-Google-Smtp-Source: ACHHUZ6PUkbpLKdJCwUKosVKgrLz4w2WV5cywVKPValUe1NsbsAgQEDJzpme4oXumETS10YOhYz3eJGlDBbOy1D9MMA=
X-Received: by 2002:a81:48c2:0:b0:561:e7bb:36a1 with SMTP id
 v185-20020a8148c2000000b00561e7bb36a1mr1030777ywa.49.1686312461911; Fri, 09
 Jun 2023 05:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063118.24852-1-amiculas@cisco.com> <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
In-Reply-To: <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 9 Jun 2023 14:07:30 +0200
Message-ID: <CANiq72nAcGKBVcVLrfAOkqaKsfftV6D1u97wqNxT38JnNsKp5A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alice Ryhl <aliceryhl@google.com>
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

On Fri, Jun 9, 2023 at 1:48=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Because the series you sent here touches on a lot of things in terms of
> infrastructure alone. That work could very well be rather interesting
> independent of PuzzleFS. We might just want to get enough infrastructure
> to start porting a tiny existing fs (binderfs or something similar
> small) to Rust to see how feasible this is and to wet our appetite for
> bigger changes such as accepting a new filesystem driver completely
> written in Rust.

That would be great, thanks Christian! (Cc'ing Alice for binderfs -- I
think Rust Binder is keeping binderfs in C for the moment, but if you
are willing to try things, they are probably interested :)

Ariel: sorry, we crossed messages; I didn't receive your message at
[1], the rust-for-linux list probably dropped it due to the included
HTML.

[1] https://lore.kernel.org/linux-mm/CH0PR11MB529981313ED5A1F815350E41CD51A=
@CH0PR11MB5299.namprd11.prod.outlook.com/

Cheers,
Miguel
