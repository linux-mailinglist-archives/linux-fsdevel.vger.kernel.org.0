Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C05CE7093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 12:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbfJ1Lj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 07:39:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfJ1Lj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qlaRIlg2IzHlknjdR50kOOzdtwiROoikVmFM60sEtfY=; b=O+rif9bOXr8XIG1Mu1oBzvBg7
        ONF2DJt8igNpozuZHO6SFOXM7asLVC9s/240RyJ+AvKpGGX+QdsHBVcb/+AViPZyY3Bztw+D+vXOJ
        nn6abYBCb5dcDVlij63Qm1aMwITCecRR4Xwsw4LtpVGGQHZEPOtMlhNKoRczSK68vFTpnZn5YEFe8
        zZkbewymgdxB8y00NXwGSZdaarHT4T8z7N+MaLES3IxVnVEQOv8GyoqBO1IRtXyGQn0KFrWQ/uKkp
        RQC03L0x644OIvhavb/LbF03rOzd6KoDi6cLxRe1nxrPapZG4fdf04srHXqNicbbnuKh9cWd/I0eA
        44QcBmt0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP3NG-0000mT-27; Mon, 28 Oct 2019 11:39:50 +0000
Date:   Mon, 28 Oct 2019 04:39:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v17 0/1] staging: Add VirtualBox guest shared folder
 (vboxsf) support
Message-ID: <20191028113950.GA2406@infradead.org>
References: <20191028111744.143863-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028111744.143863-1-hdegoede@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:17:43PM +0100, Hans de Goede wrote:
> Hi Greg,
> 
> As discussed previously can you please take vboxsf upstream through
> drivers/staging?
> 
> It has seen many revisions on the fsdevel list, but it seems that the
> fsdevel people are to busy to pick it up.
> 
> Previous versions of this patch have been reviewed by Al Viro, David Howells
> and Christoph Hellwig (all in the Cc) and I believe that the current
> version addresses all their review remarks.

Please just send it to Linus directly.  This is the equivalent of
consumer hardware enablement and it is in a state as clean as it gets
for the rather messed up protocol.
