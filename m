Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC05A47DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2LCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 07:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH2LB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:01:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362FF2AE27
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 04:01:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E521533681;
        Mon, 29 Aug 2022 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661770917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fsmgzwppApG9A2+nqAE7kmdxpmT6sjSOqHNkvPX2u8=;
        b=0ChE76ktzr4rq5otKmPAvtjeuivsU/W9qxY2Y+2lQajCfurRMaOtBQ0WiLlFZyCousbf2M
        ciBZxtRiLcMISNr55/52LB43r0Opbf/MUiy7mK1UQZG9LGRkaDYueobz0/PIGmuYTcKETO
        eFS/p7mQPQTKYws+C+Aym2v7rfiICGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661770917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fsmgzwppApG9A2+nqAE7kmdxpmT6sjSOqHNkvPX2u8=;
        b=mX+/KKYHWt0vrsJThuOEs8YQubF40r9UZTR3wCQ45Gwj6ZGt7urwiTXJ2SgF0bCUxeR9Fp
        b6TbQzOQrgU12oCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4B631352A;
        Mon, 29 Aug 2022 11:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKcPKaWcDGOsDwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 29 Aug 2022 11:01:57 +0000
Date:   Mon, 29 Aug 2022 13:03:56 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Automated-testing] [PATCH 4/6] tst_device: Use getopts
Message-ID: <YwydHBRWBX2NlqMR@yuki>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827002815.19116-5-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> size and filesystems are passed by -s and -f flags.
> That will help to pass used filesystem.

This part should be in the next commit description.

> When it, add also -h.

"When at it, ..."


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
