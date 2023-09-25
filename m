Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B87AD841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjIYMuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIYMuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:50:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834B92;
        Mon, 25 Sep 2023 05:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23089C433C8;
        Mon, 25 Sep 2023 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646208;
        bh=r1SYmSUarBUenaxk9oPJzkQomDGhy3tq1zUDGZ5RiQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrY6AbrY6tHSTn+Ap+2KvYjqSOfa+rVOWJ7hUlM0daPx8AkRSFKScuSuLIDEWCdRJ
         /b4ETXxXoo7H5MazjEVis+niNT24IjaYPFPezHyTSjBf0v2G/DqcUlsvkQ2TR+nhs4
         KxK3RCqLFq2RDxuEYfiPRpONKA/dYs+iKqun6u/zo+kKCHWd+cfkE6whluzvd/aDSx
         ueRsnfwjQJso1WM+wXZfJpIGpjDRIbruBHL1LogXc+Gk47Iys+s9M+kAIQJw8D8VKG
         LcWb/ROdbL5nV30XPoiTT0CiN2sxVWkNSNrP3w2MtkIynE9StT2PLv0GEMW4C91m59
         rFw9TLloQsmSA==
Date:   Mon, 25 Sep 2023 14:50:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Glauber Costa <glommer@openvz.org>
Subject: Re: [PATCH] docs: admin-guide: sysctl: fix details of struct
 dentry_stat_t
Message-ID: <20230925-beordern-garant-16db0ea033c5@brauner>
References: <20230923195144.26043-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923195144.26043-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 12:51:44PM -0700, Randy Dunlap wrote:
> Commit c8c0c239d5ab moved struct dentry_stat_t to fs/dcache.c but
> did not update its location in Documentation, so update that now.
> Also change each struct member from int to long as done in
> commit 3942c07ccf98.
> 
> Fixes: c8c0c239d5ab ("fs: move dcache sysctls to its own file")
> Fixes: 3942c07ccf98 ("fs: bump inode and dentry counters to long")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Glauber Costa <glommer@openvz.org>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
