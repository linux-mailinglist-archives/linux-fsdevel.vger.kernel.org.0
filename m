Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9D1658AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTHrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 02:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgBTHrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:47:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6532208C4;
        Thu, 20 Feb 2020 07:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582184833;
        bh=gPFYPlPnP/EO0JNRRO6YxcBxUsp8SOzVZcqRWL9kXvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USNKR+BT0TGhAlcJQyt5OOIbt6HU5RZS60UVLaL2YxTd4Bgkx5WIfj0yUxLkdbNvU
         4JSWh9j1JqzPu708h6CS8Ibfz0EqV6kyXNomJDv2xlfDrcK2b260E89Rmr+nNsAvP6
         sQSd82XThSBAEqjFkpi1wMEWdk9jvIB9+QaRtKtA=
Date:   Thu, 20 Feb 2020 08:47:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200220074711.GA3261162@kroah.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004825.23372-7-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:48:24PM -0800, Scott Branden wrote:
> Add Broadcom VK driver offload engine.
> This driver interfaces to the VK PCIe offload engine to perform
> should offload functions as video transcoding on multiple streams
> in parallel.  VK device is booted from files loaded using
> request_firmware_into_buf mechanism.  After booted card status is updated
> and messages can then be sent to the card.
> Such messages contain scatter gather list of addresses
> to pull data from the host to perform operations on.

Why is this a tty driver?

Have you worked with the V4L developers to tie this into the proper
in-kernel apis for this type of functionality?

Using a tty driver seems like the totally incorrect way to do this, what
am I missing?

Also, do not make up random error values, you return "-1" a lot here,
that is not ok.  Please fix up to return the correct -Ewhatever values
instead.

thanks,

greg k-h
