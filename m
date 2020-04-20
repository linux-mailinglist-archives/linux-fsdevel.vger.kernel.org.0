Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC631B198C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDTWck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgDTWcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:32:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D53C061A0C;
        Mon, 20 Apr 2020 15:32:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a22so491294pjk.5;
        Mon, 20 Apr 2020 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=noDocHhO4G8oMefT5gpQpa0JPLicJQEKjA5ekI12B1U=;
        b=SC51ozKMnXWwNxC+FS+H5K7L8wxrpZjyqGMyZlomlkxBt36rCzlZcvsGyOdEkp0qOK
         acaAbyVZD88rywT5ryrqu6eT6ug82y+7gOsQxfaK2UZl4rV1W9YO5V6hJpajm7qBQJ7Q
         +Zgu3JJJ4o24eDla+44Bh00sdZjWQBXItQe7/2Enccnm6PiSL6mjJ1CohRG51qf+6FxN
         bl7nakvc/wodoO6sEqUEBX+BYp8DehrnOpOUkHt91nVImMC4qsSRJzZblesEp+KJHHNV
         5PYZweupEdYPotyRLOjW0WYpJccNDY8JbTC+X9oMf/lsHyRYouD/z+KyItHoy4uIgL/y
         dq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=noDocHhO4G8oMefT5gpQpa0JPLicJQEKjA5ekI12B1U=;
        b=YxA5hzG27Lygikfb+NrH+3GFzFqxxcvcPNJ283ILp35NQOQhPA/mUHrJHv+qVnM2Y2
         1OsdCPYskJOPLxaeUSc01cCWZNqwZo3US/WnpwBqXmJjZDJE8LZLOpDovDGuZqMIArdq
         jQYW55VOBYDoGbKbXjOPJ6nbze6TJrDazUZUP48p4iK+EowDUCRdYX+Mi3Jp8I2976Cq
         DVe68U5+5hHWpSnxZbK6lzdkvjz9dTGrLQiGzjgFZp0Vj6tPDhaPZcH2qziuMo682WHa
         lHMQhY3GpmcTq5GDcPB9e6vOqEANxkqg624teLaejOL9rqiAYjTJS80yJaLiQKm2dXiC
         8Tsw==
X-Gm-Message-State: AGi0PuYnonl8NsiQybryBCIwoDYRjFx/K/vFoXpBFR41LZ3dPpE6cDFE
        NSPiILKv9s+qb922gLnJMrNcpzr81lWFJg==
X-Google-Smtp-Source: APiQypJlolvJeJBU5vXJhR1b+75YkPTrpnQY59XSAneQ8A2V37o0PI7hVckQTjVTNrBnofyBTzwoIA==
X-Received: by 2002:a17:902:dc86:: with SMTP id n6mr19235047pld.198.1587421957359;
        Mon, 20 Apr 2020 15:32:37 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:459a:cd47:8130:d7ac? ([2404:7a87:83e0:f800:459a:cd47:8130:d7ac])
        by smtp.gmail.com with ESMTPSA id q63sm485622pfb.178.2020.04.20.15.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 15:32:36 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Tetsuhiro Kohada' <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69@epcas1p1.samsung.com>
 <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <003601d61461$7140be60$53c23b20$@samsung.com>
 <b250254c-3b88-9457-652d-f96c4c15e454@gmail.com>
 <000001d616be$9f4513b0$ddcf3b10$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <b1efef64-f335-2e9a-0902-b080690d6209@gmail.com>
Date:   Tue, 21 Apr 2020 07:32:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <000001d616be$9f4513b0$ddcf3b10$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your advise.

On 2020/04/20 11:51, Namjae Jeon wrote:
>> Can you give me some advice?
> Your address in author line of this patch seems to be different with Your Signed-off-by.
> 
> From: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
> !=
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> 
> What is correct one between the two?

"dc.MitsubishiElectric.co.jp" is the correct domain name.

> I guess you should fix your mail address in your .gitconfig
> Or manually add From: your address under subject in your patch like this.

Both user.email of .gitconfig and from field in patch use "dc.MitsubishiElectric.co.jp".
I don't know why it changed to lower case.

For now, change to private gmail and post again.

Thanks.
