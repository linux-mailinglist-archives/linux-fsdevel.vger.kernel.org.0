Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B571081F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjEYI6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjEYI6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 04:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A6E6A;
        Thu, 25 May 2023 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kKOFZxQpgSHwqPpOmDSrhdrD3suPNbVE//fKG28eDvM=; b=Wi28jKvm/jdPHVPrfw1vBlrPKz
        EtHecYXiHt+MOaCUqHVMvBJZov0Pe4UGeRr2z9K8Zk29a3xC558HI3XcoauY/8Wf64OWOEhYORdpU
        4bOhfbWqeg+hMcb2uXjE6tkbpVqnFJlqMhdLA03uNmSSr7FVATOYrgYqvpn8NmL3pDk4ZTuIA6hqL
        RRxQt47O6xqc12D4G86r2GKBZ9pSrU8EtMVei5D4u1g/zkEACxEq4xT6Q4i3zj23gBfpFK19SceOL
        kGUXILvgSD2VZsDUMGqkzpwNIXt0y7n3+s7e7TdvtifwhkmCkvXK5rMaZGF1m1VuV0I0JI/EFSTZ1
        evki6wKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26nW-00G4TT-06;
        Thu, 25 May 2023 08:58:14 +0000
Date:   Thu, 25 May 2023 01:58:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZG8jJRcwtx3JQf6Q@infradead.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <ZGzrV5j7OUU6rYij@moria.home.lan>
 <ZG2yFFcpE7w/Glge@infradead.org>
 <ZG3GHoNnJJW4xX2H@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG3GHoNnJJW4xX2H@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 04:09:02AM -0400, Kent Overstreet wrote:
> > Well, it seems like you are talking about something else than the
> > existing cases in gfs2 and btrfs, that is you want full consistency
> > between direct I/O and buffered I/O.  That's something nothing in the
> > kernel has ever provided, so I'd be curious why you think you need it
> > and want different semantics from everyone else?
> 
> Because I like code that is correct.

Well, start with explaining your definition of correctness, why everyone
else is "not correct", an how you can help fixing this correctness
problem in the existing kernel.  Thanks for your cooperation!
