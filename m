Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787277BE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjHNRCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHNRCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:02:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E5E65;
        Mon, 14 Aug 2023 10:02:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d43930354bcso3209245276.3;
        Mon, 14 Aug 2023 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692032524; x=1692637324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoOgtExPknyCjaZt6yFcpJm1OTXC8gB2XRIzfWFG1zw=;
        b=XLYg47TzlIjv0bDM3AhmFaX0S1yOUGR0Ki1gyiGdT/2yEwVkM8/9mdaMTU37WM1DT6
         ExF1EsTqfg0PvHcTo77VcOpQ4jYwSM3nKmtdF0/FJ8Oxxy92UaKByZygEwud8PnWgjJZ
         E99louhXal4GvwauXD4HIZ+pIanBpSWe3BhzNKazqDdGMDiS5paRiXveT0ouptcFvmPa
         V+57PNGVpPVN42nGM58YFn43daZnIPF9eM2j1KwSKq0YOesYSdKHe9RXf7Fk0KuDXTy9
         c76wWof7WARoY8G2dxdDjgExCVaqoDIWuUNTx2SoQZO+kdGqvNBmzIuEeLU8kSgR5G8+
         mMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032524; x=1692637324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoOgtExPknyCjaZt6yFcpJm1OTXC8gB2XRIzfWFG1zw=;
        b=ciVs1FX8PGvfmgrlQ/yHb9jfn2oOBAYpEyxjY9Jw5UL+g8f4np599DDt7ZaBz487qZ
         CAHCJGlRBgOGNNiaxD9urK4REgCdmM+2iED3598lX45PZjpykdxwJTQlCMubQfNO1jlP
         NPA/G4qDvhl/iMlla7yNHN04vorCqIt4RwIOHKpmmgMg+zqbt9uJx0agjCG6Z7tRJBrC
         ND28Hn0k2rRSrbGBxms08zUK252pZ3SBSQgSRlXvse9o7yAnYOiOTmgW7mzR6QR12oaB
         kwQRTaG5hPO39GLHB30VYicHUKbROrOOKONArhuO+VjhklhIedkWT3od8FlBcHcN9H/j
         M6CA==
X-Gm-Message-State: AOJu0YyGecuOaHB8i9UMkKDErEEAU1odBxgvd7jQsmP1uc8NTKFp6foe
        7AVC8NdzdxtoYhMj9i1yi98nSyavtXaNjIiLTHA=
X-Google-Smtp-Source: AGHT+IG4bEDG0zFs6h8QgX1qJybvmoa2ss9LjkCZgljhQecK4wSD5P/FZmnDf7b05hg7BMMrprZPOZB2OS6moqWhAGI=
X-Received: by 2002:a25:2386:0:b0:d15:f337:938b with SMTP id
 j128-20020a252386000000b00d15f337938bmr8112041ybj.8.1692032524122; Mon, 14
 Aug 2023 10:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230811105300.15889-1-nj.shetty@samsung.com> <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
 <20230811105300.15889-4-nj.shetty@samsung.com> <0899ddc3-d9c1-3d9a-3649-2b1add9b2a7f@acm.org>
In-Reply-To: <0899ddc3-d9c1-3d9a-3649-2b1add9b2a7f@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Mon, 14 Aug 2023 22:31:53 +0530
Message-ID: <CAOSviJ2+tUZ=jiOnPSi8=mOzjANwvuNXAkAG6f3ADGi=M=F5PQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
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

On Sat, Aug 12, 2023 at 3:10=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/11/23 03:52, Nitesh Shetty wrote:
> > + * Description:
> > + *   Copy source offset to destination offset within block device, usi=
ng
> > + *   device's native copy offload feature.
>
> Offloading the copy operation is not guaranteed so I think that needs to
> be reflected in the above comment.
>
Acked.
> > + *   We perform copy operation by sending 2 bio's.
> > + *   1. We take a plug and send a REQ_OP_COPY_SRC bio along with sourc=
e
> > + *   sector and length. Once this bio reaches request layer, we form a
> > + *   request and wait for dst bio to arrive.
>
> What will happen if the queue depth of the request queue at the bottom
> is one?
>
For any reason if a request reaches the driver with only one of the src/dst=
 bio,
copy will fail. This design requires only one request to do a copy,
so it should work fine.

> > +             blk_start_plug(&plug);
> > +             dst_bio =3D blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DS=
T, gfp);
>
> blk_next_bio() can return NULL so its return value should be checked.
>
Acked.

Thank you,
Nitesh Shetty
