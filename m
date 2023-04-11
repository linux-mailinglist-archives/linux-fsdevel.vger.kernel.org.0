Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257D6DD19C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDKF1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDKF1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:27:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735DC271B;
        Mon, 10 Apr 2023 22:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aVkjrMhSt+BrTvnSznAxQhWLh2
        uAoxTleiBMFwuoWwW6mWqhILeyW6J8sKTfzYYkftecAzEk+wGO1dDg3oLRJWqq++nnfQDK+5m7Jb+
        NDakE9LbS6o9bnd/8ecG8ZtAhHY+N2FG72BPPD4DfHQCJf7DkQCHONIVaexD2KsSuFR0X063CNFs/
        65ssZGJyo4Yq14eohd9NSGXWdJ4pUywC9+eidRZkQRf9f7dPeU0ADsa4/a5JLeZ5NhLQocPHXvXdF
        6YvQM+sIfF3ksrra0bJA+8NDaUd1jGT3RBzSmmrp/JffppFaZUTRvIzh69tHRqNLkvaj5vi96I4rg
        0BcAFz3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm6XP-00GSUn-0P;
        Tue, 11 Apr 2023 05:27:27 +0000
Date:   Mon, 10 Apr 2023 22:27:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 6/8] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
Message-ID: <ZDTvv/rLisw0YBi2@infradead.org>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <86d8ef97a805c61761846ee7371c95131ec679be.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d8ef97a805c61761846ee7371c95131ec679be.1681188927.git.ritesh.list@gmail.com>
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
