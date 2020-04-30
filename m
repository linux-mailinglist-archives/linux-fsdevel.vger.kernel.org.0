Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4A1BEFD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 07:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3FhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 01:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3FhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:37:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF124C035494;
        Wed, 29 Apr 2020 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Jvr8m7fqRAfocxSgfZIiM/MufD
        Wqzgr5WRn8csXSD03Nq9jIHgo142vaHf7FJp9/MviUakPgXO53UDMJAvFCH6OMD6VXVojM6WlR0QS
        ZfpkNDT5y6XWPEmTAHZhAKdGJaXX+Adx6SCusrvOPyKdtfFxYeocSFCN060zBJwFfk51LxwsTz8Jr
        MBlFjjG39MlFQ3qU4UfpUvkh0wCDBP5+cmXk7SMMB3BpiNJGL/ZjMqGZV5RG7vGENq0OWeGOherMB
        91RzEOkr1PyotgpS9A9x4cL1XeudzYMPXfIjlngoWeR0WOxgeha2EvxhsMMrphoOfT1Hes6oiagCE
        bWPaz3qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jU1sq-0001SF-IO; Thu, 30 Apr 2020 05:37:16 +0000
Date:   Wed, 29 Apr 2020 22:37:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHv3 1/1] fibmap: Warn and return an error in case of block
 > INT_MAX
Message-ID: <20200430053716.GA27852@infradead.org>
References: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
