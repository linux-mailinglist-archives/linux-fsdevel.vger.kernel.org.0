Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD476FDE80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjEJN20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjEJN2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 09:28:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1741E61B7;
        Wed, 10 May 2023 06:28:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 772E668BEB; Wed, 10 May 2023 15:28:18 +0200 (CEST)
Date:   Wed, 10 May 2023 15:28:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] filemap: remove page_endio()
Message-ID: <20230510132818.GA3749@lst.de>
References: <CGME20230510124718eucas1p2c11356c0628b9acb44c1174fd45fa4b7@eucas1p2.samsung.com> <20230510124716.73655-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510124716.73655-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
