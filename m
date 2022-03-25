Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3C4E793E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 17:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353843AbiCYQuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbiCYQuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:50:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54150453
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 09:48:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so16563384ejd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GsAhCNbPvDHEJXkXMPkoW9BYJoGtmfn3CH9K1lJqYAw=;
        b=Xy6Z/nnlU/LoGSIRbeyD/90ov+P/jy9w2JEpUHn5cU4+rfGPH0wCxjY6i3h5Q4uPMB
         /G2uJ6cx+jRELjNgFrAp/6Lo5aPI4ueuzI6KyLcqX9t/BGZ33cTp7jmEbekdbsg7F3l3
         pSf/0WBAHE8F7oXJEWlSBeoMMg7tVyyjA0mTK0drHYSzW/yJC7JdlLgab+e2DdDeCNEH
         DwiNtOBGMW5dDTvGRNb/sFEF0wUW/TSm0Mdpn8FtkfOUPnKnLhdkwQOp3MElcy0IHFvJ
         aduWCiHIienGNht304uO8z6Gl3ayriF/CeNz9t/3lQ8xBvo8d2xgjUa4+FEkCAU1nI1e
         Zruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GsAhCNbPvDHEJXkXMPkoW9BYJoGtmfn3CH9K1lJqYAw=;
        b=5/WE1OwglV/6NT7r+0TcHYxx55xIkb77kA4aCrzml9GeduZSFRMsaR2wSdcx4AyN8u
         az24Xr/Jcb+HW7eMNRXznkcks67G6hVm1m8UUTeu+tPeNib8crGFE4WTq2NhK5tBAIyN
         S7lAmRKEhJ2tekXv/zy1rEnoecRxpWhIFgKWvBL7CP3z2pWAg6cPgDZ9+DJ2k8dGv6OF
         A7+G8w+OoBre0NEdmZ7CR/0QCNLOA7EO+qNl2D+pD9k8xG4Q/SGYBxCJmgjcyCLPUvmF
         XTuP8ua5rJSkVPrLfDKH1Rx/88h6PtYv85lXws7RnywyOnuE4nc79TnyvQk9uBcta0Xw
         KXcw==
X-Gm-Message-State: AOAM532lzHjuTMqrU664UjTxT8eDqt0yOMFHe0By9qhQ81r+DE2Ez5yB
        Qw1HbytRkX1dhrqgqrH3Wlw=
X-Google-Smtp-Source: ABdhPJzBB/XwTjfMJevREDzBmMSHkrQ3yb1Mitz/q4hM7vHiTcV1Dw/VhJfFpW/kNtYptLboMJIGPA==
X-Received: by 2002:a17:907:2d8d:b0:6df:a06c:7c55 with SMTP id gt13-20020a1709072d8d00b006dfa06c7c55mr12414589ejc.325.1648226924472;
        Fri, 25 Mar 2022 09:48:44 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090664ca00b006df8869d58dsm2511813ejn.100.2022.03.25.09.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:48:44 -0700 (PDT)
Message-ID: <814c6a67-0fa4-862c-c98e-0e3e77cee4c1@gmail.com>
Date:   Fri, 25 Mar 2022 17:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] fs/dcache: use write lock in the fallback instead of read
 lock
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220325155804.10811-1-dossche.niels@gmail.com>
 <Yj3yCqOcg0Jo9K+G@infradead.org>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <Yj3yCqOcg0Jo9K+G@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/03/2022 17:47, Christoph Hellwig wrote:
>> @@ -1692,7 +1692,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
>>  {
>>  	struct dentry *dentry;
>>  
>> -	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
>> +	WARN(down_write_trylock(&sb->s_umount), "s_umount should've been locked");
> 
> This really should be a lockdep_assert_held_write() instead.

That's probably a bit nicer indeed.
I can write up a patch that does a lockdep_assert_held_write() if you want.
