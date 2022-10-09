Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42D65F8A91
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJIK2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 06:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJIK2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:28:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0A2A42F
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 03:28:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y14so2427910ejd.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucto18LgoEv5+ynUqvo1ZWAC+UUGL5/WVlhSeckRLK0=;
        b=PWSQ3Q8kYqxErLOrdWe7bQBGHUYVGp/JFkzqyRwFKxUXzH38xKyUPgfNc3qPYTjm/c
         jc30LY6aBNyOPjnnqZQLkoyx3oe9BU+vMvSFHXdqFhbRk0fnRQ6ERI9YzRgI4qCzful8
         DV1kM+49C6wYuI4Hs1QqaZo/jgp28qRLs/1KDe55mM4Ndl56SFAPK1cPjuz4lz3R4q6B
         X2unAD8mwvKA6QzGellvYmxEOiiBGuwwrfvLqftbxEVAFLW1s0KCADPDF+r6mQobFDEt
         DygAi/yfqYfLyBsxbC01STKU2w8BbryI4AqVGyrBZEtKiVA33mf01viklrONBZ8ss8qv
         zbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucto18LgoEv5+ynUqvo1ZWAC+UUGL5/WVlhSeckRLK0=;
        b=apyrW89LCOsRDfqF+nUwzdAV/PDv9qz2mQAJZuYItfP0kOMvm2FceyaanfKruklLcN
         +vrtIaw4B0DDc1/kQ8lntmce7v6bP1BKY5b7HMsAnLHoDYlnQdr2axNkj5UDJfOATk0+
         IRyLEYH7RcvQBfE1DqtVXIrkhptB9rErHMqlMXBbF2INK3DtchGo9hWsRlhIntRZ3yla
         FitffUMYy3eEBYro6q8eZSF0l9G3S6oDI20fEBWHV8sO1754azQK0ZrJDcv61p6q+Kvy
         HSVIiJvaw7bReyRWh9n/DSnjhsN8i/VQ2ecn73SHOdXKuKxnC/OYZktX2LkX/KAkA1kO
         7c+w==
X-Gm-Message-State: ACrzQf0sUUJreY4PLAc3F3VBaAEZna5vdNk1HhLWCn/xRHep8WoJJJhU
        dEjgRkdpaw3hp+BFpUFI+XMpLCx+X5Vz7X53l+9VrA==
X-Google-Smtp-Source: AMsMyM7wHEfKvtNwcKkbX4Ry2Y89datbdz7sRkHgWEQla5i5YlGD3WJ0hyasdkZdb9Svew+M+8y25lfx55C8mG1OXWU=
X-Received: by 2002:a17:907:8a1f:b0:78d:3dbb:a017 with SMTP id
 sc31-20020a1709078a1f00b0078d3dbba017mr11003309ejc.54.1665311281487; Sun, 09
 Oct 2022 03:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220927120857.639461-1-max.kellermann@ionos.com>
 <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com> <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
 <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
In-Reply-To: <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Sun, 9 Oct 2022 12:27:50 +0200
Message-ID: <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
To:     Xiubo Li <xiubli@redhat.com>
Cc:     idryomov@gmail.com, jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 9, 2022 at 10:43 AM Xiubo Li <xiubli@redhat.com> wrote:
> I mean CEPHFS CLIENT CAPABILITIES [1].

I know that, but that's suitable for me. This is client-specific, not
user (uid/gid) specific.

In my use case, a server can run unprivileged user processes which
should not be able create snapshots for their own home directory, and
ideally they should not even be able to traverse into the ".snap"
directory and access the snapshots created of their home directory.
Other (non-superuser) system processes however should be able to
manage snapshots. It should be possible to bind-mount snapshots into
the user's mount namespace.

All of that is possible with my patch, but impossible with your
suggestion. The client-specific approach is all-or-nothing (unless I
miss something vital).

> The snapdir name is a different case.

But this is only about the snapdir. The snapdir does not exist on the
server, it is synthesized on the client (in the Linux kernel cephfs
code).

> But your current approach will introduce issues when an UID/GID is reused after an user/groud is deleted ?

The UID I would specify is one which exists on the client, for a
dedicated system user whose purpose is to manage cephfs snapshots of
all users. The UID is created when the machine is installed, and is
never deleted.

> Maybe the proper approach is the posix acl. Then by default the .snap dir will inherit the permission from its parent and you can change it as you wish. This permission could be spread to all the other clients too ?

No, that would be impractical and unreliable.
Impractical because it would require me to walk the whole filesystem
tree and let the kernel synthesize the snapdir inode for all
directories and change its ACL; impractical because walking millions
of directories takes longer than I am willing to wait.
Unreliable because there would be race problems when another client
(or even the local client) creates a new directory. Until my local
"snapdir ACL daemon" learns about the existence of the new directory
and is able to update its ACL, the user can already have messed with
it.
Both of that is not a problem with my patch.
