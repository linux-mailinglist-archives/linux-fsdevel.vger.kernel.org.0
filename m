Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C660A550434
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 13:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiFRLSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiFRLSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 07:18:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F422B26
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F+BJSLJn1l6BiMryIoFBUWaSvj/TpqkFRhEHk+nrdlo=; b=UaQ7hgrZSyHY674kpWIUZ4DB82
        fCM3v0peXs0sRhhA4Mwbd5l/B21S76VsVBS7GqcQLL/6iMGQvePZhRwz7LNxC8H8TDkjD+yKWhzhj
        21EGwCqawIK6Jlae38DFyZH2L31zE6qKw1o1AZT33eDj5OUJLdVefjj7KI/2CvDGn+kdC6O5RBbyT
        2skvCpgiIHE6D30Rr1NjAu0+Fn9HntqPdCewEwcKGWb0neJhOdl/5pmXkDF3CYWf0aCMFAscuw6Q/
        gxj8vg6FCsvpdY9agw3Qrt530/0SQdhD4HXc4ZR0Yg0eR5GLuuWIJyOPUcI/8rO7NOI/+MYxN/GuN
        63P/fwxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2WTN-001aoh-Pm;
        Sat, 18 Jun 2022 11:18:37 +0000
Date:   Sat, 18 Jun 2022 12:18:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 19/31] iov_iter: massage calling conventions for
 first_{iovec,bvec}_segment()
Message-ID: <Yq20jVaW+rR+4xSI@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-20-viro@zeniv.linux.org.uk>
 <Yq2zVpWI252Mryg5@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq2zVpWI252Mryg5@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 12:13:26PM +0100, Al Viro wrote:
> [with braino fixed]

	FWIW, a branch with this reordering damage fixed had been
force-pushed to the same place.  Since the knock-on effects are
only in 4 commits out of 31, reposting the entire series would be
excessive, IMO.
