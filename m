Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2519178C9AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjH2Q3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 12:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbjH2Q3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B613AA6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 09:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDCD62DDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 16:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F99C433C9;
        Tue, 29 Aug 2023 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693326561;
        bh=aFNQOl9GThSiOFu9gLnEl5BlMX0sBoJ6rgKopXn7lC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ttx5461w/1DMZJSsPKH6b00TxuVY0uygT66P0+fis2PBMy7jtuFryPUaaGM3Ld1tC
         3sv6iGnin/rTIRByoGXWhZKyT/AKL8GK0hO6L5N2+jI7+tqOCC+Rg8LGD0g0yTmB2g
         c5QzBom7hrmkQP1TzhQJxKyGBDt9mDzrWOz6xbRHbn0h3dUUgzoUNTSP5tDlicEAk7
         RLL8IpZQFi0ES46OyCpPq9jlLqyDDWuEa1xrOjCmJ/CXdtlGcIHkEZiFstx2cKOtWD
         vlk1MYsa/6BSBqxcDXZUw2gMvUU1E9IPwPrmObv9qkO5xLkl1JJwUlY0ZdYun1/u8H
         TEp0IaU9Jqa7g==
Date:   Tue, 29 Aug 2023 18:29:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230829-alpinsport-abwerben-4c19ebb9a437@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
 <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	return sget_fc(fc, super_s_dev_set, super_s_dev_test);

return sget_fc(fc, super_s_dev_test, super_s_dev_set);

Sorry, dumb typo that I had already fixed in tree...
