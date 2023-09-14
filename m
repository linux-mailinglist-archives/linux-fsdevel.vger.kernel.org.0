Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6F7A101D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjINV5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINV5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:57:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C321BFA;
        Thu, 14 Sep 2023 14:57:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0d5b16aacso12418325ad.1;
        Thu, 14 Sep 2023 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694728638; x=1695333438; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X34N50NaiDX+PBJtKJBqu0HsGsPzsSqdEPNcf7aeIrs=;
        b=PX2VQQqAiWTaBfzhNszo/To7XsEfIzIpKOBNFVhclk15Ev+P8MYg3cD5ngxpZKFNKH
         /9V3JJDtBfQwkwOzxW3WplbkYp55+pEXM55fEOCM1ZuDQPUEFrsYgYe+mQ8ae+1wLF/5
         IIHi2f1Rcg03TIrsFfpkyjRO/uHjz4aFzhCZSxzd/qNksGpV0zsv8uVr5MR83oTrvyeL
         p+ovLEkuckafvMBWiCH4+p5XDkOZMmRUGtuz44/m+qS7AHoDqKOGtEut6cQoldMyNVAG
         TacqQZzSCt5KOvoIJbouYvc4YaSbt+mK6OMstpVI4PBYxwtg8m1fFVXIUOF7B4Cu6cTM
         h5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728638; x=1695333438;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X34N50NaiDX+PBJtKJBqu0HsGsPzsSqdEPNcf7aeIrs=;
        b=SvVWCdufCR/8/7KP1NlAUj7oLfRWaq1cq4JBaFIGkwO6meKGrlkRoJ85HSjHquwPVM
         8olVUlPFt04sAc9CiKCjtH9LQ86FoYzLSjsqJgfY7xZ01A6GN2f7+SV02gQPw5BiA4kK
         fmhzL03469LO35MN9T7hciN15806X9jEZuo6sbIaVbdlWeE4pcslmoAUO6usITqoyUs9
         zYLQ57fISy1lVc7iqXbk9qjYt/1/094ahRCfplBiLpWveKZ9pJWpsQvlCiOUGAz5bEc2
         w0PB8zAKuDXoY+Luan9SjKAkzK4P9vDZTq3+rJEZfRsd5oIS6n8d3KlI37hifA/OhofP
         E3ug==
X-Gm-Message-State: AOJu0YxMDdjYddPkBe4dDchIu4LIr+sGqNlVllO7jUWArbbfK9KT+ig/
        qYUbTL1ILaRQETn3nYCosb8=
X-Google-Smtp-Source: AGHT+IGIaI/uWkQLliCTRlQFV1QfmbwrrxnMWQ0mT8W+Jdap0w9HAyjlgBEZRZvbgXVCbtXJ8c4H3g==
X-Received: by 2002:a17:903:2284:b0:1bc:8fca:9d59 with SMTP id b4-20020a170903228400b001bc8fca9d59mr7882429plh.29.1694728638036;
        Thu, 14 Sep 2023 14:57:18 -0700 (PDT)
Received: from smtpclient.apple (c-73-162-233-46.hsd1.ca.comcast.net. [73.162.233.46])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001bba7aab822sm2049158plb.5.2023.09.14.14.57.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 14:57:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230914152620.2743033-3-surenb@google.com>
Date:   Thu, 14 Sep 2023 14:57:04 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, lokeshgidra@google.com,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, mhocko@suse.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Liam.Howlett@oracle.com,
        Jann Horn <jannh@google.com>, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Transfer-Encoding: 7bit
Message-Id: <4F9BBE45-22D0-4F8D-BA56-CA3459998DC4@gmail.com>
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
To:     Suren Baghdasaryan <surenb@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Sep 14, 2023, at 8:26 AM, Suren Baghdasaryan <surenb@google.com> wrote:
> 
> + 	if (!pte_same(ptep_clear_flush(src_vma, src_addr, src_pte),
> +       	orig_src_pte))
> + 		BUG_ON(1);

Just a minor detail regarding these few lines:

Besides the less-than-ideal use of BUG_ON() here, I think that this code
assumes that the PTE cannot change at this point. However, as the PTE was
still mapped at this point, I think the access and dirty bits can be set.

tl;dr: this appears to be triggerable by userspace.

[ as for the performance of this code, the lack of batching would mean
  that for multithreaded applications where more than a single page is
  remapped, performance would suffer ]
