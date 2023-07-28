Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D467766B97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjG1LVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 07:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1LVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431911BD5;
        Fri, 28 Jul 2023 04:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC362620F0;
        Fri, 28 Jul 2023 11:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63039C433C7;
        Fri, 28 Jul 2023 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690543295;
        bh=LSlC0Q9PHeWLMycbSGiyKu9Jet3YZB91XdJa3QEkOCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f65PDg5jIYm9aKIG3PUffcMnydDw1hkOhCi9pL7FWfDJUWCBbv4sKKufnj4XEqc1i
         gvRxcCsJF5Ov/J67+Zl3c7dbBF9Uf2lc9cBw7YBW/+J+B/ZauWrz/vIj32b8a5X4Xc
         VUpbCFKId+nISkTIujWp4UOIgLL15Q04/t/cl4XcBOiaewPZvkCrFoDwJyY4c5REEh
         t787Io7Ji13BwOLfatLk3+SCSBpUZeUPN1qKaVOZ8ggNN+c+RkiJ6bPUajKLnezCZ5
         nfdbH0bjodjBhRzAVJ6H3VFMB38JOT4s+9mUuvZvJhkt6IQFW1erVf1ZfFyWWJXsXf
         xMxuSJaIJIL4A==
Date:   Fri, 28 Jul 2023 13:21:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>, ebiggers@kernel.org
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230728-darben-zuarbeiten-f2f6b16fc001@brauner>
References: <20230727172843.20542-1-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727172843.20542-1-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:28:36PM -0400, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> This is the v4 of the negative dentry support on case-insensitive
> directories.  It doesn't have any functional changes from v1. It applies
> Eric's comments to bring the flags check closet together, improve the

I'd like to please have Acks/RVBs from at least Eric for this since he's
been diligently reviewing this.
