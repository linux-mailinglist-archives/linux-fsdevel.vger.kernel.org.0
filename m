Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86670D439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjEWGpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjEWGp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:45:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249211F;
        Mon, 22 May 2023 23:45:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso7685948e87.0;
        Mon, 22 May 2023 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684824323; x=1687416323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bljbLmxykD3kwxzernS2PWZ42kbHe92cMTT9N5V9ktk=;
        b=ApfBlR8GphedxzmbUmg0b6LW1G/1wZ3kI7/pPLSlz6bbq/joQgF1jjGAmuCFA8vmaJ
         Oad7WTKZaBIR3xUvl4ha2IBOafNKbeFnaiVShv5yZ1NT+BR4D0gXCuzuvAf1piUMChzM
         hqGtNWPXfUaW+hn9D1uf8iNSSRix3H19L3DGzYxUHT7tllyTcVfdB0HhsMG8aC12ZHuQ
         WYbuEZm1gY4InhxJ6WfbqWoseNTiaO+YMIM3KAm7CHaHQGprqH9/IFNHNsaKlc7T+rCd
         Axm9blxJQGILf+LrttlmAV8wvgtOv7tYNBdkr1lbpUGcjwftfl8e+fJg5twLyezLM6Ot
         DNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684824323; x=1687416323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bljbLmxykD3kwxzernS2PWZ42kbHe92cMTT9N5V9ktk=;
        b=BCZxYpA6oItcBCkqvExmVUKjKMNcztxPVvL7UAh4VMY6JJYWCWsYOBh5mhNMT05sEU
         KT2yKEfdzS6zSPou/knu0bY3c3ik60k72mV43vK8xkqvrtMO3LQFDvo/oYUyVd/xps0t
         bOhqNVSPMQrkt7E/6wL64a2qJ4n6IvGoK7Y9zbE0rOtxo6LjoYeKvAuYdj614DaDk1iT
         Rfyoik8sGVFz8G+9lc5hZjU7XFGFGjrbVaElE7Xci6jmd3cIoyyMN8FXtZQSLrOKDDUq
         SdcrMJs6UpjYpCrYjcbMYwDWlYzCmbL5Qz001NhvmoVVGLA03Iwq0tsdQm3iezCAH8kt
         Nl/w==
X-Gm-Message-State: AC+VfDwvymQq1BmpoNldfd5xxdM1RBs8WMXQlBxtZ6zLHacmGdTK3hqg
        HByf0nVZkP1nAm0e2Oy3J/PElwya2Yse2aRQbXo=
X-Google-Smtp-Source: ACHHUZ6KaidAKEq3jzz278crBeX9oCb3F1L0Z12eqJXBXJ2OM5LUWrXF0SUTCMc7k/i5q3NHa5AVdyoZcMLesF7+WgQ=
X-Received: by 2002:a2e:3506:0:b0:2a8:ba49:a811 with SMTP id
 z6-20020a2e3506000000b002a8ba49a811mr4622733ljz.25.1684824323078; Mon, 22 May
 2023 23:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <2811951.1684766430@warthog.procyon.org.uk> <CANT5p=pNFpEj0p+njYw3sVdq9CKgsTdh29Gj6iYDOsMN0ocj1Q@mail.gmail.com>
 <2818727.1684779061@warthog.procyon.org.uk>
In-Reply-To: <2818727.1684779061@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 23 May 2023 01:45:11 -0500
Message-ID: <CAH2r5mtXR7xeP79Rit58769r+Q22Cg6ruV7dSPcNOb_=rQ9neA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix cifs_limit_bvec_subset() to correctly check the
 maxmimum size
To:     David Howells <dhowells@redhat.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, May 22, 2023 at 1:11=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Shyam Prasad N <nspmangalore@gmail.com> wrote:
>
> > > +               max_size -=3D len;
> >
> > Shouldn't this decrement happen below, after the span has been
> > compared with max_size?
>
> It probably doesn't matter.  The compiler is free to move it around, but =
yes
> that and ix++ can both be moved down.

I am not sure I follow - can you explain? It looks like moving it up
vs. down would change behavior


--=20
Thanks,

Steve
