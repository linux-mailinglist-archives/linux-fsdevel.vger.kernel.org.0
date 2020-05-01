Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516511C20D7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 00:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgEAWmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgEAWmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 18:42:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B0C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 15:42:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so13453977wrq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1YoBrGcOfoWOs/B+m22a2sFXdCiWrExB6slCiIMgKbc=;
        b=jI0xGxBhVhqnybezou5wj+pRK5XU0aUq5pyIuEgt1VDoiOBjHDWAeMXBE2CzslyrAV
         4kWrhrL7z+puiACbIuYaThmJfB++lY3YmYpSWWquIJSr4y3PF1j5CmDza9rKwoBhnh9i
         rhvHql0fkniS8CdnKOT8Ev+tI/Jcq1QaftZDRBZtq9RE3tXWWRV5COIo0l4Y/+o7ZIHl
         F7Yq+FX8U6T5kLbrxfpxBiad1J/SbUcPvazfNRc19Bg/g0HDPc7gjRtqyVTtX8Ey9O5+
         1oMWqKoQb4wUMfzIgUh8STCnfm80SsxxY3ygXHhaHlEBIjJLTehQamZuZuoKhDvlB4rE
         8xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1YoBrGcOfoWOs/B+m22a2sFXdCiWrExB6slCiIMgKbc=;
        b=thW8WNkni98wCwCZFMEOZoP6o+CnP9GKtVGZDhGKe3kjVyowveLCzrwo3cUvRslZc0
         wbcHgoAZyZkxgonVHSlbclAF5HyxG0REGL+a/kLYb3ymU++uHeTZzNld5xwNxQmoUIUf
         eVqRaU9/E0DaNWnYoGjKl47OLaKKrurH6Qe0iHQkXELwPJrS9MdKLA/1Ub0wUuA+Fk3h
         DezRdP4LllVds7zpXuehJ4E/l1thg13KYr/PMgOeUfzuvYajPHhi1G9BTgzpxlyUcXkL
         gczhNW4Cek9fRSgieUjv/4u8YPOK0OUS4zb2w5bR1o3760yODeqXRj3slTtQaKycEr05
         2Ebg==
X-Gm-Message-State: AGi0PuYZtqz3rUFAaUtk0DqfYX7Q1UdlRWhKrxAJcX9CDzqAnIOO6ysa
        0oDo0sUppRLxIzFAT1Kq5Zt60ZGSz1iQnoxi
X-Google-Smtp-Source: APiQypLwiXqwSDx/2b4YPOndd8yiZUZwFdBeA1+HWHdbcYWvVSw4FKrouvTOTMmgtoXo931jzjCF9A==
X-Received: by 2002:adf:ecc5:: with SMTP id s5mr5112370wro.261.1588372937299;
        Fri, 01 May 2020 15:42:17 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48db:9b00:e80e:f5df:f780:7d57? ([2001:16b8:48db:9b00:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id n7sm1404912wmd.11.2020.05.01.15.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 15:42:15 -0700 (PDT)
Subject: Re: [RFC PATCH V2 0/9] Introduce attach/clear_page_private to cleanup
 code
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
 <20200501221626.GC29705@bombadil.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <889f9f82-64ba-50b3-147b-459303617aeb@cloud.ionos.com>
Date:   Sat, 2 May 2020 00:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501221626.GC29705@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/20 12:16 AM, Matthew Wilcox wrote:
> On Thu, Apr 30, 2020 at 11:44:41PM +0200, Guoqing Jiang wrote:
>>    include/linux/pagemap.h: introduce attach/clear_page_private
>>    md: remove __clear_page_buffers and use attach/clear_page_private
>>    btrfs: use attach/clear_page_private
>>    fs/buffer.c: use attach/clear_page_private
>>    f2fs: use attach/clear_page_private
>>    iomap: use attach/clear_page_private
>>    ntfs: replace attach_page_buffers with attach_page_private
>>    orangefs: use attach/clear_page_private
>>    buffer_head.h: remove attach_page_buffers
> I think mm/migrate.c could also use this:
>
>          ClearPagePrivate(page);
>          set_page_private(newpage, page_private(page));
>          set_page_private(page, 0);
>          put_page(page);
>          get_page(newpage);
>

Thanks for checking!  Assume the below change is appropriate.

diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..f214adfb3fa4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct 
address_space *mapping,
         if (rc != MIGRATEPAGE_SUCCESS)
                 goto unlock_buffers;

-       ClearPagePrivate(page);
-       set_page_private(newpage, page_private(page));
-       set_page_private(page, 0);
-       put_page(page);
+       set_page_private(newpage, detach_page_private(page));
         get_page(newpage);

         bh = head;


Cheers,
Guoqing

