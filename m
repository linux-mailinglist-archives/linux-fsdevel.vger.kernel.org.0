Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5992E6C6B19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCWOd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCWOdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:33:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AD269F
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:33:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEXYCp010405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679582016; bh=WS3FA5IPygO1Ck5mQ+QTJf1mkRjXBenZoIXY/rh5uAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DjzVGLEijlnDAru3dwaNpS7M5xs/XCf36tb5u7BX3g8Rlrr6PfZvPExugaCgF5Bwg
         ymGsb7WyAUa4y9GLbC0PQHh4/eqUVMCs595PR9AUfYbq5w4kyGZMxIETTCkz2nSvYg
         2xHWkIpkW4I3SpSmNR+c3HCs43ew1iALw63NjLuz9xgzlUUq0wpmWAp5GjO7+8zzVd
         YKneBxewl/o6UlzM7MieSOy/wAGeTRjINKvGdDXfHcFDhyftFF/qynk3DI9WM0Pc4L
         /+OGNiGePJv+kgGFill5UzCe08UAKgreIQghlrF5KjuAn45hn6vIIQHiITh0bN7Img
         T1BK8yf4TmDZw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BE7A115C4279; Thu, 23 Mar 2023 10:33:34 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:33:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 2/7] fs: Add DCACHE_CASEFOLD_LOOKUP flag
Message-ID: <20230323143334.GD136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-3-krisman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:45:58PM -0400, Gabriel Krisman Bertazi wrote:
> This flag marks a negative or positive dentry as being created after a
> case-insensitive lookup operation.  It is useful to differentiate
> dentries this way to detect whether the negative dentry can be trusted
> during a case-insensitive lookup.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
