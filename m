Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073A6E25C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDNOal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDNOah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:30:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796ECC03;
        Fri, 14 Apr 2023 07:30:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso21834416pjs.0;
        Fri, 14 Apr 2023 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482593; x=1684074593;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZERz3WsJDdC0uDTkNugsv8O4PImMZ58vKvd+AQbFqK4=;
        b=g7knSgfC9VwoBh3Fr6AKYJSqFtPHX1EN0qoevFhSSCBdqMJqI3I2pThm6yJi0H065o
         AzpJktQo8F3Sf74mMLDQYLEo4uENGOP9K61Ha3Qvx8jORSVxOoD+Q6TZNLqA1DZaanpB
         FSPFEsgnRiamuCouchrytkUy+V0kekl3qAJxFQQH54IxdXA7VTxNxJ5xUNoA5cezOHBi
         YMN94z+SgtJVbPuYZgGDfYKfHF+17NzpCKm5Z4ypeYE/Fd0Q/28q8Hc67heXvviBiMDD
         G4+9EfcMl0bm7Ni/qCqDPrFuSiD/VtN+ytGB2QW+EEv3vqPx3kevICa+IsuuEAsKrwbR
         Fbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482593; x=1684074593;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZERz3WsJDdC0uDTkNugsv8O4PImMZ58vKvd+AQbFqK4=;
        b=MgUec80+20xT7/pKC2h0Ohj8zL7+4EHrp76igZRxNUYim3ey9R3YXQ6rrOAsCC/7Av
         jP5gssJegftXk0T8ezVbM262GavIK5Bf3LgpkLNowIefx3ZzpXLufBXxg/wrd7D3km/M
         0MjAwjmalcWiFWf3mZ+X+mAagzsGUNancLEaCUol5xvsRnWUfi/gStxAzfPigIvRXSin
         5+kMFI0lN56as18mBtBoeZIFlUYWBE/WOS08+f8VuZ31ltv2MTd+jdoCTTDdbomKMr/K
         EAd0JtaNPY0x/BLVVsQJMNOCich5FyrDLb65+NIKOsJHiphNmBjhCdbv+myec+U704Nh
         lHwg==
X-Gm-Message-State: AAQBX9einLIIT17uM2bfH4ox3c7u1rC1JHkPANx4rebu3c99fdeD9f6q
        0JaiElwo4yLOVzfgaXIb9oI=
X-Google-Smtp-Source: AKy350YyfvEeSmokb74s/n5f7KrMweS7xsSMFgIYki8lZC53XZtBesO9gCdck+1UIeRaKF8/DxjWwA==
X-Received: by 2002:a17:902:cec8:b0:1a6:71b3:42a4 with SMTP id d8-20020a170902cec800b001a671b342a4mr3667528plg.29.1681482593180;
        Fri, 14 Apr 2023 07:29:53 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id p19-20020a170902a41300b001a661000398sm3144888plq.103.2023.04.14.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:29:52 -0700 (PDT)
Date:   Fri, 14 Apr 2023 19:59:42 +0530
Message-Id: <871qkmzgdl.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 02/10] libfs: Add __generic_file_fsync_nolock implementation
In-Reply-To: <20230414142053.gvekvcgxmkjfeht7@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Fri 14-04-23 06:12:00, Christoph Hellwig wrote:
>> On Fri, Apr 14, 2023 at 02:51:48PM +0200, Jan Kara wrote:
>> > On Thu 13-04-23 22:59:24, Christoph Hellwig wrote:
>> > > Still no fan of the naming and placement here.  This is specific
>> > > to the fs/buffer.c infrastructure.
>> >
>> > I'm fine with moving generic_file_fsync() & friends to fs/buffer.c and
>> > creating the new function there if it makes you happier. But I think
>> > function names should be consistent (hence the new function would be named
>> > __generic_file_fsync_nolock()). I agree the name is not ideal and would use
>> > cleanup (along with transitioning everybody to not take i_rwsem) but I
>> > don't want to complicate this series by touching 13+ callsites of
>> > generic_file_fsync() and __generic_file_fsync(). That's for a separate
>> > series.
>>
>> I would not change the existing function.  Just do the right thing for
>> the new helper and slowly migrate over without complicating this series.
>
> OK, I can live with that temporary naming inconsistency I guess. So
> the function will be __buffer_file_fsync()?

This name was suggested before, so if that's ok I will go with this -
"generic_buffer_fsync()". It's definition will lie in fs/buffer.c and
it's declaration in include/linux/buffer_head.h

Is that ok?

-ritesh

>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
