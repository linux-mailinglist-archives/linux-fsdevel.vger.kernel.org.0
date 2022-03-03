Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05A4CB791
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 08:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiCCHWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 02:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiCCHWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:22:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310D16BF93;
        Wed,  2 Mar 2022 23:21:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A82BC219A5;
        Thu,  3 Mar 2022 07:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646292079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Yn37jBmhNQT0GOqCf3MZhOo4RpHFo+76NUeWAGWVSw=;
        b=fmXfV0qbVk2pQ7ca3cwDAQFfcpjYhP37A0O8TzJhrXTWkeDE8MQNOAsHNV0lPynQLWxzwC
        qGmWkd/IRxjiXn/q2HOfaaa3C8JyT6JW/U+//R1+lkWZyemvj1aHVRT1DUWMsxPYwJEE8v
        GLdesmWR6zHdEkOdTZLBXEacd36qbJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646292079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Yn37jBmhNQT0GOqCf3MZhOo4RpHFo+76NUeWAGWVSw=;
        b=o9mCnmC3xJ6vEQ4AJrnk34gnVXRufjNSkixUEprtdvMeTKsXTuxAeTdAHc1+dc8r7rF2yM
        om+GwCUJWdAAemDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43E4813AB4;
        Thu,  3 Mar 2022 07:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gY3iD29sIGLhMwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 03 Mar 2022 07:21:19 +0000
Message-ID: <3f54a0f2-03ae-2d12-8ebb-b6b8a61cc8a9@suse.de>
Date:   Thu, 3 Mar 2022 08:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/22 01:56, Luis Chamberlain wrote:
> Thinking proactively about LSFMM, regarding just Zone storage..
> 
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of
> having folks in the room we can likely settle on things faster which
> otherwise would take years.
> 
> I'll throw at least one topic out:
> 
>    * Raw access for zone append for microbenchmarks:
>    	- are we really happy with the status quo?
> 	- if not what outlets do we have?
> 
> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.
> 
Yeah, count me in.
But we need Matias to be present; otherwise we'll just grope in the dark :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
