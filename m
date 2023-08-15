Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6777C8E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjHOHuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjHOHu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:50:26 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193111A;
        Tue, 15 Aug 2023 00:50:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d62ae3fc7f1so3876934276.2;
        Tue, 15 Aug 2023 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692085824; x=1692690624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA7UNvLh/NtwE8oB7thsQ+ZgxpcPVqBILp5Db1EACXc=;
        b=i0vKNHq1GyS7aJEKx4XbRrsU+PCcQIEbW/RUDNyYjiAhDowmhMMCSpCW5uqmbQYhfU
         0aUkNENEhyHUH4Og5FtJz4fLzUNs8pGPtvJaT5Pkmq4GcQ/RG1xOk8lJmVot4NzXWVVT
         +EMe6Dsl16OBo1dKVXSrxy5sAXiDQQSezHfSLr+N0mYaql5ivZV9RC8qIGjF3BhqSdKg
         j5NtGUd5VhucPZcectiLfIEWE2KX5unNEKK4w7eXIN6v5EBbc+sUKe2KXowzCE0hsBLU
         IEfIZ1j3G9HfgN28SkhRqgplcntyqqZY6LS3sxLFknEs9+E4rix/NQLSeE45SDLAtyzU
         d/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085824; x=1692690624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA7UNvLh/NtwE8oB7thsQ+ZgxpcPVqBILp5Db1EACXc=;
        b=ZHhllPBDibaR25bl1IevukHuIbk7uRzkHANvYN1CmWW98uxOV1zfwPk1UbGCfQcU1M
         kV7dw8eI+4+oo8lqC0To6mYc51xwsBQjs50VqSEHFf+WzXIC5k8WTG7e4ab9m6Xg6/r0
         YAjOA2A2TdEsBBuGeehR40LwTFq1w9zHUVGOOPCt1i8uTV5zAur1hNIXwHSo2GICeJjF
         lFNKWbySHasMKY65CWu+Sfcq13RqSBOe6zIofxlnVdfC6/qLiNm3YMweo1i9VeIP6ao7
         bivC7WVgsYiFSeYrxgi+7FTbSAyEsxqSKON4+zBGPc8tynTqrpYKJv5BwnkhjQ/p4tLW
         uOAA==
X-Gm-Message-State: AOJu0YxUZiu2Pd7rLB5Mdh5Ml6tGhbBPj+M4ftq9Mg807IchFZzNlM88
        n/rWOIKSf2UA3z+pjnJD1vECX8JnT6nm4zl3z2s=
X-Google-Smtp-Source: AGHT+IHaiDSMY+QkhVwb3BPgUZZO+nmIvLSHf5aXIVOauSuFeN6IaJFsD4dH94ZZRJntrGxxCFrmO4AX2M6byBZ62ig=
X-Received: by 2002:a25:bf86:0:b0:c83:27d4:c0d6 with SMTP id
 l6-20020a25bf86000000b00c8327d4c0d6mr9479331ybk.37.1692085824032; Tue, 15 Aug
 2023 00:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230811105300.15889-1-nj.shetty@samsung.com> <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com> <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
 <20230814121853.ms4acxwr56etf3ph@green245> <abad92af-d8b2-0488-cc75-01a3f4e8e270@acm.org>
In-Reply-To: <abad92af-d8b2-0488-cc75-01a3f4e8e270@acm.org>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Tue, 15 Aug 2023 13:20:12 +0530
Message-ID: <CAOSviJ1XL1UyMk2Ur37cJpW5BJAE5Ts6J4BtTSRd2_h_NPtGCQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
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

We had kept this as a part of blk-types.h because we saw some other functio=
ns
trying to do similar things inside this file (op_is_write/flush/discard).
But it should be okay for us to move it to blk-mq.h if that=E2=80=99s the r=
ight way.

Thank you,
Nitesh Shetty


On Mon, Aug 14, 2023 at 8:28=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 8/14/23 05:18, Nitesh Shetty wrote:
> > On 23/08/11 02:25PM, Bart Van Assche wrote:
> >> On 8/11/23 03:52, Nitesh Shetty wrote:
> >>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> >>> index 0bad62cca3d0..de0ad7a0d571 100644
> >>> +static inline bool op_is_copy(blk_opf_t op)
> >>> +{
> >>> +    return ((op & REQ_OP_MASK) =3D=3D REQ_OP_COPY_SRC ||
> >>> +        (op & REQ_OP_MASK) =3D=3D REQ_OP_COPY_DST);
> >>> +}
> >>> +
> >>
> >> The above function should be moved into include/linux/blk-mq.h below t=
he
> >> definition of req_op() such that it can use req_op() instead of
> >> open-coding it.
> >>
> > We use this later for dm patches(patch 9) as well, and we don't have
> > request at
> > that time.
>
> My understanding is that include/linux/blk_types.h should only contain
> data types and constants and hence that inline functions like
> op_is_copy() should be moved elsewhere.
>
> Bart.
>
