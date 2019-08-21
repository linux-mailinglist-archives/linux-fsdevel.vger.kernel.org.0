Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0F986A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 23:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfHUVho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 17:37:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36364 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfHUVhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:37:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so3618397wme.1;
        Wed, 21 Aug 2019 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGamQBqn1keeDQN/dGpkbx0uGpXlzGw+M6ZDH31XElA=;
        b=RbBqg9V8SrwdXevvHNV0QKavqk/28xEtPZ3W/OlWlz8+aKGa9kG5/6fWjPax/AByHW
         6mYDCOBP2FfikHJCKQZ1o8qe5bpRJMZkibEAZTCohh1gbMxJJp1VlYMfoAwcgbKsz1Iv
         CeXTP4sT9dAup43HxREz/U1SvMxD0fW/dUdFRqSRuNMA4Flc+ya5pwFtjR3Ulbk05IHk
         dYsUAg3Ahqp3d6sCv28s3axERBLG+O982Co8NF5XSCkK7I1KbqKpypTuhODD9VOlI+pu
         Q+ltJtwjnlVEwd+AUU0UuKUCX6ei/l6y28QyKzzzkPcqzmNH6MzlBRh128CzrxtHExgA
         noLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGamQBqn1keeDQN/dGpkbx0uGpXlzGw+M6ZDH31XElA=;
        b=nWsLzqiKLF7HSfrKil9fkYGl7VNBQRoi7T8tO+97OkpW4ZGhPag5+3XRRPBiG1f0sr
         iZTLskGoCcMQZYvIZcxreMZFT5nx5Zn9qHVe9odMZzDal7XqRmsa7UT8TF/CuJNfmNUv
         kqpAawnTQjp9rqWLU9bOF+yhpDmdYqz9AqJWP4yzdQlGkQ9Gez+M+FRidebWJ2aHStHH
         gyu4h2MZ5/mLnGFzyfwjHpLaRmLDA3hTMkZtAZt0ng4+ZAP4agrLniKvAZOY85nK1SUF
         nZ5KCCZI+APR7MU/FyJ052o/PR5Lvzhpf8ONEBjYABUozn46gLcbr9TEC3XkLwRYQllM
         DgRg==
X-Gm-Message-State: APjAAAVmR1f9HiLqom04M+fbBvQxUZ7ngoK/sh7EO9v2hK7xJs4ExLJ4
        lf0e8/Y4194YXQC1pl8C3NnXb6641CwnGTMtJwQ=
X-Google-Smtp-Source: APXvYqxoaRWdCrsG/kgUVdNL3EM8gAOA2OOvXziMDbBBHuofOfCBAtKBmJ71Tdi0++f91VjW0Uc3UJepG9e22e4bECM=
X-Received: by 2002:a7b:c155:: with SMTP id z21mr2225753wmi.137.1566423461598;
 Wed, 21 Aug 2019 14:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at> <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 21 Aug 2019 23:37:30 +0200
Message-ID: <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
Subject: Re: erofs: Question on unused fields in on-disk structs
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gao Xiang,

On Mon, Aug 19, 2019 at 10:45 PM Gao Xiang via Linux-erofs
<linux-erofs@lists.ozlabs.org> wrote:
> > struct erofs_super_block has "checksum" and "features" fields,
> > but they are not used in the source.
> > What is the plan for these?
>
> Yes, both will be used laterly (features is used for compatible
> features, we already have some incompatible features in 5.3).

Good. :-)
I suggest to check the fields being 0 right now.
Otherwise you are in danger that they get burned if an mkfs.erofs does not
initialize the fields.

-- 
Thanks,
//richard
