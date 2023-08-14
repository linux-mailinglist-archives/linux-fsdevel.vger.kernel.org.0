Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D077BE8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjHNQ7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjHNQ6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:58:45 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4DA1FCF;
        Mon, 14 Aug 2023 09:58:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bd0425ad4fso3881204a34.2;
        Mon, 14 Aug 2023 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692032309; x=1692637109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UJyFzkhfPV1LXyzB0ge0qlS62RRiQrpMwsiRYTQDRI=;
        b=FDNjxoV6HizyNME4qceOyz2W/T/QvxPUaeKiIaQ5S2HaIiL+mCb5lwmFEqCKAXCfNC
         hF45qfgBBL/md9Xsf7IYuuqBRy8X8CUaK08JDJ6eXBGVA8kUIOltMVr7G1LMW0zlwVUD
         0U2Jq5THfYuI4WsaWaLl3g/YI8wEFKWf+uHsvTpWWM3i1BOpPiyHsrW7ALDkfsNv6DTX
         8l8ecOKJrGy/qVCNP8+95c96htmtisRcfZmhYjvWsBRaToCisEc898dWFyYLHeEdVsKS
         nk71Rg2gxhsYhI1yHLGmHjv/txtoYtA+pttVNlloNW7utArWjbcdjDTNPDKI31KHuDHH
         ck6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032309; x=1692637109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UJyFzkhfPV1LXyzB0ge0qlS62RRiQrpMwsiRYTQDRI=;
        b=ePiGag00MEmgZtvxFSVrxkCWMlji2LbOaIq5sALRnN6glbgvmb+ijlRuBB/dA2+hHE
         J2LKJ2ZLeoaqn6cLbJePjSN/aBYD+9oEUx/+aRp6XRR3F5P5+W+XGFKJ4HC+ePv8iC+z
         scG/tLgQXpAIi7QTuHG0jRe81CRP9gcr7AA5wNMccEX04fFlKFueTKV3/NBwBMPT/lyM
         wWedD24k+dXCIC1brCzGv0M5qRr45QufY9KaFHm4LdUl5YIprKcJmOJCKeIk7AMhVQ7H
         Tg2nDQ4RU+8+AnPCVM5MAEo8f0YPLplUnb0ZISwIxxtnK7GGDZZwbYn98AqPlDAWBoA+
         MChg==
X-Gm-Message-State: AOJu0YwH3prAlyy5xC/LwhnFK/74jVcWpPnTtqC/DAu4oovYLy1zcyYO
        4ilroeTM5Lc6OxNEv/JLSsov9Zgc5aEown+xcYo=
X-Google-Smtp-Source: AGHT+IE9LDZ83v2hgug7emDF5KyYh5EtftbM06X5OK/zdRBDKO/Jg4fRYrCeL75t5wx91fwlfKtCCIuFBCXTW1QrU9s=
X-Received: by 2002:a05:6830:4dc:b0:6b9:bd9d:e333 with SMTP id
 s28-20020a05683004dc00b006b9bd9de333mr10451524otd.3.1692032309587; Mon, 14
 Aug 2023 09:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230811105300.15889-1-nj.shetty@samsung.com> <CGME20230811105713epcas5p3b5323a0c553006e60671dde6c72fc4c6@epcas5p3.samsung.com>
 <20230811105300.15889-5-nj.shetty@samsung.com> <57558d7b-4444-b709-60bf-5a061cd6c3e9@acm.org>
In-Reply-To: <57558d7b-4444-b709-60bf-5a061cd6c3e9@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Mon, 14 Aug 2023 22:28:18 +0530
Message-ID: <CAOSviJ13RJd4gTL2dzXrijXLaPUCB-pGG6x+_8ouW=7REO6e7g@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 04/11] block: add emulation for copy
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>,
        martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 4:25=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/11/23 03:52, Nitesh Shetty wrote:
> > +     schedule_work(&emulation_io->emulation_work);
>
> schedule_work() uses system_wq. This won't work for all users since
> there are no latency guarantees for system_wq.
>
At present copy is treated as background operation, so went ahead
with the current approach.

Thank you,
Nitesh Shetty
