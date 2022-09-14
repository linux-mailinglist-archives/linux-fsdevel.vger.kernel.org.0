Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D795B7F39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 05:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiINDPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINDPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:15:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F301EAF6
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 20:15:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q3so13194146pjg.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Hn4otagjumTw49USqUIv3aIESk39vSQ7nnrygHJA1RM=;
        b=Vv9q+dPE9Xt5hHPzis7fhX6kTsf1B9KGILvS9Ojq8U83fKBRmcuLAytyV2QPlwV4tm
         MxpCRzVvZOssnaXJZTjzUkqHQH6yPnaveU6FhJbYJm6NpNT3QwkJVx7cf8FMhTkZA5Dm
         nhXfarzfZC6Znu6jC8Q0FDXbCGV4vUa/bhcRXTIm4dskUe1cyzsInw23LNouaKzJuk5q
         tDzVCXjJkHoH1GgOKoRX7sPPHBjxq9j8JkBXCp3N6Dh54w4qgoGEYFB4TNxUh/I8wC4x
         cL3LeOT+MZ6xG7drZQmcK+eWC/ZVnbCSJX/C5Nje3JACRZB4GOGqC4K69NyWKizP0/Rq
         OleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Hn4otagjumTw49USqUIv3aIESk39vSQ7nnrygHJA1RM=;
        b=eNUqaKQej0VnTiCkn7rPSjdDBzcHyEx+KSxecOmBAchHXR8W/lwHm5Hdh4B6ryPl9f
         imtIYd0U6c8ZNNYSOl8qP1EQ2wuPrWh/e0jUAU88MMlx5BUDCExY8g9IxMfGC5wprqfm
         sJ5s/kTqWeCrII8LVL7BqH65UGdsGs4F4HdkGKJKweitZ9dxnBHfROQozx1Yd0pm3IPp
         gKpotkAS17PEJsUKSSXdPH2Lqke9vIzyuIRd0MEvp0GLfNaLsiNQCka5BCBrBx72eRE+
         IaoH6iKLSS/82lDJj6jxaC+tYdg45yj/I7T+oy6d9S14t6v+XYEerxcSAlxOeu1tv5Bm
         dGYA==
X-Gm-Message-State: ACrzQf2Dw4z4E1FwGZg6J/mKWZPfMpubHd0wgXhdTyC10XFFXElWH0OP
        9uWOR+q8eKhq74llitp4qjjLtA==
X-Google-Smtp-Source: AA6agR4iw+NO6u+3snYgXRblqsQGkidXfNUi9Nmx0V/cbz6vyRNOEyx0KNTnzX+8/hoiCWT8wAx52w==
X-Received: by 2002:a17:90b:314b:b0:203:41c:2dbb with SMTP id ip11-20020a17090b314b00b00203041c2dbbmr2496401pjb.18.1663125347919;
        Tue, 13 Sep 2022 20:15:47 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:427:1cff:3226:873b:1ccd? ([2400:8800:1f02:83:4000::9])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090a5b1600b001fd77933fb3sm8133364pji.17.2022.09.13.20.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 20:15:47 -0700 (PDT)
Message-ID: <5f8b9a15-ec53-127b-63c3-b32005b35e05@bytedance.com>
Date:   Wed, 14 Sep 2022 11:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 2/5] erofs: introduce fscache-based
 domain
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-3-zhujia.zj@bytedance.com>
 <56b0a8c1-94ce-3219-6b43-d91d2e0e85b5@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <56b0a8c1-94ce-3219-6b43-d91d2e0e85b5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/14 11:02, JeffleXu 写道:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
> 
>>   int erofs_fscache_register_cookie(struct super_block *sb,
>>   				  struct erofs_fscache **fscache,
>>   				  char *name, bool need_inode)
>> @@ -495,7 +581,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>>   	char *name;
>>   	int ret = 0;
>>   
>> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
>> +	name = kasprintf(GFP_KERNEL, "erofs,%s",
>> +			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
>>   	if (!name)
>>   		return -ENOMEM;
>>   
> 
> What if domain_id and fsid has the same value?
> 
> How about the format "erofs,<domain_id>,<fsid>"? While in the
> non-share-domain mode, is the format like "erofs,,<fsid>" or the default
> "erofs,<fsid>"?
> 
Thanks for pointing this out. I'll revise it.
> 
