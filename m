Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39086232BE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgG3GYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 02:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3GYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:24:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D69C061794;
        Wed, 29 Jul 2020 23:24:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c6so3352632pje.1;
        Wed, 29 Jul 2020 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Shb9i0LDUlIh9UpG3vq1YdMvlhvbI8HAkHm5WKnBgRI=;
        b=De35tnc5xk2HVD/mdWVVmeQxk1EKb045+dYbNw7/gQkxGto19yzGp0yAjDbbQgsnGN
         rkw+6mA10fyiDLmZq4JiNQHfjZ4wuHm/PbxILPkNikrr6+q6Gr6R25Bfa7mD3DUghi2m
         umRzj3CMFyFL2qPrvbfov1Dg19ZyyeDOYtwuOmsexkVquJBmWCRKlFV593T80yYAk3JA
         FcCbAeWPZ98NKQrwuR5Dwb8ShYfMcvpuj+vPjjjwHJwx0eSnN7qcCPD77BI3DK1dT6OH
         953zn0EHzO7Tq5PC5XvAB361xxelqUGqUB7/kQFewab31gtiZgKMfbtdV1CnNVLuW0zn
         N38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Shb9i0LDUlIh9UpG3vq1YdMvlhvbI8HAkHm5WKnBgRI=;
        b=Oy/93bXLgxJzCBuGCg7cn49hsZV6HKMs/vq33Dm6QcOanAqLESb6nNxhhBB07CncrO
         SCwzKkX0hpJ4lCnrIqqSKPIImbFdna+1EdvWDoxs/oDsQj6CWcqhkyP+XL75OJ67ChKg
         9rx5MG9r1sL6+nwpPMpUQm+c0vfjHZOUENRXcEH0BYapn2GxPd+PaT6574q9I9nHgATV
         ZQkckCjc6lS1jWWw6mYMpAw0C4pfaxLbrq7mooKC+7R+556jhPLRZ/TZBpvPMoRkd+7F
         lGoZgk9XFXY784LfTc5ZLZDQNSgtfCcQ+mn5QyU3A0dNOkA1lTPd942SMIuOT9dy9Mgf
         hbcA==
X-Gm-Message-State: AOAM533FWJLi6W1k54ITewpdQTQaFQglSTl83ladaFRoK2NBCtUt12Ad
        hNad1u8L2gVMDTASiIsEbpPo4jmwZFM=
X-Google-Smtp-Source: ABdhPJyaJmEzG7DtkyZwrZ5g7LBfWKVfxBFN+4675TvEPpa5fecLylykOzsMbIVkBJThG9DLecykuQ==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr18520900plo.289.1596090257450;
        Wed, 29 Jul 2020 23:24:17 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:ccae:99d9:bebb:d2c4? ([2404:7a87:83e0:f800:ccae:99d9:bebb:d2c4])
        by smtp.gmail.com with ESMTPSA id d22sm4673206pfd.42.2020.07.29.23.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 23:24:17 -0700 (PDT)
Subject: Re: [PATCH] exfat: retain 'VolumeFlags' properly
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        Motai.Hirotaka@aj.MitsubishiElectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
 <20200708095746.4179-1-kohada.t2@gmail.com>
 <005101d658d1$7202e5d0$5608b170$@samsung.com>
 <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
 <015801d65a4a$ebedd380$c3c97a80$@samsung.com>
 <ad0beeab-48ba-ee6d-f4cf-de19ec35a405@gmail.com>
Message-ID: <fa122230-e0fd-6ed6-5473-31b17b56260c@gmail.com>
Date:   Thu, 30 Jul 2020 15:24:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad0beeab-48ba-ee6d-f4cf-de19ec35a405@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping..

On 2020/07/15 19:06, Tetsuhiro Kohada wrote:
>> It looks complicated. It would be better to simply set/clear VOLUME DIRTY bit.
> 
> I think exfat_set_vol_flags() gets a little complicated,
> because it needs the followings (with bit operation)
>   a) Set/Clear VOLUME_DIRTY.
>   b) Set MEDIA_FAILUR.

How about splitting these into separate functions  as below?


exfat_set_volume_dirty()
	exfat_set_vol_flags(sb, sbi->vol_flag | VOLUME_DIRTY);

exfat_clear_volume_dirty()
	exfat_set_vol_flags(sb, sbi->vol_flag & ~VOLUME_DIRTY);

exfat_set_media_failure()
	exfat_set_vol_flags(sb, sbi->vol_flag | MEDIA_FAILURE);


The implementation is essentially the same for exfat_set_vol_flags(),
but I think the intention of the operation will be easier to understand.


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
