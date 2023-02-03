Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F09689980
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 14:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjBCNNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBCNNa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:13:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27404ABFE;
        Fri,  3 Feb 2023 05:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u4NyDrKdcPWGycGNrQyezKZBDnGdKvTZkI+TqU0X1ac=; b=ck6+jalhkqeu7gRjvR0e8xaeJ8
        oXfWK7Nh5fXeRq10RS/iZpZIBhK+9ptMxA3fjZgWgpNqwN5exBSr/o2vXHYd6bnE4+B29YVn/zXRh
        ZWGGZcC9vqr7/hwcqOPvbURUqak8Z2e0txrJuSt6p+SxoAH5j99LEULSl6bB/l23ni3/u92zMO1TI
        L8RZhDwnQuLoMhhEz06SO5iL6Vmya4ccO4YhA6huKmqaHjAb7DSbUMy6fMpA3u36dznGllslmPvuN
        CdzUcP88qAoWib56bb7I9CCWTxtqKYpgbQkELrOTMEm93O0SBbqy12RhsLPT/dkPfCAWeJU4XJ1rY
        rThvcaDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNvsZ-00EKPM-Uj; Fri, 03 Feb 2023 13:13:23 +0000
Date:   Fri, 3 Feb 2023 13:13:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH 6/5] generic: test ftruncate zeroes bytes after EOF
Message-ID: <Y90Ic0F/c32Eay/q@casper.infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
 <20230202204428.3267832-7-willy@infradead.org>
 <ae8067b4-37ef-a1ea-5cec-ee8e55c101fb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8067b4-37ef-a1ea-5cec-ee8e55c101fb@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:57:11AM +0000, Johannes Thumshirn wrote:
> On 02.02.23 21:45, Matthew Wilcox (Oracle) wrote:
> > +	fprintf(stderr, "Truncation did not zero new bytes:\n");
> > +	for (i = 0; i < 5; i++)
> > +		fprintf(stderr, "%#x ", buf[i]);
> > +	fputc('\n', stderr);
> >
> 
> [...]
> 
> > +
> > +$here/src/truncate-zero $test_file > $seqres.full 2>&1 ||
> > +	_fail "truncate zero failed!"
> > +
> Is '_fail' really needed here? truncate-zero will spit out an error message
> in case the truncation doesn't work.

I don't know what I'm doing.  I totally cargo-culted 706 to make 707.
If someone wants to completely rewrite it, go ahead!
