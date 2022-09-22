Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16EE5E6701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiIVPZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiIVPZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:25:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A57C30C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 345B6B8384C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52302C433D6;
        Thu, 22 Sep 2022 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663860297;
        bh=CpHuRv5/pq/QxJVRelY/C6tHwUOwjLU7D5LVz/O8gf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaGHcByXwzuMWlUjeL6ZPAg8l+zjfbRxjn78GrGkYOngxvN/rvLHGx1jClcGFMrrd
         /iv5IH8+R0psQC0D9JwLGUkpLEbYrkpptPwTKgxhKcAduj5roAKPQVsIUvujyl0Up7
         bjUOs1rcWjkCgnWUVyTN/0RjL9+CITu+RKiP/DmzhMBPDRUMk94m2ERyf5Y/s2ffre
         ZwMg2898fzHulqM0hfDNKdBycBbQZ32/rF4H6tPIvffYKk/7cplTOP15LKnamXkf6p
         RYzsciK5Acy0xqRdzZIMSIf74qghYxTa45ZvdGb0Eod2kyeap8y+mMnBDB1p0rOUk3
         /ISPRKpxYwIQg==
Date:   Thu, 22 Sep 2022 17:24:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 04/10] cachefiles: only pass inode to
 *mark_inode_inuse() helpers
Message-ID: <20220922152452.zqmei373ia6l5zky@wittgenstein>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
 <20220922084442.2401223-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922084442.2401223-5-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:44:36AM +0200, Miklos Szeredi wrote:
> The only reason to pass dentry was because of a pr_notice() text.  Move
> that to the two callers where it makes sense and add a WARN_ON() to the
> third.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
