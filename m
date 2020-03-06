Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56417C242
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFP4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 10:56:01 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:37111 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFP4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:56:01 -0500
Received: by mail-qt1-f179.google.com with SMTP id l20so390908qtp.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ezCPULtseWvdBonQ6V0xPRaeP4ZB/PxE/0zq2zKcecE=;
        b=vrJLB0AMnGlO//iPUaQj4czq/Ymit0XSXn1kNCy8dDIfN4SAIn0VAB/1G2P2aIDpAU
         Q27jZMqu4vigDxjEMZyxINWUtIYfkl6/mAt+DeCjj4wMTZs2RV/kEGdrj66XgR5U7ES2
         wMm/c7XuXN1jlz66+O3Hn8wnQULPar1idqw7jtMSp27Zoz1C708TI1chwf9e+jI/GDFQ
         vCbYi/CLGURNzDWhNREp1p+ANBwZhR29YBXFznGQq+ABEJUoUKb6c/lAAuCEMTH/AYd1
         dHzKsl398YVeJCoLhooB/CBNL6dXtcStxFOrJ5HA0DD1cJht5EBgTz5+RJ/FijRjxZbf
         TJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ezCPULtseWvdBonQ6V0xPRaeP4ZB/PxE/0zq2zKcecE=;
        b=nN8t7yKANDslr7BBv0/gXPKs5oOOUV6sNrjGmVnU4Subtcdqma0zYZdprgv6lf5M0Z
         dluSSJtTgmESbiRWKRnKok5lHfTzd+BVtNNmUmmcBq14QYNKYCKIMIYhNKsssdMdcsL3
         GAJ4g9ZWAuL8oAI4MzaafIA3yBVt7HcuvMLZfc6tMuN6Yv/wbz1etZcLW1gwG/pEsoNt
         hNv19sLfbP1KAgg9VfcLoO4wz8amQ5tvIHBZHYAoYOCZD8ANtIf/81mxVw96FWZdnF32
         0Umf6ibjeeoY9cC8OlkY54+CH6B3XGsAj+xIUhKlKkpIrzfNpUl3p9leFWu5lbiAZmyf
         kPPw==
X-Gm-Message-State: ANhLgQ24q1ecQ5ZRfY3oOx0+9ecIVqBVOFey2W3MNGy3Hk6OFKkMyMyj
        bWtFjGtogJFyEuOvELL8Wi8y2Q==
X-Google-Smtp-Source: ADFU+vsPsQ92aQJlmertWUO6qTT3jd50HRGHtgKqPbNGPZeA9q+jXoLGczomOumHpidCeor50ODRsQ==
X-Received: by 2002:aed:2823:: with SMTP id r32mr3419004qtd.320.1583510159759;
        Fri, 06 Mar 2020 07:55:59 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 4sm9421817qkl.79.2020.03.06.07.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 07:55:58 -0800 (PST)
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Message-ID: <94dff81a-f0bb-1f91-999b-50bf29b75f4a@toxicpanda.com>
Date:   Fri, 6 Mar 2020 10:55:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/20 9:35 AM, Josef Bacik wrote:
> Hello,
> 
> This has been a topic that I've been thinking about a lot recently, mostly 
> because of the giant amount of work that has been organizing LSFMMBPF.  I was 
> going to wait until afterwards to bring it up, hoping that maybe it was just me 
> being done with the whole process and that time would give me a different 
> perspective, but recent discussions has made it clear I'm not the only one.
> 
> LSFMMBPF is not useful to me personally, and not an optimal use of the 
> communities time.  The things that we want to get out of LSFMMBPF are (generally)

It has been pointed out to me that this appears to make it sound like I think 
the whole conference is useless.  I would like to make it clear that this is not 
the case at all.  This is still the only conference that I make sure to make it 
to every year, because all of the reasons I list.

The point of me posting this is to get us to put some real thought into what 
would be the most optimal way to accomplish the same things in a different way. 
Maybe I should have titled it "Make LSFMMBPF great again!" instead.

I feel that there is a lot of fat to trim here, and many voices not being heard 
because of the way the conference is organized.  If I'm the only one then that's 
cool, but if I'm not I'd like people to think really hard about what the ideal 
meetup looks like, and how we can move in that direction.  Thanks,

Josef
