Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83086DF405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDLLo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 07:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDLLo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:44:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA9D1FEA;
        Wed, 12 Apr 2023 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uj4IBFdY4V4iRWEi/peM6LZg3PlgJcceHWlbdLmQ1Io=; b=OEpD5FUkesvy68wwHtL4TQVu5s
        YmmVtlJBiBjd55XH3wRVrnEfqPEE5LWs+AGX/RR7wy3+lgMX+LMh0kaythj7cMeEorQUN+3Axq+tr
        U9i5ITbK5/G1DQ++DHa9oBiTsB3ZxpoVMN/PXOepSRui4RPNeXz7T4rnEW6LExdnwqJUYm/5DmaRa
        UsZujSpQosRVGHynGRod3O5TIH1BQFsOj1qefirixUjpz3qT/Ty+f4nzhs8ubLKkD/DbM3q8rc/Xf
        WtK3EjG3XzAVjC8b7EgGSLvOEFkoLDob8GTUuB/Nb94POn3R8MrhEPlLmne4X6KQd6u33WmhjOAnP
        hUwcWBNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmYu0-002vfx-17;
        Wed, 12 Apr 2023 11:44:40 +0000
Date:   Wed, 12 Apr 2023 04:44:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 8/8] ext2: Add direct-io trace points
Message-ID: <ZDaZqL8eAw5qgecQ@infradead.org>
References: <20230411143433.GE360895@frogsfrogsfrogs>
 <8735561mk6.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735561mk6.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:41:05PM +0530, Ritesh Harjani wrote:
> Sure. Let me also add a trace event for iomap DIO as well in the next revision.
> However I would like to keep ext2 dio trace point as is :)

Am I confused, or does this patch only add new trace points anyway?

> 
> -ritesh
---end quoted text---
