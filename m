Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E66C6B41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjCWOjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCWOjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:39:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA732F761
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:39:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEdIe5013698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679582360; bh=8/XjPODeu0U61LLY1URpwJZq2KMUV1l5jOCz8NiMPdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ep1ZQ3GezGLfxjhBlLVfubph32pGgPm4APh3vEDMfPUjyviIgN0CDMkorz3X8p8a4
         PRR5/QYpLJNF6E3egsTSavfQxkCWXrMoerQMTfGbse+5Tw4olHwVG82LELtw2HMaPu
         DXeEeDcsfQwGtKnJBooJWemH6YGX+ur7Yj6t3PMdwfbrPUTEA8AJENb46JNJAMuCPY
         3j/t7FTGcaAHGMH1LsLqMaokonhhO2+Jgu9hVmWeAYuY/AjOUVQuNHsQmT40FZPnVC
         oyxAd3VCISLLH/kb3wTWfVxrrAs3m4FwkLyawaubJPbUO7M3d/jyjO/epS0fGOIhsm
         Itx+LwmcH58Vg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7A75115C4279; Thu, 23 Mar 2023 10:39:18 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:39:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 5/7] libfs: Merge encrypted_ci_dentry_ops and
 ci_dentry_ops
Message-ID: <20230323143918.GG136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-6-krisman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:46:01PM -0400, Gabriel Krisman Bertazi wrote:
> Now that casefold needs d_revalidate and calls fscrypt_d_revalidate
> itself, generic_encrypt_ci_dentry_ops and generic_ci_dentry_ops are now
> equivalent.  Merge them together and simplify the setup code.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
