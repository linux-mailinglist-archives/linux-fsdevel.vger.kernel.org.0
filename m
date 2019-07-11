Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649CB65B12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfGKP4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 11:56:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39951 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKP4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:56:54 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so13615589iom.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2019 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fJtEaYpuW1JqorFnoIRC1eRM7QglomBLDPa42dGcdPQ=;
        b=BXGlVD134tv0UrHdeVauqmM9VF2iK9Q2rgU/9vwzW41UEFGvzyX6LjAO6XO+MI+YLy
         MBbLcEe4ElqZoxUKrmo5BVx3/1YnKiQyjTGP9WawjEWKqsVfua9QWs8Q6bFTV3G2vVZh
         m4LrRkrf3mmyk14neX9XpZGHJf5TO0ZtsECX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fJtEaYpuW1JqorFnoIRC1eRM7QglomBLDPa42dGcdPQ=;
        b=BZ3b3TAo1vrilmYA08BcvZDlAgBpCaNgELEXrXufUvswDmc9ZUfn3pS0GYqZCO3KIO
         zk5CIT9E7KXdZZHChpxD7hbwsGAYhVOrIDUSDwt7hmfUTxdvAEW0kHqwsBmZHEKbAPpX
         rT9Q3KZdca6ppj8W/ZUoF72KVGpufCSpQ7/K1hlTy5A2LmKy2Jo5PbiCH9JzdUwoKW5k
         MeNH3YiT01gwvlZR9otaxXjYRZcN01NQ7/+IWcPsxxVp+ipIpI7kgdF6ctRnxR+Xj4Fo
         9Xh2BPKATRn4xnf7H7IqRsPNCetkwowmqed3K1/8RUND2yid8xjY2nTJF+fo/8doyoc1
         41LA==
X-Gm-Message-State: APjAAAXDTVcaT7W/37pOmv5AP06DEA3L1vDrENi1oKt8wKkpQgN2CbhT
        w53OX64ctpgfnbja/NAbteV5kg==
X-Google-Smtp-Source: APXvYqwiAHd2KEejvraiMb5Q04ydtGX2I/yoJqHdxLfhsjHFt7eALr8s7wkHoddRpYZcnGQM8qmiQQ==
X-Received: by 2002:a5d:9ec4:: with SMTP id a4mr4930044ioe.125.1562860613315;
        Thu, 11 Jul 2019 08:56:53 -0700 (PDT)
Received: from [10.10.7.141] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id m20sm6302394ioh.4.2019.07.11.08.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 08:56:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] udf: support 2048-byte spacing of VRS descriptors
 on 4K media
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>,
        "Steven J . Magnani" <steve@digidescorp.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190711133852.16887-1-steve@digidescorp.com>
 <20190711133852.16887-2-steve@digidescorp.com>
 <20190711150436.GA2449@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <6abea3a8-53da-f7ed-33f5-a9ecfd386c56@digidescorp.com>
Date:   Thu, 11 Jul 2019 10:56:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711150436.GA2449@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/11/19 10:04 AM, Jan Kara wrote:
> Thanks for the patches! I've added them to my tree and somewhat simplified
> the logic since we don't really care about nsr 2 vs 3 or whether we
> actually saw BEA or not. Everything seems to work fine for me but I'd
> appreciate if you could doublecheck - the result is pushed out to
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
>
Tested-by: Steven J. Magnani <steve@digidescorp.com>

The rework is more permissive than what you had suggested initially
(conditioning acceptance of a noncompliant NSR on a preceding BEA).
I had also tried to code the original so that a malformed 2048-byte
interval VRS would not be accepted. But the simplifications do make
the code easier to follow...

Thanks,
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>


