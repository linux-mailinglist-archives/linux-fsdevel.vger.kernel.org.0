Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0C6CFA99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 07:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjC3FOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 01:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC3FON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738459C7;
        Wed, 29 Mar 2023 22:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733E061EF2;
        Thu, 30 Mar 2023 05:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043CC433D2;
        Thu, 30 Mar 2023 05:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680153251;
        bh=+AO+4TXm7+ntP+/nBfZasS7S5uDHsYLHj2Buok4wimI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEqPWrDQSJEi40VeqmkuuofD6jN9KR8CLr9nlFFNuskQ3TMEKJtccZoFnjVNUrgGs
         Uoc1irsgIgiFg/rCw/vwaZwnlSl8wxVJpMZK58Qug7+OLNWk39mPw3lHRJPrZJ04i8
         VFa3Xonr1LXyqgAblXElHVZg3sGHHS9GeCAZv+7p92yeijOrX8fPaH+zM7yiKdQkMP
         xBDq9tc857WWJKIy6dCL6y0llUETY7Ri2DKVmtmAEZ+P5Cho+KWsatvXFfKCBVLWIo
         XmxjkNznPYyTUOmnnmW9f5OocpWomZew6/nW/2wt0fyXrNw/1Khp+Y81hQePjMHcAr
         x2ZzHHWiXTYCg==
Date:   Thu, 30 Mar 2023 07:14:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Joel Becker <jlbec@evilplan.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: consolidate dt_type() helper definitions
Message-ID: <20230330-quickly-slinky-06d441dbb61b@brauner>
References: <20230330000157.297698-1-jlayton@kernel.org>
 <20230330000340.GA2189@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330000340.GA2189@lst.de>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:03:40AM +0200, Christoph Hellwig wrote:
> > -					 v9fs_qid2ino(&st.qid), dt_type(&st));
> > +					 v9fs_qid2ino(&st.qid), v9fs_dt_type(&st));
> 
> This adds an overly long line.  Also renaming the v9fs dt_type seems
> like it should be a prep patch.
> 
> > +/* Relationship between i_mode and the DT_xxx types */
> 
> This comment seems a bit terse.

Agreed. Would be nice if we could just do proper kernel doc. Even for
static inline functions it can't hurt.
