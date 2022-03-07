Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B04D0077
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiCGNxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiCGNxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:53:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231712AFF
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 05:52:27 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s42so1219823pfg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FpiH8sK6QJ5ZecNwA0soEekz+DBDXKgGF93HUqOWr2g=;
        b=3C80KwlAfecIpqsoXr/WQ/0If5ZLPxKUel30fSldQNh+QLi/6eRFRdZYMRUfVAEK60
         q1Tz2gW7OU0CuZS613xgjZfpk9iA8CNKv87I+FVqoZAL5PjH+CNyY/m39y88OJcfoeCY
         lFLtbwbOI1GWEeXXAfPQudyK2sWVrxK1qL64/NKjtX+fGVarDmEKqYqgPBddP1ylNjo3
         Bnk+YsbeEo4XWuoaSM49mf4Wz0Z+etvvQXT+S2GiwP+asuHMSS+/IDtF38qAuIAaf/l1
         9HtsYnmBy3rdrdClH8hTGW2YS7hqgFggJCNrGIVeeDYrPgmcNPiBirtZMfsVvpZFWLak
         /lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FpiH8sK6QJ5ZecNwA0soEekz+DBDXKgGF93HUqOWr2g=;
        b=Bc8QV/1PAQWhlRgC8PzW78MiEeUGRtffC3TwtajySlGx1ItA/DMK50H8y14/Bt4lZD
         KledcjtkTDD4tAFGm7pADPYOHNe9rSssrdfYZESnxWZXx02/+xLpWJ1TLvNeM69o0xUB
         C4K9r8S+M6RoHLvo8EPws0k7D3dBPHY8q8+NdfbR5l1rTTJXLnAFaC05/ohrthPS/t/M
         mmECO1dtL+EH6jrMc5YBP6XWZ67Evok+OAD+g5c9IA/Y0r194JbjaEv5FfRL8D+BMHEN
         OddCk+I4DD4hhqtVESDaR5IkaqtyoQct0mcNkOk9T05jpAwDFniy4x7Mnjl4W5WfK888
         pkyA==
X-Gm-Message-State: AOAM530BrXnGFOZf0kkaAqUyfzjE3dkEeH06Q/9HHtku/QwbnF4No857
        E+HW+ERfR1pmeKDScrHmOTAUig==
X-Google-Smtp-Source: ABdhPJz+/iGljhGAfM285WDdfPPis8SH9wGNMH/HdIzatH84Hr3uwQ2gayBqurPn+iZWNdoEmD1R0A==
X-Received: by 2002:a05:6a00:16d6:b0:4bf:325:de2f with SMTP id l22-20020a056a0016d600b004bf0325de2fmr12833983pfc.7.1646661147261;
        Mon, 07 Mar 2022 05:52:27 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f6feec0d6csm4550102pfj.2.2022.03.07.05.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:52:26 -0800 (PST)
Message-ID: <dbd1479d-09fe-aedc-3b43-5bd0cbebe555@kernel.dk>
Date:   Mon, 7 Mar 2022 06:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] fs: remove fs.f_write_hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220307104701.607750-1-hch@lst.de>
 <20220307104701.607750-3-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220307104701.607750-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/22 3:47 AM, Christoph Hellwig wrote:
> The value is now completely unused except for reporting it back through
> the F_GET_FILE_RW_HINT ioctl, so remove the value and the two ioctls
> for it.

This commit message could do with some verbiage on why the EINVAL
solution was chosen for the F_{GET,SET}_RW_HINT ioctls.

-- 
Jens Axboe

