Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742B85BF873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiIUIAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIUIAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:00:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F463FA2D
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 01:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75CACB82E67
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CD9C433C1;
        Wed, 21 Sep 2022 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663747203;
        bh=uIVwQaLD9977YNPOcwiV9afaIfKnFQga/DCZRYWPsak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6AV/VnE5EUNvtKxdues5zWwLOSgAJ0o+TcqiuC4Cd26Jl9qa1c7OWzWxa3I9IUsC
         oVogZlKtxuI87Nzm8nw4SlNUkuWoVIzhzBwgaAJ0prtm1UhecLm7YcGFOj/EBA71+L
         +GjaMVdgHGO5Kq4tpde6W0C25+Uh10bytthMZJ1MhH79yA9rTVxCCFQrgs7DfMsXN4
         HT5rjsYFDdMhLjIIlaf1myPm+zc+tir5htOQ7AFAisbcOL6VnYJ/Vl3ygmNKfO/4mR
         IR7qvNzEC3nqw+r0BpOfVo7XYPP4r2q8J8j8dVmCkETMnqSL49NO9rBWt5UgtL8z5C
         vnjNBfSysE1vA==
Date:   Wed, 21 Sep 2022 09:59:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 2/9] hugetlbfs: cleanup mknod and tmpfile
Message-ID: <20220921075958.hgdljdwzirmjtild@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-3-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-3-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:25PM +0200, Miklos Szeredi wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Duplicate the few lines that are shared between hugetlbfs_mknod() and
> hugetlbfs_tmpfile().
> 
> This is a prerequisite for sanely changing the signature of ->tmpfile().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
