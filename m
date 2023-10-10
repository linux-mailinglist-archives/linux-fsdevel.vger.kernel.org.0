Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B77BFEBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 16:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJJOG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjJJOG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:06:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A460A91
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 07:06:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1486289066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 07:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696946785; x=1697551585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7oFoQS3B7uBcmK+0e0woSR+PlfjgeY60qyvaNyy8cI=;
        b=iDKF+GvoKPvZzq0bMkL2o9i72pkJ6BukkuU1TzGZLf2W2yMAJRCPQJ47AJ/FqI6BLu
         cW9e3dDaBkfp9MbAymp+2s6J7za8Ml1/yRLJ4EuyyShFBesLPpMzCQge/k+LFo58lcA0
         jhoAvZ5Tnjs9uG4PIxtJAUQ9448afkn5ecCpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946785; x=1697551585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7oFoQS3B7uBcmK+0e0woSR+PlfjgeY60qyvaNyy8cI=;
        b=KJLTSDqNfcz8mnUvyszffMjoCkzM7/OjVCyUpJup4CCT6tCmnr7gLfvriDOHyg7BRB
         +U4v8lNmO5fv5gnBjUEmkKsQU8mxLnmPQem93DjTn3s2FDIwqWeLoIp32W+zTVBBeck3
         oTYyybhY9kIponHo1Xe2TfvmkbiJLuc+EDTtdM/5QU6k8Ab0EBLoYBXVsnf7ofAd3gsQ
         qk+Zn4PsKSD8GGTyOuAXGn1oe/QVAXcRFZPh8AHgIN5dJ39VJixpunkvc58FGiNKJ4qa
         WzH+btittL+lu3WwpY3SJr2qcVVKBtV0wodL9i+igVrcJiCpi8nlCspidc9L8imU5osh
         +rPw==
X-Gm-Message-State: AOJu0YzhsJUirbCXKtDTAkhJRHM/8SorNMizWDJXiEx4M2EbeqaV53Yz
        w8Gzy743lxtIHxMjc3XbOIPipg7/KzvcqWbberx2wdG3sj6N+yyouLY=
X-Google-Smtp-Source: AGHT+IECdl6I3/oeXZ1rlJ1dKGfExH2JAk6gJNVnT65PjVVMCMi4JRvg+qqUIo4GMJpuVnMRTR+5xwqmyyCqjflpykU=
X-Received: by 2002:a17:907:7812:b0:9ba:2ada:e774 with SMTP id
 la18-20020a170907781200b009ba2adae774mr4649110ejc.24.1696946785064; Tue, 10
 Oct 2023 07:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <nx43owwj2x46rfidyi7iziv2dbw3licpjn24ff5sv76nuoe3dt@seenck6dhbz7> <0100018b0631277b-799ea048-5215-4993-a327-65f1b50fb169-000000@email.amazonses.com>
In-Reply-To: <0100018b0631277b-799ea048-5215-4993-a327-65f1b50fb169-000000@email.amazonses.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 16:06:13 +0200
Message-ID: <CAJfpegsvhbmAYD22Y981BiV8ut7QfZbRZMvGY7Vs-hCM2L+=dQ@mail.gmail.com>
Subject: Re: Question about fuse dax support
To:     john@jagalactic.com
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jgroves@micron.com" <jgroves@micron.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Oct 2023 at 20:12, John Groves <john@jagalactic.com> wrote:
>
> I see that there is some limited support for dax mapping of fuse files, b=
ut
> it seems to be specifically for virtiofs. I admit I barely understand tha=
t
> use case, but there is another fuse/dax use case that I=E2=80=99d like to=
 explore.
> I would appreciate feedback on this, including pointers to RTFM material,
> etc.
>
> I=E2=80=99m interested in creating a file system interface to fabric-atta=
ched shared
> memory (cxl). Think of a fuse file system that receives metadata (how MD =
is
> distributed is orthogonal) and instantiates files that are backed by dax
> memory (S_DAX files), such that the same =E2=80=98data sets=E2=80=99 can =
be visible as
> mmap-able files on more than one server. I=E2=80=99d like feedback as to =
whether
> this is (or could be) doable via fuse.
>
> Here is the main rub though. For this to perform adequately, I don=E2=80=
=99t think
> it would be acceptable for each fault to call up to user space to resolve
> the dax device & offset. So the kernel side of fuse would need to cache a
> dax extent list for each file to TLB/page-table misses.
>
> I would appreciate any questions, pointers or feedback.

I think the passthrough patches should take care of this use case as well:

https://lore.kernel.org/all/20230519125705.598234-1-amir73il@gmail.com/
Thanks,
Miklos
