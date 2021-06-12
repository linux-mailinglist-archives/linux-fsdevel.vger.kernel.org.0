Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A613A4BD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 02:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFLA7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 20:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFLA7P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:59:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CE1461374;
        Sat, 12 Jun 2021 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623459437;
        bh=/TJC72+RVmNPqO1eugc1bbx0117oCXx3BCvzlI4l3U0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ipEIINRPrx0hkuex//oPLxzO2v2pDfu6ME2jygnjGfuDrT4w9kA5730G5Nyg3i69Y
         48cnzRlr47uBG03VBbzRMQKKsZtnFZNL9OxX7/idQSeEliXpfuf+CQE/WjyF7TCJd0
         p4UrKZ87R7mkO7XzkUPIHMLltlm7zdF1vms/ea58U/GXVm4LaR6/TL05qiR9I5+Fdq
         QseR0SoAhMiekdZlmPX9rg8XCkuViEYSehnQMMoH+50etbunUeTTD/JoEEFMG0onKI
         CItMcbOhbduaFfxyl71+XxWlpJj4mgZoaNGQqMv5SD8oV1cM2zJDQSztSXTMY7b9an
         mQVT3CJKHDDIg==
Received: by mail-oi1-f181.google.com with SMTP id s23so7641249oiw.9;
        Fri, 11 Jun 2021 17:57:17 -0700 (PDT)
X-Gm-Message-State: AOAM532+y+gGERaCTAF8wajRymll5NKXi60hygQOeGIxO3JDUJxpRrhW
        CIipX8LUm4FfAtn7xblMJHRD7VGwzhPKgKSHciM=
X-Google-Smtp-Source: ABdhPJxvDONfM9WhER6OoqpCyWQRlGyleYD7xWkZVmT/mxfpjclRYhlpjnrVCb+DVd/DhG4RZGajj9i7+B75fcFCNVs=
X-Received: by 2002:aca:dc84:: with SMTP id t126mr4095908oig.32.1623459436659;
 Fri, 11 Jun 2021 17:57:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:4443:0:0:0:0:0 with HTTP; Fri, 11 Jun 2021 17:57:16
 -0700 (PDT)
In-Reply-To: <87a6nz4s0o.wl-chenli@uniontech.com>
References: <87a6nz4s0o.wl-chenli@uniontech.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 12 Jun 2021 09:57:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_dDQATXMqZ1P6tMSFDR22X55uBvcNtDFSbJQafyT7Ogg@mail.gmail.com>
Message-ID: <CAKYAXd_dDQATXMqZ1P6tMSFDR22X55uBvcNtDFSbJQafyT7Ogg@mail.gmail.com>
Subject: Re: [PATCH] exfat: avoid incorrectly releasing for root inode
To:     Chen Li <chenli@uniontech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2021-06-09 12:48 GMT+09:00, Chen Li <chenli@uniontech.com>:
>
> In d_make_root, when we fail to allocate dentry for root inode,
> we will iput root inode and returned value is NULL in this function.
>
> So we do not need to release this inode again at d_make_root's caller.
>
> Signed-off-by: Chen Li <chenli@uniontech.com>
merged into #dev, Thanks for your patch!
