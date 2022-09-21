Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D465E542B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIUUHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiIUUHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:07:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362EA3D3F;
        Wed, 21 Sep 2022 13:07:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CECD2735;
        Wed, 21 Sep 2022 20:07:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CECD2735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663790851; bh=4+6lLfNCXT495Y/8Kd50pp68aEH52Y+mpgUuGAhbZbs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tBWPjq8gDizNGC+FQz5gR2OZ8SPy85+3KuW7lt8zPLkyWF9q39cBIFdshsbsR++cM
         7TBgNGA4e5+8YLlcpCyhv+vhG3Scfgk+JTee8QABjHsHxprQs3ZxItvTGCtrRon5iZ
         AfoQVHL1nuzlDJzE5HhQUnODQg7QVcMhZzebZJafuZ4bD4dUbk5kyCL+T0mo8f1PIC
         iJNd2CHh6Ulln/fZK3A062hAuFveWqeUf8BMpcH9iAgpQuTshzWa5CDdv+oJogLhcS
         4fl03NUBJaZRtZ1qY1asrzTFKG2cfH17lTahtj1tCD37zQwnc5SniMdGQ+45m55hDv
         KOCEcbVFMk1Sw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] Documentation: filesystems: correct possessive "its"
In-Reply-To: <20220901002828.25102-1-rdunlap@infradead.org>
References: <20220901002828.25102-1-rdunlap@infradead.org>
Date:   Wed, 21 Sep 2022 14:07:30 -0600
Message-ID: <87leqcv6d9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Change occurrences of "it's" that are possessive to "its"
> so that they don't read as "it is".
>
> For f2fs.rst, reword one description for better clarity.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-xfs@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> ---
> v2: Reword the compress_log_size description.
>     Rebase (the xfs file changed).
>     Add Reviewed-by: tags.
>
> Thanks for Al and Ted for suggesting rewording the f2fs.rst description.
>
>  Documentation/filesystems/f2fs.rst                       |    5 ++---
>  Documentation/filesystems/idmappings.rst                 |    2 +-
>  Documentation/filesystems/qnx6.rst                       |    2 +-
>  Documentation/filesystems/xfs-delayed-logging-design.rst |    6 +++---
>  4 files changed, 7 insertions(+), 8 deletions(-)

Applied, thanks.  Sorry for the delay ... conferences ...

jon
