Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F3F6D0506
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjC3Ml1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC3Ml0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:41:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3376A6;
        Thu, 30 Mar 2023 05:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 926BEB828B7;
        Thu, 30 Mar 2023 12:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECADC433EF;
        Thu, 30 Mar 2023 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680180082;
        bh=H2CWthzCkNL5YlH7+JHisFXzsRbNGrgUtcahqrtI+Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn5drJVUC4auIWA58yPEiD6skHL4n/IIbN1Any560WJu21hwunt7Pe+Hjbsj7DnOy
         da4P6noaFjdmALwI7XORtevgAKw3G0vBrFvQs7npDl99H9kG8Ur9Umu6uEisE431RZ
         s+/5fg8+hyGipnypjo7WEAA4g0tiTo9p5O0iScMklpKRzrDKq3pTsgLVsi1RuUqarp
         UjtPJq3XjKQe7Y71uUY7OFIDeCXbXfmnV6qNuqz9vjQc79FWdBcNstL9IYT9PN+kG7
         48xRhKdrtiKvJDyXo/VLL3ejj/fp3LleT/AyOnrjmoQ7MNKK6LU/klIYXM50YcUA/2
         nv+FmNSAxgTAQ==
Date:   Thu, 30 Mar 2023 14:41:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: consolidate duplicate dt_type helpers
Message-ID: <20230330-overeager-balcony-36975926d0a0@brauner>
References: <20230330104144.75547-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330104144.75547-1-jlayton@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:41:43AM -0400, Jeff Layton wrote:
> There are three copies of the same dt_type helper sprinkled around the
> tree. Convert them to use the common fs_umode_to_dtype function instead,
> which has the added advantage of properly returning DT_UNKNOWN when
> given a mode that contains an unrecognized type.
> 
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
