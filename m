Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2323CB765
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhGPMhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 08:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237493AbhGPMhv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 257A8613EB;
        Fri, 16 Jul 2021 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626438897;
        bh=8oSShhkIfW1t+XoSC5QjALfMGrJlfUvBnSJjgbK3dUU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RE3E3apIjL37m9puTMaJRWXtg4wvv5pQJ++HzsRrfvFc+6K0xhirXwfr5FY4SfyXf
         SNS1FmBCSlhtE+WirH3Aw2XTU9LRvm/ag+nCT9PyJMJpGiCDQWtQqnTpZtGMf3vUp0
         R40buGaI6IsqJVqMuORqUXuX5jJQB6FTASMBykv6W3N+vsfOmiBCsThBW/uOVW69cH
         iYORXYgJLPIKU5SljBe4j0WoquY3opRecUWHabQXjHKC7ErA7H99CdCDXmGpIyuURk
         mseoqjDkYJcW2gCPtSyVPjOVSQeXsYHiD/etqkSKO6HK6kZWWSUYDCSczdL+XLOFUG
         qHjxwqonSKfgw==
Received: by mail-ot1-f41.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so9698360otl.3;
        Fri, 16 Jul 2021 05:34:57 -0700 (PDT)
X-Gm-Message-State: AOAM533gM2KWHv0GG8zHz3NGtCR2LaI/k8/zA4Np1gWztJj84r62ncyJ
        SaCRBb9v3ZFkCeLPmk2eeU4Gu1jxKaKXWkvFcG0=
X-Google-Smtp-Source: ABdhPJyjt4E+0BOmUYSSQ6pS521inDb618V4rGsb+1/LSSqH+21otdkyBWisA+zwqcCWMMK8TvRofOxu9ckWzJ8oWzo=
X-Received: by 2002:a9d:3644:: with SMTP id w62mr8212190otb.205.1626438896478;
 Fri, 16 Jul 2021 05:34:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:4443:0:0:0:0:0 with HTTP; Fri, 16 Jul 2021 05:34:55
 -0700 (PDT)
In-Reply-To: <69f734b3-7e1a-6c9c-d2cc-4debf6c418ca@samba.org>
References: <CGME20210716000346epcas1p4fecf8bdde87dd76457b739fc3c1812a3@epcas1p4.samsung.com>
 <20210715235356.3191-1-namjae.jeon@samsung.com> <69f734b3-7e1a-6c9c-d2cc-4debf6c418ca@samba.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 16 Jul 2021 21:34:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_L5owJE7yyHL5aR5-F5oPke-sh=HGGinPDGUCgVa4V7w@mail.gmail.com>
Message-ID: <CAKYAXd_L5owJE7yyHL5aR5-F5oPke-sh=HGGinPDGUCgVa4V7w@mail.gmail.com>
Subject: Re: [Linux-cifsd-devel] [PATCH v6 00/13] ksmbd: introduce new SMB3
 kernel server
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        dan.carpenter@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-07-16 17:35 GMT+09:00, Stefan Metzmacher via Linux-cifsd-devel
<linux-cifsd-devel@lists.sourceforge.net>:
>
> Hi Namjae,
Hi Metze,

>
>> Mailing list and repositories
>> =============================
>>  - linux-cifsd-devel@lists.sourceforge.net
>
> Wasn't the latest idea to use linux-cifs@vger.kernel.org?
Okay, I will add it on next spin.
>
>>  - https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next
>
> I think you should also include https://git.samba.org/?p=ksmbd.git;a=summary
> here.
Okay.
>
>>  - https://github.com/cifsd-team/ksmbd (out-of-tree)
>>  - https://github.com/cifsd-team/ksmbd-tools
>
> I would be great to have an actual branch with the posted patches,
> I didn't found any in the above repos.
>
> I would make it easier to have a look at the whole set.
Okay, Will add it in next spin also.
>
> Thanks!
Thanks for your review!
> metze
>
>
> _______________________________________________
> Linux-cifsd-devel mailing list
> Linux-cifsd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-cifsd-devel
>
