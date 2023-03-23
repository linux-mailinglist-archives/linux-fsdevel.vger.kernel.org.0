Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A16C6B44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCWOkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCWOkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:40:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC54E062
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:40:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEdpYe013894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679582393; bh=7azV9DBDgQBiJKia4YDLFtE+brQJDyiEHzkKR+zggZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=C1rcV08pIURUpZuCG31evHvrrmFZ0e/hKAgfKKHzRyqWYdrjeS8psJc7VXmM83Ww3
         H+qn70JDFZ5LE/MgvbBQIcvN5frghysghTu5KegOU0Su2l1TG21SF0ALzXK8WbY8AY
         MikMCbM2Y1XJsiPTzYqJuzceXZFyvPyQgJAgeFcy/Yi1rQBUWoEwhgBgJ2h6BXe+lZ
         lTUAaLXwEIZCFnXzT5udcoWRFQplckWtHHv1RpyfmznjS5vnhsifY9ndKHrWlPtXfo
         Ht0Q0EXjvbNo7ziCYIjBSW8DOZZE5qusUU59xCZOOCudUwucxg/e7wEFLJ2ycJ18h+
         ucyhGIXNXCYCQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC71515C4279; Thu, 23 Mar 2023 10:39:51 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:39:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 6/7] ext4: Enable negative dentries on case-insensitive
 lookup
Message-ID: <20230323143951.GH136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-7-krisman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:46:02PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of invalidating negative dentries during case-insensitive
> lookups, mark them as such and let them be added to the dcache.
> d_ci_revalidate is able to properly filter them out if necessary based
> on the dentry casefold flag.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
