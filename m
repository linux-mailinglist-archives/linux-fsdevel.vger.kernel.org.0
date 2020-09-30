Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9447B27E6E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgI3KmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3KmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:42:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B072FC061755;
        Wed, 30 Sep 2020 03:42:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so924608pfk.2;
        Wed, 30 Sep 2020 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9PUVuYIAR3dsuoBiBsw/RZdRsjKZPpHWKBbXuKbDzwc=;
        b=TotQ5KO1k06WtIu22CRFT3dk/TqwrOVUrHQqITSA7RPgZjx6kPnkXk80M0XPYy13o/
         tvzXsN06FNvHxrDEU4pYzJ6xNLNi1KqlJw7Q3Ttq4DcRFVfzN8CR2me9QJGfvX1t5SD2
         pRgXHiFPNDlO39Idj0WfRHPwZnUhrp90z/Iyu+MkBxn7TcPyYUmXdm534piI+tdThpZe
         cbZcjsdiXMCPdNB4SlDA2e2EOxfZpG94sYzf+EsMynvTJu9H0lDgJ19QNyh+3xl6GnuW
         EjmR7Xn4svgOSmwTfhToSiTnTak+g6sdYTdg57m0dJoS/89jn/asKV4Jpir8rMiwrQG5
         thhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9PUVuYIAR3dsuoBiBsw/RZdRsjKZPpHWKBbXuKbDzwc=;
        b=Ct/UBY8UTCqTbhfn0nOleZFCswBgjr4tOSyHT0esLw/dQWPCwZ66w6YnhqeMS1sGTu
         3WoE50G9J/TnJV2YXBHmQD0yDT7E4CadTnVMel0VNyMWUfcccLAJrI2xftJkliyM1kLX
         eC6TdY9j3vMtw4IjajRv5RMu4UYu6pDunnyQU0ctST2qVJQ4xoGHzHBqk2LKtdILGvZ4
         d4KlExCQF3eXyLNZCZ+wE1vIdPjk+cVIyBlGuPusxNnEBMT8k4wRce1MhydaDgfXSScA
         SF9UCO/DstCD+7bLVCB9dTGpWxznOahtiayFFVM20W5FmrOVgODKXpfHu6meJesMIVzj
         TnmQ==
X-Gm-Message-State: AOAM5316tAgCFhSicwvtcVqviVkQVNTBL7GfGyuPqqSwRmkJFyamGL9h
        xDWJO+n+AR0Yn6tbWnhQsFw=
X-Google-Smtp-Source: ABdhPJzWNvBir+nQe8cAzPzySMJQIsCctw7pje1panx0WeVO3T/pHdZpInaWEXRM1KbGPe7oSPNwlQ==
X-Received: by 2002:a63:da13:: with SMTP id c19mr1693718pgh.68.1601462521219;
        Wed, 30 Sep 2020 03:42:01 -0700 (PDT)
Received: from [192.168.1.200] (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id u22sm1670248pgi.85.2020.09.30.03.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 03:42:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
 <20200911044506.13912-1-kohada.t2@gmail.com>
 <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
 <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
 <8c9701d6956a$13898560$3a9c9020$@samsung.com>
 <000001d6956b$e7bab2e0$b73018a0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <6a0364e6-2192-439d-f874-11402dc8009c@gmail.com>
Date:   Wed, 30 Sep 2020 19:41:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <000001d6956b$e7bab2e0$b73018a0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> BTW
>>> Are you busy now?
>> I'm sorry, I'm so busy for my full time work :( Anyway, I'm trying to review serious bug patches or
>> bug reports first.
>> Other patches, such as clean-up or code refactoring, may take some time to review.
>>
>>> I am waiting for your reply about "integrates dir-entry getting and
>>> validation" patch.
>> As I know, your patch is being under review by Namjae.
> I already gave comments and a patch, but you said you can't do it.
> I'm sorry, But I can't accept an incomplete patch. I will directly fix it later.

Of course, I understand that you can't accept a under-discussed patch.

I think you know what I'm trying to do, with previous patches.
Unfortunately, I couldn't implement it properly using the patch you provided.
But I don't think the checksum and name-lenth issues should be left unresolved.
(How do you think?)
So I want you to think with me.

I still feel we haven't discussed this enough.
I still don't understand what you think is the problem with the patch.
Where and what kind of problems do you think the patch has?
- performance?
- wrong behavior?
- readability?
- runtime cost?
- style?
- other?

I think I explained the reason for each implementation.
If it's not enough, I'd like to explain it in more detail.


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
