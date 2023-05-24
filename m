Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8195C70F54C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjEXLbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 07:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEXLbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 07:31:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF1135;
        Wed, 24 May 2023 04:31:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A06FA222BF;
        Wed, 24 May 2023 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684927897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhtheA/Gzw9ZBNNVZW5R7hvu64pufOsIiq+9Wxeew6w=;
        b=yaEmWV91uf9kFNZVSdwCR4ztkwEzW569EA78TK2s1YpmSCk2G/OcFo4QTL+cl4r99DaM9D
        GUUAJMXFpG52ncpystMX4EUZixq4KVqQcHdQ9tH9PUPiiJtoSV5nQL9hHWhyZgBVeOXnVF
        3C8piEzc8ZspkJSibAR5EWqKQmzCmhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684927897;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhtheA/Gzw9ZBNNVZW5R7hvu64pufOsIiq+9Wxeew6w=;
        b=IWt0IOG3fSUbfiZwva2e35cH8bCx65a6TP4dEfu5vqXHyWpU94jKn5TXlqBtiPMBWZ6Wqo
        bHlt31ywkP0EXEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 818D7133E6;
        Wed, 24 May 2023 11:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nmgMHpn1bWQDRwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 24 May 2023 11:31:37 +0000
Date:   Wed, 24 May 2023 13:32:47 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
        Jeff Layton <jlayton@kernel.org>, Petr Vorel <pvorel@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: LTP: syscalls: statx06.c:138: TFAIL: Modified time > after_time
Message-ID: <ZG3130X0GO9eNJfc@yuki>
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
 <dca09245-5b59-438b-b7d6-c65db7a84a85@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca09245-5b59-438b-b7d6-c65db7a84a85@app.fastmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> > [ 1192.088987] loop0: detected capacity change from 0 to 614400
> > tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
> > extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> > dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> > mode: none.
> > tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> >
> > statx06.c:140: TPASS: Birth time Passed
> > statx06.c:138: TFAIL: Modified time > after_time
> > statx06.c:140: TPASS: Access time Passed
> > statx06.c:140: TPASS: Change time Passed
> 
> I found a description in
> 
> https://lwn.net/ml/linux-kernel/20230503142037.153531-1-jlayton@kernel.org/
> 
> which indicates that this is expected. Added Jeff to Cc in case
> I'm misreading his explanation.

We even have in-flight patch from Jeff to fix the test with fine-grained
timestamps in LTP:

http://patchwork.ozlabs.org/project/ltp/patch/20230518113216.126233-1-jlayton@kernel.org/

-- 
Cyril Hrubis
chrubis@suse.cz
