Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EF37AA251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjIUVPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjIUVPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D65AD196;
        Thu, 21 Sep 2023 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJC++WD0SC98QqOfTgTMoqC7V5g4Fi6TJ28HDArhxHI=; b=g1wOKXuddKHSozH+mqGV7jLWcQ
        v6y6qb70UgITOIa9uHUC+ALF/c/Ie5E02Jdg2PM+/KPhifEZaox2ZU+qvOo7C82fC7ZOoem2OlTF+
        a2gTB7oGGBzcKZg1dJrxMHKX4sKcV9XhJ+tTGx4fiBnrC9k6sErNt94pluDhrwkpfi7fMLznf789G
        RgX9hV0Nr+mNnn5ezqDzpX1SrQI2pa0BoSMTyZvBidgSxtSXfI6bQYi4/3rFWbOax+1Hk0rD39Ccu
        geqYCvZM6j36HoZXuJC2RUYm2PES0f7LqUPfm28KJ9HufAdlm/Ujrp5bA4N2NL7rYtH04zO785+91
        h3cD8TNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qjDz0-005MVd-1M;
        Thu, 21 Sep 2023 07:20:18 +0000
Date:   Thu, 21 Sep 2023 00:20:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Pankaj Raghav <kernel@pankajraghav.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com, riteshh@linux.ibm.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQvussaZsqZNSc3d@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
 <ZQewKIfRYcApEYXt@bombadil.infradead.org>
 <CGME20230918050749eucas1p13c219481b4b08c1d58e90ea70ff7b9c8@eucas1p1.samsung.com>
 <ZQfbHloBUpDh+zCg@dread.disaster.area>
 <806df723-78cf-c7eb-66a6-1442c02126b3@samsung.com>
 <ZQuxvAd2lxWppyqO@bombadil.infradead.org>
 <ZQvNVAfZMjE3hgmN@bombadil.infradead.org>
 <ZQvczBjY4vTLJFBp@dread.disaster.area>
 <ZQvuNaYIukAnlEDM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQvuNaYIukAnlEDM@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:18:13AM -0700, Luis Chamberlain wrote:
> When we first started this work we simply thought it was impossible.

*not possible*

  Luis
