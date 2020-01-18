Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53D14161C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 06:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgARF11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 00:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgARF11 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 00:27:27 -0500
Received: from sol.localdomain (unknown [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAD820748;
        Sat, 18 Jan 2020 05:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579325246;
        bh=Su46dTvr6LjbK97+KpEmyjmd9MCvkLqGMyfTWsk56iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFIjHfQvc0kv0Ya/20xHIdfC6o2bof5u5eJqd9/VwJTPA9YcLj8x1k0vYihsxVLtW
         t1a4NJrrFEzd69isqDax6lXJWaafYGXjS953uoZ94rGPWCAsJxRPKpvc74B6onf6sr
         FOJFhvTtB6DdCiGovue/tD35DIjmdgbzT+VmQa00=
Date:   Fri, 17 Jan 2020 21:27:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200118052720.GD3290@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-7-satyat@google.com>
 <20200117135808.GB5670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117135808.GB5670@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 05:58:08AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 18, 2019 at 06:51:33AM -0800, Satya Tangirala wrote:
> > Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> > encryption additions and the keyslot manager.
> 
> I think this patch should be merged into the previous patch, as the
> previous one isn't useful without wiring it up.
> 

Satya actually did this originally but then one of the UFS maintainers requested
the separate patches for (1) new registers, (2) ufshcd-crypto, and (3) ufshcd.c:
https://lore.kernel.org/linux-block/SN6PR04MB49259F70346E2055C9E0F401FC310@SN6PR04MB4925.namprd04.prod.outlook.com/

So, he's not going to be able to make everyone happy :-)

I personally would be fine with either way.

- Eric
