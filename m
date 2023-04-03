Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276496D449E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjDCMoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCMoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:44:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707FB7685;
        Mon,  3 Apr 2023 05:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19C2AB81987;
        Mon,  3 Apr 2023 12:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0762AC4339B;
        Mon,  3 Apr 2023 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680525850;
        bh=OvaU2Kusmnfo0fD/tsoA13iKs2SdYrqob7DoCtFSBis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkUKLm7OfuwFE8Uibl6eu1d8v6N93FWGh29a4deT0Elc+7PZL1szWApB/6+S3aNKQ
         713rxTxeNvVXyAg6azL7NmhmEnxQtzbpBEL4yleBs9ephEdiEFMlo6w99zYn1ka7/n
         RrewhPmAPJhBj7expysryVj2lTxVFl2uSkP/t08A1+CX7YpUjK76y0ae3H3FOf0FrF
         aGpDnsWoOrMm0vazb/io6dDLE2UvfXkRWt2KJ3vKCqP9Oo/OxVvroA1FhrkUdMb9SB
         HPlABtdTo+Xku4qlk+3MmxVALu2yLiGU1sNF6d3yg9lFnQyJbUttwApTMbuO8Uu47E
         awOOIr0hKIzSQ==
Date:   Mon, 3 Apr 2023 14:44:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Yangtao Li <frank.li@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Message-ID: <20230403-frolic-constant-bc5d0fb13196@brauner>
References: <ZBlQT2Os/hB2Rxqh@kroah.com>
 <20230322171910.60755-1-frank.li@vivo.com>
 <ZB4nYykRg6UwZ0cj@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB4nYykRg6UwZ0cj@sequoia>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:42:43PM -0500, Tyler Hicks wrote:
> On 2023-03-23 01:19:10, Yangtao Li wrote:
> > +cc code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
> 
> Hey Yangtao - I think it is a good idea to deprecate eCryptfs and
> prepare for its removal in a couple years.
> 
> It never received the dedication needed to sort out the stacked
> filesystem design issues and its crypto design is aging without
> updates/improvements for some time. The majority of the user base, which
> came about when Ubuntu added home dir encryption as an option in the
> installer, has greatly decreased since Ubuntu removed it from the
> installer and dropped official support several years back. Finally,
> fscrypt should provide a more than complete alternative for the majority
> of use cases.
> 
> Deprecating and removing is the right thing to do.
> 
> I can devote some time to limping it by until removal but would also
> appreciate a hand if anyone has time/interest.

Hey Tyler,

Do you want to send a patch to deprecate it with your SOB?

Christian
