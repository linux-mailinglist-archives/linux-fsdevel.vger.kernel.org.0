Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDE39D4C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 08:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFGGRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFGGRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:17:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3AC061766;
        Sun,  6 Jun 2021 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=oawbtEP8uHGSz69C5s6bH+uzE7
        6fsCnhdr6gYc7uq/gcDnDL00mDMZMI5vxky9QSfdYwDPbQ7CWL0bw0Ri7INiiZjKeg4/O2n74g9Yn
        t0GpJ9TJcjjHtVctveaOFP0Gd5DN4RFasPHYsOU60RItaERL4cOTKiD5Okq+tHgKoSVUS52gDNAS1
        PLOjbf706ECQgyIo9iOSzj5A3d0ZU8xGkJ5SIEDusRBOoJSClyloEMPVO49mOB9Ee0FEacaKdKw05
        ZriqylSq2yUNXXAxtSZCYzHrm+wAtjkITR83CF4lvmzylOugNbbZ9o8nl7rvJw7m7hxq9O4yZq5X0
        gYLIjEPw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lq8Wz-00FQfc-HT; Mon, 07 Jun 2021 06:14:41 +0000
Date:   Mon, 7 Jun 2021 07:14:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, brauner@suse.cz,
        linux-api@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/2] Change quotactl_path() to an fd-based syscall
Message-ID: <YL25TVhiqAoF2voU@infradead.org>
References: <20210602151553.30090-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602151553.30090-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
