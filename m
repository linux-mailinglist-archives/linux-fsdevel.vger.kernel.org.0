Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20F1024C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 13:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfKSMn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 07:43:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37684 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfKSMnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:43:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id y194so18775776oie.4;
        Tue, 19 Nov 2019 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5MSKtsb6iqkVQ7BW7w/AmpW5TOtiq/Srx1jW+59rrl4=;
        b=A5CIoy8/cyb2kAwkDkjBIQilfcNoYYARax4TRe3fhm3SkqVl9OVS5JosvkDV2X3KXN
         m0+MSBtoVctYh5DaaWPSGXBXGUXoIfeuKhIj4mU/bOa+ShHZkAApaOwVLHuG0JLKDzgy
         GZji7nHA9iTI2hYfYSMad3BBBODYgjY+ku7u+KtGLykNA2S2+cF9wmZWA1nfKD/ubyyL
         118Wt506P4+EeTZXiZv0lG8bl82+jVqCk5E+4FPl1yvxItrIMS1AKqU1TzcDgxrmSMsY
         1SyeaoIE3GUn6/glg71JJ5P4bStcQTUy/9wofCA7B6Omtkpoyf+xfvIwCHAUjzaHescY
         m5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5MSKtsb6iqkVQ7BW7w/AmpW5TOtiq/Srx1jW+59rrl4=;
        b=QoMb4Wi356Aa1FmjvlcQYsLAZcJPdpxVRGY4qOC/9LTCMa1sFv8rgXrPkRgn+i1cJC
         MLc8QoPtWnz02tD8lC5wy+r+rhf5sh6p/FyfJJPzx5lo4cbCJBTUjsKtEHASzqkAXFQl
         Vc9ec/UFE/eMotDI+OtW7uE/CXdjOwrdoBX/p9qakUmSpT4rC9Df4pbrAeVIQh10Km/4
         8px+JE6mWHxfR9WCybNHMObxivCvgYwJLZtFu5UcuGoQhLMlrj9pWFM8Rk7M6QZb5klt
         TmEg6AmR2xL2+npP8IVIiKxkBpwE8q916gWr6FSIUEoEB7K58HtmwjYYQd1WcxOTWe42
         dzUw==
X-Gm-Message-State: APjAAAVBMNfj8WWv9Z6mlA5dv/+4Npwmi509Xk8i2UKSgd07IX7KLGJg
        DvdobJDAu0QGyjtQnagkwbp8Pw1okq4+13fvEAc=
X-Google-Smtp-Source: APXvYqwruuqBpg/77+iq6NzLKr6d47hyVlaeNzcqcdg25IMEhT9vw6mSXOz7+kCtWM2/z54d14RSWpe/BIPDc1O1VcI=
X-Received: by 2002:aca:450:: with SMTP id 77mr3922090oie.113.1574167433319;
 Tue, 19 Nov 2019 04:43:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:d7:0:0:0:0:0 with HTTP; Tue, 19 Nov 2019 04:43:52 -0800 (PST)
In-Reply-To: <2cc05215-3b44-06f0-b34a-eb841476b329@web.de>
References: <CGME20191119094019epcas1p298d14fcf6e7a24bee431238279961c5b@epcas1p2.samsung.com>
 <20191119093718.3501-1-namjae.jeon@samsung.com> <2cc05215-3b44-06f0-b34a-eb841476b329@web.de>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Tue, 19 Nov 2019 21:43:52 +0900
Message-ID: <CAKYAXd86mEc7fFO6TzaUm7V=dXS4HG4mMWziz_Nq=SNQ-9RWQQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] add the latest exfat driver
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2019-11-19 21:15 GMT+09:00, Markus Elfring <Markus.Elfring@web.de>:
>> =E2=80=A6, an a random previous
>
> Does this wording contain a typo?
Yes, Will fix it on next series.

>
>
>> We plan to treat this version as the future upstream for the code base
>> once merged, and all new features and bug fixes will go upstream first.
>
> Were the following mentioned issues occasionally reviewed already
> by other developers before?
https://marc.info/?l=3Dlinux-fsdevel&m=3D156985252507812&w=3D2

>
>
>> v3:
>>  - fix wrong sbi->s_dirt set.
>>
>> v2:
>>  - Check the bitmap count up to the total clusters.
>>  - Rename proper goto labels in seveal place.
>
> Would you like to avoid further typos in such change descriptions?
Will fix on next series.
>
>
>>  - Change time mode type with enumeration.
>
> How do you think about to increase the usage of enumerations
> at any more source code places?
I will check.
>
>
>>  - Directly return error instead of goto at first error check.
>>  - Combine seq_printfs calls into a single one.
>
> Please refer to the correct function name.
Okay:)
>
>
> Thanks for your positive feedback.
Thanks for your review!
>
> Regards,
> Markus
>
