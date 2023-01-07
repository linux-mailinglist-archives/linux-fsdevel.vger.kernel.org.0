Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF9660E06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjAGKo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 05:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAGKo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:44:57 -0500
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 02:44:56 PST
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00D219;
        Sat,  7 Jan 2023 02:44:56 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4Npxfs0mvYz9sTj;
        Sat,  7 Jan 2023 11:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1673088293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPDgkeBAH2zIokhJqqVIvBl7NG72zPQvxS5diV0lvOU=;
        b=KWUGQPZotoJsjDX+ZGTW5P6lwLXO6MF+Xur3xVsGqhOimxOtAmouRsJvXp6yP22hykWDGO
        uLs/lCjd4GvjYP44iueijiqMC16rTGZk+GgSa6WGV1OWJojGOybbOx28h00inToEXVq9Fc
        pa189gxxcwycK9NeN80PTjFtllupUZ2yrEbonzK/zeMRVAZPWlwcI6oglw5zI3n88Nwt5R
        ReRfxqrV5W61aeSZz3Q4MmATM4bUiITLvRQtyfAv0g2QMWQky19w1u1Yj57CJBEYg3SIpL
        ikpH6A1mDZfGJpbI341HPR9STcV2t8CiN0dcLkNejeXoWuKT/WCk8aVjW1QwWw==
From:   Finn Behrens <fin@nyantec.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Rust PROC FILESYSTEM abstractions
Date:   Sat, 07 Jan 2023 11:44:51 +0100
Message-ID: <61BCB8A9-044D-4321-AF3F-1387FCDB230E@nyantec.com>
In-Reply-To: <Y7lMtA1OO3NX5bl1@kroah.com>
References: <4AE31CB6-53D9-45C9-B041-0D40370B9936@nyantec.com>
 <Y7lMtA1OO3NX5bl1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4Npxfs0mvYz9sTj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7 Jan 2023, at 11:43, Greg KH wrote:

> On Sat, Jan 07, 2023 at 11:36:27AM +0100, Finn Behrens wrote:
>> Hi,
>>
>> I=E2=80=99v started to implement the proc filesystem abstractions in r=
ust, as
>> I want to use it for a driver written in rust. Currently this requires=

>> some rust code that is only in the rust branch, so does not apply onto=

>> 6.2-rc2.
>
> Please no, no new driver should ever be using /proc at all.  Please
> stick with the sysfs api which is what a driver should always be using
> instead.

Oh did not know that, only translated a C driver from my work to rust, an=
d there procfs was used. But okay, will change it to sysfs.
>
> /proc is for processes, not devices or drivers at all.  We learned from=

> our mistakes 2 decades ago, please do not forget the lessons of the
> past.
>
> thanks,
>
> greg k-h
