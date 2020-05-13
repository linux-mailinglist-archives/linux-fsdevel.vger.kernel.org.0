Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3981D1D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbgEMSQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733175AbgEMSQR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:16:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5141A20659;
        Wed, 13 May 2020 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589393777;
        bh=NzWZMwcALO2Ink36HyIe2Q6IAjI7yALGFMtqrR20MkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cq1KZYO+yqMKqCVJa5a+qSnmOdDeU9MYSCzy91/uXLdy/BkeajpPJD0xzF62BtUSi
         v0car04IsUZjOGWn3W2aZ+zTtfHX798CRa97jEknrFuB/IMQB9tCptjZNaol5OyNRV
         0MPR7cNoSo5OM4BXzpqeaG6ZWtVSZ8K9dfVGyYm8=
Date:   Wed, 13 May 2020 11:16:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 06/12] scsi: ufs: UFS driver v2.1 spec crypto
 additions
Message-ID: <20200513181615.GF1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-7-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:53AM +0000, Satya Tangirala wrote:
> Add the crypto registers and structs defined in v2.1 of the JEDEC UFSHCI
> specification in preparation to add support for inline encryption to
> UFS.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

One nit:

> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 6ffc08ad85f63..1eebb589159d6 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -555,6 +555,12 @@ enum ufshcd_caps {
>  	 * for userspace to control the power management.
>  	 */
>  	UFSHCD_CAP_RPM_AUTOSUSPEND			= 1 << 6,
> +
> +	/*
> +	 * This capability allows the host controller driver to use the
> +	 * inline crypto engine, if it is present
> +	 */
> +	UFSHCD_CAP_CRYPTO				= (1 << 7),
>  };

The other values of this enum don't use parentheses.

- Eric
