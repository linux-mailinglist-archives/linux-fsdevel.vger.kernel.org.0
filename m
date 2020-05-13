Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094001D1F6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390696AbgEMTjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgEMTjL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:39:11 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A7620659;
        Wed, 13 May 2020 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589398751;
        bh=KXxqBrzLeeAqHk4gtdn0I0ZYxOj9nDjdnEZkDmE/AD0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=icAvLYRsMmmlKalnFgVitIB6YgqA5lAMu+YhIRLXxIIiq3BVLuq9N95zqswodsRBB
         1iKYOsmVyCZO60BoDYbCKNJEIhejePOe3LB4KNE1PQagmFEiJF8x/qSDynheLtg1Pf
         3SUpbR9S+ZBoeJkotoGwwocdmG39FBSjNE2dKy/k=
Message-ID: <1589398747.5098.178.camel@kernel.org>
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
From:   Mimi Zohar <zohar@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 13 May 2020 15:39:07 -0400
In-Reply-To: <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
         <20200508002739.19360-2-scott.branden@broadcom.com>
         <1589395153.5098.158.camel@kernel.org>
         <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
         <1589396593.5098.166.camel@kernel.org>
         <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
> > On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:

> Even if the kernel successfully verified the firmware file signature it
> would just be wasting its time.  The kernel in these use cases is not always
> trusted.  The device needs to authenticate the firmware image itself.

There are also environments where the kernel is trusted and limits the
firmware being provided to the device to one which they signed.

> > The device firmware is being downloaded piecemeal from somewhere and
> > won't be measured?
> It doesn't need to be measured for current driver needs.

Sure the device doesn't need the kernel measuring the firmware, but
hardened environments do measure firmware.

> If someone has such need the infrastructure could be added to the kernel
> at a later date.  Existing functionality is not broken in any way by 
> this patch series.

Wow!  You're saying that your patch set takes precedence over the
existing expectations and can break them.

Mimi
