Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FFB77E911
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjHPSvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjHPSvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:51:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562DB26AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bf91956cdso852144366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692211876; x=1692816676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaKaeU51JPSPyvo4LO/gtZBA5F2n47wdQ6cksSuHE10=;
        b=XRGBBq+rOvRMc69Whh9cvRs65DLBBjwah59cp0mxt/dJ5E43b+fAMg2r2s8dTZ6ppe
         68ZjZshHkEsIkU2f9TFXn1EUt0eyLjbhaLjRK3uDEBb61G5xzubTtsmKXZDYWTVeU3qD
         kwRpPWw4TlmwPBMfcbziBSxi0WrTfJ/kVLYzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692211876; x=1692816676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaKaeU51JPSPyvo4LO/gtZBA5F2n47wdQ6cksSuHE10=;
        b=Y9rfGNSfGfvV8b/FJ9A7XEzg8SuwLJOx7id90pu0Fh4xQoDrOuoBl8Aqf5HYJJJA8u
         QGq5oBKM+NcOsNvvl6Vz/SBFrzIdG4JAe8k2EUIIDxvYIAyFfe8yxprBkk19fS6zhoKd
         h6aeLFL62u2oJAFSqpgJ0vord+O8JucgOiM47nUzxpckmMLpvunj04chLX9nxccn8v9g
         MmCZhSBjR+mHcRRvAIX+xq4zPoxjyLciggGKU7mHRIHz9vB0MWUKJZ2trWR6kr2qhMn4
         VOeKiM+KrifOYZtScjPUgpwLhiD4SQN6wLUQ+pyhUoKd53niS4EnZl9kCd35HhUNxVNW
         3mwA==
X-Gm-Message-State: AOJu0YwrnM8IA+gjc1ES8CzROKN1bwAIYi7qlTMlyrfzRy/9mYIkNoZt
        WYr3eelsjxyq4TqHCm3h71XAur1lAYAzcVXhg8pfA30I
X-Google-Smtp-Source: AGHT+IEqEW8TM5EC+cC6P/CDFYdhw/ax5aPbH8L9kvadM5P/Attd6te2R5P46h0lILLLBcHvB6ko9w==
X-Received: by 2002:a17:907:77da:b0:99d:fd27:b38d with SMTP id kz26-20020a17090777da00b0099dfd27b38dmr606031ejc.70.1692211876745;
        Wed, 16 Aug 2023 11:51:16 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090654c800b0099cf91fe297sm9049086ejp.13.2023.08.16.11.51.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:51:14 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-525bd0b2b48so359890a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 11:51:14 -0700 (PDT)
X-Received: by 2002:a05:6402:1854:b0:525:69ec:e1c8 with SMTP id
 v20-20020a056402185400b0052569ece1c8mr1797634edy.40.1692211873612; Wed, 16
 Aug 2023 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
In-Reply-To: <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Aug 2023 18:50:56 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
Message-ID: <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Aug 2023 at 14:19, David Laight <David.Laight@aculab.com> wrote:
>
> What about ITER_BVEC_MC ??

That probably would be the best option. Just make it a proper
ITER_xyz, instead of an odd sub-case for one ITER (but set up in such
a way that it looks like it might happen for other ITER_xyz cases).

                Linus
