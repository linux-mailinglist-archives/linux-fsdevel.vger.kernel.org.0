Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F381DF36D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 02:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgEWAOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 20:14:47 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50183 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWAOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 20:14:46 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu7so5689907pjb.0;
        Fri, 22 May 2020 17:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8sh7/Jb1dluiEsgALu1CN7Z9jV8JyhMmSJJWK9ECsGg=;
        b=DU91Hpgt/x/QsRigWve7HGyG4bCKJ9WM5qw6NgYaOdEzAjTHnAIQZSb0O6HWPYxCRc
         VpLkwiUaHFBf5HjYRGEp/RV/4IRRqjIVa6ZKtp3wJIeniFMXw7t0h197FpLWXzWAxMT/
         PeV8CYIY+NP8tE8MOS27Pz5G3C8BUSgc89FXt+a7g09Vjd7odRLXCCuQ1zRh+ND9SE0G
         0aurk1ZpWpzN6uKUERM8EFfS4iRmKGcb5cLr5UQkXP3yX/xOq0Y0qgMpaSbDDLjXDI6C
         oirkgAINdmEERmjNOi4PNxkpU2ELB+Ll8uIiRiq9/I5BS+gnXK7yHxaDsMpqHsTazJ90
         Xd0A==
X-Gm-Message-State: AOAM533Ar5jdE3VbGFPLl+VyOIpClX6IP0gWiL5vYynFWDsDeOlycLf9
        62pe2C/JfojRcgOQFm8YwVY=
X-Google-Smtp-Source: ABdhPJzinHVQBUmTlp57xG6X/Xg4Lcp1Fohv2CAoewS7fdg2SiJzKBWsFw4r9rlUlrkuFx7lNSDfXg==
X-Received: by 2002:a17:90a:dc10:: with SMTP id i16mr7356372pjv.137.1590192885688;
        Fri, 22 May 2020 17:14:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o15sm7236031pjq.28.2020.05.22.17.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 17:14:44 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C6A9B404B0; Sat, 23 May 2020 00:14:43 +0000 (UTC)
Date:   Sat, 23 May 2020 00:14:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2] firmware_loader: change enum fw_opt to u32
Message-ID: <20200523001443.GI11244@42.do-not-panic.com>
References: <20200522231202.13681-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522231202.13681-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 04:12:02PM -0700, Scott Branden wrote:
> "enum fw_opt" is not used as an enum.
> Change fw_opt to u32 as FW_OPT_* values are OR'd together.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
