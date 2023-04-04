Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504F36D63B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjDDNqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjDDNqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:46:15 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5875248
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:45:59 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id e12so23311883uaa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Apr 2023 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLuB22DJ95IrMYf0oxR3oaM5hvr+ULcAoWT4C+7bcXs=;
        b=bKQQECAyesieGLTaHOt1AqGsp6esAhybn3oofwA3s+nFNQbWuokaHYDGOfvTJ8A0fd
         pct8pzHRASqhtPn+G+FBUhrtHaLXPCG9zTMPnhHu6Awg9tXxdSkut41dV433g1fF1dTA
         dVYfdRgh7q2dd7H84z7UtA9k2VdlMOL0cwnhBiT1p3i9EwnFsKNp9/UHoQghRWNPjh+a
         1sxanEuXHPldDPtC14t5T/24NQY57fK4m/0NnNu3D1W23dlLD6ojztnYxNcAlN5ygbve
         N3Dr14WpEINGBhPkkTKqdubHsZwVxIa8Cqxx//vqxJJ9h7UDFQFIts6JSYQPjchh1yYS
         5jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLuB22DJ95IrMYf0oxR3oaM5hvr+ULcAoWT4C+7bcXs=;
        b=Mu7klpvdnw17XiOJ/oGwR020FJOxFe8xOCckk6KGs5A/jsgzYlvd7GqCve+8mGnGa/
         cDYWwVmhUY4KJRsupbKkxuKLCd+AcGLzIVD0ERmFteIP7IU4NeMtztIBlm85iUJtVH25
         YoneRvbmzdcrXNXiLzdvwW9ziksK5KuvQqB71UFrMhn1JNLD03hyUUdQ8VsWW12MOAcj
         M56Y+WSRcjMt4WrC5c4CkXW/yg3mfus3pl3voTZnLnSkzCxjA3ztHgbCGCVWumaat4Jh
         V5n6kKIcXVR3rSmeVt5Xcaqk35B/XeM81IvYLwJXzahSZws6jDEoWllWIuCxRl21uZ95
         3wfA==
X-Gm-Message-State: AAQBX9fNNbeVkV7FC8aMe96HLyIK+5KTxt6MG04tjwSoXikpiGKoMYou
        Tj/be26P8JsMS4gj8ujcUJwoEQOBks4DbrWC+UE=
X-Google-Smtp-Source: AKy350ZvQWmunb3ZmdGz75zZC2NP3k84REWOVJQg8lYqjBWhG7Yzo9vJzEWzsrl84OodKBjK4hYOi0vCaZqrcYeh+0g=
X-Received: by 2002:a9f:3110:0:b0:68a:a9d:13f5 with SMTP id
 m16-20020a9f3110000000b0068a0a9d13f5mr1718115uab.1.1680615957953; Tue, 04 Apr
 2023 06:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230322062519.409752-1-cccheng@synology.com> <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
 <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk> <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
 <80ccc66e-b414-6b68-ae10-59cf38745b45@kernel.dk> <20230404092109.evsvdcv6p2e5bvtf@quack3>
In-Reply-To: <20230404092109.evsvdcv6p2e5bvtf@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Apr 2023 16:45:46 +0300
Message-ID: <CAOQ4uxiCKRVe_hVM7e8t3UGcnbBNEBUiZPa5Jrmh02hCkAPq8w@mail.gmail.com>
Subject: Re: [PATCH] splice: report related fsnotify events
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 4, 2023 at 12:21=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 03-04-23 11:23:25, Jens Axboe wrote:
> > On 4/3/23 11:15?AM, Amir Goldstein wrote:
> > >> On 4/3/23 11:00?AM, Amir Goldstein wrote:
> > >> io_uring does do it for non-polled IO, I don't think there's much po=
int
> > >> in adding it to IOPOLL however. Not really seeing any use cases wher=
e
> > >> that would make sense.
> > >>
> > >
> > > Users subscribe to fsnotify because they want to be notified of chang=
es/
> > > access to a file.
> > > Why do you think that polled IO should be exempt?
> >
> > Because it's a drastically different use case. If you're doing high
> > performance polled IO, then you'd never rely on something as slow as
> > fsnotify to tell you of any changes that happened to a device or file.
> > That would be counter productive.
>
> Well, I guess Amir wanted to say that the application using fsnotify is n=
ot
> necessarily the one doing high performance polled IO. You could have e.g.
> data mirroring application A tracking files that need mirroring to anothe=
r
> host using fsnotify and if some application B uses high performance polle=
d
> IO to modify a file, application A could miss the modified file.
>
> That being said if I look at exact details, currently I don't see a very
> realistic usecase that would have problems (people don't depend on
> FS_MODIFY or FS_ACCESS events too much, usually they just use FS_OPEN /
> FS_CLOSE), which is likely why nobody reported these issues yet :).
>

I guess so.
Our monitoring application also does not rely on FS_MODIFY/FS_ACCESS
as they could be too noisy.

The thing that I find missing is being able to tell if a file was *actually=
*
accessed/modified in between open and close.
This information could be provided with FS_CLOSE event

Thanks,
Amir.
