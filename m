Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65D112D94D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLaNyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:54:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37879 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaNyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:54:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so50401419otn.4;
        Tue, 31 Dec 2019 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kGyXkBQJvM0c0hAT504olnbwajE9HeVwh9tzY4Wj4LY=;
        b=bSyniGigC0qO9gd/Y2toL098hO1c80PihKqgNSew+a++IsTm3mxU4Oc6nLsNnOK1EK
         vSOr+YvoFHp5GFWLnLGP+ElgWvsTdZ27dFj1PaW63Mg777TFpcu/PxkWAKLHN3wlSFfR
         OaKFoFfKRwyzOFBxUBe0kdFne5nFFZayWJvnQymE7MhlXVSGbK/21U2K6mzrdyh0dSCs
         oIN3lRYqzb1i94jM54Py6/PXxCh0QmUzkYnWksdBxUADnmh9QtpI08VBPyhW7S5+uFP/
         y9ODZY4Mlu57lyl0+IrZ7icTiAXHZPqoVrANjqipAqgL4mx6MSsauQHoJWA7eaykQkUr
         HXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kGyXkBQJvM0c0hAT504olnbwajE9HeVwh9tzY4Wj4LY=;
        b=OGaYDWVpP8G++hEa1riC+4ctO/C+iqpXFpzWxRkvX7wUDs2NOeQqvEOHky+Yo9z7te
         8qJYO4GJ4odyvnk9zrpy50Lip0TR2X1Zb0E5jYRTxqiA0dFlseZAOkSi/GuvtwyoFAOc
         TWZK7iWmYug26+ibK0TVQ7UF10T+XPGzNFkJufMLcFALaCYdZ2pbgDb1Qd6ENrnS8mbR
         vgjhdgteKmqx9E29+UmFgplVg6MFG9/W3AJkEgVUNkEiGwJWdilHcybIqLBGq5u+uJwz
         f+p2Kd7ItUMo0yODybLojV8bhywidOnVQ3FJCMAkvbRiRDvUpx11IQOYwdAzmtBTWfql
         2tCg==
X-Gm-Message-State: APjAAAUIWoYmtv6C/g0XPFJJMGkAUXlVV5zX40J54uru/2jbk6wgsJ4j
        oweVzL4iZFDDtnxiDyVxiRFPTk5dnZeIvUx/hoA=
X-Google-Smtp-Source: APXvYqyE4/pCtSX3yLBRbI6W4bgx6Xb/kgk1G7fxT89nT9ORh9LV9Su5OMtLQETzAxRDg6SQtdpJzcztHjoFsTBdB48=
X-Received: by 2002:a9d:6196:: with SMTP id g22mr83252945otk.204.1577800439673;
 Tue, 31 Dec 2019 05:53:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 05:53:59 -0800 (PST)
In-Reply-To: <20191229141550.w66jnp2ayvd4bkk3@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062733epcas1p1afd7af6ca2bfbde3d9a883f55f4f3b60@epcas1p1.samsung.com>
 <20191220062419.23516-4-namjae.jeon@samsung.com> <20191229141550.w66jnp2ayvd4bkk3@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Tue, 31 Dec 2019 22:53:59 +0900
Message-ID: <CAKYAXd-VmWMDqATCh9+jpGRx_Arw9_nc19CgJ8bNmRwSZDvD5w@mail.gmail.com>
Subject: Re: [PATCH v8 03/13] exfat: add inode operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> +	/* strip all trailing spaces */
>> +	/* DO NOTHING : Is needed? */
>
> Hello, this comment looks like a TODO item which should be fixed.
Will fix.
>
>> +
>> +	/* strip all trailing periods */
>> +	namelen = __exfat_striptail_len(strlen(path), path);
>> +	if (!namelen)
>> +		return -ENOENT;
>> +
>> +	/* the limitation of linux? */
>
> And this one too.
This too!

Thanks.
