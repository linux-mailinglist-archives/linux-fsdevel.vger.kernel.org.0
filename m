Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA99353BE44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiFBS4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFBS4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609CFF7;
        Thu,  2 Jun 2022 11:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E4A66173C;
        Thu,  2 Jun 2022 18:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B80C385A5;
        Thu,  2 Jun 2022 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654196201;
        bh=BIJuR3WVfttnfFMroMY2Ci020YZ18R5cA31hsspvHFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mqiG1DS5bCF5nIrUoquIR/CCs0U4P7fzkvKP5YTn7cBnJMGVPNjbsLRQJh6cF1vwW
         3QkYccG/hSBWmY1db6kkKLxbLrh5kRd5AtfYAWl8QyPAaC4yNP6ogir2wZfiEDH5yN
         S6dLskkyKjA0eHNdLo12JmC0EgDEZn+213i2BpjI=
Date:   Thu, 2 Jun 2022 11:56:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
Message-Id: <20220602115640.69f7f295e731e615344a160a@linux-foundation.org>
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 8 May 2022 22:36:06 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> This is a combination of two patchsets:
>  1.fsdax-rmap: https://lore.kernel.org/linux-xfs/20220419045045.1664996-1-ruansy.fnst@fujitsu.com/
>  2.fsdax-reflink: https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/

I'm getting lost in conflicts trying to get this merged up.  Mainly
memory-failure.c due to patch series "mm, hwpoison: enable 1GB hugepage
support".

Could you please take a look at what's in the mm-unstable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm a few hours from
now?  Or the next linux-next.

And I suggest that converting it all into a single 14-patch series
would be more straightforward.

Thanks.
