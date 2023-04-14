Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E916E1C23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 08:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDNGAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 02:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNGAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:00:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900CF1BC5;
        Thu, 13 Apr 2023 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q943ycV218LzoaVqdSEZ0yWb+RcKsNGDHGiTNIwtOMs=; b=E3O8FLlifWu4tdXT6UprJIhWiv
        0x+QnASO3FUNmPDP6CbN2s31hDIB233yOjAdJ6FlV0I71b45+Sj0VqnWbLnRmGuI1E6YcAIeCqaJJ
        FreDiGdWvVOrNaXJKc80MDARdeuW/rRM4AdD6zVkWL8ZjbDKpCcy2UfnN4pT95ym/ym0iDJoi0sm2
        PZZFYPN/Rc/8tEUiZCjb46FXw+DRfHuqS5OUnouWVywKaUnCIv/pHGr0VIW0hUk2W8L5yRUocIcAq
        TEB43VETnYxi2t5c3NWgbdjgOyv1Nm5lprKoOtiy7FisLKy29ZlXo8VoItZmNAoOo95xFyHIJLEPT
        poPKV3Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnCUO-008QKG-2T;
        Fri, 14 Apr 2023 06:00:52 +0000
Date:   Thu, 13 Apr 2023 23:00:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 09/10] iomap: Minor refactor of iomap_dio_rw
Message-ID: <ZDjsFG2Rfbb+9nd4@infradead.org>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <ac0b5e5778585f8d02b4abc355f185cba261b239.1681365596.git.ritesh.list@gmail.com>
 <20230413143530.GC360877@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413143530.GC360877@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 07:35:30AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 13, 2023 at 02:10:31PM +0530, Ritesh Harjani (IBM) wrote:
> > The next patch brings in the tracepoint patch for iomap DIO functions.
> > This is a small refactor change for having a single out path.
> > 
> > Tested-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> IMHO this could've been part of the next patch instead of separate, but
> eh, whatever, looks good to me.

Yeah, without the next patch this is a bit pointless.  And also a harder
to review without seeing why it is done.
