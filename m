Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E1764AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjG0ILk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjG0IKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:10:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B89B2704;
        Thu, 27 Jul 2023 01:07:31 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-577ddda6ab1so9160567b3.0;
        Thu, 27 Jul 2023 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690445202; x=1691050002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnWFpt95Q3j8e7MLb3EqSgHRbu05nFOkNwUSTleai7E=;
        b=aXUsQ8/fEEeIVnty+3bsScnD48iuOFMA/lXYFJu+8jVcSjQE8dJcEzmSz7pleCnnEp
         ebkIz4M9tSzUmHN1+2XUD3THlcodhxXPL5j2Jb5ICm69QHCov6hY9SSAbREl64gdPqR6
         V4Gye1UgSbbeWo0y9pOVAh9OSCP23Sh6skCaY7vr+dmNXcj5b9vHP/+VWwTTdlgzk5V9
         P0OGfQ3b/YcMjrFOvTwm0ho5ZNSQA7F97ALlpfmm/pyly8KFpcF+L0vp9uAOtOOFaCWl
         LoKel1Vw8lc4QqgbCFEhznoG4SoDFC5cQI9M28jAGnuSfTQMTsQExGXOLB0WkiAIb6im
         IsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445202; x=1691050002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnWFpt95Q3j8e7MLb3EqSgHRbu05nFOkNwUSTleai7E=;
        b=b1mZv83AQ9QJkS1zjp5GHjlxBMn/aQlSOFWOQ087eU431v4BQS52Epgd6JC4WwJKnL
         lAvgDWnWIqvXkIL1zPvAsEngp+1HDa2H5OjUQxGH+utHTAQUZVRCJWeQMNw8VF+EpR1+
         YKtR0ibwqxR2aR5RB4KLLo2ROR3pc3mEgv5/zq2uSSg2OoePZs+SFB29ax2g/wcECE2k
         q/ev6OdsSjVAvPEc+FcOZ4QAlXtf/7FNgQ/WaPIzOSMLgNANtFkh7mKPhKn9EKcTMtpM
         JnuYfShI8Jv1ytTYwt5PJdGbe7JnPgcHYUJWGIC6rAMTF4hbjv5PsHNsfeSHWzvtGbna
         d+Vg==
X-Gm-Message-State: ABy/qLbkE6ukbDFU0Bg1Wik0FIHjy/K8fJPaXlpIocSMFvFrNKsbMgHe
        YeR8K38kagymKGYr5ewPyFOaWp19y5KWsSOD8iA=
X-Google-Smtp-Source: APBJJlH30/jlnH5SmnxS+zKhKs/V7g/mAPXehe2n3RR59HUyByZM1u+swtqS9Rtjc3ZTfOwHpuXxA5rXobngfkYHhT8=
X-Received: by 2002:a0d:dbcd:0:b0:56f:fd0a:588d with SMTP id
 d196-20020a0ddbcd000000b0056ffd0a588dmr2448456ywe.8.1690445201803; Thu, 27
 Jul 2023 01:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-11-amiculas@cisco.com>
 <CALNs47ss3kV3mTx4ksYTWaHWdRG48=97DTi3OEnPom2nFcYhHw@mail.gmail.com>
 <CANeycqqTdL9vr=JF+Fij5EY0TW_+_FY1p2qGdvGhYcyH9=9J9w@mail.gmail.com> <CALNs47s=eXJ-=s7WiVSBoqgcKSqkuZemm_Lx_Ts7yoaOp_e13A@mail.gmail.com>
In-Reply-To: <CALNs47s=eXJ-=s7WiVSBoqgcKSqkuZemm_Lx_Ts7yoaOp_e13A@mail.gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 27 Jul 2023 05:06:32 -0300
Message-ID: <CANeycqrGTB3Pd1JBoYHgLHU=ckBQjdv1oZt+no31aZ5UXHW8uA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] rust: puzzlefs: add oci_root_dir and
 image_manifest filesystem parameters
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com
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

On Wed, 26 Jul 2023 at 21:02, Trevor Gross <tmgross@umich.edu> wrote:
>
> On Wed, Jul 26, 2023 at 7:48=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gm=
ail.com> wrote:
> >
> > On Wed, 26 Jul 2023 at 18:08, Trevor Gross <tmgross@umich.edu> wrote:
> > >
> > [...]
> > > The guard syntax (available since 1.65) can make these kinds of match=
 statements
> > > cleaner:
> >
> > This is unstable though.
> >
> > We try to stay away from unstable features unless we really need them,
> > which I feel is not the case here.
> >
>
> Let/else has been stable since 1.65 and is in pretty heavy use, the
> kernel is on 1.68.2 correct? Could you be thinking of let chains
> (multiple matches joined with `&&`/`||`)?

Oh, my bad. I got it mixed with "if let guard" (issue 51114).

And yeah, we're on 1.68.2, so this code can benefit from this simplificatio=
n.

Thanks!

>
> >     let Some(oci_root_dir) =3D data.oci_root_dir else {
> >         pr_err!("missing oci_root_dir parameter!\n");
> >         return Err(ENOTSUPP);
> >     }
> > [...]
