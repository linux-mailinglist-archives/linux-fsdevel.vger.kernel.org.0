Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFA6B8ECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 10:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCNJdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCNJdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:33:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F93592;
        Tue, 14 Mar 2023 02:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0381B8169E;
        Tue, 14 Mar 2023 09:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E167FC433D2;
        Tue, 14 Mar 2023 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678786395;
        bh=ZjAmxn/q8YEGQ5kQv/HWcJZxtkfbRE+Jk/VwPgYAWZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfARFqFB7lQkBRsm4T+pGf+e1KqkLkEgAE5qPmidlzkIVOhEBlaZ8XOQeaxBJD0xw
         CLJIRFO4FEAM/iExWPXJQo63ugHm5UWgxa3qYuZnCLzYYFxMKw1SlGh236AY9sUbOC
         2Uircig5+GUtMWpvySjfguuIDKK8odI06avtp5BPZrDScx8arS3Qu8OL/jDEDvFAW9
         49x67kwvo+6sxXwa+2YA03QPkdt8dfUGbcmfKlKCIO+d6ntT9zmmxK4k/yW3tWO3hZ
         b+1HPviua+Rygf6cOCiLV0eDXSuCSMWbxqy2Z3yXMwsxSQrxDtSvFwEUQcVmIwVp6c
         gXJhmyuUcUosA==
Date:   Tue, 14 Mar 2023 10:33:05 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fs/proc: corrections and update
Message-ID: <20230314093305.t6pfm6hvpa4odm3c@wittgenstein>
References: <20230314060347.605-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230314060347.605-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:03:47PM -0700, Randy Dunlap wrote:
> Update URL for the latest online version of this document.
> Correct "files" to "fields" in a few places.
> Update /proc/scsi, /proc/stat, and /proc/fs/ext4 information.
> Drop /usr/src/ from the location of the kernel source tree.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
