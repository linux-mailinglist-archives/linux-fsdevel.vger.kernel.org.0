Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D461DFCAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 05:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgEXD20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388318AbgEXD20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 23:28:26 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A264C05BD43
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 20:28:25 -0700 (PDT)
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04O3SMYf010880
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 23:28:22 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04O3SHot027639
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 23:28:22 -0400
Received: by mail-qk1-f198.google.com with SMTP id g20so14808194qkl.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 20:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=i58OCaMAvQBYliGiBa5+vTtK/78utl6tdtCjNYsEte8=;
        b=ShnoIdYlesXPgnggFKBEubLZOikekrlH6kfiqz1lMqLdsGkb4I+nZFhMtblUgi8QA4
         CruTMuh/dw9XUeTrAAHgSU7zD/KG8lk/5jeZykcTVKfTAaitOVs/OKwAwWi5eC30+MnR
         143D7+00Tl0Ajf7vRJ13mq1ECcN3YbsjlSdn86CEoB8CvTY+aklndyLasfGG5TSthP5H
         y8j4t+OoPmjPEgrWEcNFho7bcZKXYCldnhO1AcnebpmApTlXiMCkTKN4nbgn0K5iTMsO
         VD0TssoiGfQev+xW7uCUYd6CKnxEU1TsbB9ZJ+sd1eNQuiedbASFmG5+IFVDRGqc5Jop
         n4/Q==
X-Gm-Message-State: AOAM5332ksXjQw2UqqN5styoKViUVJni0TgZCMuckQF+IdB0EjhrHf6U
        AvZA9V2T8QSN6GJpXodo+fuQn8gIn4ND7389lIaEdChuYCHW/RoPMVNDG6/WTr3HXYRvPLHenfC
        qaYL9A1bcyyYPyg4UXIkVA6vSEKB7jSjw69w/
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr22092048qkk.490.1590290897443;
        Sat, 23 May 2020 20:28:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTv3M8riA+KCQEJ7UovI1OPJ0n7n+QJ0IE5YxSOmpO2i0TDa2rJYRwX0A2430HsIuZYpNvCw==
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr22092030qkk.490.1590290896986;
        Sat, 23 May 2020 20:28:16 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id p25sm2768539qtj.18.2020.05.23.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 20:28:15 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next-20200522 - build fail in fs/binfmt_elf_fdpic.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590290894_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 May 2020 23:28:14 -0400
Message-ID: <22928.1590290894@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1590290894_16657P
Content-Type: text/plain; charset=us-ascii

Eric:  looks like you missed one?

commit b8a61c9e7b4a0fec493d191429e9653d66a79ccc
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu May 14 15:17:40 2020 -0500

    exec: Generic execfd support

  CHECK   fs/binfmt_elf_fdpic.c
fs/binfmt_elf_fdpic.c:591:34: error: undefined identifier 'BINPRM_FLAGS_EXECFD'
  CC      fs/binfmt_elf_fdpic.o
fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
fs/binfmt_elf_fdpic.c:591:27: error: 'BINPRM_FLAGS_EXECFD' undeclared (first use in this function); did you mean 'VM_DATA_FLAGS_EXEC'?
  if (bprm->interp_flags & BINPRM_FLAGS_EXECFD)
                           ^~~~~~~~~~~~~~~~~~~
                           VM_DATA_FLAGS_EXEC
fs/binfmt_elf_fdpic.c:591:27: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [scripts/Makefile.build:273: fs/binfmt_elf_fdpic.o] Error 1
23:14:07 0 [/usr/src/linux-next]2


--==_Exmh_1590290894_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXsnpzQdmEQWDXROgAQKL5BAAjI/OXaLC+STtx047fdE5RkoaXShnqUSw
GhJ1TJnAtDtaDQTtX1BGLWaUtLlBqndad5OBRri0fspOPB2iL4nRscZCojqNupAv
Mja4gDYmlNhvHjO6Vzs/OHGRObz01+WD0SGAs7vEx2Sxpbm2rq37sWe7dzblznVl
VUyc3t+AUJek45kuOyxP6MrvvakLQLJdLWTHbg0bqUh0byRU6LT97Xu5gdyYoGsi
a/DfSNQFJHYbAzqR8cZA+/u9m04uEaJ+1eaz1NTQqq9fxN4fFFSXkqokkUAhezbq
OyFz8Q1cW7R3rB/EsrcmQ+hpGrZmlFR/N8qtK7Frp6ALwM1kgvpLpRAOWsVdlFTq
W7km69mUe3eBrUNGQ0UD0SUxGDIYwu2Z1GKUjmTDe3kPzH2PCk+/TIpYtVvXMnCe
T8vmu/yR37VgEOepko8Zgo9pNY6V5CGr/e/UiZHnA7DgFp5cT2YD3G6OLoXsibnf
k/qzNNJ0mmu+iDduIH+rBIOE5bpFn41Un8vuZRxb8FQD1PLFdwlT/V6BHqIuhAnU
ZtIjOlC0AUu15jzFZFrpUsOKC22BCNBSMzrHlli+G5BsDB4hR/xWSMHaedTAQwdH
cxOm75EAhXpwBj5xlnXyujyRvTSw52Lt5fNzVVGboYP4SEFIeePuenaKmkpCYs0e
3HPmljnddXE=
=6Us+
-----END PGP SIGNATURE-----

--==_Exmh_1590290894_16657P--
