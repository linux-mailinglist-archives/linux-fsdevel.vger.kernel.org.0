Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947286D1CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjCaJn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCaJnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6CDEB61;
        Fri, 31 Mar 2023 02:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C20626BB;
        Fri, 31 Mar 2023 09:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E97C4339B;
        Fri, 31 Mar 2023 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255743;
        bh=y87xyZCMd1W1yjQaxVv+iKe9SRDUeqhLoz5FppjxSlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5hDTbJ+gBS/Ug4zSYOmCSs5dPqePtZKLDcHOT17nlVNdfwPutORilUzz/38cNlyQ
         KsZa9xdZfux+JiaFmm/KXvESqGZsFIFmbFzRs3QvlsCouUA+jWOV6M8rksSD254PqH
         WGXqZmPGorQScZdi0hfej+zkOO5LILTPfFQZk3DY=
Date:   Fri, 31 Mar 2023 11:42:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: consolidate duplicate dt_type helpers
Message-ID: <ZCaq_LKzU7RKm4PL@kroah.com>
References: <20230330104144.75547-1-jlayton@kernel.org>
 <20230331-floss-occultist-0335eb57e847@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331-floss-occultist-0335eb57e847@brauner>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:16:20AM +0200, Christian Brauner wrote:
> On Thu, Mar 30, 2023 at 06:41:43AM -0400, Jeff Layton wrote:
> > There are three copies of the same dt_type helper sprinkled around the
> > tree. Convert them to use the common fs_umode_to_dtype function instead,
> > which has the added advantage of properly returning DT_UNKNOWN when
> > given a mode that contains an unrecognized type.
> > 
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Phillip Potter <phil@philpotter.co.uk>
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> 
> Greg, Christoph, if you have a minute could you please take a look
> again and re-add your acks?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
