Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3B6E357C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 08:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjDPGou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 02:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:44:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F24FB;
        Sat, 15 Apr 2023 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6s4LiducBObu0GNShPsneVlFyIlB4lwkmTrNe/+ASkM=; b=lvBh02tlbPtOc2LTH6TiSIt5sG
        Zuq1m9Yn5H6ww/GPK6rdF0IB/MatWA2uI9ezxIFk+mUjv49PtOXP4URUtUYhBymKwaliQwFFNbEYa
        LhuI1uJdrGTslnVS387sTJn10ID5yqR8Hs2BPqJdRT0SDWI2cj1Eo6TU6ZSTw55g+MFetWSSlJ9I9
        GGQtTKnFD2NGGVId/tbYQDXERi+81g/rjxa+k3D/DwoCCfbRxLTrWHGcDtSl0HBb7HF8w72Fjuxup
        1pAp3BWHW9kyly66szTcE9c5dOj6ZbYqLtAvCxJbDdq4pDzhoRq7h6rQ3yswtbOSgoMSQupbOxT+8
        Z8sjLGFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnw80-00DFXK-22;
        Sun, 16 Apr 2023 06:44:48 +0000
Date:   Sat, 15 Apr 2023 23:44:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv4 9/9] iomap: Add couple of DIO tracepoints
Message-ID: <ZDuZYOEQT38nMlbS@infradead.org>
References: <ZDuOtt6w+ZOcVv9w@infradead.org>
 <873550jb4e.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873550jb4e.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 05:24:25PM +0530, Ritesh Harjani wrote:
> Sorry, my bad, I might have only partially understood your review
> comment then. Will quickly send the next rev.
> So in the next rev. will only just add a _begin tracepoint in
> __iomap_dio_rw() function. Rest everything should be as is.

Thanks and sorry for beeing unclear.
