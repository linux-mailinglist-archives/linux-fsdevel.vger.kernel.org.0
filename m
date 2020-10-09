Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6B288A8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbgJIOSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbgJIOSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:18:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0CC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2020 07:18:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so10698606qka.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Nsozhx6Vbc7+gevBK4suxhbi1tLEGMu37jB4LFRAPw=;
        b=hxFVkoe9fUSNiPI+uQ12JsKm6OjRLbKc/6lbFpVRDpIhsRf4KNWmimf4Uw4bwdRTz5
         uQebX3pJKZMtpcnAIYfdaL/HusqLmmVCjy1WhA7fNAyfon0iBRnmnTuq2eXAKWGAKu/g
         /vTH9xfC6VEOLORYAQpLlpSOhlk9U2mh95fmy7zrpVmL8CpQGirmNAr8bviupqSX4BiN
         JsjOaIWFbd15tmtcIRr9ygyReyr9DpipdN4qGf3pIBBGAQj2KR4tjY8vTI0zqQxk5GwQ
         Ocn5+xIj9xtTzKOSYGRzic4/Nq4+1UxKLsdYs+sy/07AkRNYMjjoJc4aPs5x3V89ALRG
         9rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Nsozhx6Vbc7+gevBK4suxhbi1tLEGMu37jB4LFRAPw=;
        b=HPx4hrHGAeC7LLvVFjIoxE/5hFjijAMyiGZro+0mc5iExFi3a7UhYlOLDVNSuJGhgH
         Mx+NVC0IzDiqZXGpnAQ90pJ43ltuiIikSTCdPhWChY6ClDV8/3erffQOX2z6EO2XPw5E
         rFRPKj/a1s+QNL+yaZfm8QuCOYd8upNmJV4OGguc6M9uOvrsSJvGz/MADirUx6f8Qwnm
         uAjcVcZkLHnZeH3kdqFTBw5eqqrxZUeu+LV+2POs3tWcHJs5d4v52Q+VBzGPR+7YxtYQ
         EXz9Mumx9bN3bVYBBFHwN5tzDS+CGmNrsjgwftjUa5BVs5tEFqfEeZTKxjvhg4FHu8cs
         j+hg==
X-Gm-Message-State: AOAM533XF1eTZIhIfv8e46u8IQ3y6C01s1q82J/b2TSrTl2yYqcU3DRC
        1TEp4xRUkMcGFywvfw9y7TzEaA==
X-Google-Smtp-Source: ABdhPJwWctAz3Cj788czTSYpVZIZN+OINVRMuTkx431OvmGfAhyvUvX02fo6IXvszZ32Z1TA67pjlA==
X-Received: by 2002:a37:4587:: with SMTP id s129mr12042169qka.99.1602253110784;
        Fri, 09 Oct 2020 07:18:30 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id t7sm5107903qkm.130.2020.10.09.07.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:18:29 -0700 (PDT)
Subject: Re: [PATCH 6/7] btrfs: Promote to unsigned long long before shifting
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     ericvh@gmail.com, lucho@ionkov.net, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, idryomov@gmail.com, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        stable@vger.kernel.org
References: <20201004180428.14494-1-willy@infradead.org>
 <20201004180428.14494-7-willy@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <84f3800c-445e-6dbf-2381-56840d7bba69@toxicpanda.com>
Date:   Fri, 9 Oct 2020 10:18:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201004180428.14494-7-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/20 2:04 PM, Matthew Wilcox (Oracle) wrote:
> On 32-bit systems, this shift will overflow for files larger than 4GB.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
