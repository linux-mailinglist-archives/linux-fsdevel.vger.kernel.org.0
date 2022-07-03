Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88DD56482A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGCOyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:54:15 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194ED2DC4;
        Sun,  3 Jul 2022 07:54:15 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id t21so6837960pfq.1;
        Sun, 03 Jul 2022 07:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N/5JSOMEADoapmIXoVRcPDoVueHzRiWPhNBdsUZ1uek=;
        b=vrVUo2KTpKNzb5cG4zxaRTPges13A+3TxcVWKad7B5j6k3xGAGGgZn36G/cQcYT4/X
         4sejEmA3+fG2a/zQbYfkPGWe2ZwyeH2hx/0zcYGaHXd57P+btpsXHUUpjX1Vl5mijzED
         kgkeeE+s8bxiV3e3rr+yQ9cplTBg4nAewBGq85+LgVws9m/cj3fOor4YFckD9PiZg7Ic
         YGq0JmPLJnnQpN7YBFLjPk92iFgj3JfNl3S8InU7O3xvq8fN5gMKJr3KY31fYYB0L6wy
         6lOo4D5j+pis68XNptYEh8EgaMz1GQPWORwamnpg91zAwZxLzZru4NegfifVfoFF+kJG
         TLRg==
X-Gm-Message-State: AJIora8yxtyPbre1x6pzQ9bxCIfEkEL75Bh457x0RVBv4jd9upr0k0zM
        fCbAQKMEKrKVetZzdpVZYgg=
X-Google-Smtp-Source: AGRyM1v3iRbadRBADbEjJfZBpuos8qHnw0o4bD0D51mMNQMz8DhRKlPNNZqEkr5eG8gAifIg5nx96Q==
X-Received: by 2002:a63:7741:0:b0:40c:c3cb:d9bd with SMTP id s62-20020a637741000000b0040cc3cbd9bdmr20458523pgc.581.1656860054340;
        Sun, 03 Jul 2022 07:54:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b00168c4c3ed94sm18981428plh.309.2022.07.03.07.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 07:54:13 -0700 (PDT)
Message-ID: <1abb9307-509d-e2dc-5756-ebc297a62538@acm.org>
Date:   Sun, 3 Jul 2022 07:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        amir73il@gmail.com, pankydev8@gmail.com, josef@toxicpanda.com,
        jmeneghi@redhat.com, Jan Kara <jack@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org> <YsGaU4lFjR5Gh29h@mit.edu>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YsGaU4lFjR5Gh29h@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/22 06:32, Theodore Ts'o wrote:
> On Sat, Jul 02, 2022 at 02:48:12PM -0700, Bart Van Assche wrote:
>>
>> I strongly disagree with annotating tests with failure rates. My opinion is
>> that on a given test setup a test either should pass 100% of the time or
>> fail 100% of the time.
> 
> My opinion is also that no child should ever go to bed hungry, and we
> should end world hunger.

In my view the above comment is unfair. The first year after I wrote the
SRP tests in blktests I submitted multiple fixes for kernel bugs 
encountered by running these tests. Although it took a significant 
effort, after about one year the test itself and the kernel code it 
triggered finally resulted in reliable operation of the test. After that 
initial stabilization period these tests uncovered regressions in many 
kernel development cycles, even in the v5.19-rc cycle.

Since I'm not very familiar with xfstests I do not know what makes the 
stress tests in this test suite fail. Would it be useful to modify the 
code that decides the test outcome to remove the flakiness, e.g. by only 
checking that the stress tests do not trigger any unwanted behavior, 
e.g. kernel warnings or filesystem inconsistencies?

Thanks,

Bart.
