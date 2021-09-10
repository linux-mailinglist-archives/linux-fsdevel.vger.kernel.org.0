Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB74064A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 03:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbhIJBDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 21:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235646AbhIJBBm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:01:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D1F961212;
        Fri, 10 Sep 2021 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631235632;
        bh=aUNldVDxvY5/8JXSEkOZmy1vrLTGFSD5+GFKtxsglSQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eRKsyVt4X5cg0xJyS8CzN6b+LvTrGWHK3BFuGpBuHFHWApgAfqJlqAZLQzj+urkgx
         12u/QIcILMImUOueYNl+SVsaNGWcvtkitgsibnaCSIZRdulh0jyLPPk4hsTBgcgdW1
         wFFgF2ZAqycmIMnhfLagRSVByY0wCUNQZwazfLarOySHDuB0sdar42ikZQQVLjkoJo
         xE39TdHtGfWcePXkZvNhUX188KluQsOR3hsruT4aZXRqQZ6JH2BbeM6F2WmN5wUevw
         0rBEAzElgM5sSQs/6y4/nviX+8Q8QvrcIMmDaGUAWwX19fAzEWQRPY31oGXpItn2KE
         3imZHDXYOh+ug==
Received: by mail-oi1-f175.google.com with SMTP id w144so588504oie.13;
        Thu, 09 Sep 2021 18:00:32 -0700 (PDT)
X-Gm-Message-State: AOAM533h2JyFddlTYDSZ+QqwOy06tW61GPEfEDvsjjt1Oi1xbwytWLM4
        zFx8n6YsBwIE3Lfe74444kazTWSZyCutPzbUFrs=
X-Google-Smtp-Source: ABdhPJybx83dV2sx9yXRM5MNUx6veFDt/2aziwDv69/0ofKrjiY7AWKyd/NuG2zUqrYY/rmEgmXgZVbJ0i+oW6htxag=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr2140445oif.167.1631235631424;
 Thu, 09 Sep 2021 18:00:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:74d:0:0:0:0:0 with HTTP; Thu, 9 Sep 2021 18:00:30 -0700 (PDT)
In-Reply-To: <20210909065543.164329-1-cccheng@synology.com>
References: <20210909065543.164329-1-cccheng@synology.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 10 Sep 2021 10:00:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
Message-ID: <CAKYAXd_1ys-xQ9HusgqSr5GHaP6R2pK4JswfZzoqZ=wTnwSiOw@mail.gmail.com>
Subject: Re: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't set
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shepjeng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-09-09 15:55 GMT+09:00, Chung-Chiang Cheng <cccheng@synology.com>:
> EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
> specification [1]. If this bit isn't set, timestamps should be treated
> as having the same UTC offset as the current local time.
>
> This patch uses the existing mount option 'time_offset' as fat does. If
> time_offset isn't set, local UTC offset in sys_tz will be used as the
> default value.
>
> Link: [1]
> https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#74102-offsetvalid-field
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
Please read this discussion:
 https://patchwork.kernel.org/project/linux-fsdevel/patch/20200115082447.19520-10-namjae.jeon@samsung.com/

Thanks!
