Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A871B4B61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDVRM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 13:12:56 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:43270
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgDVRMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587575574; bh=+KYwgqq/AmEfR52qW4/rvXPouS6eAxPS2KKqaT54mFU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RaJerD9V+3WaVEj5DW6is3CQxL3t5vLiaY1PokUhh6ntWe9FHyeog82h5VgGn+Lu/QeCc9yoSPEPZkMNSIO3Xh397GJeU3MFO8Cjs4YtrzF49bk70sYXhLH5v3lxk6fKKJKWxqGyvmOfSCQR1bd4JSJZMGisfImjpRhuh87eWsRKfucji5L8g4stG656VG5ByZFma/h8xrtlw3x8ncWGzOLYiZ01vXKkMxtGXGvB+yhAKDfSI7vv6420PEKmTchcyDfV0i9JLPFMQ7IqWAuQql5FALsd/daddsI9zKpkMD9DI/4JwLZhnE/5OCCkmTDx1lsY7CyIVS4wQ6Eo+wUoIQ==
X-YMail-OSG: tEYDWw8VM1me8UGcuDB0ueuFndIiHF0J5tbhT7fzdEQKs758k7rfONd6qzR8vbA
 .0z_79vcLhPGw9W5VV5ab9l1kaBUqf4mmkrdT3DgBPbbOvVEbvS838Gd_b_fMmsqge6IFCT_vgaP
 4nzHWzNhSlI5lP5Kg8foDqCSTBLakHSatTTXGv2sKh1SpxHuf5A7YHcxFW0J2fJcVF8plLmjvFL3
 Q2gWeGYYAdizQK_Ii2ucqa3bKIXOm4qqSeATOvo6tCp7Oj0tYbAscsm9JfmNeF3_J6vujd2MV9C.
 3lLY0P6VPCfvxpp8viwyP4cU_g..ZyVXHhcKMP7MXSJO8hl6w9hcF2.CHMOWBXMIZklccAj1s5fE
 J.ALFGyVF43Frfp8_6WE1SossBoWDPHdNlZiNfr8XmfJCgs3_MtjyeArkhZ6lmR9ttCz4vI9Fqbu
 LVRAoPSFG48PMjjjoo_CvJ53iHEVhzpd9f9AkB.M.PsjBoUEvUoOYvwwxBnAj76lvcXlNr2nv_Ow
 FagbAC1g7wOpu8tDR_NKgw6J45TTcW49iSJQYvfYIJun68BlLT7C.BqmmDppXjBp4R4RinVxie9n
 B6anJkyoV_WkYMp_ywKV8teXQ0gWihkr6j8sG0OfUnC_.JR_bln2mdPGxi93kvudQuCbbyWWtk5h
 1Chs7zMS.62JYkmAkq_6vTM7hilZtMbtg1w6rVJlhnLx.FB1hlWmNrLZFKiXfO8i6s4u5AXhDp35
 duYsjUK6EzQ8jE9.ilbfWfF1lLtmZUgSEK5EfQ78XBcipsho0Lj1nAAFGN9GTmZPFeC7m7EG4dLQ
 Xd1ZH_PWTAuu6DnpnzWeQJatd2RRzC0eIu7bR6bsFYeJcGqbSYrnlcu8CONnDOlETygor3ivdqzq
 .OzU7uLIvDWN9zrXm1lULqX1eAlx.hqhB6ek1a.JeKGHX1JZkgNxflM8mr6ejF3dlyYquPXcKIXZ
 tJLscNa0S1jsP_7zMFF7zstoODV0.sGh.OFq0sqbkrQS6miJgl2DZqT5AzgiZnAvQpOTjc7YsJFx
 wYdB.TmQ160L9BBTPFnIrppB.JvMWLn_DrG_1AKoG.aDaN8OteaW9FNHKeKE7BvxnTEzvrdPGxEk
 47_shXz1FXyNhtNIUbK4Hr_PtWdlA7xkDBsWU7LVRFpbgIs.RzbPFv8ft63BY7bqUTmHajtZ8wZ9
 07UQC_eq_tvyE7xqvukIqCQU3fUD50KxuAOf.IBQlKd0ulRyRp63Gi0MOuuoAFt7ZP9CV3jYAiqO
 gOvLfEaJPsAFrMRe2b_i.JG9T4JYvHuNa6YZZZ7U.l1nnq1S9ifVKDoi6GOref8gjn_Pml4OVMZC
 JAl8zsc46TPKxg1GybYWCBMIqImmVEbuKc67vxpYJf_JYUfaAx43pKvOVkNRdI4jC9ccRV6mzyfE
 L5ktjp4l9UtrNqcP9cNkdEscptOA9E.7oa_pC3BYQjPU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Apr 2020 17:12:54 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7e7f1419592d6ebe33c3473a62489b2a;
          Wed, 22 Apr 2020 17:12:48 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     James Morris <jmorris@namei.org>,
        Daniel Colascione <dancol@google.com>
Cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200326200634.222009-1-dancol@google.com>
 <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
Date:   Wed, 22 Apr 2020 10:12:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2004230253530.12318@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15739 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/2020 9:55 AM, James Morris wrote:
> On Mon, 13 Apr 2020, Daniel Colascione wrote:
>
>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>>> Changes from the fourth version of the patch:
>>
>> Is there anything else that needs to be done before merging this patch series?
> The vfs changes need review and signoff from the vfs folk, the SELinux 
> changes by either Paul or Stephen, and we also need signoff on the LSM 
> hooks from other major LSM authors (Casey and John, at a minimum).

I haven't had the opportunity to test this relative to Smack.
It's unclear whether the change would impact security modules that
don't provide hooks for it. I will bump my priority on this, but it's
still going to be a bit before I can get to it.

