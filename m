Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDFD79BCD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjIKUzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244139AbjIKTLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:11:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DFCE0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 12:11:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A275121863;
        Mon, 11 Sep 2023 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694459466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jd1GXArbDlH//JD9QgDmADD7DMHkLitKJX8xJ6rAvJg=;
        b=W2cv0Xz9qzM7XTQweMGsyPuzuUGv6tsBtxRA1eHgrynyRUI1CdLxJ5zlQP7nbt3I6psUAD
        Pv0vLeipRPIc7jLcU7Xd6tu3ncPGFuWN3ug+cRfqdyz0TAuu3ckG4qrWS3lB20qWPX7fnB
        nPwjJWixepZ1RfIGBfTgwzLMG8f89/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694459466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jd1GXArbDlH//JD9QgDmADD7DMHkLitKJX8xJ6rAvJg=;
        b=kIDhiR96Wc2/sKwMM361W4cDDn46R/qoZ6di4YLALJX4rjz0S5i39D5bgiT3eVjrXzLr+5
        VKrNmS9udY5Oo1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B68139CC;
        Mon, 11 Sep 2023 19:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lnDgEkpm/2R1UwAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 11 Sep 2023 19:11:06 +0000
Date:   Mon, 11 Sep 2023 21:11:05 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>,
        Octavian Purdila <tavi.purdila@gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230911211105.1050fb2c@echidna.fritz.box>
In-Reply-To: <3c66d844-67e5-82d2-6d14-9f6c6b6fcc36@acm.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <ZPe0bSW10Gj7rvAW@dread.disaster.area>
        <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
        <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
        <20230909224230.3hm4rqln33qspmma@moria.home.lan>
        <ZP5nxdbazqirMKAA@dread.disaster.area>
        <20230911012914.xoeowcbruxxonw7u@moria.home.lan>
        <ZP52S8jPsNt0IvQE@dread.disaster.area>
        <20230911153515.2a256856@echidna.fritz.box>
        <3c66d844-67e5-82d2-6d14-9f6c6b6fcc36@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Sep 2023 10:45:31 -0700, Bart Van Assche wrote:

> On 9/11/23 06:35, David Disseldorp wrote:
> > The LKL block layer may also become useful for legacy storage support in
> > future, e.g. SCSI protocol obsolescence.  
> 
> There are probably more Linux devices using SCSI than NVMe. There are 
> several billion Android phones in use. Modern Android phones use UFS 
> storage. UFS is based on SCSI. There are already UFS devices available 
> that support more than 300K IOPS and there are plans for improving 
> performance further. Moving the SCSI stack to user space would have a
> very significant negative performance impact on Android devices.

I could imagine cases where support for SBC <= X and SPC <= Y is
deprecated or removed. SG_IO would probably be more applicable for
legacy device support in user-space, but I think it still serves as a
reasonable example for how LKL could also be useful.

Cheers, David
