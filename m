Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140B748ABAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 11:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349350AbiAKKsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 05:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:48:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66655C06173F;
        Tue, 11 Jan 2022 02:48:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E0B0B81867;
        Tue, 11 Jan 2022 10:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1172C36AE9;
        Tue, 11 Jan 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641898093;
        bh=qRdQhOfheZ8aNeW75Ewd8jAySRFu7huUWfxw9iD6v1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXG1zoVZubSqcjM+FEWZ7sWGE6AwmKDaUMyaZJW0IqUDgeeiMH8ASbE9kUhxYFN9L
         o1q9sTanuqsN9A72zGT0gDgZ0DLq8iAENseXKZ8903m9rSZd6t+Z/HT74dPazzesOO
         O5ee2AsRfNfIPLJeyiiFe0a+lWhc8TQqSvDLVpuGkIVXORsqUeTvGA9oKQ8V0/50Ck
         mOUtd0tI2QYL1oxaK15LwxOBmUMLKIsJGRfWxGMR8ehNJP52zcwqGTOA3LWvVqWdW2
         JXCphCh7Jad8fStAGu4+V/jvfepr9y6HTzh1tlPg5m7+diSW6OrHmJcFMoOCoj+iD3
         OhgGWxG2BahMA==
Date:   Tue, 11 Jan 2022 11:48:08 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        richard.sharpe@primarydata.com, linux-nfs@vger.kernel.org,
        lance.shelton@hammerspace.com, trond.myklebust@hammerspace.com,
        Anna.Schumaker@netapp.com, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <20220111104808.zqqcixjmml2o2rbs@wittgenstein>
References: <20220111074309.GA12918@kili>
 <Yd1ETmx/HCigOrzl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd1ETmx/HCigOrzl@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:48:14AM -0800, Christoph Hellwig wrote:
> On Tue, Jan 11, 2022 at 10:43:09AM +0300, Dan Carpenter wrote:
> > Hello Richard Sharpe,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch bc66f6805766: "NFS: Support statx_get and statx_set ioctls" 
> > from Dec 27, 2021, leads to the following Smatch complaint:
> 
> Yikes, how did that crap get merged?  Why the f**k does a remote file
> system need to duplicate stat?  This kind of stuff needs a proper
> discussion on linux-fsdevel.
> 
> And btw, the commit message is utter nonsense.

That's not in mainline though, right? At least I don't see it there
looking for this commit. 
