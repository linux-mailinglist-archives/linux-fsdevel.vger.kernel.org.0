Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7E351AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 23:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFDVLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 17:11:53 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:35938
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbfFDVLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559682711; bh=rIePoQB7SfoXEtKT+Ykbw4tlwyh2+weCxD1TWpXWU/c=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=bUNqTZBshgF6lT2ZVGKEVPunsAMpq5+svvqycwgdRizvoFNDcMTjzq8O8BzRgWTy20oKaeKLCbOGDHNjwrLy80H+r7EDQ+kRgCWNkA/iFAAzZu+/nVHvsZctgenjAfal4onefIbkptu2SUUNI8HxYaGSVCWjapatN9dOYmHtwJZ5Bp6AUzbo+R5HMTA+aW7DLnuYnh2G4F9yXtBh0iY0ihXehWMRKq6weOaCymsiRYW+pcUBNM6awBGTvh3p9mLNFDjkDmWWVo8u62+52bXhpd4GaNzQiaMnwQbrQ2L9JcQOOmm+Bc8B0I1xu3iwkQKjcwfg0G80RwiauPpoH4v0GQ==
X-YMail-OSG: bECyNgYVM1m1qz1rZ5_tSVQtdUXUh55m1CyhbxS.3Xc0MUkAPWDot8hT0_j.5Cc
 joS1KBruJIc_X5e_jEU6hNJ.qSDDbwfSzMW9swkznzXAbo.acChmA14CnCZQEWslaoDGD7xNC_F4
 mCljYqz_OtRck9PZXw7hvFABWR8V_m.4Wvt0UTcIexC5AsCRYB7F5J.8JpbWq8yiCpMfpKGg8AVc
 l2V9inOFhhv74sO8Uh4JryZHGnajGSAO8TnrimPg4n1wKQ1yc_TD7FMjO.N1uB7GOLBmlt2r3GtU
 3LdTAM3Tx_7vX3fNmcdt8P9pH8dvFwxSDWuOKwM7DK0Z.kmc9tRkpH8v3kqldXFsihy7vmlXoQUU
 yg1TgYqypAnCRjR3gK6Fsr9yE9xk1mNwNcXafU9ZHLQ79Fd1kxUS0lPKT9YLCtZIjtJb2qv_jvdB
 hZUOdzp.efFPJytC0256TjCZeQ5LHW58DiNWCujiV9S3HtfwUWtdbHJs3fbDwq5pxTrLYAlouidw
 ocDrVpJZN4k7FRHq2j0DYLHAEEbxsRczZClzrGX5jxt4AoW5UGBcfvHXQC21WkkuHoeZkE5OvOt8
 vMzdvhfld8iGr8TjDQbjQdEdJbzseRHPUwNlcg6zpPGeHr463OOGmFSzgRHUmIPvrI5I93Hl0znb
 8_qEflCOEbT2ZlPhlPylK5R1dzxI2fw1am.ngJq3axlgi..p.j32f6UHUy_L.YMdKjOzO9tgHuc3
 esc0pQaFqbzBCiu1kVjM0fOh.N0nk9uwOhjYT3TVCeA_07aDRdQ6O.1EnDW44JjE1tLplzKqW_3E
 yRk3D6HhnHjAcVh_X6buY5Udc91GZn0dL2eU90VGiKSMN5.mDSJVPgiiOXdR_rMyZQivtswiBAWV
 ScBCv_6jmYkbezFq8f2VW80FsSmcaGkUJhHH7iiLDT_rTxCxuAvLbll_Q_zPyG0TEL1r.zi8fyV8
 oAYzKtufldOj3yhVo5buNU.41QaetVG6c8qt40p2Y2Z7Z1oz2sU.d2zzkRwCkU11c9_JqASVLjEL
 tYIgIw7OJYeOXJl5DhXD0OYP4m0oumbkf_aVhQtjZm4UuouzDD7OQIeYRvOEdLuYtu7nY9f90I1t
 8TI4SYJCtOiQS3W6JrGbxKFgIqCtsZcIyJFqPXFGuhyvljYzqFs.UntcTp519S92VYfqPLgv6rRU
 PdoMhX.eSz_aMuF8d.TsZgLwI72fG1cycruTmx2QMYBHSabcqmDGXRQeMGyihDgNNAR.cuS4CxDM
 ndMgn6AN2SGDbBOIE5pAI3m7_PFE8f7sUEQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Jun 2019 21:11:51 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e29402de8ce9ac532fdb1db0d6288519;
          Tue, 04 Jun 2019 21:11:46 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <1207.1559680778@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <3ca991d1-4056-c45b-dbae-9976fb5d81e0@schaufler-ca.com>
Date:   Tue, 4 Jun 2019 14:11:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1207.1559680778@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/4/2019 1:39 PM, David Howells wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
>
>>> Here's a set of patches to add a general variable-length notification=
 queue
>>> concept and to add sources of events for:
>> I asked before and didn't see a response, so I'll ask again.  Why are =
you
>> paying any attention at all to the creds that generate an event?
> Casey responded to you.  It's one of his requirements.

Process A takes an action. As a result of that action,
an event is written to Process B's event buffer. This isn't
a covert channel, it's a direct access, just like sending
a signal. Process A is the subject and the event buffer,
which is part of Process B, is the object.


> I'm not sure of the need, and I particularly don't like trying to make
> indirect destruction events (mount destruction keyed on fput, for insta=
nce)
> carry the creds of the triggerer.  Indeed, the trigger can come from al=
l sorts
> of places - including af_unix queue destruction, someone poking around =
in
> procfs, a variety of processes fputting simultaneously.  Only one of th=
em can
> win, and the LSM needs to handle *all* the possibilities.

Yes, it's a hairy problem. It was a significant factor in the
demise of kdbus.

> However, the LSMs (or at least SELinux) ignore f_cred and use current_c=
red()
> when checking permissions.  See selinux_revalidate_file_permission() fo=
r
> example - it uses current_cred() not file->f_cred to re-evaluate the pe=
rms,
> and the fd might be shared between a number of processes with different=
 creds.
>
>> This seems like the wrong approach.  If an LSM wants to prevent covert=

>> communication from, say, mount actions, then it shouldn't allow the
>> watch to be set up in the first place.
> Yeah, I can agree to that.  Casey?

Back to your earlier point, you don't know where the
event is coming from when you create the event watch.
If you enforce a watch time, what are you going to check?
Isn't this going to be considered too restrictive?


