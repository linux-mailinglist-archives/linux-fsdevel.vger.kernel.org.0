Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F944CDE01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiCDUJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiCDUJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:09:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8620C2DA;
        Fri,  4 Mar 2022 12:03:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f37so15972832lfv.8;
        Fri, 04 Mar 2022 12:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2feTJ8tP3DC/YFFoVPPzvKdizBU6tg9lhj95h2BK0Uk=;
        b=M6uJy3jiqnYZQ0PUmcG9NFo1HLo/wJenMcAEDj8OcYlR9/RQqdhxHfSkm6Iz8Hh9j+
         S2tVbOzWmTyNQWI7IehtdN0/doGOGBH+9z4AYvxiIUBQtm/oGDsIMDl/58jnglUsqcs6
         4PG/NyJteifuVuoi41+Wbf2iHgHbzRXtxdFTI3sszlV8I+N/veBbFrR16u6uKEZzWuWT
         YB8aIEu9GUS8lTNfvcjZ9yuYi6h33a3rVUp5BRkgiLUbna+Tq5TxZEFS5VJG9e5t2vUC
         BsUnwJ8dXcPJk8VIQXlJjC6sYe8z8GsVkL68X9QTAQjrlf6qV+IkO1ovVHYW7UYuq3cp
         wDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2feTJ8tP3DC/YFFoVPPzvKdizBU6tg9lhj95h2BK0Uk=;
        b=VkEohwuwCex97HTqNctxF6HRD2n31mM7U+S/HaDSMkguxXuIkBtfdWcGNjDFsA5mks
         RtjjlGwA7UJQvRySBZ3vaZd0/M3T0/h/kMkLj5+kNOftnWCL/LPWVR04+HIro96Rro2o
         CRMnKdT3erR9/HBsHTMitQmQue/7un8mmxFYWBzdsADgIMUDwCd3d3Gy3QuI4I/CnyCv
         NmbMJlV9zjFyb5VK2yjxL8R56IRoe3qMjBHH5aeucRbl3Vc64gTO61UtbEFWVJMIybtL
         StA9wzoizf2z7H/k8r5KJdVhzc+1WmXRlW7P4l3/EcfpWO1s7pGNi3Jbv1r43tE4QMzD
         Dndg==
X-Gm-Message-State: AOAM533EzWywU5wnqzyeIdTyCbzGPvotA7UytGmepImdx8cZ1/livitZ
        lk4wVatPmJh+8dyAytt00tQ3X6bBXrPQ7w==
X-Google-Smtp-Source: ABdhPJxDMYpnJkvbS4DeRXy/SlQQziXOQnVycA9teF/oaohkBhHHeN4VqtYX3TuB4i8JAUwVxLhqXg==
X-Received: by 2002:a17:907:334c:b0:6cd:76b7:3948 with SMTP id yr12-20020a170907334c00b006cd76b73948mr262340ejb.55.1646422143286;
        Fri, 04 Mar 2022 11:29:03 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.82])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402520f00b00415e50f8ce1sm2242179edd.54.2022.03.04.11.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:29:02 -0800 (PST)
Subject: Re: [PATCH v4 16/24] locking/lockdep, cpu/hotplus: Use a weaker
 annotation in AP thread
To:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
References: <1646377603-19730-1-git-send-email-byungchul.park@lge.com>
 <1646377603-19730-17-git-send-email-byungchul.park@lge.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <aac81d30-ccc6-b351-729a-7265e8b6ec2c@gmail.com>
Date:   Fri, 4 Mar 2022 22:28:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1646377603-19730-17-git-send-email-byungchul.park@lge.com>
Content-Type: text/plain; charset=utf-8
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

On 3/4/22 10:06 AM, Byungchul Park wrote:

> cb92173d1f0 (locking/lockdep, cpu/hotplug: Annotate AP thread) was

   You need to enclose the commit summary in (""), not just (). :-)

> introduced to make lockdep_assert_cpus_held() work in AP thread.
> 
> However, the annotation is too strong for that purpose. We don't have to
> use more than try lock annotation for that.
> 
> Furthermore, now that Dept was introduced, false positive alarms was
> reported by that. Replaced it with try lock annotation.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
[...]

MBR, Sergey
