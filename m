Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81BD725400
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjFGGVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjFGGVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:21:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13467AA;
        Tue,  6 Jun 2023 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=as7HoSo6fK1iB1ZeJ1fvStsjFygkeg1TGSwX3BDPsnY=; b=Jqx2/aBqpN8trsbbYkEWEM4Ma/
        WXV779ZszyTPK+MRTmdnoCAtfOz3l/xhv1y0BStvycm8gcZz0+ObE0FRGZDwLcnBfqct3Yo8c+a1K
        fcfV1LHyRnv3GPgOhdtzblIdBIkUOnGCwaqYig9kW2qTbPwSCo1DeL8UO0/ZffqZ1urxxLUSuqv4/
        jc5735mzM8o82g/coA2CyyPkua9vo6y17AGco2nSORcVpFqt/kxUXRvdtqHvexqCKRObDEJrn6KRH
        Lbkfv+R7kVu47U70YffNXgBw9AOH5+rlM7CHJUrY5SxSM4+ooIsEIP/RK8r+7hgGsylfjp79OEjwG
        qWWAg3hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6mY8-004Xuy-1f;
        Wed, 07 Jun 2023 06:21:40 +0000
Date:   Tue, 6 Jun 2023 23:21:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wubo.oduw@gmail.com
Subject: Re: [PATCH 1/1] fsnotify: export 'fsnotify_recalc_mask' symbol
Message-ID: <ZIAh9BFbUy3Soz4W@infradead.org>
References: <20230607024700.11060-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607024700.11060-1-bo.wu@vivo.com>
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

On Wed, Jun 07, 2023 at 10:47:00AM +0800, Wu Bo wrote:
> To enable modules to update existing mark, export 'fsnotify_recalc_mask'
> symbol.

Why, and which module?  And why isn't the code to use it included?
