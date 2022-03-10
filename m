Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4154D3FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 04:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiCJDmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 22:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCJDmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:42:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F86711AA3F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 19:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F16E617B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 03:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD9AC340EB;
        Thu, 10 Mar 2022 03:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646883698;
        bh=gwF7pZkYKExYPd9bVhRSpaTZ64GgtDxB1S1EJENW6fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tiggf+1iCylzDx/4ncudboha0rFtXilfFMqPpPUFlT6PfvmDUehVKcjqtRwGC9SCd
         u6cMRe4PzPpFElmb5gjcLf8BTIGwAQduTebrlwiSnnSaJp+DNKjbCBvlJ36us2330e
         raR3YyoV6VT6zPQEwGaeiu8fn/FhK3S0riazklKM=
Date:   Wed, 9 Mar 2022 19:41:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v6 3/6] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig
 option
Message-Id: <20220309194137.0b3607f6c3dcbc606cfc0833@linux-foundation.org>
In-Reply-To: <20220308140942.47dcb97c@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
        <20220107133814.32655-4-ddiss@suse.de>
        <20220308140942.47dcb97c@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Mar 2022 14:09:42 +0100 David Disseldorp <ddiss@suse.de> wrote:

> @Andrew: while looking through lkml archives from a lifetime ago at
> https://lkml.org/lkml/2008/8/16/59 , it appears that your preference at
> the time was to drop the scattered INITRAMFS_PRESERVE_MTIME ifdefs prior
> to merge.

That was but moments ago.

> I'd much appreciate your thoughts on the reintroduction of the option
> based on the microbenchmark results below.

Thanks, I'll take a look after -rc1.  Which gives reviewers much time
to do their thing!

