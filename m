Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB09F153740
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgBESHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:07:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBESHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gs10jRZHLwjIOjYVjU5UoDYIxulcXGovME2eBvzaEu0=; b=K5B5B1Wr2NgBnfmyO9DXR16gbP
        UWtIGk1NOt9+nnJLa9z8Hx9aSHXAN28QVk1+j81UZ4ps+KIX9PiL9RpepFY/llR8vFYM+VjxtlFKS
        RDOAmrCz0xLwUfEcXOpE2w90vsqxK/HjozjZTrvXiNdfa3RLhAyBfl4ZvQeuUtR45EfyP1J4NEb91
        ZQqGP8cVqKIEOApdbh+sWw7rj5D3LQJcioXoE1HLIt3g3pw4KsToRoLAKhhQafKmFFHfG7FQhSrxz
        jPx50gFpHpM6INp9TKyjx7BSF1JuGgUr03bW8xgOuoy7ti96pTjdN62goLKbranqk9g+U3q97w5jc
        i5/J1IIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izP52-0001RS-L0; Wed, 05 Feb 2020 18:07:16 +0000
Date:   Wed, 5 Feb 2020 10:07:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200205180716.GB32041@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-7-satyat@google.com>
 <20200117135808.GB5670@infradead.org>
 <20200118052720.GD3290@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118052720.GD3290@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 09:27:20PM -0800, Eric Biggers wrote:
> On Fri, Jan 17, 2020 at 05:58:08AM -0800, Christoph Hellwig wrote:
> > On Wed, Dec 18, 2019 at 06:51:33AM -0800, Satya Tangirala wrote:
> > > Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> > > encryption additions and the keyslot manager.
> > 
> > I think this patch should be merged into the previous patch, as the
> > previous one isn't useful without wiring it up.
> > 
> 
> Satya actually did this originally but then one of the UFS maintainers requested
> the separate patches for (1) new registers, (2) ufshcd-crypto, and (3) ufshcd.c:
> https://lore.kernel.org/linux-block/SN6PR04MB49259F70346E2055C9E0F401FC310@SN6PR04MB4925.namprd04.prod.outlook.com/
> 
> So, he's not going to be able to make everyone happy :-)
> 
> I personally would be fine with either way.

Oh well, the split between adding functions and callers is highly
unusual for Linux development.  Adding the defines I can see,
especially if they are large (which these aren't).  But you'll need
to get this accepted by the UFS folks, so I'll shut up now.
