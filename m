Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D06A5EDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjB1SiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 13:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1SiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:38:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E205FDF;
        Tue, 28 Feb 2023 10:38:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so10536572pjp.2;
        Tue, 28 Feb 2023 10:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wmsoon14vl3q0w+HRQHUkmOdkXkAsQ8VnTRgpMmtBaw=;
        b=EsRTCDIfVr4BCBhblR3U6WySyTH2wBFfbmZVw8+7dUrRHe6viLsuCUMM5hTP/qFhXd
         noP1TtHtq+a4e61XajhaI0pr+hL0UQ9VkA0SM3xNm7+yGw6DamDr5SD7NoiiHpmPogRl
         oAMuvfuN/KBoKgI0d467fbfIkuuCsGCncjiqce9cdMeImX0mNROTAavlBaAwh1SpCAxd
         fOFPa6AO1Rs2LbXhI47vlPVVA1HUWUieRDFGRiamCwQ3ntqKuiFou78F4QUGGCdLptad
         JGoHV9dmDH7tUskS0Ff+aFZVMVYTaj3Xv8hE/CDBuy+2dFbFEMus+cvavBQG0YF43dBf
         Pjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wmsoon14vl3q0w+HRQHUkmOdkXkAsQ8VnTRgpMmtBaw=;
        b=fgxjJMkNAWLAlaRRqIpk+NvU1a6IwLwnTHJ8zIPGOoNsIVTRwFxre9surjvo9MELNa
         CFVrhcLKXtiq9N7NFPGfjcqjTvZoIc2r9Wyhcg+4O6ORcVXgkLns9rdGlSE4IP37am5D
         tuNXQ3PME8F8DKD/NYSLy5nJZ+hS69+7UuComMxX0GEU7njxwMNHVbqO1So1mXcFIJWr
         TwHLsV2EQhT/jtGKpQww4uNMc1Gv+TD1CveG+C1+90irI76rjNGuubv2CmyllaUYlq3S
         sSoUATiVl1sNSDH6p9dzW6CkK5kDOrHtiLZoI436dpb+9a0FuWmd2yvQRNhGxka1StBJ
         VHXA==
X-Gm-Message-State: AO0yUKX50UJbx2nRYk0qdOyojp6TvUBd73VnD1GrvtTJ+dkJomcLc1bY
        POrsGCWbuHMbCVI1TwmL0Z4xZpOph/6bGg==
X-Google-Smtp-Source: AK7set+NN5twdpBlrBqcroOMuFj7gKlrwjPaSWBe5yC3qZJTdX1oI7ln9bgVQdhHk+IlpS5kHNNvXg==
X-Received: by 2002:a05:6a20:7d88:b0:cd:91bc:a9af with SMTP id v8-20020a056a207d8800b000cd91bca9afmr5262273pzj.58.1677609493212;
        Tue, 28 Feb 2023 10:38:13 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b0058837da69edsm6358450pfo.128.2023.02.28.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:38:12 -0800 (PST)
Date:   Wed, 01 Mar 2023 00:08:07 +0530
Message-Id: <874jr53ab4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 2/3] iomap: Change uptodate variable name to state
In-Reply-To: <Y/vp36n3n3MNUjqD@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Feb 27, 2023 at 01:13:31AM +0530, Ritesh Harjani (IBM) wrote:
>> +static inline bool iop_test_uptodate(struct iomap_page *iop, unsigned int pos,
>> +				unsigned int nrblocks)
>> +{
>> +	return test_bit(pos, iop->state);
>> +}
>
> 'pos' is usually position within file, not within the folio.  That
> should be called 'block' or 'start' like the other accessors.

Agreed. Will make the change in next rev.

>
>> +static inline bool iop_full_uptodate(struct iomap_page *iop,
>> +				unsigned int nrblocks)
>> +{
>> +	return bitmap_full(iop->state, nrblocks);
>> +}
>
> Not sure I like iop_full_uptodate() as a name.  iop_entirely_uptodate()?
> iop_folio_uptodate()?  iop_all_uptodate()?

I can settle for iop_all_uptodate(). But would you rather prefer
iop_uptodate_full() like bitmap_full()?

-ritesh
