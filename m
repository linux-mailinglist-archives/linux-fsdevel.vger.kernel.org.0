Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A457AE621
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 08:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjIZGj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjIZGjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:39:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6F12A
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 23:39:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so125306091fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 23:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695710355; x=1696315155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt/DEmiaU+uQWt8wI6/BzNvc9Crtevm3JQW6PBfhMKg=;
        b=byS4b7vb6ToN++9oOCYpc+qg/jJ71+wwec1i3wj75+6TPSfONTnlVbAwejROawfQ9R
         GX3GrC3Hk7kHTGArz+Mf0+FAx4uMLmoxA59ITYkbxjca0Hf3PbJRstNI4/5yVgqti9D3
         SaT6igLoGZjIyeDN+16KTqZg4z6iJO5IAFlAKSdsIGqu5n+h7s79tCQxQOW1wL26MGAX
         iKsGhWOOjU0HoyTPFahmN3g2KwNX2YI+TzAPjMcRqZefmXr9Lh0Kmp20dKjR8u3OqqAs
         YzMJSrtJk6/Q6x3Ys5ualldiR9NsqlI7aUGH8Iaq5G5pdFQl5SL3qT5jwAeWOIVrtrSO
         ZCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710355; x=1696315155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt/DEmiaU+uQWt8wI6/BzNvc9Crtevm3JQW6PBfhMKg=;
        b=gODD5dZ13qyvBX9sUPYePWm1hauUu+VCwh/NbBtB1jhTKZZZlYLnu4Ond6ZMkF9rG7
         cB0EDFOUe+R9aErS7jz56s54yBzmTsVgX7PtA7rdvviXIw15/acMCi0vmFR8lgZ7r/oX
         TpsA6dmANeis/n5v8l6Lml8J9eJaPINwN3LCdDWpaE7vX0WRvdGlVrjrNwFsQcwjMzBJ
         tXZzSSey/2yrn2/vyX83DnWzenbjnPUJ8k7kUgTLGaL4gRKLnAjjsWtJ8O17b6ldhgsJ
         3+cdgdcpSAi/yhEgmt/iHUBYCEClK95SAW6xrZbW47NHm1KxqZTI7phMYpPr5mLY9fW6
         iuAw==
X-Gm-Message-State: AOJu0Yzz+bYhMN+zySpsgH+UQPFfGdBumM7+IZY0eRQo7Aw6VN9I+Phl
        uNSTHJaM/zYBZvgrA4H733drjfgyHOxXRsYk7xTu6Q==
X-Google-Smtp-Source: AGHT+IFzUv3m9pLSgMurtyvIA0srGeB3W1DDhFF6t6u3Yhr2FaoPUbIkF1SR20aZ/ZkACNo6qBBLGk4+uqGWc2OKjz0=
X-Received: by 2002:a2e:9a83:0:b0:2b6:fa3f:9230 with SMTP id
 p3-20020a2e9a83000000b002b6fa3f9230mr7475377lji.46.1695710354931; Mon, 25 Sep
 2023 23:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230919081259.1094971-1-max.kellermann@ionos.com>
 <20230919-kommilitonen-hufen-d270d1568897@brauner> <f37c00c5-467a-4339-9e20-ca5a12905cd3@kernel.dk>
 <CAKPOu+_fwVZFXhTuzcWneNcjHJ99n00j_oq+sF8P-zvsPCOdVQ@mail.gmail.com> <20230925-erstklassig-flausen-48e1bc11be30@brauner>
In-Reply-To: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 26 Sep 2023 08:39:03 +0200
Message-ID: <CAKPOu+80oVuFu90Tmx0ct+DvJ0PO87a66rKDmT_Jecg9p1t3Ng@mail.gmail.com>
Subject: Re: [PATCH] fs/splice: don't block splice_direct_to_actor() after
 data was read
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 3:10=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> > OK. I suggest we get this patch merged first, and then I prepare a
> > patch for wiring this into uapi, changing SPLICE_F_NOWAIT to 0x10 (the
> > lowest free bit), add it to SPLICE_F_ALL and document it.
> >
> > (If you prefer to have it all in this initial patch, I can amend and
> > resubmit it with the uapi feature.)
>
> Please resend it all in one patch. That's easier for all to review.

Done. Though I was surprised there's no "uapi" header for splice, so I
only changed the value to 0x10 and added it to SPLICE_F_ALL.

Since the splice manpage is in a different repository, I'll submit a
separate patch for that; can't be one patch.

Max
