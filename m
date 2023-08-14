Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702DE77BE83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHNQ5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjHNQ5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:57:18 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA27199F;
        Mon, 14 Aug 2023 09:56:57 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56dfe5ce871so1542176eaf.2;
        Mon, 14 Aug 2023 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692032166; x=1692636966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9O7uVavugQIWG4+/30ol/uNZ+vUipg1yWncf1HB7Z8=;
        b=SXLBBu9oNOxnHeWHA3EzDEcQx4zuwk/WnRawLjvMOoFNw7dpzT1cc0Zh3imGGu5biH
         hF3gj0fRHQ72e59mu7XzFNFxxtuLAL6ZFxOgG2j4wOX+YZAVs3TkYanLQVFe+jZctHSn
         gRxqqBRQ64EUwLZkoQs6MhwsohiAS+iuZrEPX6LlKTe7wKlVSVqQ5ZUWMS2XWnv3ukdN
         xlx8rrlrQqId4/tGMozDD2l5xfvpRrFWtivaal0jSX3deLqfh+C3I6DXAEvX5W8/UQJ5
         CNDQmsfU8Esw1uGGrTs5LBHBGY5zVpcRKJdL/zTQ7JbJGkTBRoprtkOUNrZbBBQ1Hqzm
         u1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032166; x=1692636966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9O7uVavugQIWG4+/30ol/uNZ+vUipg1yWncf1HB7Z8=;
        b=CJ7eDssTBGXb/bdDoe+U+BeEtGUEnRw5bZIoXuQ7k+rRcjidn5a+RaMpoIdkCAx21x
         pNdPwbfR620dSoVDkA5xIAR7pq8oTz0D4LhXP2cXCNXLxWlb+m4L5O2aL8cs9qhJlQ8b
         qQhF0X5wy0rUswqY3o8Pn7MxiEg4179t+xZguqyizr6duc67ifapgcRVrt9Xi/XUb4iA
         KyErwI9hMhYwpcpEo95k6cE8sAs/ckWwWpvMpt2W6cpS3HWIpQCBNOPNIgi2s+9BRipV
         gwxk+nUlFNe5DWWY2AvUua9AEejMr5NKxg2WsyhHnzLv3VW9QR+V7wiIal/OLU6MJ2AE
         oSLw==
X-Gm-Message-State: AOJu0YzIl60tqzkn4qfEO/zGmM8hBaKMmXvqTBedwG/lSbY+LGIIMj4Y
        Xxr4Cmb3ZjYBwY8Ur+fzgdKagOXaNX3qZVJysSQ=
X-Google-Smtp-Source: AGHT+IGRiUAbrBbY9Vni9Tn8QSBhVGIX9TfUXofBqPCsNnEmk1YYklY4fqhqnWDK5MhusbsyCSnQmJcr7FbUisha/AQ=
X-Received: by 2002:a05:6358:9212:b0:134:e952:16a8 with SMTP id
 d18-20020a056358921200b00134e95216a8mr6760283rwb.24.1692032165879; Mon, 14
 Aug 2023 09:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96@epcas5p1.samsung.com>
 <20230811105300.15889-1-nj.shetty@samsung.com> <2cc56fb5-ddba-b6d0-f66b-aa8fffa42af0@acm.org>
In-Reply-To: <2cc56fb5-ddba-b6d0-f66b-aa8fffa42af0@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Mon, 14 Aug 2023 22:25:54 +0530
Message-ID: <CAOSviJ1b5ySAugzKExa_ZQgOzvQAOWB3D-ZRMQeGmNpQbaoBSQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 00/11] Implement copy offload support
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
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        mcgrof@kernel.org, dlemoal@kernel.org,
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

On Sat, Aug 12, 2023 at 3:42=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/11/23 03:52, Nitesh Shetty wrote:
> > We achieve copy offload by sending 2 bio's with source and destination
> > info and merge them to form a request. This request is sent to driver.
> > So this design works only for request based storage drivers.
>
> [ ... ]
>
> > Overall series supports:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >       1. Driver
> >               - NVMe Copy command (single NS, TP 4065), including suppo=
rt
> >               in nvme-target (for block and file back end).
> >
> >       2. Block layer
> >               - Block-generic copy (REQ_OP_COPY_DST/SRC), operation wit=
h
> >                    interface accommodating two block-devs
> >                  - Merging copy requests in request layer
> >               - Emulation, for in-kernel user when offload is natively
> >                  absent
> >               - dm-linear support (for cases not requiring split)
> >
> >       3. User-interface
> >               - copy_file_range
>
> Is this sufficient? The combination of dm-crypt, dm-linear and the NVMe
> driver is very common. What is the plan for supporting dm-crypt?

Plan is to add offload support for other dm targets as part of subsequent
series once current patchset merges, dm targets can use emulation to
achieve the same at present.

> Shouldn't bio splitting be supported for dm-linear?
Handling split is tricky in this case, if we allow splitting, there is
no easy way
to match/merge different src/dst bio's. Once we have multi range support th=
en
we feel at least src bio's can be split. But this series split won't work.

Thank you,
Nitesh Shetty
