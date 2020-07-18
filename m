Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B261224846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 05:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGRDTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGRDTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 23:19:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9AC0619D3;
        Fri, 17 Jul 2020 20:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eseByOVopawDlzbukKjPjMvILQnceFwEXai26ExVQbI=; b=ZBb361Mtu7rgcZXJXLo4rvwsGb
        hdaE2U8YNgq8j7pyZT3KUntcxpxa99oJhxsJ0MZxVYu+2BBf9d6kAMrxlqjdJVXjLHGEX6UQsEe/q
        6u8/5QkSpr5wwhoO9CEkjC5EQOGk8LS7KFCQGRHjnUocZhw4ybKDMugApPMo+5TeSExPbdseBnqsL
        rvc1vX6DdofePkUSYXB2PMtAZrrzP2o031Q9WtAXUDMMAkIwA7s9p/IFXYYCAgHFOVXITLNgPH3S4
        4sflxNtkKEa1+Y0sAl8NNhj9EXbryZnE2BtWm988z3eeSq44pxJDftNXaMODviH11yMiQ2R3Y6RWM
        oeFrvXMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwdNh-00064x-7I; Sat, 18 Jul 2020 03:19:21 +0000
Date:   Sat, 18 Jul 2020 04:19:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] locking: fcntl.h: drop duplicated word in a comment
Message-ID: <20200718031921.GU12769@casper.infradead.org>
References: <13c2a925-8522-64e2-4d30-97395901e296@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c2a925-8522-64e2-4d30-97395901e296@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:54:13PM -0700, Randy Dunlap wrote:
> +++ linux-next-20200714/include/uapi/asm-generic/fcntl.h
> @@ -143,7 +143,7 @@
>   * record  locks, but are "owned" by the open file description, not the
>   * process. This means that they are inherited across fork() like BSD (flock)
>   * locks, and they are only released automatically when the last reference to
> - * the the open file against which they were acquired is put.
> + * the open file against which they were acquired is put.

This is the kind of sentence up with which I shall not put!

How about "This means that they are inherited across fork() like BSD
  (flock) locks, and they are automatically released when the last
  reference is released for the file they were acquired against.

Even that is a bit too convoluted for my tastes.  Better suggestions
welcome.
