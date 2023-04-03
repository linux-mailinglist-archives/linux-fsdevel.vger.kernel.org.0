Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5F6D4E8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjDCRAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjDCRAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:00:39 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F32711
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 10:00:38 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id l23so2578820uac.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680541237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNgBnsOaEbB6dmkQ3WCDTWtS5dqNxfOjjR+tC6EL8dw=;
        b=WiizP39DDIKc1c7DmeEP5F0m/r5J6QQjMKZI0szXEOaNIKQbOlGfZ3uoCnJtBcGEbY
         uGFxiXWw87qMcBsHUNZMuIRD1VRLk17VFUK5l0rOsKruq0nAU055uZ3XJOtCneQBq0yC
         gkt9IMrau/kgH8DVWUQWP2A/CSmEfUKPyfCASso1XEP/NpYXUnxQF2lh94laPBzHyVcv
         UVrlV0x6A8MDGSE4t0k9+6X3jl37l7FQocSUV0iredLBdrHjZMdSHP42NvS9YM6YdH3c
         VhvcKNHjuvfB0+F2c9NXrCcd+fj0BiGrdIKUzgyXPxdXRXhDroGj9M1etVEOzBBEvBy+
         St3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNgBnsOaEbB6dmkQ3WCDTWtS5dqNxfOjjR+tC6EL8dw=;
        b=noVHzP6Cw4Se58qbvyLTN9IEoKq1Fp5fQJh9p90qN5LPSoeyYWznzgchPRK959ZXSH
         sef58QhWFVrj2zk7hNAQiSUPseiyxXiH3Ni0sQ84t+vFVBPk5Uef1IOcYx5RTpGoakUI
         OgVBmPD6qV6tT8fyW4DVTecQ2//DmNT7q8miGDzT/NASjOIBY1o04WqvJcvhvSLZdcZH
         1EVQ+IAuRgZtD+Qk7VttnGLouwZDpsnXHKcx94TxpdxorovIjq4iVmLRVYC7R83SaIgE
         x3Bbi1MblbyuzPZ0pwealy6r3+ok9Xh9I1hdU4/ivNf6H7/NZ3MtsTxINt/9Ctkab+Iq
         FLsA==
X-Gm-Message-State: AAQBX9fZsaspRFyHIANwtfzcQftWqv/GQg/wsrMUSrFI846+L/TPZko8
        2uIrRxDi2PJq2FPiLmgkbmlsAjnu7TegGTZVtUE=
X-Google-Smtp-Source: AKy350bgov0M3miNLViedPIZuLi36RDSs5QV0VUBegdwr6jBqsCbozMkZin7rlYxpzqM5aSp1+zsSU5UVna5SYfE1k0=
X-Received: by 2002:a1f:31d3:0:b0:43c:3dd6:5535 with SMTP id
 x202-20020a1f31d3000000b0043c3dd65535mr131465vkx.0.1680541237472; Mon, 03 Apr
 2023 10:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230322062519.409752-1-cccheng@synology.com> <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 Apr 2023 20:00:26 +0300
Message-ID: <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
Subject: Re: [PATCH] splice: report related fsnotify events
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
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

On Wed, Mar 22, 2023 at 9:08=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Mar 22, 2023 at 8:51=E2=80=AFAM Chung-Chiang Cheng <cccheng@synol=
ogy.com> wrote:
> >
> > The fsnotify ACCESS and MODIFY event are missing when manipulating a fi=
le
> > with splice(2).
> >

Jens, Jan,

FYI, I've audited aio routines and found that
fsnotify_access()/modify() are also missing in aio_complete_rw()
and in io_complete_rw_iopoll() (io_req_io_end() should be called?).

I am not using/testing aio/io_uring usually, so I wasn't planning on sendin=
g
a patch any time soon. I'll get to it someday.
Just wanted to bring this to public attention in case someone is
interested in testing/fixing.

Thanks,
Amir.
