Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53A47DF63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbhLWHPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbhLWHPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:15:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630AC061401;
        Wed, 22 Dec 2021 23:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B0961DCF;
        Thu, 23 Dec 2021 07:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CCFC36AE9;
        Thu, 23 Dec 2021 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640243708;
        bh=HVxM//ntK1qRnHFipdMHkr5gZeZwVoVR/PC1f0qXHkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FabOGeiKxi6Xam81bcnqxvCPwPxizBnxiL+FGB5WYK8kVTOWeCluGzx/lK/+DliqH
         cqG1hbS5rpmwRFAt/moZdv61H6adWAFE0NFMI+RUIQQOYANfVDtrZD8bn3ar1dJpCC
         YL0+JvodiB08nT886BZOunkmoGnKbzqFxE23SlS0=
Date:   Thu, 23 Dec 2021 08:15:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, logang@deltatee.com,
        dan.j.williams@intel.com, hans.verkuil@cisco.com,
        alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] chardev: fix error handling in cdev_device_add()
Message-ID: <YcQh+M/7STAG/4Ka@kroah.com>
References: <20211012130915.3426584-1-yangyingliang@huawei.com>
 <1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 09:41:03AM +0800, Yang Yingliang wrote:
> ping...

ping of what?  You suddenly added a bunch of people that were not on the
original thread here with no context :(
