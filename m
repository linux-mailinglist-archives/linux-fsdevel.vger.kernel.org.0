Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3E5EBCB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 10:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiI0IFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiI0IFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:05:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AF11E721;
        Tue, 27 Sep 2022 01:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD51FB81A0F;
        Tue, 27 Sep 2022 07:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E188FC433D6;
        Tue, 27 Sep 2022 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664265556;
        bh=xKiJOTKLznhaitvhYKqM3K2U2nS497pmNonv8xVj/Cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lA2BnX484NXhhV/DHCXHC+R6fwpXR8UuroWiL+kACU4CjDuqIM8EmNgWcohFaLXcm
         t7k4yl+FoJNhAFGhIqqq8YFpD4YFXwucTGsUURe+lw6rAGS7u6OVjAyc4jtZNU7SzW
         EKwYNIjlBCVqXAZnYPGvBlRQXEGVTXtG2R00KWbJFy8DcFpUx6oNopfqrFloZ9AL8F
         ivmles9Ko1gySiGvSFjzsk44dMAm3uPdsHVP86qQnL3IGs6yGu2Y+FR1R4dZep7JFk
         TOuvGFHVe7Z1a1dB2VJ81sItLXDTKZIufx5X8k8CktVJoDrJPMCVdmG5h7E0gMHH+k
         u6REW6do5QU2w==
Date:   Tue, 27 Sep 2022 09:59:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 00/30] acl: add vfs posix acl api
Message-ID: <20220927075910.remwae5cz6w2dgob@wittgenstein>
References: <20220926140827.142806-1-brauner@kernel.org>
 <99173046-ab2e-14de-7252-50cac1f05d27@schaufler-ca.com>
 <20220927074101.GA17464@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927074101.GA17464@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 09:41:01AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 05:22:45PM -0700, Casey Schaufler wrote:
> > I suggest that you might focus on the acl/evm interface rather than the entire
> > LSM interface. Unless there's a serious plan to make ima/evm into a proper LSM
> > I don't see how the breadth of this patch set is appropriate.
> 
> Umm. The problem is the historically the Linux xattr interface was
> intended for unstructured data, while some of it is very much structured
> and requires interpretation by the VFS and associated entities.  So
> splitting these out and add proper interface is absolutely the right
> thing to do and long overdue (also for other thing like capabilities).
> It might make things a little more verbose for LSM, but it fixes a very
> real problem.

Agreed.
