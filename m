Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18F6B7927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCMNix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMNiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:38:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40278113C1;
        Mon, 13 Mar 2023 06:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5EB612BF;
        Mon, 13 Mar 2023 13:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A329C4339B;
        Mon, 13 Mar 2023 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678714710;
        bh=VCcPwSPz5EuP/QtrFpxE9pJUqeNC8f0YH754H6N66S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDq/pxiKjGNdz/oa9R50TTPP9OD1zjBQ+3Z63QHpGBXKNYujgkCrjgnMOxMwHp9ju
         2xPNVGmYShgnz76eDNLvGjhc1OOr0kSbK7fpW+XQQ1gnank2epFSHaZkEWu5ijHK5A
         y3bQxTauHvrZowgnOmT7QsxBk/c5GoVhCTM8TAp5+VkVeGu72hXPApZtSOTmXkmOwj
         GxZj+DsxigDp/o2TRg3Zg6E6VjnbAT+6t3HGILpe6dncJk9u6gOHPWDarDx0fA+yCZ
         hIDIMNHpgEqYy8Xlr2atqY0mc3sVadPUoMo4nTVDbq1uoA+67mJH8m6wLY/+VibdSp
         BRgr6G7CFGkow==
Date:   Mon, 13 Mar 2023 14:38:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     corbet@lwn.net, Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] docs: filesystems: vfs: actualize struct
 file_system_type description
Message-ID: <20230313133824.xkwa5q6pntgqd3s4@wittgenstein>
References: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
 <20230313130718.253708-2-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230313130718.253708-2-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:07:17PM +0100, Alexander Mikhalitsyn wrote:
> Added descriptions for:
> - fscontext API ('init_fs_context' method, 'parameters' field)
> - 'fs_supers' field
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
