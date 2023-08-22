Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199E783C6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjHVJD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjHVJDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797EA189;
        Tue, 22 Aug 2023 02:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 118E064FD4;
        Tue, 22 Aug 2023 09:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A653C433C8;
        Tue, 22 Aug 2023 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692695033;
        bh=XF2DHR9cVBAjSC1JYb0fBkqyDH+OwSrCPzK85eiLk4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfdzWNmx7Pg14qw902O4jsKZSBGRSmY/oKhOsFl8kTXzpD2dCG8aXEbO1/rE0ZaUO
         wkW7gHFOm0WqiUo80a3ffW8SXw2P3egg7B7HcuAGDxZTTfm9845WmToKjixMnRLGEU
         Kk3NVMfawizSITwLrCOT5zbjUbzVmVxG5XCkmg2SWd4KKKkWRZ4DDuezw0nEzvhfqu
         WZ0FixzI7Vdg6Mquo9lRimD3cN7Z7g/l8zN1SIRV4QYkP1eG7sQ98sX8aKe+oDo31H
         oSGAmprKHxWr2VyfmrB6w2j6qsTT62Vbld4kOY5YF/Qf1m4ie8cd9h11L1YFx472gU
         KrTHjD60ohIxQ==
Date:   Tue, 22 Aug 2023 11:03:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230822-denkmal-operette-f16d8bd815fc@brauner>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230817170658.GD1483@sol.localdomain>
 <20230821-derart-serienweise-3506611e576d@brauner>
 <871qfwns61.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qfwns61.fsf@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Targeting 6.7 is fine by me. will you pick it up through the vfs tree? I
> prefer it goes through there since it mostly touches vfs.

Yes, I think that's what will end up happening.
