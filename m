Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A667C1D1D3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390114AbgEMSRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733175AbgEMSRA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:17:00 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7312820659;
        Wed, 13 May 2020 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589393820;
        bh=7OdZ4IZArUi+L4mY8bHUPOZTuTiNZ3U2f/N6r1sYvNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tksfnANLVmlXEvwcksk10I0WQqNWoydzaZczzHwya8RjqTwR39GMXOEVvQV4MIX04
         35pvgssetPaGXSG5fZwqJf9km87mgDBWNsN3BLyEF2BGTjgo3GA1B5IhhFkpr9wl3K
         a7yYuAlxQnWqha8R1PhibTiiwD1Xy5rYh4/0/Evc=
Date:   Wed, 13 May 2020 11:16:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 07/12] scsi: ufs: UFS crypto API
Message-ID: <20200513181658.GG1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-8-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:54AM +0000, Satya Tangirala wrote:
> Introduce functions to manipulate UFS inline encryption hardware
> in line with the JEDEC UFSHCI v2.1 specification and to work with the
> block keyslot manager.
> 
> The UFS crypto API will assume by default that a vendor driver doesn't
> support UFS crypto, even if the hardware advertises the capability, because
> a lot of hardware requires some special handling that's not specified in
> the aforementioned JEDEC spec. Each vendor driver must explicity set
> hba->caps |= UFSHCD_CAP_CRYPTO before ufshcd_hba_init_crypto is called to
> opt-in to UFS crypto support.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
