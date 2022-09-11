Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B925B4D3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIKKPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 06:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIKKPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:15:03 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588CB15704
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 03:15:02 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h1so6130980vsr.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3creKp+0gQrX4E2fKo5+13Jvd4SrVIi5E+YlSTNV0jU=;
        b=l4R0wZrl9FUHQwPexgPvvpNVmgyazZtNF0nIkk9YGgqLiJ3wkeuZJbR2xZa4AuRyzS
         BV+9pyndLae/QDXHbd7b193eVMkzDPqkwvJ7zHijE3H4V5dZdsne/+vuioqXuuWDGLqC
         0tZmmu9Z73XCbi65OfY7f/VnjTKB3bL4d4o5IldKvh6m3v0b7Ye08hOvy/+KizkAjDbv
         nSExmyX7m/Mz11QY8Rd6RLRg6mE0UmxKKqDTHhDbmN3komIQJ0fjjM8/W5w/HX36tj8P
         is0vBg9yCPl4sL6NXIZj8V5Cw7KF38QadzdEPyeN+cHHLFRCzDuS7u7CDX/7fv54RCH1
         0PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3creKp+0gQrX4E2fKo5+13Jvd4SrVIi5E+YlSTNV0jU=;
        b=plWBhKN95wjajEOTStXDcN6Nm+TAJoLiMFk1ZPfzD/IKYBa6zokuyMOGkaMXAtFW98
         AGARVsMHAhK7rQpLpBSB5nU0KXC/hG6hD3DK0QBXH2XPK3lNPSXBA2i33IeOYKuKs+Qe
         Ee3jF/+PzpPN/0KcUT8E7L77zh4QUc0GlUjxzM/WnVrXglbWq5wpa00W3SXgNjo6HSF9
         010X6Vlay5qcNduLDtayI57l5cCpvaiVnMtNDYf/na/ynSBzYUOX47li2s3IzyUmZSO6
         ua4CeH+gXBiPZhd9/u5yhbs2VhLG+cMnzYpLItO+RREaA4ECys85tDNXxFTCK0hTACa6
         6BKA==
X-Gm-Message-State: ACgBeo18VmpEaz8ZQnQhZVn+KMk+cXt8elXnMoLStU2KPRaxmkWQbWqK
        AZFfvecMKjTqBT6XPKEUixyqHX6NqDwizLwYOe6uOARS95A=
X-Google-Smtp-Source: AA6agR5ZWhjMp8Yep/X3zkeZIznoVizAQsPsCfR1QFSK/eX/EUtosXpo25cf9f8fuH23hoTTZvmPFl4uWnHTWi+Hcb0=
X-Received: by 2002:a05:6102:d3:b0:398:6f6a:8850 with SMTP id
 u19-20020a05610200d300b003986f6a8850mr1238060vsp.71.1662891301452; Sun, 11
 Sep 2022 03:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
In-Reply-To: <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Sep 2022 13:14:49 +0300
Message-ID: <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file handles)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> One proposal was to add  LOOKUP_HANDLE operation that is similar to
> LOOKUP except it takes a {variable length handle, name} as input and
> returns a variable length handle *and* a u64 node_id that can be used
> normally for all other operations.
>
> The advantage of such a scheme for virtio-fs (and possibly other fuse
> based fs) would be that userspace need not keep a refcounted object
> around until the kernel sends a FORGET, but can prune its node ID
> based cache at any time.   If that happens and a request from the
> client (kernel) comes in with a stale node ID, the server will return
> -ESTALE and the client can ask for a new node ID with a special
> lookup_handle(fh, NULL).
>
> Disadvantages being:
>
>  - cost of generating a file handle on all lookups
>  - cost of storing file handle in kernel icache
>
> I don't think either of those are problematic in the virtiofs case.
> The cost of having to keep fds open while the client has them in its
> cache is much higher.
>

I was thinking of taking a stab at LOOKUP_HANDLE for a generic
implementation of persistent file handles for FUSE.

The purpose is "proper" NFS export support for FUSE.
"proper" being survives server restart.

I realize there is an ongoing effort to use file handles in the virtiofsd
instead of open fds and that LOOKUP_HANDLE could assist in that
effort, but that is an added benefit.

I have a C++ implementation [1] which sort of supports persistent
file handles, but not in a generic manner.

If anyone knows of any WIP on LOOKUP_HANDLE please let me know.

Thanks,
Amir.

[1] https://github.com/amir73il/libfuse/commits/fuse_passthrough
