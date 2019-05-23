Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1B275CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 07:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfEWFwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 01:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfEWFwg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 01:52:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AEFE2075E;
        Thu, 23 May 2019 05:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558590755;
        bh=/g4Suzk9Uv40ML24PDYpoH3ELnGQmDwI4WXDie7W71Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W948ysnYaVqAVTxIZC4wSkNbqRVKQerewHEMvKfC4gpj6EAHT3ghkme9VgDOSqZoZ
         Chs4ufQTwwVPvic54RaWWa8trh4khB2BlGosIRh38MH+bmeUQ6PYlZPo7GwsO9/ITo
         4Imjh9WA9FVC6GlyLonu86qgAMCbghCvT697Wk3E=
Date:   Thu, 23 May 2019 07:52:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
Message-ID: <20190523055233.GB22946@kroah.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523025113.4605-3-scott.branden@broadcom.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
> Add offset to request_firmware_into_buf to allow for portions
> of firmware file to be read into a buffer.  Necessary where firmware
> needs to be loaded in portions from file in memory constrained systems.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/base/firmware_loader/firmware.h |  5 +++
>  drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
>  include/linux/firmware.h                |  8 +++-
>  3 files changed, 45 insertions(+), 17 deletions(-)

No new firmware test for this new option?  How do we know it even works?
:)

thanks,

greg k-h
