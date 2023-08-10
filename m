Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01942776F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 07:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHJFPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 01:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJFPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F382C1B4;
        Wed,  9 Aug 2023 22:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B89860A5A;
        Thu, 10 Aug 2023 05:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DBFC433C8;
        Thu, 10 Aug 2023 05:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691644522;
        bh=XGFJ/Gtq79WsTu6ReOtX86Z5xSjbbqr3fINMsVl3i0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mp9wtWreQCmQTWlA75pU6++YInwy6632DvrAtyp+86X7k+Q9wGPLt1o7XVtQlWUe2
         IK5F+D/4r2l/HWeK7/5mzUzYz47UIPgKUP7h1Jjd84PEbdHpdhlg2sG7vgUGHsS3BD
         FfXLL7j4pvCoFNmSY6SiJTxbOLw1+Lgk1ijur2jOA2LjcEf+QiAOzZfstT/1+D+v+v
         yvwBKjQwXZVF/A6Tnq29PqXBqqn3RH3RwXBbvM/0nZoVIpNQR6kfFFcCADG38QY2AS
         kISCOpplGMmDiTKo4haz2DnTlw4NmYjNHO9g/1clW16lP45o2LjdxR9PIp9esdkUW2
         yyUppAndkVFdA==
Date:   Wed, 9 Aug 2023 22:15:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Zhiyu <zhiyuzhang999@gmail.com>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: A Discussion Request about a maybe-false-positive of UBSAN: OOB
 Write in do_journal_end in Kernel 6.5-rc3(with POC)
Message-ID: <20230810051521.GC923@sol.localdomain>
References: <CALf2hKvsXPbRoqEYL8LEBZOFFoZd-puf6VEiLd60+oYy2TaxLg@mail.gmail.com>
 <20230809153207.zokdmoco4lwa5s6b@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809153207.zokdmoco4lwa5s6b@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:32:07PM +0200, Jan Kara wrote:
> Improving kernel security is certainly a worthy goal but I have two notes.
> Firstly, reiserfs is a deprecated filesystem and it will be removed from
> the kernel in a not so distant future. So it is not very useful to fuzz it
> because there are practically no users anymore and no developer is
> interested in fixing those bugs even if you find some. Secondly, please do
> a better job of reading the code and checking whether your theory is
> actually valid before filing a CVE (CVE-2023-4205). That's just adding
> pointless job for everyone... Thanks!

FYI I filled out https://cveform.mitre.org/ to request revocation of this CVE.

- Eric
