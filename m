Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5841731941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjFOMyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjFOMyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:54:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E52684
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 05:54:35 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CD483F460
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686833674;
        bh=7s7V2+321ZyNPza6R2xt2k0HvW7HQ5rLMPUQLo4DBaw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NXBc7kAKGYrYj8g1LepdRYV9ljKmdjmL2BLst5jE14c7VROB/eKUMTq3J8ynhLCUs
         8KT1+b6N8k3DYCRsoWIZAPcvATHXpnWyQEUYn2xhQWp+CHFLj9UzFI0rOoRViE8qFM
         rjhx1Ou0EYn3l7S8HvwjDmQNiFtVCynUys4XsNqVfj8Xlsoi056mYAmcahgR2KiHjm
         qTfWUHvYKYT6H8DXqElYJM2Yt1c0VQT+7jncRNU9EbMLqId98/frA+Qfn9ObGyzJPb
         FpbfRvng6OaQfsOzQlREu1o030FL9oqaKiDcbztiCojoSXjWVF8KYRknT+EuBdaB0G
         4ZwwljE9bQx3A==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-569e7aec37bso26016807b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 05:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833672; x=1689425672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s7V2+321ZyNPza6R2xt2k0HvW7HQ5rLMPUQLo4DBaw=;
        b=efUqg161ue09qevEy3OQ4qiH50E2dPHg7qKlkDeccKstq85fvnoJ4rDVfIxybh1XWS
         bd55mX7TMsGQ9WZmPMrXW15c+GFBXGUtUpZoVRVir9Q4j5AJxD1ksQDThYjy9wnKSrp2
         719xMeJ4RJf0ikrqbcv3calJoXjKb1zcmUggnhQ3pOobpi7MHXDOqunBJ5PHdGqPeUgR
         oZDI6fJsXY3CxrhUgU8CHuqOq4SszzNl5Gme4+owyTlmEdZc3ih9AZV3CEguKGg6R9Ec
         QBSv23nZyDAqyU7USLl/MewJRxOgjEAHg6vhKlPoeAMeuIu6HWYjo44pSrhWOl71K0jG
         RvgQ==
X-Gm-Message-State: AC+VfDx/aJoU2aSmd5TY1kCCecxdP7p/hSRo+kpmmNjSlQT4c7tTrhNb
        8gWyk7pyrkMRD/BTD9Cu45+eLANH8cl7el2pAb5M6ZhPjNLtD4qeHX2NLeJuGs5WZer4Ms0OQOP
        PcuDL+pCVPsz+ZqIHnozAmiUoKJQ8g0Cxif3AyXaG/kTZAd4EqcMuQGjxv2NqveZXIH9Jlw==
X-Received: by 2002:a25:9343:0:b0:bca:bc83:d315 with SMTP id g3-20020a259343000000b00bcabc83d315mr4006454ybo.48.1686833672217;
        Thu, 15 Jun 2023 05:54:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hn6UZyTkhqkXMs7EsEchzgkYgQOII9JrpSSDDEzuUcgS6z/9CIjVM1YDyfA1PNBjUSWlTAvliMX355ES8p7c=
X-Received: by 2002:a25:9343:0:b0:bca:bc83:d315 with SMTP id
 g3-20020a259343000000b00bcabc83d315mr4006440ybo.48.1686833671920; Thu, 15 Jun
 2023 05:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <bb20aebe-e598-9212-1533-c777ea89948a@redhat.com>
In-Reply-To: <bb20aebe-e598-9212-1533-c777ea89948a@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 15 Jun 2023 14:54:20 +0200
Message-ID: <CAEivzxdBoWrN1cNrotAcKrfRHg+0oajwSFT3OBAKTrjvmn=MKA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 2:29=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrote:
>
> [...]
>
>  > > >
>  > > > I thought about this too and came to the same conclusion, that
> UID/GID
>  > > > based
>  > > > restriction can be applied dynamically, so detecting it on mount-t=
ime
>  > > > helps not so much.
>  > > >
>  > > For this you please raise one PR to ceph first to support this, and =
in
>  > > the PR we can discuss more for the MDS auth caps. And after the PR
>  > > getting merged then in this patch series you need to check the
>  > > corresponding option or flag to determine whether could the idmap
>  > > mounting succeed.
>  >
>  > I'm sorry but I don't understand what we want to support here. Do we
> want to
>  > add some new ceph request that allows to check if UID/GID-based
>  > permissions are applied for
>  > a particular ceph client user?
>
> IMO we should prevent users to set UID/GID-based MDS auth caps from ceph
> side. And users should know what has happened.

ok, we want to restrict setting of UID/GID-based permissions if there is an
idmapped mount on the client. IMHO, idmapping mounts is truly a
client-side feature
and server modification looks a bit strange to me.

>
> Once users want to support the idmap mounts they should know that the
> MDS auth caps won't work anymore.

They will work, but permission rule configuration should include
non-mapped UID/GID-s.
As I mentioned here [1] it's already the case even without mount idmappings=
.

It would be great to discuss this thing as a concept and synchronize
our understanding of this
before going into modification of a server side.

[1] https://lore.kernel.org/lkml/CAEivzxcBBJV6DOGzy5S7=3DTUjrXZfVaGaJX5z7WF=
zYq1w4MdtiA@mail.gmail.com/

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
