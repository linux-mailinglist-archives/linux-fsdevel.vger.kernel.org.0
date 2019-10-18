Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E48DC060
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632754AbfJRIxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 04:53:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33947 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731761AbfJRIxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:53:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so4101229lfm.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2019 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QvykNFbnNXUA/35cmCwECruIwHVAP9FS5vmkV2rcJVc=;
        b=e2XNGcDLP5tYUNfDcwQ/4jQXHWJZtmdEBvKm4zsud3+3hGzo1SnlOH7ki57g+4k5Bs
         pSrloN6L37JEV51+g9fv049XteaRCqGSyVulpddLtxIjPsnSOEkfCVU3ajTi93kTXzcO
         +LE4sWkFGClKw7GX6h+/8kvoPdcyabVgu4mk1cjOnuCBqK/M2kgOE6j9FGVIwN8egihj
         HSdbjVxXXS/7xDqbbnKx/3syk7WobKSt+ncbMlIoR+JhxwoaR40MRjPAx8niBM08EbJN
         QNA1RgXr5J1AB9chFYpIe2vfanz2gLFkiOK0iv9CZYcvcP/oKMZDWjcPThxD3QmAkrcB
         RrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QvykNFbnNXUA/35cmCwECruIwHVAP9FS5vmkV2rcJVc=;
        b=rCliGlY5LEJMihQ9J8nmHw5V+f+VwAmfcCB7OlpIgehxothIwqiu8wBP8wZVHM0pmK
         2U6d1jDc3T4kIOu9jdjBifqeMs84hlyTciqhMbriM2Hvg7v6vF1+vtZ9ckQ6daemk7OD
         +wSkPxGxm+8BkOxxAVeLUPV1DljGPq//2eTkJblHHNgC7GosPMcQmahxkyvND+2y1EIe
         gqI2jtZKpGXhxxqTIK5tXrT5YHPBVGvMRr2nY1ONWmp61eM3UQL38xxOzPRXfiVL/F1O
         18IuH00OVS6LKjCu7G/TKH5dvKBW+roPEbdMecNrn0W1orVjOsOpaOkbVC6nkuZ5/k4M
         Yh1g==
X-Gm-Message-State: APjAAAV7x2z3XKCAXRafBkQ/6KBRcEYbv6MzVI5aTvfjtQhmcvn5t44V
        wam0ZpMV/l/Rh0Ohd1onbZdSLA==
X-Google-Smtp-Source: APXvYqxiUM/hPu1BWsYDmnBfi16DgFKj6w5zuXO1zG2jbPhUGDA2qS0EJWPvtTc6D/msUDPMkJ/vAQ==
X-Received: by 2002:ac2:523a:: with SMTP id i26mr5534770lfl.148.1571388797776;
        Fri, 18 Oct 2019 01:53:17 -0700 (PDT)
Received: from [192.168.0.12] ([87.117.56.64])
        by smtp.gmail.com with ESMTPSA id j127sm3646018lfd.63.2019.10.18.01.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:53:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 2/2] hfsplus: add a check for hfs_bnode_find
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20191017205222.GA2662@eaf>
Date:   Fri, 18 Oct 2019 11:52:44 +0300
Cc:     Chuhong Yuan <hslester96@gmail.com>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <64BA43A8-4C8A-4284-9263-8549F26659AF@dubeyko.com>
References: <20191016120621.304-1-hslester96@gmail.com>
 <20191017000703.GA4271@eaf>
 <CANhBUQ3vPBAstTMJ25Zt6sR4CcRKWkeR7VKhFXc9aiqQKmW=Ng@mail.gmail.com>
 <20191017205222.GA2662@eaf>
To:     =?utf-8?B?IkVybmVzdG8gQS4gRmVybsOhbmRleiI=?= 
        <ernesto.mnd.fernandez@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, I had some glitch during message sending. I am repeating the =
message sending.

> On Oct 17, 2019, at 11:52 PM, Ernesto A. Fern=C3=A1ndez =
<ernesto.mnd.fernandez@gmail.com> wrote:
>=20
> On Thu, Oct 17, 2019 at 09:30:20AM +0800, Chuhong Yuan wrote:
>> On Thu, Oct 17, 2019 at 8:07 AM Ernesto A. Fern=C3=A1ndez
>> <ernesto.mnd.fernandez@gmail.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> On Wed, Oct 16, 2019 at 08:06:20PM +0800, Chuhong Yuan wrote:
>>>> hfs_brec_update_parent misses a check for hfs_bnode_find and may =
miss
>>>> the failure.
>>>> Add a check for it like what is done in again.
>>>>=20
>>>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>>>> ---
>>>> fs/hfsplus/brec.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>=20
>>>> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
>>>> index 1918544a7871..22bada8288c4 100644
>>>> --- a/fs/hfsplus/brec.c
>>>> +++ b/fs/hfsplus/brec.c
>>>> @@ -434,6 +434,8 @@ static int hfs_brec_update_parent(struct =
hfs_find_data *fd)
>>>>                      new_node->parent =3D tree->root;
>>>>              }
>>>>              fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
>>>> +             if (IS_ERR(fd->bnode))
>>>> +                     return PTR_ERR(fd->bnode);
>>>=20
>>> You shouldn't just return here, you still hold a reference to =
new_node.
>>> The call to hfs_bnode_find() after the again label seems to be =
making a
>>> similar mistake.
>>>=20
>>> I don't think either one can actually fail though, because the =
parent
>>> nodes have all been read and hashed before, haven't they?
>>>=20
>>=20
>> I find that after hfs_bnode_findhash in hfs_bnode_find, there is a =
test for
>> HFS_BNODE_ERROR and may return an error. I'm not sure whether it
>> can happen here.
>=20
> That would require a race between hfs_bnode_find() and =
hfs_bnode_create(),
> but the node has already been created.
>=20

The whole function hfs_brec_update_parent() looks like the cycle. And =
there are several
places where PTR_ERR(node) is returned with error ([1] - [2]). So, it =
sounds that it needs
to follow this pattern or to rework these cases too. And, by the way, =
what if the node pointer
will be NULL?

Thanks,
Viacheslav Dubeyko.

[1] =
https://elixir.bootlin.com/linux/latest/source/fs/hfsplus/brec.c#L371
[2] =
https://elixir.bootlin.com/linux/latest/source/fs/hfsplus/brec.c#L402


>>=20
>>>>              /* create index key and entry */
>>>>              hfs_bnode_read_key(new_node, fd->search_key, 14);
>>>>              cnid =3D cpu_to_be32(new_node->this);
>>>> --
>>>> 2.20.1

