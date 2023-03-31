Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12C6D1997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCaIQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 04:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCaIQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:16:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD688D322;
        Fri, 31 Mar 2023 01:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52FE6B82CDF;
        Fri, 31 Mar 2023 08:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86617C433EF;
        Fri, 31 Mar 2023 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680250587;
        bh=PYmLM1bxoyFg+1lJKD4C5xnYYLaPTUsZdePvriHRkgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaMfo1OsCPFpTL8Mbm7l6/a6MfvE/SDSFYkgJvV06UzSV0apXE3wLINDfsGmJpuME
         YZuD3Nhrhi66/lig1KIg/7Y0VZHS49GYmNoZbrYW+5BEh+ZFn6lz/D7U/uRWZYJhfu
         zcZd7gR882IcuaUHdtYfstGa8FkLm1xvsQ2Ua/X6un7PU+MwM0fQnGcbhOSg0MVGVJ
         Jh8GDr3OQsn1PdSTzlEIYwZwdxluvTzSVYQZLFlWcySDkNtoy1ZBYifS66RJ9P2gN/
         WpMjgrmOwpm4rdXiC70xYyXh3Un5pxyDpnTb2NyW9JQ+wyMiugmcqHgUUnjUM3NS7Y
         vFph0vmwigP5w==
Date:   Fri, 31 Mar 2023 10:16:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
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
Subject: Re: [PATCH] fs: consolidate duplicate dt_type helpers
Message-ID: <20230331-floss-occultist-0335eb57e847@brauner>
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

Greg, Christoph, if you have a minute could you please take a look
again and re-add your acks?
