Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7F6B34E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCJDkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCJDko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:40:44 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D3A9DC2;
        Thu,  9 Mar 2023 19:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JZiF53bxmc/MLuNb1YEKJk9gkzndAVyIO5xNpj+Nmhs=; b=FuuWjo1upLo/wHs2NXXbRXxAOJ
        leA9cTuNBYkLUNif5UdWqotdSAjJHiV2zbCw94ADvsd4R9lo1tuVdJjgnerWCMKwr4U5u6hlrZpLZ
        ZiRV0mPTzJSBiezPPyPLwtefWvQRa8L+YKpu72SS2E9j22zb93zXRD+LhN7Ke7mMOY6BpIY4gw1mF
        B8kzc8nJDW7NN+BHplzekS3tybKFZ7F+eTW1Hgvz5L6VyMjgdRVm6i/zWzkpqTmSbUOkwTA/nqw4D
        S1X/M7JXuAgyTOy1A5bD2Dmx4cyqgdRgCcuxzyfzOV3wf5mHd1PP/ghyINJ69koiH51llJYOZULpM
        zIQlKS7w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTc8-00FCfv-0T;
        Fri, 10 Mar 2023 03:40:16 +0000
Date:   Fri, 10 Mar 2023 03:40:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fs/locks: Remove redundant assignment to cmd
Message-ID: <20230310034016.GH3390869@ZenIV>
References: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
 <167835349787.767856.6018396733410513369.b4-ty@kernel.org>
 <fd7e0f354da923ebb0cbe2c41188708e4d6c992a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7e0f354da923ebb0cbe2c41188708e4d6c992a.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:50:15AM -0500, Jeff Layton wrote:
> On Thu, 2023-03-09 at 10:25 +0100, Christian Brauner wrote:
> > From: Christian Brauner (Microsoft) <brauner@kernel.org>
> > 
> > 
> > On Wed, 08 Mar 2023 15:13:16 +0800, Jiapeng Chong wrote:
> > > Variable 'cmd' set but not used.
> > > 
> > > fs/locks.c:2428:3: warning: Value stored to 'cmd' is never read.
> > > 
> > > 
> > 
> > Seems unused for quite a while. I've picked this up since there's a few other
> > trivial fixes I have pending. But I'm happy to drop this if you prefer this
> > goes via the lock tree, Jeff.
> > 
> > [1/1] fs/locks: Remove redundant assignment to cmd
> >       commit: dc592190a5543c559010e09e8130a1af3f9068d3
> 
> Thanks Christian,
> 
> I had already picked it into the locks-next branch (though I didn't get
> a chance to reply and mention that), but I'll drop it and plan to let
> you carry it.

IMO that's better off in locks tree; unless Christian is planning some
work in the area this cycle (I definitely do not), it's better to have
it in the branch in your git - we can always pull a branch from it if
needed and it's less likely to cause conflicts that way.
