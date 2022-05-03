Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BFF517BA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 03:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiECBZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 21:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiECBZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 21:25:03 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45233BC0;
        Mon,  2 May 2022 18:21:33 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DA7F06214; Mon,  2 May 2022 21:21:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DA7F06214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651540892;
        bh=PFJHZl/JMNbRaHYYffsJYT0FnozlQ9Nnkp874Pqt0as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2qBzJgei+hJI4LXNcJRtNP1It/O1gWQZIMDHCoKUkRHvA6TYLP+UzDUdSjvBgK9E
         h470KH4UvIyR2RtpNz5HyRt58XQNd3AW3We5anX15KHSBOoU3r9eB7VtMsfNXQtP+p
         aJTorO+JHd8dq0YCdrT2OLs6lEqMkP7lEQ1FdrpQ=
Date:   Mon, 2 May 2022 21:21:32 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v25 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220503012132.GL30550@fieldses.org>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
 <20220503011252.GK30550@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503011252.GK30550@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 09:12:52PM -0400, J. Bruce Fields wrote:
> Looks good to me.

And the only new test failures are due to the new DELAYs on OPEN.
Somebody'll need to fix up pynfs.  (I'm not volunteering for now.)

--b.
