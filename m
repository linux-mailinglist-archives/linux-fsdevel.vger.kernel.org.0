Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E31733223
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344570AbjFPNZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPNZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:25:53 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7706E2D76;
        Fri, 16 Jun 2023 06:25:52 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-783f17f0a00so269138241.2;
        Fri, 16 Jun 2023 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686921951; x=1689513951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgcXbmw/7pPr+i3S6oPTY0mWNz8QyZljH3Cc3A9Oe2g=;
        b=oyjgscg8mP9ft2Fn+CtbyTpcSyuv4TDeJUHzeLg9CvPSFUMK0+ylKdT3mGsirnhiS8
         Ae7VPjHh/TNBE0Z5W20PW7CMni/QdWO/sZJ18bw199yG58i6T2HGKue74DXYu3bRmf/0
         1y7ew4dNKR8DPKgD0R19q095GmrLgn//ToOb+DkZ0fcKdQngj3/aMRAkdrB2xgHFjAv2
         8Z5mv3vwXjZIjtb2bmtfHcjUZtHzY564dXtDOz8CHV6HRlCIFmgYN1iViUsj9oixV1ai
         ILoxCZW3jYCUpjArpqcVvrF4RWj5RnQAR8FZ/oYaHFWtZpk5PLKTpEGNwF57Int0FqX+
         rpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686921951; x=1689513951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgcXbmw/7pPr+i3S6oPTY0mWNz8QyZljH3Cc3A9Oe2g=;
        b=LDJvBpn1jiMuqVSf5/hhwMEuapFQbwycjph9mfNqEffuIa/w7uUwmVcob0F2JQSJh8
         rCdKHVM8LdqlAUQBKD4hSGtCNEDnvA3pN3vMXv8ZMtqqJhQeVBFriHkdMyRwjhqpdgOc
         rrtKXLfnNfTA40Hwa1ELyqMRHcJVkvgIRHxP8LdDqFZq3jO6oBE7YOGaSzC1EUciFZle
         cUXYwPo6ya99GZ3pGN6gN3urr6Hgg/VJdNhLkuqt+FwN7dcDoFLSrvlkD+vkjh7vM157
         TZ3bsfbgqB5ai61/GIrU4zvN5rRBui+nNMHFSbzOd7T0Iygis3q/C4Kx67imJn2+To7r
         hYeg==
X-Gm-Message-State: AC+VfDwf7r7uHUWEydwb3AbrkYR5wMdCFU7Gx3zTCrz2SskOFEWDR6pt
        +3LBsAemBt3g/JFKVNc5RncoVS95wsAEJUKVHwQ=
X-Google-Smtp-Source: ACHHUZ6Nd72Zl0gmqBIhrQMZ5EhgYpbs1GI/43qebZeDgrYBvyNOPy+/gIuTtvKySiQJZhyfFjGGhM9dmNCB7g3wJvM=
X-Received: by 2002:a67:fd6f:0:b0:43b:2cf3:a70e with SMTP id
 h15-20020a67fd6f000000b0043b2cf3a70emr1858380vsa.10.1686921951509; Fri, 16
 Jun 2023 06:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org> <CAOQ4uxgg7dYZFn63CAU4XQoxOTaQQJzUregoyudPxUHgNBpUdA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgg7dYZFn63CAU4XQoxOTaQQJzUregoyudPxUHgNBpUdA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jun 2023 16:25:40 +0300
Message-ID: <CAOQ4uxhn2Z-7Wz1gqnX765Wg5sUkv_2JkUKwZWg1nPdUoa5vsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ovl: port to new mount api & updated layer parsing
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
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

On Tue, Jun 13, 2023 at 6:02=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > Hey everyone,
> >
> > /* v3 */
> > (1) Add a patch that makes sure that struct ovl_layer starts with a
> >     pointer to struct vfsmount as ovl_free_fs() relies on this during
> >     cleanup.
> > (2) Rebase on top of overlayfs-next brought in substantial rework due t=
o
> >     the data layer work. I had to redo a bunch of the parsing and adapt
> >     it to the new changes.
>
> Sorry for that pain.
> I do like your version much better than mine :)
>
> For the entire series:
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>

Miklos,

If you like, I prepared a pull-able branch at:
https://github.com/amir73il/linux/commits/fs-overlayfs-mount_api

With some more cleanups.
I will post the cleanup patches soon.

The branch above already passed basic sanity tests.
I will run more tests on it, but if you can to push it
to overlayfs-next for soaking, that would be great.

Thanks,
Amir.
