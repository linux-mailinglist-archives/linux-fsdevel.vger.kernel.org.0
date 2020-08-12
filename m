Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5C242B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHLOqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:46:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3492C061383;
        Wed, 12 Aug 2020 07:46:00 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p13so1858958ilh.4;
        Wed, 12 Aug 2020 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kQOJV8hQKKWi1Q4IBwonjxI4nlnYdAyxL48CghY2b34=;
        b=HGQFwkMBI0qZO7MrD0rp1rh/DwuatULSWC/TiTjc9FpR639vDt8wLod16lHEAgWVXH
         XY/Olcv9YPJYu5mbQ//6e/+4DgrFb2uQNUoGS3NSOjDW3Z+GX1guEJ8A5V/+WuogzmwZ
         qKc9hbiTlyrh/T0KKY6Y9dDr4uMbK6x4uLivHygeyGF1RnzfICFM6Jk8oc+wvWnk+Xjc
         2yv81izp0yfN4CzEpLu8fNlunwIjjUt2c7fono233rGNqbuOlrCVp/N8zDYXr/Ob99Jm
         eUwgbm0s0S5ZhVeIpen7HznxUNNDmhXFS1QDH9omiN2bvck9akJvRUz2WQEpMvLM1v0S
         B8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kQOJV8hQKKWi1Q4IBwonjxI4nlnYdAyxL48CghY2b34=;
        b=D8wUSmkNZBxuObflQKSY2ViJdaFvyC4PJTzq7KHd58X7fgXUNyWukWM3fcV5KvNUVO
         mopMHZPCFVxumKI0i8shEBsY1BX3Wjn6kV+0rDxEHXbCzFuV+NhHihjNwKAgho+3J7iv
         6US6gTMsTKBamXTqfPoCB92YUMHtZFgjGOYkll/lSQjWNrPb44f3tPEoCGWiKgdKNM1l
         feTGsWSRKqcCgD3Sx25TrXtI02/8QAHbLVfp4F3VW2zRmZWuK1JScA0FLqZWoUy1kCNK
         tdOnZ5rJr8xW85KX9axb22EGe+U2tuPuFwCYo1R9NYisG4H/4Q+rOGuCMhhprGTlSrZf
         so4w==
X-Gm-Message-State: AOAM530tDB9lArvmlVVkc5LxQI7Grm74UttCcwlOHEA1tH0Py1Poc6Z4
        5rI92Mj0qTvS4QtA/rmpSyw=
X-Google-Smtp-Source: ABdhPJwhgRbaRRSqe0vcGsrFV97VYVYstE/PFYHOorVWwg7UGiBOlCHPQtwmMYxo8Rf89OCc3e2t5w==
X-Received: by 2002:a92:6d0c:: with SMTP id i12mr8272ilc.37.1597243558796;
        Wed, 12 Aug 2020 07:45:58 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k14sm1089731ion.17.2020.08.12.07.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 07:45:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <1597159969.4325.21.camel@HansenPartnership.com>
Date:   Wed, 12 Aug 2020 10:45:56 -0400
Cc:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>,
        snitzer@redhat.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <20F82AFA-D0AC-479B-AB1D-0D354AE19498@gmail.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
 <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
 <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
 <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
 <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
 <1597073737.3966.12.camel@HansenPartnership.com>
 <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
 <1597124623.30793.14.camel@HansenPartnership.com>
 <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
 <1597159969.4325.21.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 11, 2020, at 11:32 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Tue, 2020-08-11 at 10:48 -0400, Chuck Lever wrote:
>>> On Aug 11, 2020, at 1:43 AM, James Bottomley
>>> <James.Bottomley@HansenPartnership.com> wrote:
>>> On Mon, 2020-08-10 at 19:36 -0400, Chuck Lever wrote:
> [...]
>>>> Thanks for the help! I just want to emphasize that documentation
>>>> (eg, a specification) will be critical for remote filesystems.
>>>>=20
>>>> If any of this is to be supported by a remote filesystem, then we
>>>> need an unencumbered description of the new metadata format
>>>> rather than code. GPL-encumbered formats cannot be contributed to
>>>> the NFS standard, and are probably difficult for other
>>>> filesystems that are not Linux-native, like SMB, as well.
>>>=20
>>> I don't understand what you mean by GPL encumbered formats.  The
>>> GPL is a code licence not a data or document licence.
>>=20
>> IETF contributions occur under a BSD-style license incompatible
>> with the GPL.
>>=20
>> https://trustee.ietf.org/trust-legal-provisions.html
>>=20
>> Non-Linux implementers (of OEM storage devices) rely on such
>> standards processes to indemnify them against licensing claims.
>=20
> Well, that simply means we won't be contributing the Linux
> implementation, right?

At the present time, there is nothing but the Linux implementation.
There's no English description, there's no specification of the
formats, the format is described only by source code.

The only way to contribute current IMA metadata formats to an open
standards body like the IETF is to look at encumbered code first.
We would effectively be contributing an implementation in this case.

(I'm not saying the current formats should or should not be
contributed; merely that there is a legal stumbling block to doing
so that can be avoided for newly defined formats).


> Well, let me put the counterpoint: I can write a book about how linux
> device drivers work (which includes describing the data formats)


Our position is that someone who reads that book and implements those
formats under a non-GPL-compatible license would be in breach of the
GPL.

The point of the standards process is to indemnify implementing
and distributing under _any_ license what has been published by the
standards body. That legally enables everyone to use the published
protocol/format in their own code no matter how it happens to be
licensed.


> Fine, good grief, people who take a sensible view of this can write =
the
> data format down and publish it under any licence you like then you =
can
> pick it up again safely.


That's what I proposed. Write it down under the IETF Trust legal
provisions license. And I volunteered to do that.

All I'm saying is that description needs to come before code.


--
Chuck Lever
chucklever@gmail.com



