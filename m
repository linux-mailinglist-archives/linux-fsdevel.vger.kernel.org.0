Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73629399A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393470AbgJTLGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393449AbgJTLGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:06:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F03C061755;
        Tue, 20 Oct 2020 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y8tm4EXpO/+dnvlvRNR45vf5nYEzmrYDbgkTOvPsrbg=; b=CJhxfcOTCLGmRVnDt3CM/VeBpE
        icKiLykiLwVt9cy2SBi1P+AUxSPXWsQpPwMvQ9EW21WFreJmHJQwK+I1f6gekdAmf2XqEe68z3EBr
        7i98Z1JQUydG4dFsHKWfDkgj0pwudkV+CaDUoQj2dyRBEer1U99LLqiwT5Y2hZTKCHgRmRyxUxSK1
        aed6cw/sMv06l2zLKeFSndUZfQl21qyU8T0R4Tpgw8v4XxzCj5asw4FSOnNN05DCB3f0oBkU2BThj
        1o7Za8wz5kd1iuyvVABiskZXH1y7vtt5R+cR+YeVOf4RMZ3O/hCRG4M8058KwJZ4hLE4o1kW8HTan
        PxiaNatg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUpTU-0000S2-DB; Tue, 20 Oct 2020 11:06:41 +0000
Date:   Tue, 20 Oct 2020 12:06:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Takashi Iwai <tiwai@suse.de>, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH] cachefiles: Drop superfluous readpages aops NULL check
Message-ID: <20201020110640.GY20115@casper.infradead.org>
References: <160311941493.2265023.9116264838885193100.stgit@warthog.procyon.org.uk>
 <20201020075307.GA17780@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020075307.GA17780@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 08:53:07AM +0100, Christoph Hellwig wrote:
> Hmm,
> 
> what prevents us from killing of the last ->readpages instance?
> Leaving half-finished API conversions in the tree usually doesn't end
> well..

Dave's working on it.  Git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

(we've been collaborating and some of the prerequisites have trickled
into Linus' tree this merge window, eg the readahead changes)
