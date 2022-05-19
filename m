Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A665152CD47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiESHjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiESHjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:39:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD0A7E2A;
        Thu, 19 May 2022 00:39:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4EA2668AFE; Thu, 19 May 2022 09:39:12 +0200 (CEST)
Date:   Thu, 19 May 2022 09:39:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <20220519073912.GF22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <20220518171131.3525293-4-kbusch@fb.com> <YoWL+T8JiIO5Ln3h@sol.localdomain> <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 07:00:39PM -0600, Keith Busch wrote:
> How? This patch ensures every segment is block size aligned. We can always
> split a bio in the middle of a bvec for any lower level hardware constraints,
> and I'm not finding any splitting criteria that would try to break a bio on a
> non-block aligned boundary.

Do you mean bio_vec with segment here?  How do we ensure that?
