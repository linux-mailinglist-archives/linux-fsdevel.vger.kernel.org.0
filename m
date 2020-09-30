Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12BF27E487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgI3JIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3JIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:08:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B660C061755;
        Wed, 30 Sep 2020 02:08:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so561926pjd.3;
        Wed, 30 Sep 2020 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y1fGvj5TRletayE/ZjHOAdbqfTuQvn97CcIg9svcNDc=;
        b=vR1T71ptm6GoVKvLVzs9wytAVW2aHaPupYtIsMtZBKVjUyaF0GopOqoRchGeej05Re
         ar1VX4cRQKVTbp/e24J34v0hlHNs+tc36U7O4FHLnN5u4IhOJ5iNbe2I6Gs8NIAF0hF1
         jOEYgNMnkt5lV6zzW0+UenetSAyiMzONIhtNf0+7cP6HZPsc4EoBRMZApyZ3jB02JFm/
         q9YNaZDS29ibmK2s3M7mRG+9s2OnIIOFhNIXGjpKOUxGjl5HdzjPigjI9aetdOJrp44E
         RWxoIQl6gYT+K3Ej+p5TQzOJhPefZE7djiYOI5e3cYPuLb61XscyMty95sjTgZTtOLDt
         e0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y1fGvj5TRletayE/ZjHOAdbqfTuQvn97CcIg9svcNDc=;
        b=CFt5v8kq+mrqbq3Fy9Jc0xLXv/ODbmLyf+vb4wmHwlrJYUUGs/v+OEvnzuJC+t295M
         laU5rsuxOiFFil9CLUX+EiPkjX9KEYPCUg0Bow9zryjeLlNPH2dWtxupT7qizhEV8Mkw
         2wxmPTDmBvKkAImgHq5ZVGMJV4rZzcXq9wBMMXWFOJYUN0jYuNp8qWviIE9r5KbsiLG/
         4qXP9LC+OnamL9yfd14QtkngPW8gYHWh/u47PqDMgT+5kuENavzfeyhIaneQmGfoL1Ax
         to7VdHVSsc7DR5sh17qt2DbDjJEm9ljtl/tp/qyJ9OYEPZs6vBoAJMrje1QQyLxJTqfz
         21QA==
X-Gm-Message-State: AOAM530is4/jXcS9MbrU6R7N0cQojGsXsRGQQDXeb6XV3xdAPIvvkDQ4
        rIWtDbT2MUrRpL26IYXKhhh8b5pBaWxGEg==
X-Google-Smtp-Source: ABdhPJzm/UU85gI0KceqR3MyhSIY9FzwuzAAEGG5YyuTceeX9huClOgBY2mlGMHDO7sGdi4ucBBHrg==
X-Received: by 2002:a17:902:ed42:b029:d2:ad1a:f45a with SMTP id y2-20020a170902ed42b02900d2ad1af45amr1458396plb.33.1601456898467;
        Wed, 30 Sep 2020 02:08:18 -0700 (PDT)
Received: from [192.168.1.200] (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id c20sm1695270pfc.209.2020.09.30.02.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 02:08:18 -0700 (PDT)
Subject: Re: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
 <20200911044506.13912-1-kohada.t2@gmail.com>
 <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
 <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
 <8c9701d6956a$13898560$3a9c9020$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <f51d1689-d1a5-35c5-3d0d-09155d517132@gmail.com>
Date:   Wed, 30 Sep 2020 18:08:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8c9701d6956a$13898560$3a9c9020$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Are you busy now?
> I'm sorry, I'm so busy for my full time work :(
> Anyway, I'm trying to review serious bug patches or bug reports first.
> Other patches, such as clean-up or code refactoring, may take some time to review.

I'll try to reduce your burden as much as possible.

>> I am waiting for your reply about "integrates dir-entry getting and
>> validation" patch.
> As I know, your patch is being under review by Namjae.

OK.
I'll discuss it with him.
If possible, please let me know your opinion.

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
