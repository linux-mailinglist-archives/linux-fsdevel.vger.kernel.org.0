Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0468558A73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 23:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiFWVBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 17:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWVBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:01:06 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530FF54BD3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 14:01:05 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id v33-20020a4a9764000000b0035f814bb06eso90939ooi.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F89yAMjXepvjkRuQ7cF+LnWImZXVbWprCZTwSVgbFyY=;
        b=WDGblmiqwtm20dLva67uSF2XaQP2c6p74PqSPYNWpf4YJWHQRTgwwvDXcoWKgGilrr
         HvKljx57hDHcA8WTgjTTBlzRG/fJDltyCSKqLsqnQuct8Y3JHP7PD6gImIp8VN2aeI5f
         4QEQUNoXlzCbVUlaEuik2j2ROAwr+0GgTbc3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F89yAMjXepvjkRuQ7cF+LnWImZXVbWprCZTwSVgbFyY=;
        b=RcHMPQYRNhuYUUSTZWNd+b4hjgq+FM74iI5dz4lbQ7JqqqmyNTL9ZXYV/vciWAaC/w
         7O4LoL/aLJzYp8wEGcZ85plWISOr3REI1ewNIlQHPbt7nTpZuImxS3YJokurCNMXmFUp
         iZFoVMpRl0AoGh3JTFaTodWdUBrK2H8/W9u3AvxB2dmc4rU7uxrfTt5ZccctXA47Lz0g
         v/7an2JL1k+J9Ed5/T+DZG9E7+0C8rpasvXkAijuNGBYF5PpvncxcdbVak2jTQh0JLox
         TFOjQc8s/ioH/oxc4giHrQaop1LK1wZhjZ1VQFmukJAg8lJIaBnU2mtebr8UxSWd3LRh
         TSGA==
X-Gm-Message-State: AJIora/2FC400hVEyFqngqQo4F/+uoEzNAsgXsbcCzptiU5dVG3PVFr8
        twdmGETDTAybSVzyhAV084481Q==
X-Google-Smtp-Source: AGRyM1s2JS1YuAC8wDHM0cQ0Jop8OYQI3UBzlJHesUup5RIXlp7/ul7Kvro7khS0nQccCnQwLWVGzQ==
X-Received: by 2002:a05:6820:1606:b0:41b:c35f:999a with SMTP id bb6-20020a056820160600b0041bc35f999amr4579602oob.43.1656018064667;
        Thu, 23 Jun 2022 14:01:04 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:9794:3c64:a9f9:ef76])
        by smtp.gmail.com with ESMTPSA id kv9-20020a056870fb8900b000f39f0816bbsm484667oab.40.2022.06.23.14.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:01:04 -0700 (PDT)
Date:   Thu, 23 Jun 2022 16:01:03 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/8] introduce dedicated type for idmapped mounts
Message-ID: <YrTUj0skph2MYTHH@do-x1extreme>
References: <20220621141454.2914719-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621141454.2914719-1-brauner@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:14:46PM +0200, Christian Brauner wrote:
> From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> 
> Hey everyone,
> 
> /* v2 */
> No major changes. The type got renamed since we agreed that the initial
> name wasn't great. There are some typo fixes in the commit messages and
> a few tweaks to the last commit and added Jan's rvb.
> 
> This series starts to introduce a new vfs{g,u}id_t type. It allows to
> distinguish {g,u}ids on idmapped mounts from filesystem k{g,u}ids.
> 
> We leverage the type framework to increase the safety for filesystems
> and the vfs when dealing with idmapped mounts.
> 
> The series introduces the type and converts the setattr codepaths to
> use the new type and associated helpers.
> 
> Currently these codepaths place the value that will ultimately be
> written to inode->i_{g,u}id into attr->ia_{g,u}id which allows to avoid
> changing a few callsites. But there are drawbacks to this approach.
> 
> As Linus rightly points out it makes some of the permission checks in
> the attribute code harder to understand than they need and should be and
> increases the probability for further issues.
> 
> This series makes it so that the values will always be treated as being
> mapped into the idmapped mount. Only when the filesystem object is
> actually updated will the value be mapped into the filesystem idmapping.
> 
> I first looked into this about ~7 months ago but put it on hold to focus
> on the testsuite. Linus expressed the desire for something like this
> last week so I got back to working on this.
> 
> I'd like to get at least this first series in for v5.20. The conversion
> can the continue until we can remove all the regular non-type safe
> helpers and will only be left with the type safe helpers.
> 
> Thanks!
> Christian

As I mentioned in my other responses I prefer to see comparisons with
invalid ids always evaluate as not equal. You can take or leave that
suggestion, but even without it this looks correct, and I think a
separate type is a good change to avoid confusion. For all the patches,
feel free to add:

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

Seth
