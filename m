Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C813C240
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAONGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:06:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38212 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgAONGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:06:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so15270414oii.5;
        Wed, 15 Jan 2020 05:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JU9kuKxn9mpkSpt1hbmOyF2WKWsYNHvYX8lhEgp3peU=;
        b=kPTb5XKtbdm6GvZw5kee+z0odrnJ3y10FEs4N4XtH2a5VZpTrSl/XMWtnR/DWXnYzn
         ajfOOAL7vr4cl3/KORzWGV6juViCwnmM5xN50UuxseBTlwXvksmVXgHyquhMI7w2/Cq8
         LBqIDHVNCGkoNt9tEiYOKRfcV1/OEfgKrER4AmPcVXCldHPrZHRUvk3l1U+1QKFbtzhN
         Bv171EkMkpi/uSxtwS31tBI+glwOi8dpf31ZWYaG37SSxHNCYM0ny9xE55ghRxXqBjvo
         uHAvpQAAgG5kAnfmNJv1Q7NnHK0SxRIHc3X9lwMJYWOI+UfHtLatJUTR3L2aolFtwviO
         W+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JU9kuKxn9mpkSpt1hbmOyF2WKWsYNHvYX8lhEgp3peU=;
        b=DkSmPgbQyawww5M61GSje8xYzgDayKtixxutko5Tse9Q+MwOW2++PcVE7K97ScqOei
         8pd8w05HO73YOEHmJaWUln1OZQ7gFN2CfJ2q+rFX5loq8abHypSjWCPaq+pVZeHf9OQE
         dQ2QoAl+8dfCb62vgEpzzKnc2gDbeOs7pDa7Yklx8IL2GbqB4/cIBuLK57IYJFarFxK2
         ojfd3iZgH2T4QLtpEaumSkJPwP0xfOhkL7erdGW8vGe91QR3QeP1zVE8oXQvrzSQDB08
         /fU2m5O5p1P3xwDQEBcbtuCrT70HF+so69tFtoq+C/v7xzzroXLEFR/A5j0M7iIxg8zz
         Q4qQ==
X-Gm-Message-State: APjAAAVYaSwU68HQ6tmYdz9sAu7OKPV2CW8aS0f95Rc/7ve3/Y8sjaKM
        Y1PlyEhjREY8dBEzx6KCRHcnndFFPKEE+A0A0Lk=
X-Google-Smtp-Source: APXvYqwyoLtH9KlfHcROVs5Pac4RNcXyeiRBPTeYcs7TzRPqJB5XONxY5OFPWrIgkDNFG3CPpKaiDQYxHoQvYO0daq8=
X-Received: by 2002:a05:6808:a11:: with SMTP id n17mr20201684oij.94.1579093610072;
 Wed, 15 Jan 2020 05:06:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 05:06:49 -0800 (PST)
In-Reply-To: <20200115085658.GA3045123@kroah.com>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082826epcas1p3475ce2b4d03234dc96ced428be582eb3@epcas1p3.samsung.com>
 <20200115082447.19520-15-namjae.jeon@samsung.com> <20200115085658.GA3045123@kroah.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Wed, 15 Jan 2020 22:06:49 +0900
Message-ID: <CAKYAXd_EwLd3CoaO1P_7ppJeakmnTUifX6yUojjrTkKxHGwQiw@mail.gmail.com>
Subject: Re: [PATCH v10 14/14] staging: exfat: make staging/exfat and fs/exfat
 mutually exclusive
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        valdis.kletnieks@vt.edu, hch@lst.de, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-15 17:56 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Wed, Jan 15, 2020 at 05:24:47PM +0900, Namjae Jeon wrote:
>> Make staging/exfat and fs/exfat mutually exclusive to select the one
>> between two same filesystem.
>>
>> Suggested-by: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
>> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Thank you!
>
