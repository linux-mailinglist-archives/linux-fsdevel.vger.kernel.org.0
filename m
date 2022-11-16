Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8910962C388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiKPQJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiKPQJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:09:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE6D56EE1;
        Wed, 16 Nov 2022 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FUlTxx4wtR65WJ5qQ4MHWcmwco
        ck17GfnRKs1B9b3U60nh7qgved0lcGPtvNvFaLK+gXA92dSz8hWkBOAh9z6ouM9YrAgF18B9RsEqB
        tn2ORGsadwvgHWHMMu7SpOemh3yLBa22XmGt7c0NGYyK3IBHnRU5ft5G/El2O/bto+kNTMC3WQ+/C
        Me8UiHcZpH4KVGphm0QKADKGgq1t9IVklTdkDrimuA1d1l3FL8qUCMlg8mSG3W3XFdHAVUlNMxoEr
        gb3aN/2taUnPHadk//jeqdGw6kqoAz628trkZVGPGUmtAJBlpkNlcBLdlB+kIIkDkViSIpXrmvt+Y
        k9JVhQ1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovKyO-005iRC-WB; Wed, 16 Nov 2022 16:09:12 +0000
Date:   Wed, 16 Nov 2022 08:09:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        chuck.lever@oracle.com, viro@zeniv.linux.org.uk, hch@lst.de,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 4/7] ksmbd: use locks_inode_context helper
Message-ID: <Y3ULKDSFWC2StNwb@infradead.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
 <20221116151726.129217-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116151726.129217-5-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
