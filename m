Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9F6874A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 05:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBBErX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 23:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjBBEqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:46:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2DE80157;
        Wed,  1 Feb 2023 20:45:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mi9so795877pjb.4;
        Wed, 01 Feb 2023 20:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytIoiUbvoF4e9kKYBUD6qxM7lUbST+sBiwJ35KUDVFc=;
        b=C3rdIX1iag6g/n3E8FPTezGgZUY8D9p71fFg/fA5ErGJczLPM6nGFWt/tQ104keY1F
         SLjFol54WdfTqIzmg9SG2VBNiel+WDWcyhGkAYqu6XRxuxN4lHrR/3CpNAS9wOiwrGlm
         V8PXip0svP6UIqp8pJNQUo93PyuxsSh5vgIuelI72I0/0QU3sSsgMHkQM/ruUmypAgXA
         9Z4QAz5IpBEYLY2b/Ljmt7OlR7roFEhbYkkfcb0137BugpVH8PPUgxjdwF+y67hmXm1z
         YAM3W3XBEHcHq9aO0ojHd/eXz/CBOh8aJ+GqrFfwr1GNICTZ1v+uWJb2XM18UB/B5fFk
         VHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytIoiUbvoF4e9kKYBUD6qxM7lUbST+sBiwJ35KUDVFc=;
        b=tZiVAhp5VpXGoLcIOUX6cGWI3EqXOp8fUHaLLsogKKtfOUBxoWZWCQ2S8PhZDX5E6i
         C84f7ACgPL0DXbIHb6eRuMK+WNJ0UX4bDtb2klKKXG57bnTy1zXkRQRpKyUq/dGtxJYQ
         EweNS6GXFmlSLPOr7/eJdIJmc7B6UnCiPeRkQ7DMyHd5xFi3A8AWc8uW+J+y9L8J+JCn
         Ezq4nOeHMtnwhskAxTdcbc7pXGlgyxqsvWFknK1mRHJzzlTD3BOQIyh6kw52oroIIxjI
         /UkXF3l138FVJdzg6TFmZWdENz6gMsg85zkkla9lRv8vDr8EApy3PDzdvBf7raMC71q/
         lXww==
X-Gm-Message-State: AO0yUKXskHFT95dV5GflFsLafF1hasdyCz7VfMzo68+fTGk49nMihrCT
        KevZLhVqz0n3TklBZpV1bgahz+ysh8eLuQ==
X-Google-Smtp-Source: AK7set8EFV88g5c+6GhmGCp2kPFi9gS13vV8f2lUaTVpceGW9vmrt9da7JVa7srdjSFklDgfBB8aqw==
X-Received: by 2002:a17:902:e551:b0:196:2143:5eff with SMTP id n17-20020a170902e55100b0019621435effmr6119311plf.24.1675313110584;
        Wed, 01 Feb 2023 20:45:10 -0800 (PST)
Received: from localhost ([2409:4071:2308:8a61:d54c:14a7:7774:c76b])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902988200b001966eaf7365sm8571700plp.17.2023.02.01.20.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 20:45:10 -0800 (PST)
Date:   Thu, 2 Feb 2023 10:15:06 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 0/3] iomap: Add support for subpage dirty state tracking
 to improve write performance
Message-ID: <20230202044506.jimfszk6o7gkeq7z@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675093524.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello All,

Thanks for the review and feedback on the patch series.
I am on travel starting today. If I get sometime in between I will try and work
on the rest of the review comments. Once I get back next week, I will prepare
to send out V3 with review comments addressed.

Thanks
-ritesh
