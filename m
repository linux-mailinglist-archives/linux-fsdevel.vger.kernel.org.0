Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8139C7BCE96
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjJHNgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 09:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjJHNgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:36:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF4CA;
        Sun,  8 Oct 2023 06:36:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690bd59322dso2686575b3a.3;
        Sun, 08 Oct 2023 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696772164; x=1697376964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3C2YJQ++TrMtt8XMmFcOgeObKioQb8RQl5GTEnxRYY=;
        b=RD+MvbIActNUU6C32NN7LXAnWwec3JOFxU4hxQqobWWZARAw4uv4FRkomIAfBpIdp6
         Ch/KBx5Q8qh0XB6ctIdRRESgq2OhFwN7YnjSoJucaswdkP6a8GDypwP8waAZ/iL7emjp
         4JUe/N2dJkltOSuYZPOhWZYtEtiGwiNr1ewtMWZNW4QZJZn7bS5OxHyDW2sw5lKCf1Mg
         Qxe7NPBd3HDv+C3vg8qGIJeSReZzfx3CaOd9jw/hQugW8zyXjgsnUTlOpO9tkD6BKPAt
         XUXWQP6Pe8d2Sk9/7cT8N8Ictv1ZtlUZ3IloImpDscpEA+qYUD5z013s7t5kpFtyMfuB
         /k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696772164; x=1697376964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3C2YJQ++TrMtt8XMmFcOgeObKioQb8RQl5GTEnxRYY=;
        b=hu9x85SFw/MFu0pIiUgFf237EmRgr52hcZlqwj3uXRI/539Z+Q5rBt8dzyGVtifT/6
         JSiTJhufq3AURA8aQtloMSDdHNDtv2+QIGDrXqYSvgG9YVpV0M57HRTHd4Cw/Ks8P5sh
         f3XLH51yJZBz+dLZ1oQ4vZ0eaKDmB/xDoTKxzrWzF1epnkvPUvVBsE1a1i1kWCJaFvSy
         iTbe59VADBxE9OyfFeXcdlU8RI85gzk5lwPmvVlKYSi9pt3zAyuhnG2/LUzYo2VTPTcw
         M416wMWdLJPhiOlPXL9hpnw6GMkdcE5BLkQdJ/tiX0iiLeoTlib91FeMdgy2MS/ZOlDi
         CesA==
X-Gm-Message-State: AOJu0Yx1MGPLbFP412ErbYrPADQ+bsUjSzLhyO8ies6Ao8MTPnjYoXyU
        oPv+Tv2IgFXHK00dOe5Wxf0=
X-Google-Smtp-Source: AGHT+IE68Y3LKvsBHUpJMMPK95SwkQZkayPN1x8wuVejOFs8DLxHeGXOIQXhpO8YVH0QOtDaUZSm6w==
X-Received: by 2002:a05:6a20:8e0c:b0:15a:7d2:7594 with SMTP id y12-20020a056a208e0c00b0015a07d27594mr13164508pzj.11.1696772164136;
        Sun, 08 Oct 2023 06:36:04 -0700 (PDT)
Received: from ?IPV6:ddf2:f99b:21f4::3? ([2403:18c0:3:961::])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001bc676df6a9sm3373726plg.132.2023.10.08.06.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 06:36:03 -0700 (PDT)
Message-ID: <162d90ab-e538-402e-90f1-304183bf6e76@gmail.com>
Date:   Sun, 8 Oct 2023 21:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: kernel bug when performing heavy IO operations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
References: <f847bc14-8f53-0547-9082-bb3d1df9ae96@gmail.com>
 <ZOrG5698LPKTp5xM@casper.infradead.org>
 <7d8b4679-5cd5-4ba1-9996-1a239f7cb1c5@gmail.com>
 <ZOs5j93aAmZhrA/G@casper.infradead.org>
 <b290c417-de1b-4af8-9f5e-133abb79580d@gmail.com>
 <ZRPXlfGFWiCNZ6sh@casper.infradead.org>
Content-Language: en-US
From:   dianlujitao@gmail.com
In-Reply-To: <ZRPXlfGFWiCNZ6sh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The problem does not occur with 6.1.56 lts kernel, not that old as you 
expected.

在 2023/9/27 15:19, Matthew Wilcox 写道:
> On Wed, Sep 27, 2023 at 01:36:52PM +0800, dianlujitao@gmail.com wrote:
>> Hello, I got some logs with 6.5.4 kernel from the official linux package of
>> Arch, no zen patches this time. Full dmesg is uploaded to
>> https://fars.ee/F1yM and below is a small snippet for your convenience, from
>> which PG_offline is no longer set:
>>
>> [177850.039441] BUG: Bad page map in process ld.lld pte:8000000edacc4025
>> pmd:147f96067
>> [177850.039454] page:000000007415dd6c refcount:22 mapcount:-237
>> mapping:00000000b0c37ca6 index:0x1075 pfn:0xedacc4
> It still looks like memory corruption to me.  If you go back to an older
> kernel (say 5.10 or 5.15) does the problem go away?  It's not really
> dispositive either way, since a newer kernel might drive the hardware
> closer to the edge, but it might give some clue.
