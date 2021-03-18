Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60D3408FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCRPfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:35:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42500 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhCRPfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:35:03 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1lMuft-00039n-Rg
        for linux-fsdevel@vger.kernel.org; Thu, 18 Mar 2021 15:35:01 +0000
Received: by mail-ed1-f71.google.com with SMTP id w18so18571632edu.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0CTA1Y3sluOT4Qsh6qv0jDY/lM9GSPSNXmGPaJY6Wu8=;
        b=nfm8FxASLOBFQTTCUvAJ3xyfmcUg4GHpOO9rs3BLrEKBlneHmzl7Fmf97tvAPGaZMs
         SDydY6psg/Zh/IU/1lCSJx8gJkHIC0p8WKe/u2q+48euGjdzVs/YMYWJL7XPlhzrpy59
         FwnDKkVZs8Z/kb8oosLPetlRzN3aoeg1m3VmRCa2Ac5gQT9mFssu/YL0MN3T/likFpfL
         bko0+6hEVZMDjkVXF9g1z0ZNCD2EioaQ/ZbZJMufCIQEFZ4mSkpurFDkOElFtWeIlKET
         rpPQb/mb9BghmOAAUUTCSxw0/r1CJf8akHO6kNkzrJlGagS7WvV32qKZvUX+k8/t3ybb
         kgSQ==
X-Gm-Message-State: AOAM53213VKZde9onebS58z2AVB2ml/byVvJXgnecSm5BfSXBe3OIAoa
        M8+PZVxEd2T+3ikUvt/9WunXR42bahIMiPRHJi4VkReF6gPqOfUOH9RAcTDPrGmsi1QUyzvX/Ug
        O7INVf+17cv0qcxAKAu/fJl+tNAl+9IRi+qz40+xcFkc=
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr4307565edv.321.1616081701593;
        Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyubUDKilDMndxbQbypUxRod+E8BeHn6ehiL2vZj7sJsP+2LHSLB41RjU20lobXHca6Lu241Q==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr4307544edv.321.1616081701369;
        Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id u14sm2109344ejx.60.2021.03.18.08.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
Date:   Thu, 18 Mar 2021 16:35:00 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] fs/exec: fix typos and sentence disorder
Message-ID: <20210318153500.ntwnsdsptesbnfm5@gmail.com>
References: <20210318153145.13718-1-caoxiaofeng@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318153145.13718-1-caoxiaofeng@yulong.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:31:45PM +0800, Xiaofeng Cao wrote:
> change 'backwords' to 'backwards'
> change 'and argument' to 'an argument'
> change 'visibile' to 'visible'
> change 'wont't' to 'won't'
> reorganize sentence
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
