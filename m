Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377806D6F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjDDVrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 17:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjDDVra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3610D2;
        Tue,  4 Apr 2023 14:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B082863A4A;
        Tue,  4 Apr 2023 21:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A358EC433D2;
        Tue,  4 Apr 2023 21:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680644848;
        bh=/W2l6FEblcPBW3a3/IFotwqzUPzNhBW9UW0Zd0bfWms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DSeplztvtpJqsg9f5uaYJlK/NnWyyAnh/SEV2H/IQK6vqQDyo4T0Qd1lI0BgG3OMJ
         JUHA7gXk+j2U+gRcqXBV2F76wMkbAicPjqRGXMoEU5qU6Q38/4SZDl9eA8xcQVruDn
         4GnQVn1dbKsDNYhFTF5GD+CQ+JoP49SVOotqemrg=
Date:   Tue, 4 Apr 2023 14:47:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Zi Yan <zi.yan@sent.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Message-Id: <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
In-Reply-To: <20230403201839.4097845-1-zi.yan@sent.com>
References: <20230403201839.4097845-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  3 Apr 2023 16:18:32 -0400 Zi Yan <zi.yan@sent.com> wrote:

> File folio supports any order and people would like to support flexible orders
> for anonymous folio[1] too. Currently, split_huge_page() only splits a huge
> page to order-0 pages, but splitting to orders higher than 0 is also useful.
> This patchset adds support for splitting a huge page to any lower order pages
> and uses it during file folio truncate operations.

This series (and its v1 & v2) don't appear to have much in the way of
detailed review.  As it's at v3 and has been fairly stable I'll queue
it up for some testing now, but I do ask that some reviewers go through
it please.

