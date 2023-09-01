Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95AE78FE10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbjIANIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 09:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjIANIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F3910CA;
        Fri,  1 Sep 2023 06:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76F3A6196F;
        Fri,  1 Sep 2023 13:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E79C433C7;
        Fri,  1 Sep 2023 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693573717;
        bh=Sk1iDEqO9atzJ8M5YkkBefYugsMqR/P/gCmddG+fYLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6XnDLJL7vz7bm2YDKXveFc1n+Z0WKMf7qtp3o7bUHsNlcChJ2TVO0nyDGFSLWQqw
         DOReG+YCI6jZ90i82CeW9yjdncCkPliGf06L9x/C7EsjvreKxc5N/nXDTjCxX1UE2P
         m2rPt+ueju6/t0eeIDTZcpyUmP8ssPj/1F1o+x+MzBinzH49bjpBwevvmt2gggugTF
         Ev5TjYl2TLvMUNUvkdt2dlAZWlllKSIhqduOETbXQC/z+zBLUvoBydss0o9IFTEwjC
         3tuqfyt/nmqhlYQrwUa/5PaWMDpoPLZBO11u0SaiLYNJ8i0RoPsN0R1uMI+Job/c5A
         Xa2EgNtSzy8Kg==
Date:   Fri, 1 Sep 2023 15:08:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.6] super fixes
Message-ID: <20230901-thank-you-7902fd09539c@brauner>
References: <20230831-innung-pumpwerk-dd12f922783b@brauner>
 <169352176330.24475.9732725297267621963.pr-tracker-bot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169352176330.24475.9732725297267621963.pr-tracker-bot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks to both of you for helping with reviewing and fixing the
immediate remaining issues. Much appreciated.
