Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FF16B5C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 00:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgBXXiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 18:38:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBXXiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q86n0/Atkm4Y4ZtubbVGTblHU1TxdG/2icnoc8+Xwo0=; b=tsH+RQq9nsdWo8IIY9tkNpYUNU
        XgrNdOr80eLKEtXvEFno8gvU4qBdtiN5909aTbWi0i4Mn192mp414I4f7ImjuKXsQEPhOibS7bTwU
        cOsxCIWLp2zKT3TrsWxL2LBmNdhy2TDXl8m50nN4H1fo5ZuoIqjiPZzhYNjCMDBSq643wPIW66ATo
        c2u37N+UIz34xOGA5lZnneTU0FiBG/QNqURtzRbfxDmVDDvcVQXxx2J9oSjbcL56/SnvF6ZaDdp5f
        xwB90p+ijsqr/WHbcdu8Ex6TI2tXeVKVR+0eEXlgj0Omm7bgRLCdF0x20EQH304R+C2d0zp+9SCLy
        d4HdDp4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6NIV-00021I-MY; Mon, 24 Feb 2020 23:37:59 +0000
Date:   Mon, 24 Feb 2020 15:37:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: Re: [PATCH v7 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200224233759.GC30288@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-7-satyat@google.com>
 <20200221172244.GC438@infradead.org>
 <20200221181109.GB925@sol.localdomain>
 <1582465656.26304.69.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582465656.26304.69.camel@mtksdccf07>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 23, 2020 at 09:47:36PM +0800, Stanley Chu wrote:
> Yes, MediaTek is keeping work closely with inline encryption patch sets.
> Currently the v6 version can work well (without
> UFSHCD_QUIRK_BROKEN_CRYPTO quirk) at least in our MT6779 SoC platform
> which basic SoC support and some other peripheral drivers are under
> upstreaming as below link,
> 
> https://patchwork.kernel.org/project/linux-mediatek/list/?state=%
> 2A&q=6779&series=&submitter=&delegate=&archive=both
> 
> The integration with inline encryption patch set needs to patch
> ufs-mediatek and patches are ready in downstream. We plan to upstream
> them soon after inline encryption patch sets get merged.

What amount of support do you need in ufs-mediatek?  It seems like
pretty much every ufs low-level driver needs some kind of specific
support now, right?  I wonder if we should instead opt into the support
instead of all the quirking here.
