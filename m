Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D839076659E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjG1HpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjG1HpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19FB6;
        Fri, 28 Jul 2023 00:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50F956202F;
        Fri, 28 Jul 2023 07:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3DBC433C7;
        Fri, 28 Jul 2023 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690530310;
        bh=nLljaAEO7Ry7mUuAOrxQY3HFOUMvAf5rTdMrMu9ZgWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLNU76rfd4+NtkOReb2y1UM2W+NV1srTOumrSK5jLOsHRqyIYAP/H7WXcTeLC6nvx
         3ed1wQP2044cO5klybmLtL6iIzytXmuTLIlbooAiJkdeZsIdiMaGlAyCeYToiddjaF
         alePvLa3D3XBiRrquDqzmDhoI31efc5GyuW0Wi7RkrNgJMbMBM/irW3Zhwaqx0wEWG
         nOcUToZZijhNZVLFbsdHhVO9Wtvm7RI87PR3DlMLpQ/6terZqM/mdL287AVIRUFc13
         MYoCSUSq+53tVSdGtGZ3Y2A1JOqAPtm/KIlWYcse5yxDT0JIIRCxVvobnh7JyDJlBw
         UZVdv/RuJL2AA==
Date:   Fri, 28 Jul 2023 09:45:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230728-ersetzbar-implantat-9143619b982f@brauner>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727181339.GH30264@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727181339.GH30264@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> since it has vfs, ext4, and f2fs changes (and the bulk of the changes
> are in the vfs), perhaps it should go through the vfs tree?

I've just waited for Eric to finish his review. I'll take a look later
and will get it into -next for long soaking.
