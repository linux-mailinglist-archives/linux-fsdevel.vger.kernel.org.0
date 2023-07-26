Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89992763B81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjGZPqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjGZPqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:46:08 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE7E4D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 08:46:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so7492121276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690386366; x=1690991166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4KgyDeQrSBviYcAIl4THJ/dOEwnDjoTrG5uDNKkzwM=;
        b=PsNPRHYGxbBz6NhNZl9HzDTLscRYCauDynkogxjqM4vd7hBxQ+UoR8vRi/VGV5eAix
         i6iR+TqvHdX0HW1JfDcq3ua3fxqq1dlcy5B/RNlCMgeMhgrBtb0udwNDfUXssml9Q2gT
         IQ0ls4Pq4MVgfzZSaevYYaeMU9q+b3jTC4U4NtqLSoT6F81+KyNPbaJJKkoYdJR73WeC
         +5Ml22mdt0a2Dot9cV8j6PEMF1DZkiG3N5dRvImEXSCO3nYWII/qahD5zelN+mlXS6VH
         ORmnhXQ/Va7Q7jLftQMYzhVN+HfAbj6OerHQGyyJlvRXMUQVyWSBiohATWAA+OJkYaVe
         XM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386366; x=1690991166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4KgyDeQrSBviYcAIl4THJ/dOEwnDjoTrG5uDNKkzwM=;
        b=jQ2WODOSUmNfA1lVaeHs8EE6ErB9lEhr5osCeODN29Rc3EuVJ4o8Cs3DsXhW0SNdT2
         oc1AdnVuoY+VvTpuNgQBKqS041HBrK4FicpNHebKPIm00lROzQA2dQkybwyZV1r+Qkmz
         J8piBpYSsLqpkvvTM5TaV97RqbrXR/fftMoJobZOds3AvDNPYOSuwqlE57KcH0gV7rEF
         JGzmG6M/dWx/PjDocOPMJfMTgE5+Xpykr7JAJUyg9jN0b8uDVr7S0RDrz1Qao7NBeNXj
         L5mFNj6/76RK5NzL2S/EtFQvK34Lner/2/slz8Qv441oDnqmeXfcu0tPEF9SWY8f424A
         9l7w==
X-Gm-Message-State: ABy/qLbdAyWITl91Rc3U3aSpSpVB4MT6SheKubL/V8kwmwgdocwYdhVg
        Mu7LJ93eCZCuZktR66YYjwM4SiqpyuUL4SqAMU/vyQ==
X-Google-Smtp-Source: APBJJlF8/q7GpusPPrHAc1t8Ynbc8xtVqX7zeutqSFIS9pZYmvtcqn4HwbMgy47aDeoql3KKwDFgB8XgDhgRE6AS10A=
X-Received: by 2002:a5b:f45:0:b0:d0e:c8fb:986a with SMTP id
 y5-20020a5b0f45000000b00d0ec8fb986amr2197424ybr.42.1690386366531; Wed, 26 Jul
 2023 08:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b5e2405f14e860f@google.com> <0000000000009655cc060165265f@google.com>
 <CANp29Y7UVO8QGJUC-WB=CT_MKJVUzpJ2pH+e6WAcwqX_4FPgpA@mail.gmail.com>
In-Reply-To: <CANp29Y7UVO8QGJUC-WB=CT_MKJVUzpJ2pH+e6WAcwqX_4FPgpA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 26 Jul 2023 18:45:55 +0300
Message-ID: <CAA8EJpq2Az=8gLyFY7j3D8-P=PUAo6ydmzvvpkcfNQnA0OCEoA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] KASAN: use-after-free Read in qd_unlock (2)
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com>,
        agruenba@redhat.com, andersson@kernel.org,
        cluster-devel@redhat.com, eadavis@sina.com,
        konrad.dybcio@linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Jul 2023 at 18:09, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> On Wed, Jul 26, 2023 at 5:03=E2=80=AFPM syzbot
> <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 41a37d157a613444c97e8f71a5fb2a21116b70d7
> > Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Date:   Mon Dec 26 04:21:51 2022 +0000
> >
> >     arm64: dts: qcom: qcs404: use symbol names for PCIe resets
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17b48111=
a80000
> > start commit:   [unknown]
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe56f7d1939=
26860
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f6a670108ce4=
3356017
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1209f878c=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D111a48ab480=
000
> >
> > If the result looks correct, please mark the issue as fixed by replying=
 with:
>
> No, it's quite unlikely.

I highly suspect that the bisect was wrong here. The only thing that
was changed by the mentioned commit is the device tree for the pretty
obscure platform, which is not 'Google Compute Engine'.

>
> >
> > #syz fix: arm64: dts: qcom: qcs404: use symbol names for PCIe resets
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction

--=20
With best wishes
Dmitry
