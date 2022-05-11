Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A652362A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiEKOuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245083AbiEKOuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 10:50:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FD1A04D;
        Wed, 11 May 2022 07:50:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BEobXT027771
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652280639; bh=cFpcX2Ojol0CTzs27Jy21ktxvo2sL7WCKPeBqeZ5USc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jb1qSj/b+LydIGq6ppRX0WFU30AF/3BYpnwsFLBwtKasHUX2V09/W9jVlfPfhf4Nn
         h7qVY6qd5wAqxgzaOsDbbxdc13J5cwpdyuDe2JXKcP30xgaFrcvJb9K66DcRnF0ecl
         baF4oTG8QZN6kkbyuDpAOOs3Rcpet0/tDExOSwz1sT/CIesdtzAcwqc191hUn0frBl
         7R5fnvchISGaULtLNtyN/LHtrv5VQhPSwa7L4gPhmr5wHtKDTQlRQvkNTJ446lK4MD
         8DchZfVrAu14az95XGFVHDBTGMAdQJhIbiMjz6zI8zTcvEHWGqOa5kNjbx3hTjbGUW
         0wruCxNCQauoA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EC43D15C3F0C; Wed, 11 May 2022 10:50:36 -0400 (EDT)
Date:   Wed, 11 May 2022 10:50:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs/super: Add a flag to mark super block defunc
Message-ID: <YnvNPPbzzY08Ly7y@mit.edu>
References: <20220511013057.245827-1-dlunev@chromium.org>
 <20220511113050.1.Ifc059f4eca1cce3e2cc79818467c94f65e3d8dde@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511113050.1.Ifc059f4eca1cce3e2cc79818467c94f65e3d8dde@changeid>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 11:30:56AM +1000, Daniil Lunev wrote:
> File system can mark a block "defunc" in order to prevent matching
> against it in a new mount.

Spelling nit: s/defunc/defunct/

I would suggest changing s_defunc to s_defunct in the patch below, to
ease in readability.

Cheers,

					- Ted
