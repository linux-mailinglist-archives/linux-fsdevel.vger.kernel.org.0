Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC02A118
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404344AbfEXWVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 18:21:15 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44298 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404332AbfEXWVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 18:21:15 -0400
Received: by mail-wr1-f48.google.com with SMTP id w13so3015447wru.11;
        Fri, 24 May 2019 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=kV6iJR4xfy9BRC6MyG7RFLVo/Wi9XJHicoj8GiJ50zE=;
        b=RQPcqx6ozrqP8a1MxQY745UDH4f80SGRWFECqSzzyeASqseyw2aQlzRzIn1wiM81sg
         xsbUtqjNLpiZTDR/k11/K9wPe+t70ZSe1+78iAG390Y/HLpNbDtocRJNNPfHN4GRQG/G
         AvmvGxT33F/Nounqxq/tVmwfrkbNL2OspUTiWl/KPhxixJkuhxaArg2hRwQ2s4oey+ZJ
         NXsVa6G+37JjbFSaKF2s6IHQnDl4KXaesPaA5Y9yaTT6QReo1UvSaCciJixjZiMNOaXw
         z0WWhoz3l/w4vT5on4FVVwrbCe5qkPePBrHdGNYWF/jRUpSTOzW9ACEU42qBBEMl+fXy
         B1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=kV6iJR4xfy9BRC6MyG7RFLVo/Wi9XJHicoj8GiJ50zE=;
        b=qELDDdwBLBUhiZSa1qgmtr1csFhSTo6VmOy3nw4vY6YY9Fn7zdpgsSqAreN1kXJ7x9
         Qeeaj/jjJhd4bQpVdD7GGiV8KmRYExc26AysXeUqa1g/ZFxq90y6pDUiWvQ37sS6gBA9
         GUxHH6hvf4BZ7B9Cy5Cl0i8Vl8am0rEsq9LbCHzvqn2uMhIVYUNx8p8ss/4L58zskMHX
         1MCyjaMU99dtzAhRTpT6oZZOzFLSpZr01SLhVzhFMUr+eWUsbfu3D+HV4PhSsWqpVzn5
         1ZMRN7jdWMs6ZUcZIatXKfbY2IFArdj6gWlA9KW90upIVA82rY8rWboNiIDAD8sR52wS
         Mgqw==
X-Gm-Message-State: APjAAAVQR0YQ73I02Er2Zd1yToNDgBEhVyD5kXW8DG/+1qWjPM3W7NEl
        +IzXlGqteEKkrpvghNr3CMSYq3qTSCP5Bg==
X-Google-Smtp-Source: APXvYqyiO9AqF/rXwvpnWtzQtWh6QNPh6n/g/DmOpGzsA7BmBQUI/Z91rD8hQzpSoz5Dwi9toVKNZg==
X-Received: by 2002:a5d:628d:: with SMTP id k13mr7050635wru.319.1558736473197;
        Fri, 24 May 2019 15:21:13 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id l18sm3880043wrv.38.2019.05.24.15.21.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 15:21:12 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Sat, 25 May 2019 00:21:11 +0200
MIME-Version: 1.0
Message-ID: <b1f6ba08-6774-4be9-9e96-563f95e9ccdf@gmail.com>
In-Reply-To: <20190522162945.GN17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, May 22, 2019 6:29:46 PM CEST, Al Viro wrote:
> On Wed, May 22, 2019 at 05:44:30PM +0200, Vicente Bergas wrote:
> ...
> IOW, here we have also run into bogus hlist forward pointer or head -
> same 0x1000000 in one case and 0x0000880001000000 in two others.
>
> Have you tried to see if KASAN catches anything on those loads?
> Use-after-free, for example...  Another thing to try: slap
> =09WARN_ON(entry->d_flags & DCACHE_NORCU);
> in __d_rehash() and see if it triggers.

Hi,
i have been running 3 days with KASAN enabled and also with
diff a/fs/dcache.c b/fs/dcache.c
@@ -2395,3 +2395,4 @@ static void __d_rehash(struct dentry *entry)
 =09struct hlist_bl_head *b =3D d_hash(entry->d_name.hash);
=20
+=09WARN_ON(entry->d_flags & DCACHE_NORCU);
 =09hlist_bl_lock(b);
but the issue has not appeared again.
Next week i will try -rc2 without KASAN and with WARN_ON and see if it
triggers.

Regards,
  Vicen=C3=A7.

