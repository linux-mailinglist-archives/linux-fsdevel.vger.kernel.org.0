Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA45B4855
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 21:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIJTsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIJTsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:48:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538627B3D;
        Sat, 10 Sep 2022 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gf3iMQ+MIqgx3+mJysjCBke8D/E+r5JbUH6683x5+Og=; b=j6Iq4VK9au7hbkSuQKBGdDG9GP
        mwAGx/98LQc7paRsL14lJtePAQ6KABmyGEiCoqpgJSj2UbqQxSTMRrQ5/Taiug3UjN4Oc/5CfoX58
        sN7/z/u2sbh1TbDVON/fsTWzC0NSpnpSWPxv18dHXrUjI0Z0zc+9RuIkgErQjwhFBHEHxF7LpN2Zd
        GYbt9za+SxMF6DJXFWMYVDkY4hXexaztbWaQuLMKeJmDQZlnthkZ0Pm4O1zb2IoZbzipYbmpee0MF
        MgZ+XhfrOFTa+OgKZMEtnZ0iNfbAxXLFUg1vjLVO1eP2OSYy/kjJEVwjO0UsIHYbKGHhei/dZagQB
        M9E8wObQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oX6RN-00EPHP-Rk;
        Sat, 10 Sep 2022 19:46:57 +0000
Date:   Sat, 10 Sep 2022 20:46:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <Yxzpsdn4S6mTToct@ZenIV>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
 <20220907125211.GB17729@fieldses.org>
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
 <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
 <166259764365.30452.5588074352157110414@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166259764365.30452.5588074352157110414@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:40:43AM +1000, NeilBrown wrote:

> We do hold i_rwsem today.  I'm working on changing that.  Preserving
> atomic directory changeinfo will be a challenge.  The only mechanism I
> can think if is to pass a "u64*" to all the directory modification ops,
> and they fill in the version number at the point where it is incremented
> (inode_maybe_inc_iversion_return()).  The (nfsd) caller assumes that
> "before" was one less than "after".  If you don't want to internally
> require single increments, then you would need to pass a 'u64 [2]' to
> get two iversions back.

Are you serious?  What kind of boilerplate would that inflict on the
filesystems not, er, opting in for that... scalability improvement
experiment?
