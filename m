Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BD1AB499
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 02:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbgDPAJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 20:09:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44539 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732827AbgDPAJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:09:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so791223pfb.11;
        Wed, 15 Apr 2020 17:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MpW66db2TQolWnI94YZHor4fyLu1EvPbEE+3crcrgOA=;
        b=aT9XffR2zO2o8DBzAsHDzQ9lZki09VTdlA0sGuWrpNmacdEUMdnNCk4r82xaPrQsUv
         CmS60ERiO40DdDbXUrf1bMQnbMsnvmWqMaPPw1+ighQXy8A5UVeVMwcrkUZblaMygLLy
         gIybm1q8WNNTatdzGBV2AQa0r+8lYsId0ulLi5ToYJYpZ0YHN+ZmDZYbr06c0EJlbUx3
         gnIWXWS+tlezqcrG7ZeRoOoKsE44SLGEwJt0PvVy3ODg9K/zVEez9tly+BwYjYEQPSID
         xC8ZQjVqM2Apdaf801rF16bGjkVlwOGxuTCvLgRNHrJNWpdyyIHJkvReL2g9HbZD/dgO
         6LHg==
X-Gm-Message-State: AGi0PuZrOPF57EMbZgsK2NC456IMZPwP9PJLdZ+uXV5SkRuuvK7lJUiT
        lB7Q/p/r9u7WGrb4rU6dvps=
X-Google-Smtp-Source: APiQypLrQO2DM+Ep9IB6PtTHaaRO59cFlOYiTyody/qhtTsCEdrSI5RZRl9YI2E2UEk4F4CVu8xz7A==
X-Received: by 2002:a65:6887:: with SMTP id e7mr8956981pgt.318.1586995782145;
        Wed, 15 Apr 2020 17:09:42 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t12sm9468095pgm.37.2020.04.15.17.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:09:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2070140277; Thu, 16 Apr 2020 00:09:40 +0000 (UTC)
Date:   Thu, 16 Apr 2020 00:09:40 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     keescook@chromium.org, yzaikin@google.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-parisc@vger.kernel.org, wangle6@huawei.com,
        victor.lisheng@huawei.com
Subject: Re: [PATCH] parisc: add sysctl file interface panic_on_stackoverflow
Message-ID: <20200416000940.GY11244@42.do-not-panic.com>
References: <1586610379-51745-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586610379-51745-1-git-send-email-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 09:06:19PM +0800, Xiaoming Ni wrote:
> The variable sysctl_panic_on_stackoverflow is used in
> arch/parisc/kernel/irq.c and arch/x86/kernel/irq_32.c, but the sysctl file
> interface panic_on_stackoverflow only exists on x86.
> 
> Add sysctl file interface panic_on_stackoverflow for parisc
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
