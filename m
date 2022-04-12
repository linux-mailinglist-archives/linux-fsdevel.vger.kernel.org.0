Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22124FEAB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiDLXoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiDLXnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:43:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A4EB0BA
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 16:25:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k5so485269lfg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 16:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEf3ghNJkoFaoWuY+1wI1QnhHwrm43YYsrClV3MyqfI=;
        b=REbi327RrkR6HSTgkHSf+nZ3SQfIOuOq2YEO+YINnAhIuEKbRbk23Oj4KWA5yWFdXF
         pBvcZAq7HFUQl0JgP0of0X9f+/dcqWixfDipfytfFy4mshNdYQsjyIWrzcStRvzJxz72
         pzBvPQjmX1wRRKbyjJuqOV/6DQkkGws4nvIkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEf3ghNJkoFaoWuY+1wI1QnhHwrm43YYsrClV3MyqfI=;
        b=lSNl3YRpecH0AjNg/yTGkUZOOYS0lxAWCCmDn2RZNebRetIyx4+KIslnV8R1Db8ETj
         VUymaZpCOok8vDHm33270ZR3+42pBEbG8WVyfgwkys5jToM9bXAv8PWT0PUSXY8ge0AL
         YLrRHUkh735CNyIcOUP2raZWjeuXiRirZyPGB2ny062McNHsdS5qHV2yq829dv0f4s7M
         gwi4dKSjGUDXG9HhYZO2RLE7nxSImZDC74/953RVH9adRpMzxY7Qm7SUzNa5hc1/c0QW
         eZOilW+xM0lWgWUgy+n8Ys6BXCFwPkVDybNoQXdHsq5Fyv3f5NH5fJpy7EHAMZfddSxm
         zs0A==
X-Gm-Message-State: AOAM530yVWNSitae/MjpEi7UTQojkCVl1SFdaIeAR13h3WZhfy6j0cR0
        GQfcWC2s1dC+alH+AhSQ6IE3LMxTUDnLCa/H
X-Google-Smtp-Source: ABdhPJybvIQa0eh56gVV4SB5XbuK7UXRBPtI0VfIjrQRoxYwiumAS6ngJ+ASiWBHxCjY7sKgR5CDQw==
X-Received: by 2002:a05:6512:1054:b0:46b:e17f:e1eb with SMTP id c20-20020a056512105400b0046be17fe1ebmr814804lfb.269.1649805919459;
        Tue, 12 Apr 2022 16:25:19 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m5-20020a197105000000b0046bab1edfddsm721147lfc.264.2022.04.12.16.25.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 16:25:18 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x17so480407lfa.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 16:25:18 -0700 (PDT)
X-Received: by 2002:ac2:5483:0:b0:46b:9dc3:cdd4 with SMTP id
 t3-20020ac25483000000b0046b9dc3cdd4mr11503890lfk.542.1649805918419; Tue, 12
 Apr 2022 16:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
 <alpine.LRH.2.02.2204120520140.19025@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiJTqx4Pec653ZFKEiNv2jtfWsNyevoV9TYa05kD0vVsg@mail.gmail.com> <alpine.LRH.2.02.2204121253260.26107@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204121253260.26107@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Apr 2022 13:25:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=whu4qvXYPwh3HS1bcJMOuMiap_g8=EqcHb7P3TQyvM6Cw@mail.gmail.com>
Message-ID: <CAHk-=whu4qvXYPwh3HS1bcJMOuMiap_g8=EqcHb7P3TQyvM6Cw@mail.gmail.com>
Subject: Re: [PATCH] stat: fix inconsistency between struct stat and struct compat_stat
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 7:42 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> As long as both major and minor numbers are less than 256, these functions
> return equivalent results. So, I think it's safe to replace old_encode_dev
> with new_encode_dev.

You are of course 100% right, and I should have looked more closely at
the code rather than going by my (broken) assumptions based on old
memory of what we did when we did that "new" stat expansion.

I take back all my objections that were completely bogus.

             Linus
