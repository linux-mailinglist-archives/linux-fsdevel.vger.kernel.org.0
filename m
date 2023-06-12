Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28DC72B537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 03:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjFLBxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjFLBxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:53:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D387E42;
        Sun, 11 Jun 2023 18:53:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3d44e3d1cso2708825ad.0;
        Sun, 11 Jun 2023 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686534796; x=1689126796;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXP4cNz2t4ZDkBT1cIgolpXOZPb+pc1BHI1BHsEvX7M=;
        b=QZ5bGCIpGHbOH30GJ0Vj1yd4riN0She2upYTWDR3Egs4ibXpscmtcucLmvkfxF/ORO
         7OGvYZIPfnqFfJEzuvN/15sJDKbMTF6OaIfbEf0bU85dVY1YYfRCtDh1SLOGfcU5osK6
         8dN2w/eYlereO1YRJQZ6aUkr3fhim5ThMXNhqlHY9lGRJqvm1Q+WYt0sAp86Povb7U/a
         0TiXekpQCtbKU87a20i51stNCpkCXcq0Z4zokTxMgN1aaqKL3mTWTlK+L5lM8klPbMX5
         zp7DaAv23vObUuOlpxW2XF6QHNytWiNQD4VZFwLNHcI9/rJZBckrlYQ/CXCOEFhdnDJ9
         mHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686534796; x=1689126796;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXP4cNz2t4ZDkBT1cIgolpXOZPb+pc1BHI1BHsEvX7M=;
        b=NrXQkNzrHo5/gGRKTTkbAAOnx64mAW4ydwLp48xlLEKCAKpQX6m7GFwUJys/2opIyg
         OxFPKxOKvj8wDohPHkRDPsdjqohq/eudQYRKIUqdwyQoyC9y26OjhVkqvknbdwbixJtX
         YaCO0FlvRyFHnqJSb9gyPdpDzQQ7x7dUZdBo50mhdYI5UCknpP/KodfGCeDMKWtIxkuz
         KDWrtgrlo6D9O6fiH72rpdiSdk43NZiz/D/xQ6VcPpPfkOS5ftZVuxjay2DTZI/TjF0i
         zYYsrgtYHOibiVSQmDyNNmzSXAWhmBr9/AERdQLV/ZCeAH6/+UDJqSQLEBOdwuXi83Os
         E92Q==
X-Gm-Message-State: AC+VfDzr7fO7njEo7VelQygIAuqGqL1UVQJyXSLIAW+SGgllvx+SY4L/
        SVnA2MAVDhiDKM4atEHuumA=
X-Google-Smtp-Source: ACHHUZ5BNiY3nhsAahGpBTQXH2dS2OYKPuqr+MFJAL26s478eK40jCOAPCUITbQCzP7gmMnMowSheA==
X-Received: by 2002:a17:902:c407:b0:1ac:5717:fd5 with SMTP id k7-20020a170902c40700b001ac57170fd5mr7562551plk.60.1686534795692;
        Sun, 11 Jun 2023 18:53:15 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902bcc700b001b052483e9csm6915001pls.231.2023.06.11.18.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 18:53:15 -0700 (PDT)
Message-ID: <35a8d0f1-0def-a1f8-b3db-d48863693fbb@gmail.com>
Date:   Mon, 12 Jun 2023 08:53:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] fs: Fix comment typo
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me> <87edmhok1h.fsf@meer.lwn.net>
 <ZIZ31kVtPmaYBqa0@debian.me>
In-Reply-To: <ZIZ31kVtPmaYBqa0@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/23 08:41, Bagas Sanjaya wrote:
> On Sun, Jun 11, 2023 at 01:50:34PM -0600, Jonathan Corbet wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>
>>> On Sun, Jun 11, 2023 at 08:33:14AM -0400, Shaomin Deng wrote:
>>>> From: Mao Zhu <zhumao001@208suo.com>
>>>>
>>>> Delete duplicated word in comment.
>>>
>>> On what function?
>>
>> Bagas, do I *really* have to ask you, yet again, to stop nitpicking our
>> contributors into the ground?  It appears I do.  So:
>>
>> Bagas, *stop* this.  It's a typo patch removing an extraneous word.  The
>> changelog is fine.  We absolutely do not need you playing changelog cop
>> and harassing contributors over this kind of thing.
> 
> OK, thanks for reminding me again.
> 
> At the time of reviewing, I had bad feeling that @cdjrlc.com people will
> ignore review comments (I betted due to mail setup problem that prevents
> them from properly repling to mailing lists, which is unfortunate). I
> was nitpicking because the diff context doesn't look clear to me (what
> function name?).
> 

And no wonder why several maintainers also highlight this (which prompted
me to review that way):

[1]: https://lore.kernel.org/all/162b5545-7d24-3cf2-9158-3100ef644e03@linux.intel.com/
[2]: https://lore.kernel.org/all/3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com/

-- 
An old man doll... just what I always wanted! - Clara

