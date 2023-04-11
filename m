Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB36DD1DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDKFi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKFi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:38:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D484272B;
        Mon, 10 Apr 2023 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DtJBda7+423fCPXSoaU+w/bnAF
        xEzsEwvzsNukBCpHfYe4JqcBSVsm60zPalyMIe2jlJyMUJeoFWaQCeiJ1vqaX0KC1hXP/E6XYVEJ4
        ityc2kLM4mkdM5p1ffUEyN8gT1IgR4UoOkH2VTM1mUuNmlh1/C6GMv6b8V48QIeOuty6CaMWxeW15
        YRudJxXrbtdkRplphwpSIrHOcEggSIfOV9SYFDYWa+ZIrdO9hlsuuF4tdK1A7DqL/vKPcoeeNDOGB
        XrOjhBPSjO9LWl7AYl65POwgiXRyaAbAXl8E0lLgMVbMOh24Gi4oMG+2eMh3285MPjRo9yYzrwYIz
        WBz1flmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm6iT-00GU9c-05;
        Tue, 11 Apr 2023 05:38:53 +0000
Date:   Mon, 10 Apr 2023 22:38:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 7/8] fs.h: Add IOCB_STRINGS for use in trace points
Message-ID: <ZDTybcM4kjYLSrGI@infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <d02f3e41ef7e2af88640cc8d4403f54530942776.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02f3e41ef7e2af88640cc8d4403f54530942776.1681188927.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
