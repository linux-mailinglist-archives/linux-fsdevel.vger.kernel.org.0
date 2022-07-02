Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EBD5642F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGBVsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBVsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:48:17 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F3E90;
        Sat,  2 Jul 2022 14:48:16 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id g7so5903281pjj.2;
        Sat, 02 Jul 2022 14:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7pzCwbuJ1awOTDylC4AhAOeWlZjFXPBT2qh8yB9f/UI=;
        b=D3LH1f0A+zK8TYAVgii7giXyKC22NUd+9+y0h6pSM1Z7yiTYvdPsPWZCVNQ+PZZzmL
         H8Nf7JNeomZSWktgwlMW8lU7GvrCpEkaadiKhfYpZFDCxzboL5T+SHhvPTWHkpgNcZIR
         5lmuCi7Qg7On49sdGYnHPCphI1Y6meBeU3SoJZDE4FmS7R9OdwHfCT3hdqTpwshsw/5h
         +WTGZsWvabtDA+ttkOTZtuZF22IIZOps/bHS5g4sscxKb0I/k6Cmo6MBEGo+PvuR5qMy
         PqWGG7pZv97n5Ir72ZDks6zKwk527Yv9+aESs4jBOc6i44LoTIlj3ICsRjyXmph2Sovw
         NwRg==
X-Gm-Message-State: AJIora/Sj+ZijtiluQQt688yUOIc4KaqKDO2UvcK8q5S0JQrSB1qpOqa
        j38zMng+8bVY2h5iI4uDACY=
X-Google-Smtp-Source: AGRyM1tw20hL7NzxcC3lFHpleCL9qds7kkpA3sISl4o4Fht8U57Yct74xtvn4jcfwoluT7gkdzaQIQ==
X-Received: by 2002:a17:90b:4b42:b0:1ed:f6f:ff2 with SMTP id mi2-20020a17090b4b4200b001ed0f6f0ff2mr27694822pjb.131.1656798495445;
        Sat, 02 Jul 2022 14:48:15 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id x65-20020a623144000000b00527d9639723sm9027011pfx.184.2022.07.02.14.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 14:48:14 -0700 (PDT)
Message-ID: <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
Date:   Sat, 2 Jul 2022 14:48:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     amir73il@gmail.com, pankydev8@gmail.com, tytso@mit.edu,
        josef@toxicpanda.com, jmeneghi@redhat.com, Jan Kara <jack@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/22 20:07, Luis Chamberlain wrote:
> I've been promoting the idea that running fstests once is nice,
> but things get interesting if you try to run fstests multiple
> times until a failure is found. It turns out at least kdevops has
> found tests which fail with a failure rate of typically 1/2 to
> 1/30 average failure rate. That is 1/2 means a failure can happen
> 50% of the time, whereas 1/30 means it takes 30 runs to find the
> failure.
> 
> I have tried my best to annotate failure rates when I know what
> they might be on the test expunge list, as an example:
> 
> workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> 
> The term "failure rate 1/15" is 16 characters long, so I'd like
> to propose to standardize a way to represent this. How about
> 
> generic/530 # F:1/15
> 
> Then we could extend the definition. F being current estimate, and this
> can be just how long it took to find the first failure. A more valuable
> figure would be failure rate avarage, so running the test multiple
> times, say 10, to see what the failure rate is and then averaging the
> failure out. So this could be a more accurate representation. For this
> how about:
> 
> generic/530 # FA:1/15
> 
> This would mean on average there failure rate has been found to be about
> 1/15, and this was determined based on 10 runs.
> 
> We should also go extend check for fstests/blktests to run a test
> until a failure is found and report back the number of successes.
> 
> Thoughts?
> 
> Note: yes failure rates lower than 1/100 do exist but they are rare
> creatures. I love them though as my experience shows so far that they
> uncover hidden bones in the closet, and they they make take months and
> a lot of eyeballs to resolve.

I strongly disagree with annotating tests with failure rates. My opinion 
is that on a given test setup a test either should pass 100% of the time 
or fail 100% of the time. If a test passes in one run and fails in 
another run that either indicates a bug in the test or a bug in the 
software that is being tested. Examples of behaviors that can cause 
tests to behave unpredictably are use-after-free bugs and race 
conditions. How likely it is to trigger such behavior depends on a 
number of factors. This could even depend on external factors like which 
network packets are received from other systems. I do not expect that 
flaky tests have an exact failure rate. Hence my opinion that flaky 
tests are not useful and also that it is not useful to annotate flaky 
tests with a failure rate. If a test is flaky I think that the root 
cause of the flakiness must be determined and fixed.

Bart.
