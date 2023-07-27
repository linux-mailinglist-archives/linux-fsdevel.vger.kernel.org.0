Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95138765C3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjG0Tla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjG0Tl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:41:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C52D6A
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:41:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-115-64.bstnma.fios.verizon.net [173.48.115.64])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36RJf3O0011710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 15:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690486865; bh=tz9uDfs6x3woAC8m0CkGKUI4YE1GEN19wLcnCAZOmDw=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=It93TSp9L8wmstJLNCNTuAY5F9XA33MfVDdDuin7qGEU7Z1pdbkb7Wi8DTEerb91b
         5RUCBvW6KEGb1NP56fho0ANmvHGN/2GLSHW7LdnapAg1oA8TTlGolMOswnkL6AQFUd
         vRBVD7JvntP5y/H1d0dh+uF5UW+E7Khk3ghokHmnOkADEU6ecU3YAu/uWO0tCMMcKs
         BVBZRsaJIri2VAjngUhGkhDqxZD8V9tnlLVu3LL/ZFd/MI+wiedOYssjhcnhbFWISf
         9npS4Oy8x1mcuf8CLcc779ImSxiGWu4oMHFSO/2FPHFDk1BftxWejYODL+x2fWnQSu
         4Y1X77ku0GlVg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5951E15C04EF; Thu, 27 Jul 2023 15:41:03 -0400 (EDT)
Date:   Thu, 27 Jul 2023 15:41:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, ebiggers@kernel.org,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230727194103.GJ30264@mit.edu>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727181339.GH30264@mit.edu>
 <87cz0d2o78.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz0d2o78.fsf@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:39:55PM -0400, Gabriel Krisman Bertazi wrote:
> > Also, Christian, I notice one of the five VFS patches in the series
> > has your Reviewed-by tag, but not the others?  Is that because you
> > haven't had a chance to make a final determination on those patches,
> > or you have outstanding comments still to be addressed?
> 
> I'm not sure if I missed Christian's tag in a previous iteration. I
> looked through my archive and didn't find it. Unless I'm mistaken, I
> don't think I have any r-b from him here yet.

Ah, right.  I looked back and I'm not sure why I thought he had signed
off one of them; I must have hallucinated it....

							- Ted
