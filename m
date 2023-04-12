Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DC6DF728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLN2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLN2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:28:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C186AD;
        Wed, 12 Apr 2023 06:28:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A140F1F890;
        Wed, 12 Apr 2023 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681306038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh38YBUTOyaiwhL23o/32BL2Qxe5Kg/e4uFfEax2LOA=;
        b=PRd9QcpEglRG3Z6VaeJjGqb6hSlbmKlvsvyQ5ZmzfvjGSlcU+NshrNcCey5+CXv/wWnMjl
        C/JyAhYr1IIJI3Yv3rLSVZBfJNHEu2QiNi0FzsT7nNDRGaZ7E5nYbe8rTI9uO++Y5BLBpI
        mWjHsLDw9OF9MtvETrKAHisqe9Dpn3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681306038;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh38YBUTOyaiwhL23o/32BL2Qxe5Kg/e4uFfEax2LOA=;
        b=BC1CiNzc0Q5amoQl+Zh+Uw0ihVS3/VuDWnfl7gJ8CMgHCERuwGX4JduXeCHTl04UC5FLBo
        YOYmMCSsjlOc/PCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 920EC13498;
        Wed, 12 Apr 2023 13:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D1ReI7axNmSHdgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 12 Apr 2023 13:27:18 +0000
Message-ID: <f6eba66c-1698-0002-8329-6fe6d216c5f4@suse.de>
Date:   Wed, 12 Apr 2023 15:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] Sunsetting buffer_heads
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6ca617db-5370-7f06-8b4e-c9e10f2fa567@suse.de>
 <ZDavMfPMwEeWa4uQ@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZDavMfPMwEeWa4uQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/12/23 15:16, Matthew Wilcox wrote:
> On Wed, Apr 12, 2023 at 12:18:29PM +0200, Hannes Reinecke wrote:
>> Ceterum censeo ...
>>
>> Having looked at implementing large blocksizes I constantly get bogged down
>> by buffer_heads and being as they are intricately linked into filesystems
>> and mm.
>>
>> And also everyone seems to have agreed to phase out buffer_heads eventually.
>>
>> So maybe it's time to start discussing exactly _how_ this could be done.
>> And LSF/MM seems to be the idea location for it.
>>
>> So far I've came across the following issues:
>>
>> - reading superblocks / bread(): maybe convert to ->read_folio() ?
>> - bh_lru and friends (maybe pointless once bread() has been converted)
>> - How to handle legacy filesystems still running on buffer_heads
>>
>> I'm sure this is an incomplete list, and I'm equally sure that several
>> people have their own ideas what should or need to be done.
>>
>> So this BOF will be about collecting these ideas and coming up with a design
>> how we can deprecated buffer_heads.
> 
> Might be worth reviewing this thread:
> 
> https://lore.kernel.org/linux-fsdevel/20230129044645.3cb2ayyxwxvxzhah@garbanzo/

A-ha. So I'm not alone.

Please count me in in that session.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)

