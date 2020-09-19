Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA91F271111
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Sep 2020 00:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgISWX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgISWX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 18:23:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4593C0613D8
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2020 15:23:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so5829840pfn.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2020 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Zt+NcwFtW78Ml5fABVrawYmyBt1OY97jVqUspSuSzso=;
        b=JGo5Ok3UQlPkC13DKOsYdJnfzq73atFfYisEM+Hwumxj0suTBGssb+VorpwmGSdeCs
         bcXUpcZN25SMMCskSZLqiZtD4YDbCCmBpaZRkf/XvoBbu4chMl2XKMFhFG1ni8TPjold
         u1MXw/S5l0zIP2gSmcy2WrK2PhaeRtThtZVCQ2dBve9yiyZAijqQYE96b0yFOHC1wqdZ
         7hEKxxWuktu0haCnifIZQak4CZt8BJYl2PwWFDdP87EmsRRAJSorXT5hINrPIcaUrT6Y
         ZGcKD1NJTEIknksw7U+45Z60Vnnj162xs4+yz1Qx9fnmzqSyx2F/YY69FVIp1XlYNq6/
         4JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Zt+NcwFtW78Ml5fABVrawYmyBt1OY97jVqUspSuSzso=;
        b=NvygZRqlqE8MdJYmlflXIumg4IMzhrRH2Qi/yopd060fElfAACwR19LRoXOekcJAEQ
         THdq2wHp4eZSKXarhF+8RUabixfrPgxKTbNiustb87BXUiuCsh0xBF5Dwudc1/W7OSta
         T0zJsDtlSdLwsD3m7QTc7VWVJ82DDWxGqalO7f2/oJD50JcsbjRbDmHhvoxa52zbVnPA
         BHCe9HN9YTozY2+UhN/lF8x10rz2D5EkTord7+1150rPBfg0aZO/HBWFHLKYpPeQUS92
         TF98RgyEx/fSNzW1um9ienLUbesQwop8gpVOPqqrnDRjwQU7k9ZLmvpSmbHUkg+5n+VT
         7n1Q==
X-Gm-Message-State: AOAM533Czp8l/qUU/s0hOeh1bpZJQCCYPXeO5L4uKtLM+tLaSpEh3mFg
        5CxIOtNpCkoRUCZcqCVSBfXWAQ==
X-Google-Smtp-Source: ABdhPJzQlxXV5m1vFuZ7oLLvJBaRav6dyPvh+IWASrFhojswDAtpJrULIu1W68E3I7AE9Ae7seCzYQ==
X-Received: by 2002:aa7:9583:0:b029:142:2501:396a with SMTP id z3-20020aa795830000b02901422501396amr21664408pfj.47.1600554235950;
        Sat, 19 Sep 2020 15:23:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:c200:1ef2:e9da:b923:b529:3349])
        by smtp.gmail.com with ESMTPSA id gb17sm6607151pjb.15.2020.09.19.15.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 15:23:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Date:   Sat, 19 Sep 2020 15:23:54 -0700
Message-Id: <AA2CFC7E-E685-4596-84AD-0E314137B93F@amacapital.net>
References: <20200919220920.GI3421308@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20200919220920.GI3421308@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Sep 19, 2020, at 3:09 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 18, 2020 at 05:16:15PM +0200, Christoph Hellwig wrote=
:
>>> On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
>>> Said that, why not provide a variant that would take an explicit
>>> "is it compat" argument and use it there?  And have the normal
>>> one pass in_compat_syscall() to that...
>>=20
>> That would help to not introduce a regression with this series yes.
>> But it wouldn't fix existing bugs when io_uring is used to access
>> read or write methods that use in_compat_syscall().  One example that
>> I recently ran into is drivers/scsi/sg.c.
>=20
> So screw such read/write methods - don't use them with io_uring.
> That, BTW, is one of the reasons I'm sceptical about burying the
> decisions deep into the callchain - we don't _want_ different
> data layouts on read/write depending upon the 32bit vs. 64bit
> caller, let alone the pointer-chasing garbage that is /dev/sg.

Well, we could remove in_compat_syscall(), etc and instead have an implicit p=
arameter in DEFINE_SYSCALL.  Then everything would have to be explicit.  Thi=
s would probably be a win, although it could be quite a bit of work.=
