Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7380E6AF62A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 20:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjCGT4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjCGTzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:55:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4AC3B3E3;
        Tue,  7 Mar 2023 11:47:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D7F4B81A12;
        Tue,  7 Mar 2023 19:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29617C433D2;
        Tue,  7 Mar 2023 19:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678218477;
        bh=/1zAIbTQcsRF2izXv8x+EJJixmh8dm5+NhK5ibW2Rsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyyYAwqUTTOk9EKiTutS5g25pM/VHwE2Yo3m82FjZAEXqu/CleA62t3i3SG/UTcG8
         cfH4mySgtTAl/FkN3gD0CJ7euNCSl9MX75AxDRKpva3vVaLJWbvyQOasMf1XPhtEse
         iBPu1h6EuVXY5lSdO/v6rwRJyxtn75T589Un0p3nRcpQZTj4bzppHMLBRDyhPnoXuz
         bHLOcMt+mmUsAQeljRkMmtZP9ekqGRdabMDAkS8V22Sb9MTBleK1hrduVVF14vWP/W
         aM3Nzol2A4VsZbRWcmcKEm4dvZ7lbDMj/phDraV03qLey3PXcapCMK6yTL8Mqeg2US
         bLMU3ZOVlo9ww==
Date:   Tue, 7 Mar 2023 11:47:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        tytso@mit.edu, guoren@kernel.org, j.granados@samsung.com,
        zhangpeng362@huawei.com, tangmeng@uniontech.com,
        willy@infradead.org, nixiaoming@huawei.com, sujiaxun@uniontech.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] fs-verity: simplify sysctls with register_sysctl()
Message-ID: <ZAeU6shP3vjBOqo7@sol.localdomain>
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302202826.776286-10-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:28:24PM -0800, Luis Chamberlain wrote:
> register_sysctl_paths() is only needed if your child (directories) have
> entries but this does not so just use register_sysctl() so to do away
> with the path specification.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/verity/signature.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next  

- Eric
