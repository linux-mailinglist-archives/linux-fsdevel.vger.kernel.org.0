Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34BD765135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjG0Kan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjG0KaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:30:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D501984;
        Thu, 27 Jul 2023 03:30:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d167393b95aso2880069276.0;
        Thu, 27 Jul 2023 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690453800; x=1691058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omUaDYixzWjtTMpLHRqhT6EXYqbxVHZ/m0JLSVt+zRU=;
        b=kR/E8OXTGyuAcMVnK2KQrLklJTZJIbjeBJSeT2sIhGPM65Oruur9kofklO6ietHDy9
         iN+Yk3uFFi0DCH5b+KIEtuBcPluVBtavpypaR5WD07CSqNhopnv+R23ky6tSh9IjXGJk
         GzdeqRWRPgntqPs3w/iwM7pGLzDbKoIc/aZkfpT2kgbAlhsGaHHBFI9ifZTJ75RImlBN
         m18KEttAN2mbFemlm21ARI+oQPZWhQ5ZKjtL1LwA/zUs5OtenG40a77AVnpCBMgIji09
         cexZ5ek/pfpL8k5LTc7yy93lENk2O4UsiIb8Ws8buCdDhR4wb5xCwrRekry+fPBuluvl
         CgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453800; x=1691058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omUaDYixzWjtTMpLHRqhT6EXYqbxVHZ/m0JLSVt+zRU=;
        b=Nu8Cnj1AU3YMdobcxa6j38XTBGUDdHZm7Ky9rG3bDO6Bpsc5YvUwy4Ls4JKoI0vE6p
         fDRcYuQBDmF1ol3FOqfI90Sogn5jarlnblz6QRZXQpjzDD5W+OmymYPd8yXvWZko/99u
         VrwsIC/nMpSmNo8Xab1qUjBS+oIaGidWw90Vj1kfg+DGTRLindzQd33933aP8lyqXJG0
         DpXdeYo0nCkTUSEE2HuiuyW6dltaAnJ/VnE27ZuIhN6K3byMWznT2jBaN3wmlZOjYJsA
         Z00EgGMUVC75B0bGE45zLiKc9SWm4nE7tnnh7h1Gl6at2Uw1xhkFlYYIXIQEkNLmTdKD
         8p0g==
X-Gm-Message-State: ABy/qLbE5I+ILduGkww569LqrERsogemz2UFR91B88us+mQ8g+lkSqf3
        g7cn8Tog7LvzodQZUyykbJGa4M+vux4fv1nTERE=
X-Google-Smtp-Source: APBJJlHBlYlPNCAOaUQmX7sCh/RdKgzYXiRFfLFaMRkHkke9meK1yv0x0Ok78z4gqgOSPSppdBIT7tY7YrKsz3aQ6Jo=
X-Received: by 2002:a25:3617:0:b0:d1f:8809:ffa1 with SMTP id
 d23-20020a253617000000b00d1f8809ffa1mr2701868yba.27.1690453800151; Thu, 27
 Jul 2023 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9@epcas5p4.samsung.com>
 <20230627183629.26571-3-nj.shetty@samsung.com> <20230720074256.GA5042@lst.de>
In-Reply-To: <20230720074256.GA5042@lst.de>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Thu, 27 Jul 2023 15:59:49 +0530
Message-ID: <CAOSviJ3oDSHk2HXyRZa=A43vCxh-n2YkyuW-qXNq-q=i6bNacQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/9] block: Add copy offload support infrastructure
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
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

On Thu, Jul 20, 2023 at 1:12=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> > Suggested-by: Christoph Hellwig <hch@lst.de>
>
> Hmm, I'm not sure I suggested adding copy offload..
>
We meant for request based design, we will remove it.

> >  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
> >  {
> >       if (req_op(rq) =3D=3D REQ_OP_DISCARD)
> > @@ -303,6 +310,8 @@ static inline bool bio_may_exceed_limits(struct bio=
 *bio,
> >               break;
> >       }
> >
> > +     if (unlikely(op_is_copy(bio->bi_opf)))
> > +             return false;
>
> This looks wrong to me.  I think the copy ops need to be added to the
> switch statement above as they have non-trivial splitting decisions.
> Or at least should have those as we're missing the code to split
> copy commands right now.
>

Agreed, copy will have non-trivial splitting decisions. But, I
couldn't think of scenarios where this could happen, as we check for
queue limits before issuing a copy. Do you see scenarios where split
could happen for copy here.

Acked for all other review comments.

Thank you,
Nitesh Shetty
