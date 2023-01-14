Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86B66AB49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 13:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjANMJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 07:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjANMJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:09:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466E448A
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jan 2023 04:09:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bj3so21700602pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jan 2023 04:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+o3aaAuolf2/uRomR6WtHUNv1uFhVkDXFlfeWDDe0E=;
        b=XemS6r+6V5QQxqi/VYBPu+Lkm/RatFiqztHVe/R15ZAk7LT8pwa76EPm5b+Z2kZTgT
         uD1qgKoMk00wAGyZoMZ/6n8G9FPxV4Sk6UztEG19nU8cMqhywx51wzrDMhvnICL2sCjB
         qw9yjagJV0sLJJsw3jGFCNk2G9IPiTLfbYi8ZF2j2QclHATEg0M+clTiG9SiHe7tjRNd
         CjM3afg0SfE316bT/q0VJoVjyV6bc/y8cvjksB3/JJ3bwIQt2E2Zm5+hhvEmUgKecYy8
         rWzBafdXsOVoFi36U1BWtVkivfZtoEN3nXdzSDa8PFkUndYxvKzstjDui5P9+Yse5ylw
         rrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+o3aaAuolf2/uRomR6WtHUNv1uFhVkDXFlfeWDDe0E=;
        b=aaH8oD0UQmEnG9jZosomBeptGrVyL7rwyYAwRZTfgt9K+81MGjZtde1TtmEZsx8n44
         zkUcgHgbJoOLC+5bYOz9Vfy6c6qZi4M+N2g/r99kjVUNEdYcY6vsCYRXWjgGJTEHhJtE
         nEVPw46OUaBlg2BqZNBhu1neesXNiKTI1UR4SJmvd12ZgKYUtuabQJZY91+4iLKpf9wH
         PUg7P52LUcdwrmL6tK9ehHu6wbCk2PrJaTPb+/nWhlHrhV6Gv0oumTqdyhG6EKwmJkAj
         crt8kH/QaZbJSIljVBCNqoCCRaryq+9+e/FAiuQzvbgqxxTlORzHIAx9/1rOhTFIQeJM
         5fOQ==
X-Gm-Message-State: AFqh2ko+oJIF8OUwXP/hXt1EZyEXpGaEYQt7MwdPwTbXXIdnbMRHx3aY
        sSHVPqzHTN+IqesqktI25dd0eg==
X-Google-Smtp-Source: AMrXdXtK5wXM0KcfuPhTmm7EQ3X4jDr1pU5000kNB7pAPFaSlyJ4FnFnuAIrM36BhM9z2aR9TWyBcQ==
X-Received: by 2002:a17:90b:1958:b0:227:1d0e:3696 with SMTP id nk24-20020a17090b195800b002271d0e3696mr20742421pjb.11.1673698161833;
        Sat, 14 Jan 2023 04:09:21 -0800 (PST)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a318e00b00226d0165d97sm15434011pjb.22.2023.01.14.04.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 04:09:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: Should we orphan JFS?
Date:   Sat, 14 Jan 2023 05:09:10 -0700
Message-Id: <393B8E4A-8C9A-4941-9AFF-FAC9C0D0B2DA@dilger.ca>
References: <f99e5221-4493-dba3-3e80-e85ada6b3545@oracle.com>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Christoph Hellwig <hch@infradead.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f99e5221-4493-dba3-3e80-e85ada6b3545@oracle.com>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jan 13, 2023, at 08:15, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>=20
> =EF=BB=BFOn 1/13/23 7:08AM, Harald Arnesen wrote:
>> Christoph Hellwig [13/01/2023 06.42]:
>>> Hi all,
>>>=20
>>> A while ago we've deprecated reiserfs and scheduled it for removal.
>>> Looking into the hairy metapage code in JFS I wonder if we should do
>>> the same.  While JFS isn't anywhere as complicated as reiserfs, it's
>>> also way less used and never made it to be the default file system
>>> in any major distribution.  It's also looking pretty horrible in
>>> xfstests, and with all the ongoing folio work and hopeful eventual
>>> phaseout of buffer head based I/O path it's going to be a bit of a drag.=

>>> (Which also can be said for many other file system, most of them being
>>> a bit simpler, though).
>> The Norwegian ISP/TV provider used to have IPTV-boxes which had JFS on th=
e hard disk that was used to record TV programmes.
>> However, I don't think these boxes are used anymore.
>=20
> I know at one time it was one of the recommended filesystems for MythTV. I=
 don't know of any other major users of JFS. I don't know if there is anyone=
 familiar with the MythTV community that could weigh in.
>=20
> Obviously, I haven't put much effort into JFS in a long time and I would n=
ot miss it if it were to be removed.

I've used MythTV for many years but haven't seen any particular recommendati=
ons for JFS there. Mainly ext4 and XFS are the common filesystems to follow t=
he main distros (Ubuntu in particular).=20

Cheers, Andreas=
