Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE925891EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiHCR5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiHCR5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:57:14 -0400
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 10:57:12 PDT
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD965A16B;
        Wed,  3 Aug 2022 10:57:11 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id D4A4B7FD17;
        Wed,  3 Aug 2022 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1659549012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MA+gnPofh7m0h90TueToyzo3t+yzml63JRNV5q5y+mM=;
        b=H8pbMXoR4BHlmgxonNr793NznJqZ9uF2fbyp4ntsh0kwo/o82AcslpT6B9H2AbXRXmPs5P
        TG+PG3ohHvY+M1ZIWTOTJ4yFSDVgfiQLJ4M3iDmlOIPxjJrxkxFP1uR4/qPb5vbYOOdFG2
        IMba8Ecuw1yIW4+GtisxxRPoTxdqgZvLqNlkl6K48rNPkPrF4MuC2T+kS2WILNKkPW0IfJ
        Lv7xgBOUBm3DRAsMeDs2PvCDCWfhyxxdjLdIxPFYeuEDGAnsPN4qVsmgm/kOyodA9DQiZW
        fkznHdHsqsrAbxXVOoYvgkyY/aAxhLOItY6Nyhde6silCD1nzBTlotJZv/fhSQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Enzo Matsumiya <ematsumiya@suse.de>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tom@talpey.com, samba-technical@lists.samba.org,
        pshilovsky@samba.org
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
In-Reply-To: <20220803144519.rn6ybbroedgmuaie@cyberdelia>
References: <20220801190933.27197-1-ematsumiya@suse.de>
 <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
 <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
 <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
 <20220803144519.rn6ybbroedgmuaie@cyberdelia>
Date:   Wed, 03 Aug 2022 14:50:17 -0300
Message-ID: <87fsidnrmu.fsf@cjr.nz>
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

Enzo Matsumiya <ematsumiya@suse.de> writes:

> A note on backports: I myself (and Paulo) do the backports for our SLE
> products, sometimes down to SLE11-SP4 (based on kernel 3.0) and I
> could not see what other issues could appear given if we backport this
> rename to released products.
>
> Of course, I don't know every process for every distro vendors, so if
> someone could provide feedback on this, I'd appreciate.
>
> @Paulo I'd like to hear your opinion on possible issues of future backports,
> if we backported this rename patch to SLES.

We all know that backports aren't usually easy to deal with --
especially when doing them on very old kernels.  So, if we're gonna make
them even more difficult, there must be a good reason like a new feature
or bugfix.  This rename simply doesn't justify all the trouble, IMO.

Besides, for any future fixes marked for stable after this rename, it's
gonna be tricky as well.  Of course, we can definitely handle them but
not worth the trouble, too.

Just to be clear, this is a NAK from me.
