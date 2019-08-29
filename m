Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31548A1D56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfH2OlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 10:41:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfH2OlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KdVEQ5VHWxxvnLBymhZvGgMWXmV/8HO1L9jLY+cC+b4=; b=kNRVBxJEcBa0af3GiXPGGFOZT
        oCh+HQZnQv4RvcQGc+jSeepfyhlLUVsHDVH/T4WP8No1q3gznXe7HfqRZS2YNX00hi0dTdnb/04D+
        PasJEtLwJ2nkcDEHtIGAtdo3pBzMhfXMcA3I3QrVzzwJnyQTRHcltq86qSDPsVRAQfPR69Exn2vPX
        wumT6ZC0llos6PXgfW5wO21RT97FgH4cJhNmSjg3mhMGoTdeULBaJ9OFHUQcljnhTPtwbc7sVVdSX
        m3s0D3gE2VPjKc2c3x5kclJy3LHFLN2g4ga3feezppd4VnMzgpRlo2FhqO0KmDIrR/IwBLwHC+RRI
        UryEw8zeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Lbk-0001H5-38; Thu, 29 Aug 2019 14:41:04 +0000
Date:   Thu, 29 Aug 2019 07:41:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190829144103.GA1683@infradead.org>
References: <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
 <20190824230427.GA32012@infradead.org>
 <20190827095221.GA1568@poseidon.bobrowski.net>
 <20190828120509.GC22165@poseidon.bobrowski.net>
 <20190828142729.GB24857@mit.edu>
 <20190828180215.GE22343@quack2.suse.cz>
 <20190829063608.GA17426@infradead.org>
 <20190829112048.GA2486@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829112048.GA2486@poseidon.bobrowski.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:20:50PM +1000, Matthew Bobrowski wrote:
> Uh ha! So, we conclude that there's no need to muck around with hairy
> ioend's, or the need to denote whether there's unwritten extents held
> against the inode using tricky state flag for that matter.

So in XFS we never had the i_unwritten counter, that is something
purely ext4 specific, and I can't really help with that unfortunately,
but maybe the people who implemented it might be able to help on that
one.
