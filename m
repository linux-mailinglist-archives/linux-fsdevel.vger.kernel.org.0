Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EFB726147
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjFGNaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 09:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjFGNaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:30:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7521AC;
        Wed,  7 Jun 2023 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GDHR4aFrrReoV3V4aWQhlwhUHLkt4QMHTM2AiWMpQTA=; b=hS5hyGka78IPTsstz3d4plca2h
        rXcUZizyaST84XeKLqIxLkWJOUlhxhPuwAAWpc8LmjX0KURwheWVtdeAr4wqji9FQ8Z2sDde4npAJ
        gR/lENesNeVXmFdhxtvgjOacmDwczPdCPlaI5ZGh5Fj5rank3fU5FqtwjBXXhnNFUWuwahm2ze1jL
        X+tr9GdQ2FTb6x/B+yi3tUM9GZFcXWyrX4Oii7JeCRvKPF8ljdrjouh2wDvBILTZNLFFCkeijLJ9z
        Ux0oBp+7jnhxheRHbykR6oI8su3NRmbsFBJEV0PQjuHU1FXVAUZs+wXjSPgMa+bcyU1NubMxyGYdV
        wbEx7z5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6tEa-0066VG-1x;
        Wed, 07 Jun 2023 13:29:56 +0000
Date:   Wed, 7 Jun 2023 06:29:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 2/5] iomap: Renames and refactor iomap_folio state
 bitmap handling
Message-ID: <ZICGVCWx3PKaBnF+@infradead.org>
References: <ZIAouOHobxGXUk5j@infradead.org>
 <87wn0fimbe.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn0fimbe.fsf@doe.com>
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

On Wed, Jun 07, 2023 at 04:14:21PM +0530, Ritesh Harjani wrote:
> 1. Renaming of uptodate and uptodate_lock to state and state_Lock.
> 2. Refactor iomap_set_range_uptodate() function to drop struct
> iomap_page from it's argument and move it above iomap_iof_alloc() (or
> iomap_ibs_alloc or iomap_fbs_alloc whichever name we settle with)
> 3. Add uptodate bitmap helper routines e.g.
> iomap_iof_is_block_uptodate(), iomap_iof_is_fully_uptodate().

Yes, please.
