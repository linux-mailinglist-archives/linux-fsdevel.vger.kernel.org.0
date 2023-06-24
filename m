Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA89773C73E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 09:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFXHLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjFXHLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:11:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777826AF
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 00:11:39 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 96EFD42419
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687590696;
        bh=bZz/LQgUAu95ZYcCnmkTkIGQIutFEz+JhRbHpbTz8PY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lcoZWSG59KZnXEYNQeshuhtgBo9tD9rogUiJnchakHXVN4ZI7hF7paIjGk73se9ZC
         Rc1bp30RS96vrrvy3k2RgujnnrbtrAi/QKXgx9fQNqgNptYJDxgz+tVWpIHeuzf4t+
         MwAdexYScR9TUeOD9Al84ZcztynrwXvqRFCAJsyrJTydlAsIQov945yWEisE0iRIlN
         t/17BIejjIVEkpzg/6AXiiBtwbfRF3sW1QURFJ3tRol7VPArVZbBZDwjSO8/69K44T
         2R6aNaVI2tmJ7Zph66LvcuqSUfJxK2GZ1Gqwvn5W621gY+QfRqvtnLAZwQGC6aApgc
         LrGeG64SL41Gg==
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-bc68c4e046aso1661080276.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 00:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687590695; x=1690182695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZz/LQgUAu95ZYcCnmkTkIGQIutFEz+JhRbHpbTz8PY=;
        b=cfL9CkYBPno8hzHn82moboskCJDo/v6imS/w7Xj6DDqy70iAKBx2KKI7IWnRcAx1Hy
         mYt/fBQ/lgg2QbGuuZJ0n8XCmjKAqJcmyYIlW4tifJxASrn4vtevBqAsNuxjO3f2p7oJ
         p0h2EGUcxrFLZ/Fs5VMZ8tOUiTo0lBQHMo4tuCHOWssTmcx7AY3zHgO7MzTWznKAy6mI
         gWzhU4pSZ29xTGbaKPFGCwHv7CcfeWjBDF/87Rg68SiNinnJ9wny2wSxUp3xKpaaTa9/
         799xfXqsw0wqPRIc7kndrvL0awY5G96cx30O5Yq3LjabrwZq7D1sLuFfpkFCLQZsWT7i
         UH9A==
X-Gm-Message-State: AC+VfDxFlmOnYzanSVtkdy/DY9ZzgSMc1DetXG4uPO4Sb9I8998bsojh
        tuXNxJCuOZy3c5HQ6RIn+waYeFrN8v9X1xO2zPs6Q2FxIE/hRQnB3xlVUuPQcI4HUMC1e5sjIJU
        8ry8CltXTjA0w689p3qmaaPUtYavmuY0zMyopeWuyBJew2ZUL1CficU6D0Pg=
X-Received: by 2002:a25:aa90:0:b0:c10:cc4:69f4 with SMTP id t16-20020a25aa90000000b00c100cc469f4mr1171179ybi.26.1687590695478;
        Sat, 24 Jun 2023 00:11:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4huLRnj7OptCbX0imrt6C0epTZwBXik75dRK3pwKAn45wCejPbrivSK4IDl42sH/32xTq1XehW/bFfFZn15H4=
X-Received: by 2002:a25:aa90:0:b0:c10:cc4:69f4 with SMTP id
 t16-20020a25aa90000000b00c100cc469f4mr1171176ybi.26.1687590695243; Sat, 24
 Jun 2023 00:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
In-Reply-To: <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Sat, 24 Jun 2023 09:11:24 +0200
Message-ID: <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 24, 2023 at 3:37=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
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
> IMO we should prevent user to set UID/GID-based permisions caps from
> ceph side.
>
> As I know currently there is no way to prevent users to set MDS auth
> caps, IMO in ceph side at least we need one flag or option to disable
> this once users want this fs cluster sever for idmap mounts use case.

How this should be visible from the user side? We introducing a new
kernel client mount option,
like "nomdscaps", then pass flag to the MDS and MDS should check that
MDS auth permissions
are not applied (on the mount time) and prevent them from being
applied later while session is active. Like that?

At the same time I'm thinking about protocol extension that adds 2
additional fields for UID/GID. This will allow to correctly
handle everything. I wanted to avoid any changes to the protocol or
server-side things. But if we want to change MDS side,
maybe it's better then to go this way?

Thanks,
Alex

>
> Thanks
>
> - Xiubo
>
