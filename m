Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736AE6FDEB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjEJNgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjEJNgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 09:36:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640616593;
        Wed, 10 May 2023 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YaQwF1frg1L2zFBLSgiiO6ayGJAl/k8aAvj4g4Zl+8s=; b=tehkRIobsVut8UrEW31Irtgy2W
        GE6VNKPcKoL+qQ+KdNM7GF7vhNOYYcgvHhSlWDvBZK/w+nkHts2K6PXQ6xFYSrzvmwjUjlaLkcZo9
        sarCYcW382dt0sa225SEswfeQyfpNa9VPq3ouMH85J2Wy2IX7tM8TYlnj8FPkwSlAimLZMwr/vwVN
        amAZNpiWOH9U/ph0Z/3LpRDywt/A05MEATkxWfb2qR0gAyJ0Nq/WX2ZG4kWZoey4xEbxGimLDpEH6
        1meH9GnWlVFVS7REznNfkukhIh6P8c9HZmL/dv4RBr8tsdsZj0/5h4KayvJO65WLd/GJ5qdho0VEY
        Hpm9qvEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwjzW-00GJLp-S8; Wed, 10 May 2023 13:36:26 +0000
Date:   Wed, 10 May 2023 14:36:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: remove page_endio()
Message-ID: <ZFud2lRePq1lI70m@casper.infradead.org>
References: <CGME20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7@eucas1p2.samsung.com>
 <20230510124716.73655-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510124716.73655-1-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 02:47:16PM +0200, Pankaj Raghav wrote:
> page_endio() is not used anymore. Remove it.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
