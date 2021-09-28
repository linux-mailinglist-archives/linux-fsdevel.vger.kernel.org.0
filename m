Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304AB41AE75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 14:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbhI1MJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbhI1MJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:09:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28077C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 05:08:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d21so57505985wra.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=zlRDuLS0vDVlIuVZiu1DzhMJOhOnDKbUORg0nkwVBz0=;
        b=ei9+hWwKsEJS1BIrhNxMpYCsnjdQPHrG2OwZ7oSY9ubVYq9585kxJ5xKbP+lo5yrv2
         ha/f9N2jLSZpf2/5+SxfLbz/NHnY0lYBK6yjAjTBawVxbLQrwFLcY5KqjrxEaI4ltxdX
         4+BqFCuGxm8i4O4MBlk61qOvuK8oAezfBBboTdR9xlRB0wOeX7/13COeyiLBxMz3Dukn
         aV15za2mOh6k+dq15jp2AsYmlXDFqxEPzQDTY8cGP2MPW3UM+3dzEjD0yJSr2enFR+PV
         sF66jh8QYoWu+evn78ueNQ0eq+6c5HJ8d4OfMQHlo4/FYyG790SR4OI7IN14xJ/JGLAl
         9DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=zlRDuLS0vDVlIuVZiu1DzhMJOhOnDKbUORg0nkwVBz0=;
        b=Vll2nY21nSf7Fm5zWYHKib/zcb5qfJ7LXVGYH//9hW1YTkPQYr04ikmzXV3MTAgMPu
         I6iLsl3zg7wXGsDd3VsJJFgtY3LI1egljA5fgZaGgnSxS9zU/eeYEVu8LuNPTCK2uTpX
         EYRc9b4NzgyAttJjgP2dtGLzcOZRtUK1+jO19wqvJ2pqh+klKqctOiHWca5rHyM2NOrj
         yJHI7EShjJGjCkUbYH6vfEG0vkTvlqL/2tJqEQ6JAy2laXhbYh1pLiRZRDEgFncSrSqu
         S8IZoc/YX6fQ37xpG94U6wkQrGHHDE98hH5nEX24BarhRT0kjcRHq8Fe2EE6h53/etno
         4ypA==
X-Gm-Message-State: AOAM53267SO5Qa7VeKo5e4s9dARNw1hlmCjlfs0X9tFZjJh+jF4uFmyW
        M0pwwu76AG0Xo5IMFKjSUo3kUcI4/Ps=
X-Google-Smtp-Source: ABdhPJyfbfGQMEpOn8KiEghxT10y4t+quChtXcdKzWnJsjWj8g7eteayEDGnt/Qj0ntJ31B41cZrJQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr4002871wrr.210.1632830890728;
        Tue, 28 Sep 2021 05:08:10 -0700 (PDT)
Received: from ?IPv6:2003:c6:bf29:6200:d1a7:7809:cefa:acf6? (p200300c6bf296200d1a77809cefaacf6.dip0.t-ipconnect.de. [2003:c6:bf29:6200:d1a7:7809:cefa:acf6])
        by smtp.gmail.com with ESMTPSA id f1sm21098679wri.43.2021.09.28.05.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:08:10 -0700 (PDT)
To:     linkinjeon@kernel.org
Cc:     linux-fsdevel@vger.kernel.org
From:   Reiner <reinerstallknecht@gmail.com>
Subject: timestamp incompatibilities in exfat-fs
Message-ID: <1f823846-5ba5-6a99-a391-0537bca9a9e7@gmail.com>
Date:   Tue, 28 Sep 2021 14:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-LU
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear exfat-fs maintainer,


Files from a digital camera on SD-Card with exFAT filesystem shows under 
linux 5.14.7 (plain vanilla)
incorrect timestamps. (atime, ctime and mtime)
These times are of by +2 hours (2h  ahead). Depends on the timezones 
used on digital camera and linux computer to display the files.
The same issue is also on the distribution kernel 5.10.46 (debian).

There is a workaround: Using the patched exfat-fuse driver and mounting 
as fuse filesystem.

see: https://github.com/relan/exfat/pull/119

I tried this patched, and it works. Timestamps are ok with it.
Without the patch, it shows also wrong timestamps, like the exfat driver 
in kernel!

Can you please have a look into the timestamp handling of the kernel 
exfat-fs and check how to fix it?


This bug is filed in bugzilla kernel.org (Bug 214555)


thank you and best regards

Reiner
