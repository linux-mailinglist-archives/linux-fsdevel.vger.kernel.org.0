Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5576C79C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjHBH4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjHBHzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790C3C10
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 00:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F21D61866
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4F1C433C8;
        Wed,  2 Aug 2023 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690962789;
        bh=mFkMaX+qLjN1IBitzjNqptbPbhZ4Y2a94FIDOPY7US8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgAtO6b2CWfto9dKnpy8ulGeQgjt6D7pDmEVuFKTS+6dF19OsUqUZ+0lniHzlbQg5
         n2M/mJandwMXl5oy9P+IS5Mfjfaw55Zy4ISwqnhnqVzIqRif9i8MDVVjFJYxvAL/qG
         DtfScWdWxvsZ6L+z1z4Vsrfy9fTpDlTh1JPl3j8Pfr5ovrOBT/JKt22i1ibuOO6uFE
         YG0VQFivgtxrugnf/Eviu1AxwAFOA3TZDt4MX0HSIuqgybciWVVy/wUEHPI9FwGAFk
         nZVopDsijYtXhPkl7r0J6HnlktEEkj8FeH57Hd8LqaH13m7KhdiLkK2orjGghl1TMY
         j+WFYcsZM8VFw==
Date:   Wed, 2 Aug 2023 09:53:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     cem@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        mcgrof@kernel.org
Subject: Re: [PATCH 4/7] shmem: prepare shmem quota infrastructure
Message-ID: <20230802-mehrsprachig-abwarten-028d0994ba94@brauner>
References: <20230725144510.253763-1-cem@kernel.org>
 <20230725144510.253763-5-cem@kernel.org>
 <20230801213753.oopnuscdfoctdrnh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801213753.oopnuscdfoctdrnh@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:37:53PM +0200, Jan Kara wrote:
> On Tue 25-07-23 16:45:07, cem@kernel.org wrote:
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > Add new shmem quota format, its quota_format_ops together with
> > dquot_operations
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Updated in vfs.tmpfs on vfs.git.

commit d76060bf7074ab433720903a60bdfc72c8901651
Author:     Carlos Maiolino <cem@kernel.org>
AuthorDate: Tue Jul 25 16:45:07 2023 +0200

    shmem: prepare shmem quota infrastructure

    Add new shmem quota format, its quota_format_ops together with
    dquot_operations

    Signed-off-by: Lukas Czerner <lczerner@redhat.com>
    Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Message-Id: <20230725144510.253763-5-cem@kernel.org>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

