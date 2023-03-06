Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DFF6ABCAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 11:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCFKaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 05:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCFK3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:29:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3603A8F;
        Mon,  6 Mar 2023 02:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FDA360DE2;
        Mon,  6 Mar 2023 10:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BB0C433D2;
        Mon,  6 Mar 2023 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678098524;
        bh=V3Ct/I6AfSwu8m0jBEoSVpf39U2qfhfmGppj2qXjkpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE2Q9190W5FjCxPSxOZv6OzDmWdMWXUFs4SLKs6gz3vQz5exkQtXZNoCdleh7seoq
         MEpvSHyvp0NP7osX43r9T+wKrJ5bJTdUD0tovlV/nPPGHzsJrvjnnDmResIzepbJ0J
         8v4FRay7l5K93oz3/SoawxzHRJwThysTG/i3VMy/BIQez25nSJDyWmyutNaS9DTFsp
         SQZFgw1+NrXKgwmyjpWWXPnNV6jcQjnuuGk5Wh3PBSwtyJJUMSaEVDbxCmE8lH2WPM
         peVmTw//d0ZMrw2VuOfZUFGSIg+OS6TNyK/fCNTMBcGdxcwQ2voY8fRz7uBN6myvYw
         1QVv3iNBXrIpQ==
Date:   Mon, 6 Mar 2023 11:28:36 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 12/28] fs: Fix description of vfs_tmpfile()
Message-ID: <20230306102836.xmfl2qryl6sp3xuz@wittgenstein>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-13-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303181842.1087717-13-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:18:26PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Update the description of vfs_tmpfile() to match the current parameters of
> that function.
> 
> Fixes: 9751b338656f ("vfs: move open right after ->tmpfile()")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Trivially correct. But this shouldn't need to be a part of this series
afaict. Please send a this separately to fsdevel so we can pick it up
right now,

Acked-by: Christian Brauner <brauner@kernel.org>
