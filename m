Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83354BD2A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 00:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiBTXVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 18:21:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbiBTXVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:21:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEAB11C09;
        Sun, 20 Feb 2022 15:21:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cm8so16177859edb.3;
        Sun, 20 Feb 2022 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fDq3b+MqL0QmT25AsPMDwBUjZnQZoBnhIAME0gjmEdI=;
        b=g9Du09O+dLFuuHvdk9LB2JKidh3SK7T2Oe20hax9r1/HkZ41KDv8RlJhjAoywW4SUs
         QhHsqBOz6o53QqVhWJJU5F2YDRBYqgtSW+Lgw4p0STbx1aYWMwK/idwVT14XUHq296iD
         bcJMD9ITPQ9F1EMSJ0XZZ8p+dPvw1OY1OZH7l4cx7YWCdP3Y6yjaPwKmxEzkrqofzHVP
         iRnhntTn66gNBprvmxoB8sZDoOtQwDFhk42AEUqsEjv69lQkSyFxPaUEX1ejRVMiKkUZ
         U6dH2Bhr+Zp+sbiwObmeRp/TmGVyU/eOOesbvl3PV/BnJqfGyEAbdYdNVbmLeYVTbTqh
         aQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fDq3b+MqL0QmT25AsPMDwBUjZnQZoBnhIAME0gjmEdI=;
        b=UL0xWUlu/lZ6fRt/UP23i2bEPwUFdhMZ6bV6hZMx3hOiMXKMHWPw2izqwHwY2ampvG
         HvVIg2kfZ3qBIGkNCbUU74/hW/YnEKyJNO4fbGnbhK/2wRrZsVpCa3XMpMTMC7/FLDdy
         ffDPESjfuufl3OhJiektAQdApLqNbEoUJXTeTdSKiS1d/PsGj4ejDxUHrmigFXC31UQS
         l+ciuGD5WoELVFpiXlspTZwA5fwJFi2r+nWLiF1TPci1I6LqcKGOqZiPc/nWcpCIbGzB
         q4qtuFZngP9+crOwvekXDTrPZKmqx65ZNxYrR3406YNXz8elZP2/8+uxxLwEjOruB0rC
         rVEg==
X-Gm-Message-State: AOAM530kkvM6ZPA1EeRbAflCUieI8N/B+ZfnzA3DOa9tkFrWknt67uYM
        X2h5DadcGwv/QXTzf6ZQeQE=
X-Google-Smtp-Source: ABdhPJz7G3T995hFgbk0UZASONQra2YDixjNdDbsxLZhhCVewurdtkPB5CR3YNWY455EpDmoqqpDCA==
X-Received: by 2002:aa7:d648:0:b0:412:b567:3664 with SMTP id v8-20020aa7d648000000b00412b5673664mr15172392edr.296.1645399273777;
        Sun, 20 Feb 2022 15:21:13 -0800 (PST)
Received: from [192.168.0.48] (ip-046-005-230-144.um12.pools.vodafone-ip.de. [46.5.230.144])
        by smtp.gmail.com with ESMTPSA id s10sm4577721ejm.0.2022.02.20.15.21.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 15:21:13 -0800 (PST)
Subject: Re: Is it time to remove reiserfs?
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
From:   Edward Shishkin <edward.shishkin@gmail.com>
Message-ID: <fbc744c9-e22f-138c-2da3-f76c3edfcc3d@gmail.com>
Date:   Mon, 21 Feb 2022 00:21:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <YhIwUEpymVzmytdp@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

On 02/20/2022 01:13 PM, Matthew Wilcox wrote:
> Keeping reiserfs in the tree has certain costs.  For example, I would
> very much like to remove the 'flags' argument to ->write_begin.  We have
> the infrastructure in place to handle AOP_FLAG_NOFS differently, but
> AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.


Please, consider the patch (next email in the thread) which drops that
flag from reiserfs.

Thanks,
Edward.
