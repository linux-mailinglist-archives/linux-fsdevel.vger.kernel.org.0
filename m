Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC966EAE75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjDUP51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjDUP5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:57:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A213FB0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 08:57:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b781c9787so644505b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682092639; x=1684684639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSZLkVrR4znaBU7/34lRloMzkiKioLgkBLFv9+jq45M=;
        b=g4bXgCh8LuC3ClwDCLrnCk0XQ0qeQ8+OkLvZpxtjzYrZORmg8nhN3RUxO44Kkkuply
         2uzoyEoYfpmUh28rAxSNTQZglyOFV4uJYxda/1j5YNle//kU+2KxjgNrwxJl9ulpI4FF
         7HiLJELiaOETqk2CrKziAAdf71lsbulo0yXBeQpzbMG4ku61nobUoKvIwHpwyQpCpAuz
         q+LuacPxrCzs57vj2UUex3zg0/aU70H5HByVlPD4vtEJb2/KY8GsHjtZGsTPT1L77WNb
         CEhEjC6kF/7LqtFeTRDheD3Pd8bUSAXP4QPNnFGDDq8xMPW8zZCeDiTK2SzixoxpbXqS
         F0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682092639; x=1684684639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSZLkVrR4znaBU7/34lRloMzkiKioLgkBLFv9+jq45M=;
        b=g9mMuk6sZ8LxpbbUy14Oa/60boSrbSe/pRvDahDSSIkg/vjIfjEBdg1+SsOh/CcwAN
         P75Mzqc8D9+G6pBBc7lHBb84xcWS8HlIH72p3nyiPw8QKnmgFoRozdoasHC76sWdr/si
         HcBMh3BT8Fd8dFJCvltD0tiUF7Bfars8gzATGXK8/j5ETEiM8gnkPR9CrYxJvfAsyD4f
         Jp+BRwgmcWWmPPfz2khqRZ8F6zsdHWPb0hFUHqyuXNBrxsCk4DdQ5GSpVUDH3Tq6n7Eq
         y4nN9E4t9aE3DKWID9FyjHhfaZhm2JjpdVDQI1h6SHWQwboft+ZXOXP3JehYxbScBt4i
         nDQA==
X-Gm-Message-State: AAQBX9e3FnrGVBVlSiIOuixdn10di8ZMaIUGAMY2n5MAXr8KABWTMk5Q
        n3uBoSSUrjwPAWdGv0a6KVoKqA==
X-Google-Smtp-Source: AKy350bmJO3gBsnB6yY3o4rGG0zrD6tuLB1Xi8207GssvwrIUXDbqDVivrR9GhG8tmYVgSkpJaZ55A==
X-Received: by 2002:a05:6a20:54a6:b0:cb:af96:9436 with SMTP id i38-20020a056a2054a600b000cbaf969436mr8222809pzk.0.1682092638756;
        Fri, 21 Apr 2023 08:57:18 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p8-20020a63e648000000b0051b9e82d6d6sm2780655pgj.40.2023.04.21.08.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 08:57:18 -0700 (PDT)
Message-ID: <26e393fd-ffba-db6a-3a08-eb5aaa70315d@kernel.dk>
Date:   Fri, 21 Apr 2023 09:57:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Can you drop the splice patches?
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Ayush Jain <ayush.jain3@amd.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <208643.1682091901@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <208643.1682091901@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/21/23 9:45 AM, David Howells wrote:
> Hi Jens,
> 
> Can you drop the splice patches for the moment, please?  Al spotted problems
> with them.

Yep I saw Al's comments, it won't go out this time. I'll drop them from
for-next as well.

-- 
Jens Axboe


